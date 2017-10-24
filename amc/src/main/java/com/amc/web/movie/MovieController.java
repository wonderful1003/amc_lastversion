package com.amc.web.movie;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.junit.internal.matchers.SubstringMatcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.amc.common.Page;
import com.amc.common.Search;
import com.amc.common.util.CommonUtil;
import com.amc.service.domain.Movie;
import com.amc.service.movie.MovieService;

//==> 영화관리  Controller
@Controller
@RequestMapping("/movie/*")
public class MovieController {
	
	///Field
	@Autowired
	@Qualifier("movieServiceImpl")
	private MovieService movieService;

	//setter Method 구현 않음
	
	public MovieController() {
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	

	@RequestMapping( value="getMovieList")
	public ModelAndView getMovieList( @ModelAttribute("search") Search search, 
								  Model model , HttpServletRequest request) 
								  throws Exception{
		
		System.out.println("/getMovieList  GET ");
		
		ModelAndView modelAndView = new ModelAndView();
		
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
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		System.out.println("list show ::"  + map.get("list"));
	
		
		if(request.getParameter("menu").equals("movie")) {
			System.out.println("listMovie.jsp called");
			modelAndView.setViewName("/movie/listMovie.jsp"); 
			return modelAndView;
		}
		else  if(request.getParameter("menu").equals("manage")) {
			System.out.println("manageProduct.jsp called");
			modelAndView.setViewName("/movie/listMovieManage.jsp");
			return modelAndView;
		}
		else  if(request.getParameter("menu").equals("calendar")) {
			System.out.println("manageProduct.jsp called");
			modelAndView.setViewName("/movie/calendar.jsp");
			return modelAndView;
		}
		else if (request.getParameter("menu").equals("commingsoon")) {
			modelAndView.setViewName("/movie/listCommingSoon.jsp");
			return modelAndView;
		}
		else if (request.getParameter("menu").equals("preview")) {
			modelAndView.setViewName("/movie/listMoviePreview.jsp");
			return modelAndView;
		}
		else if (request.getParameter("menu").equals("search")) {
			modelAndView.setViewName("/movie/listMovie.jsp");
			return modelAndView;
		}
	   
		
		return modelAndView;
	} 
	
	
	@RequestMapping( value="getMovie", method=RequestMethod.GET)
	public ModelAndView getMovie( @RequestParam(value="menu", required=true)  String menu, 
								    @RequestParam(value="movieNo", required=true) Integer movieNo , 
								    Model model ) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		System.out.println("/getMovie : GET");
		//Business Logic
		System.out.println("movieNo ::" + movieNo);
			
		Movie movie = movieService.getMovie(movieNo);	
		
		//System.out.println("Date format before :: openDate :: " + movie.getOpenDt());
		
		//SimpleDateFormat dt = new SimpleDateFormat("yyyyy-mm-dd"); 
		//Date opendate = dt.parse(movie.getOpenDt().toString()); 
		//Date enddate = dt.parse(movie.getEndDt().toString()); 
		
		String steelCuts = movie.getSteelCut();
		System.out.println("steelCut" + steelCuts);
		
		steelCuts = CommonUtil.null2str(steelCuts);
		System.out.println("steelCuts null converted :: what ??" + steelCuts);
		
	
		
		if (!steelCuts.isEmpty()) {
			List<String> steelCutList = Arrays.asList(steelCuts.split(","));
			
			System.out.println("steelCutList length :: " + steelCutList.size());
			System.out.println("steelCutList isEmpty() :: " + steelCutList.isEmpty());
			
			if(!steelCutList.isEmpty()) {			
				if (steelCutList.size() == 1) {
					String steelCut1 = steelCutList.get(0).toString();
					movie.setSteelCut1(steelCut1);
				} else if (steelCutList.size() == 2) {
					 String steelCut2 = steelCutList.get(1).toString();
					 movie.setSteelCut2(steelCut2);
				} else if  (steelCutList.size() == 3) {
					 String steelCut3 = steelCutList.get(2).toString(); 
					 movie.setSteelCut3(steelCut3);
				}
			}
			
		        System.out.println("Movie domain steelCut1 :"  + movie.getSteelCut1());
		        System.out.println("Movie domain steelCut2 :"  + movie.getSteelCut2());
		        System.out.println("Movie domain steelCut3 :"  + movie.getSteelCut3());
		
		}
		
		//String convertOpenDate =  dt.format(opendate).substring(1,11);
		//String convertEndDate =   dt.format(enddate).substring(1,11);
		
		//movie.setOpenDt(convertOpenDate);
		//movie.setEndDt(convertEndDate);		
		
		System.out.println("Date format check :: openDate :: "  + movie.getOpenDt());
				
		// Model 과 View 연결
		model.addAttribute("movie", movie);
		
		if (menu.equals("managed")) {
			System.out.println("updateMovie.jsp called");
			System.out.println(movie+"겟무비액션");
			modelAndView.setViewName("/movie/updateMovie.jsp");
			
			return modelAndView;
		} else {
			System.out.println(movie+"겟무비액션");
			modelAndView.setViewName("/movie/updateMovie.jsp");
			
			return modelAndView;
		}
	}
	

