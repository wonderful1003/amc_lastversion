package com.amc.web.movie;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.amc.common.Page;
import com.amc.common.Search;
import com.amc.common.util.CommonUtil;
import com.amc.service.domain.Movie;
import com.amc.service.domain.MovieAPI;
import com.amc.service.domain.onetime.MovieJson;
import com.amc.service.domain.onetime.MovieList;
import com.amc.service.domain.onetime.MovieListResult;
import com.amc.service.domain.onetime.MovieOnScheule;
import com.amc.service.movie.MovieService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jdk.nashorn.internal.scripts.JO;




//==> MovieAPI RestController
@RestController

@RequestMapping("/movie/*")
public class MovieRestController {
	
	///Field
	@Autowired
	@Qualifier("movieServiceImpl")
	private MovieService movieService;	
	private String dbFileNames;
	
	//setter Method 구현 않음

	public MovieRestController() {		
			System.out.println("MovieRestController default constructor call");
			System.out.println(this.getClass());
	}	
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value="json/getAPIMoiveList", method=RequestMethod.POST )
	public void getAPIMoiveList(HttpServletRequest request, 
						  		HttpServletResponse response						 
								) 
								throws Exception{
		
		
		List<MovieList> list = movieService.getAPIMoiveList();
	
		MovieJson movieJson = new MovieJson();
		
		movieJson.setPage(1);
		movieJson.setTotal(12);
		movieJson.setRecords(10);
		movieJson.setRows(list);
	
		
		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(movieJson);
		
			
		System.out.println("json ====>>>>>  " + json);
		
		
		response.setContentType("application/json");
	    response.setCharacterEncoding("utf-8");
	   
	    PrintWriter out = response.getWriter();
	    out.write(json);
	    out.flush();
	    out.close();
	
	}

	@RequestMapping( value="json/addMovie", method=RequestMethod.POST )
	public int addMovie   (HttpServletRequest request, 
						  HttpServletResponse response						 
						  ) 
						  throws Exception{
		
		Enumeration<?> em = request.getParameterNames();
		List<String> prodList = new ArrayList<String>();
		String oper = "";
		int rtn = 0;
		
		
		while(em.hasMoreElements()){
			String  parameterName = (String)em.nextElement();
			String  parameterValue = request.getParameter(parameterName);
			
			
			System.out.println("parameterName ::" +parameterName );
			System.out.println("parameterValue ::" +parameterValue );
			
			String[] parameterValues = request.getParameterValues(parameterName);
				
			if(parameterValues != null){
			   for(int i=0; i< parameterValues.length; i++){
				   System.out.println("array_" + parameterName + "=" + parameterValues[i]);
				  
				   System.out.println(parameterValues.length);
				   
				   //Operation del delete from ProductList
				   if (parameterValues[i].equals("del")) {
					   oper = parameterValues[i];
				   }  else if (parameterValues[i].equals("add")) {
					   oper = parameterValues[i];
				   }
					   else if (parameterValues[i].equals("edit")) {
						   oper = parameterValues[i];
					   }
				  else {
		
					      String[] var = parameterValues[i].split(",");
					      for (int j = 0 ; j < var.length; j++ ) {
					    	  System.out.println("var :: " + var[j]);
					    	  
					    	  prodList.add((var[j]));
					      }
					   
					   System.out.println("proList ===>" + prodList);
			   	   }
		
			   }
			   
		    } else {
		    	  System.out.println(parameterName + "=" + parameterValue);
		   }
		}
	
		System.out.println("prodList ::" + prodList);		
		String prodList2 = prodList.toString();
		
		String itemList[] = prodList2.split(",");// Variables declare
		String movieCd = "";
		String delimeter = ",";
		String movieContry = "";
		String directorNms = "";
		String directorNm = "";		
		String watchGradeNm = "";
		String movieName ="";
		String genreNms ="";
		String postUrl = "";
		String movieEndDate = "";		
		String syonpsis = "";
		String trailer = "";
		
		
	        
        for(int i=0 ; i<itemList.length ; i++)
        {
            System.out.println("itemList["+i+"] : "+itemList[i]);
            movieCd = itemList[0].substring(1, 9);          
            movieName = itemList[1];
            movieContry = itemList[2];
            movieEndDate = itemList[3]; 
            syonpsis = itemList[4]; 
            trailer= itemList[5]; 
        }
		
		System.out.println("movieCd : " + movieCd);
		System.out.println("movieName : " + movieName);
		System.out.println("movieContry : " + movieContry);
		System.out.println("movieEndDate : " + movieEndDate);	
		System.out.println("syonpsis : " + syonpsis);	
		System.out.println("trailer : " + trailer);	
		
  	
	    //movieListResult.setMovieList((List<MovieList>) movieList);
	    
	    Movie movie = new Movie();
	    movie.setMovieCd(movieCd);
	    movie.setEndDt(movieEndDate);
	    movie.setSynopsis(syonpsis);
	    movie.setTrailer(trailer);
	    
	    
		if (oper.equals("del")) {
			System.out.println("/movie/json/delMovie : POST");
			//return  productService.deleteProductBatch(prodList);
			return  0;		
			
		} else if (oper.equals("add")) {
			System.out.println("/movie/json/addMovie : POST");
			return 0;		
		} else
			

		return  rtn = movieService.addMovie(movie);
	}
	

	private final String PATH = "C:/amcPoster/";

	@Autowired
	MappingJackson2JsonView jsonView;	
	
	@RequestMapping(value="json/upload", method=RequestMethod.POST, produces="text/plain")
	public ModelAndView upload(MultipartHttpServletRequest request,
							  final HttpServletRequest req) throws Exception {
		
		System.out.println("json/upload called RestControl ");
		
		ModelAndView model = new ModelAndView();
		model.setView(jsonView);
		
		Iterator<String> itr =  request.getFileNames();
		String movieNo		 =	req.getParameter("movieNo");
	
		System.out.println("request.getFileNames() :" + request.getFileNames().toString());
		
        if(itr.hasNext()) {
        	List<MultipartFile> mpf = request.getFiles(itr.next());
        	
                       
            for(int i = 0; i < mpf.size(); i++) {
            	
            	System.out.println("mpf.size()" + mpf.size());
            	
            	String fileNames = mpf.get(i).getOriginalFilename();
            	String delimeter = ",";
            	

            	fileNames = new String(fileNames.getBytes("8859_1"),"utf-8");
            	
            	        	
            	dbFileNames += fileNames + delimeter;
            	          	
                // File file = new File(PATH + mpf.get(i).getOriginalFilename());
                
            	//한글꺠짐 방지
               	File file = new File(PATH + fileNames);
                
                if(file.exists())
                {
                	System.out.println("file delete execute...");
                    file.delete();

                } else {
                
                // logger.info(file.getAbsolutePath());
                mpf.get(i).transferTo(file);
                
                System.out.println("fileName :: " + fileNames);
                }
            }
            
            JSONObject json = new JSONObject();
            json.put("code", "true");
            model.addObject("result", json);
            
            System.out.println("dbFileNames testing....  " + dbFileNames);
            
            
            
            System.out.println("json value true ::" + json);
            return model;
            
        } else {
        	
            JSONObject json = new JSONObject();
            json.put("code", "false");
            model.addObject("result", json);
            
            System.out.println("json value false ::" + json);
            return model;
            
        }
	}
	
	@RequestMapping(value="json/movieOnSchedule", method=RequestMethod.POST)	
	public void		 movieOnSchedule
							   (HttpServletRequest request, 
								HttpServletResponse response,
								Model model,
								@ModelAttribute("search") Search search
								) throws Exception {
		
		System.out.println("json/movieOnSchedule called RestControl ");			
		
		
		if(search.getCurrentPage() ==0 ){			
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println("pagesize " + search.getPageSize());
		System.out.println("search " + search);
		
		// Business logic 수행
		Map<String , Object> map= movieService.getMovieList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);	
		
		System.out.println("list show ::"  + map.get("list"));
		
		String str = "";
		
		List<Movie> list = (List<Movie>) map.get("list");
		
		
		//Movie JsonObject 선언(개별)
		JSONObject movieObject = new JSONObject();	
        //movie event의 JSON정보를 담을 Array 선언        
        JSONArray movieArray = new JSONArray();       
        //monthly 정보가 들어갈 JSONObject 선언
        JSONObject monthlynfo = new JSONObject();        
 		
		for (int i = 0; i < list.size(); i++) {			
			movieObject.put("id", list.get(i).getMovieNo());			
			movieObject.put("name", list.get(i).getMovieNm());				
			movieObject.put("startdate",list.get(i).getOpenDt());			
			 
        	switch (i) {
			case 0:
				movieObject.put("color", "red");
				break;
			case 1:
				movieObject.put("color", "orange");
				break;
			case 2:
				movieObject.put("color", "green");
				break;
			case 3:
				movieObject.put("color", "blue");
				break;
			case 4:
				movieObject.put("color", "purple");
				break;
			case 5:
				movieObject.put("color", "skyblue");
				break;
			case 6:
				movieObject.put("color", "brown");
				break;
			case 7:
				movieObject.put("color", "darkred");
				break;			
			default:
				movieObject.put("color", "ivory");
				break;
			} 
	
        	movieObject.put("url", "getMovie?movieNo="+list.get(i).getMovieNo()+"&menu=commingsoon");
		
        	movieArray.add(i, movieObject);		    
        	movieObject = new JSONObject();	   	    
		}
            
       
		//*
		//* Domain 객체에서 받아서 Json으로 넣는 방법 
		//*
		/*List <MovieOnScheule> movieOnSchedule = movieService.getScreenCalendar(search);	
		
        //Movie JsonObject 선언(개별)
        JSONObject movieObject = new JSONObject();
        //movie event의 JSON정보를 담을 Array 선언        
        JSONArray movieArray = new JSONArray();       
        //monthly 정보가 들어갈 JSONObject 선언
        JSONObject monthlynfo = new JSONObject();        
      
			
		for (int i = 0; i < movieOnSchedule.size(); i++) {
		
			movieObject.put("id", movieOnSchedule.get(i).getId());	
			movieObject.put("name", movieOnSchedule.get(i).getName());			
			movieObject.put("startdate", movieOnSchedule.get(i).getStartdate());
			
			switch (i) {
			case 0:
				movieObject.put("color", "red");
				break;
			case 1:
				movieObject.put("color", "orange");
				break;
			case 2:
				movieObject.put("color", "green");
				break;
			case 3:
				movieObject.put("color", "blue");
				break;
			case 4:
				movieObject.put("color", "purple");
				break;
			case 5:
				movieObject.put("color", "skyblue");
				break;
			case 6:
				movieObject.put("color", "brown");
				break;
			case 7:
				movieObject.put("color", "darkred");
				break;			
			default:
				movieObject.put("color", "ivory");
				break;
			} 
	
			movieObject.put("url", "getMovie?movieNo="+movieOnSchedule.get(i).getId()+"&menu=commingsoon");
				
		    movieArray.add(i, movieObject);
		    
		    movieObject = new JSONObject();	
		}*/
		
		System.out.println("movieArray values : " + movieArray.toString() );

		monthlynfo.put("monthly", movieArray);
		
		System.out.println("monthlynfo values " + monthlynfo.toString());
		String jsonData = monthlynfo.toJSONString();

		System.out.println("json ====>>>>>  " + jsonData);
		
		response.setContentType("application/json");
	    response.setCharacterEncoding("utf-8");
	    
	    try {
	    	PrintWriter out = response.getWriter();
	  	    out.write(jsonData);
	  	    out.flush();
	  	    out.close();		
	    } catch (IOException e) {
	        e.printStackTrace();
	    }   
	}
 
}

	
