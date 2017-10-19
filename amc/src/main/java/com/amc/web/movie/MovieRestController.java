package com.amc.web.movie;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.amc.service.domain.Movie;
import com.amc.service.domain.MovieAPI;
import com.amc.service.domain.onetime.MovieJson;
import com.amc.service.domain.onetime.MovieList;
import com.amc.service.domain.onetime.MovieListResult;
import com.amc.service.domain.onetime.Screen;
import com.amc.service.movie.MovieService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;



//==> MovieAPI RestController
@RestController
@RequestMapping("/movie/*")
public class MovieRestController {
	
	///Field
	@Autowired
	@Qualifier("movieServiceImpl")
	private MovieService movieService;
	//setter Method 구현 않음

	public MovieRestController() {		
			System.out.println("MovieRestController default constructor call");
			System.out.println(this.getClass());
	}	
	
	@RequestMapping( value="json/getAPIMoiveList", method=RequestMethod.POST )
	public void getAPIMoiveList(HttpServletRequest request, 
						  		HttpServletResponse response						 
								) 
								throws Exception{
		
		
		List<MovieList> list = movieService.getAPIMoiveList();
	
		MovieJson movieJson = new MovieJson();
		
		movieJson.setPage(1);
		movieJson.setTotal(12);
		movieJson.setRecords(5);
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
		
		Enumeration em = request.getParameterNames();
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
	    
	    Screen screen = new Screen();
	    screen.setMovieCd(movieCd);
	    screen.setEndDt(movieEndDate);
	    screen.setSynopsis(syonpsis);
	    screen.setTrailer(trailer);
	    
	    
		if (oper.equals("del")) {
			System.out.println("/movie/json/delMovie : POST");
			//return  productService.deleteProductBatch(prodList);
			return  0;		
			
		} else if (oper.equals("add")) {
			System.out.println("/movie/json/addMovie : POST");
			return 0;		
		} else
			
		return  rtn = movieService.addMovie(null);
	}

}