	private final String PATH = "C:/Users/jeung/git/amc/amc/WebContent/images/movie/";
	//private final String PATH = "C:/amcPoster/";
	
	
	@RequestMapping (value ="updateMovie", method=RequestMethod.POST)
	public ModelAndView updateMovie( 						
									 @ModelAttribute("movie") Movie movie,
									 MultipartHttpServletRequest multiPartRequest,
									 HttpServletRequest httpReq,												
									 Model model,
									 HttpSession session
								   ) throws Exception {
		
				
		/**
		 * Upload Multi-files using Spring Controller
		 * 
		 * 테스트 용도로 로컬 경로로 지정했다가, 실제 Deploy할때는 서버 경로로 변경할 것
		 */
		
		System.out.println("상대경로 : " + this.getClass().getResource("").getPath()); // 현재 자신의 절대 경로
		System.out.println("절대경로 : " + this.getClass().getResource("/").getPath()); // classes 폴더의 최상위 경로
		// System.out.println(this.getClass().getResource("/com/amc/config/config.properties").getPath()); 
		
		/**
		 * 실제 배포시 comment를 풀어야 함.
		 * 		
		 */
		//String uploadFiles = session.getServletContext().getRealPath("/images/movie");
		//System.out.println("session of getRealPath :"+session.getServletContext().getRealPath("/images/movie"));
		
		System.out.println("updateMovie Controller Start ===>>> ");
	
		
		ModelAndView modelAndView = new ModelAndView();
		
		Iterator<String> itr =  multiPartRequest.getFileNames();
	
		System.out.println("request.getFileNames() :" + multiPartRequest.getFileNames().toString());
		String dbFileNames = "";
		
        if(itr.hasNext()) {
        	List<MultipartFile> mpf = multiPartRequest.getFiles(itr.next());
        	
                       
            for(int i = 0; i < mpf.size(); i++) {
            	
            	System.out.println("mpf.size()" + mpf.size());
            	
            	String fileNames = mpf.get(i).getOriginalFilename();
   
            	/**
        		 * 실제 배포시 comment를 풀어야 함.        		
        		 */
            	
            	//String fullPath = uploadFiles + "\\" + fileNames;
        		//System.out.println("fullPath"+fullPath);
        		
            	String delimeter = ",";
            	

            	fileNames = new String(fileNames.getBytes("8859_1"),"utf-8");
            	
            	        	
            	dbFileNames += fileNames + delimeter;
            	          	
                // File file = new File(PATH + mpf.get(i).getOriginalFilename());
                
            	//한글꺠짐 방지
            	/**
        		 * 실제 배포시 comment를 풀어야 함.        		
        		 */
               	//File file = new File(fullPath);
                
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
          
        System.out.println("dbFileNames testing....  " + dbFileNames);
   
        System.out.println("dirctor  : "  + movie.getDirector());
        System.out.println("actor    : "  + movie.getActors());
        System.out.println("genre    : "  + movie.getGenres());
        System.out.println("rating   : "  + movie.getWatchGradeNm());
        System.out.println("openDate : "  + movie.getOpenDt());
        System.out.println("RunningTime :"  + movie.getShowTm());
        System.out.println("EndDate : "  + movie.getEndDt());
        System.out.println("PostUrl : "  + movie.getPostUrl());
        
        System.out.println("synopsis :" + movie.getSynopsis());
        System.out.println("trailer  :" + movie.getTrailer());
        
        
		movie.setSteelCut(dbFileNames);
					
		movieService.updateMovie(movie);	
		
		modelAndView.setViewName("/movie/updateMovie.jsp");
		
		return modelAndView;
		
	}
        return modelAndView;
  }

	@RequestMapping( value="deleteMovie", method=RequestMethod.POST)
	public ModelAndView deleteMovie(@RequestParam(value="movieNo", required=true) Integer movieNo , 
								    Model model ) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		System.out.println("/deleteMovie : GET");
		//Business Logic
		System.out.println("movieNo ::" + movieNo);
			
		int rtn = movieService.deleteMovie(movieNo);
		
		System.out.println("return value :" + rtn);
		
		modelAndView.setViewName("/movie/listMovieManage.jsp");
			
		return modelAndView;
		}
	}

	
