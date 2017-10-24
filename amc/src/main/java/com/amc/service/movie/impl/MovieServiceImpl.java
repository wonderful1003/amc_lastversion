package com.amc.service.movie.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.common.util.CommonUtil;
import com.amc.service.domain.Movie;
import com.amc.service.domain.MovieComment;
import com.amc.service.domain.WishList;
import com.amc.service.domain.onetime.MovieList;
import com.amc.service.domain.onetime.Twitter;
import com.amc.service.movie.MovieDAO;
import com.amc.service.movie.MovieService;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;


@Service("movieServiceImpl")
public class MovieServiceImpl implements MovieService {
	
	///Field	
	
	@Autowired
	@Qualifier("movieDAOImpl")
	
	//@Qualifier("movieApiDAOImpl")	
	
	private MovieDAO movieDAO;
	
	public void setMovieDAO(MovieDAO movieDAO) {
		this.movieDAO = movieDAO;
	}
	
	///Constructor
	public MovieServiceImpl() {
		System.out.println(this.getClass());		
	}

	@Override
	public List<Movie> getMoiveAdminList(Search search) {
		
		return null;
	}

	@Override
	public Map<String , Object > getMovieList(Search search) throws Exception {
		
		System.out.println("Search ::" + search);		
		
		List<Movie> list= movieDAO.getMovieList(search);
		
		System.out.println("list ::" + list);		
		
		int totalCount = movieDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	

	@Override
	public List<Movie> getMoviePreviewList(Search search) {
		
		return null;
	}

	@Override
	public List<Movie> getCommingSoonList(Search search) {
		
		return null;
	}



	@Override
	public Movie getMovie(int movieNo) throws Exception {
		return movieDAO.getMovie(movieNo);
	}

	

	
	@Override
	public int updateMovie(Movie movie) throws Exception {
		return movieDAO.updateMovie(movie);
		
	}

	@Override
	public int deleteMovie(int movieNo) throws Exception {
		return movieDAO.deleteMovie(movieNo);
		
	}

	@Override
	public List<WishList> getWishList(Search search, String userId) {
		
		return null;
	}

	@Override
	public List<MovieList> getAPIMoiveList() throws Exception {
		
		System.out.println("MovieServieImpl getAPIMoiveList()" );
		return   movieDAO.getAPIMoiveList();
		
	}

	
	@Override
	public int addMovie(Movie movie) {
		// 발급키
		
		System.out.println("MovieServiceImp addMovie called....");
				 
				String key = "430156241533f1d058c603178cc3ca0e";
				
				// Variables declare
				String actorsNm = "";
				String actorNms = "";
				String delimeter = ",";
				String movieCountry = "";
				String directorNms = "";
				String directorNm = "";		
				String watchGradeNm = "";
				String genreNm ="";
				String genreNms ="";
				String postUrl = "";
				String movieEndDate = "";		
				String syonpsis = "";
				String trailer = "";
				
				
				
		        // split()을 이용해 '-'를 기준으로 문자열을 자른다.
		        // split()은 지정한 문자를 기준으로 문자열을 잘라 배열로 반환한다.
				
			
				String movieCd = movie.getMovieCd();
				
				System.out.println("MovieServiceImp addMovie :: movieCd " + movieCd);
	     
	            movieEndDate = movie.getEndDt();
	            syonpsis = movie.getSynopsis();
	            trailer = movie.getTrailer();
		     
		        
		        System.out.println("movieEndDate" + movieEndDate);
		        System.out.println("syonpsis" + syonpsis);
		        System.out.println("trailer" + trailer);
				
				// KOBIS 오픈 API Rest Client를 통해 호출
			    KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
			    
				// 영화코드조회 서비스 호출 (boolean isJson, movieCd)  
			   
			    String movieContentInfo = null;
				try {
					movieContentInfo = service.getMovieInfo(true, movieCd);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			    
			    JSONObject jsonObject = null;
			    String movieInfoResult = null;
			    JSONObject jsonmovieInfoResult = null;
			    JSONObject jsonmovieInfo = null;
			    String movieInfo = null;
			    String showTm = null;
			    String movieNm = null;
			    String openDt = null;
				try {
					jsonObject = new JSONObject(movieContentInfo);			
					movieInfoResult = jsonObject.getString("movieInfoResult");
					jsonmovieInfoResult = new JSONObject(movieInfoResult);
					movieInfo = jsonmovieInfoResult.getString("movieInfo");
					jsonmovieInfo = new JSONObject(movieInfo);
					showTm = jsonmovieInfo.getString("showTm");
					movieNm = jsonmovieInfo.getString("movieNm");
					openDt = jsonmovieInfo.getString("openDt");
				} catch (JSONException e1) {
			
					e1.printStackTrace();
				}
			
			    
			    System.out.println("showTm :: " + showTm);
			    System.out.println("movieNm :: " + movieNm);
			    System.out.println("openDt :: " + openDt);
		    	    
			    JSONArray jsonArray = null;
				try {
					jsonArray = jsonmovieInfo.getJSONArray("audits");
				} catch (JSONException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			    System.out.println("jsonArray-->"+jsonArray);
			  
			    
			    for (int index = 0, total = jsonArray.length(); index < total; index++) {
			         try {
						jsonObject = jsonArray.getJSONObject(index);
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			         try {
						watchGradeNm = jsonObject.getString("watchGradeNm");
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
		             System.out.println("watchGradeNm :" + watchGradeNm  );  
			    }                           
			    
			    JSONArray actorsArray = null;
				try {
					actorsArray = jsonmovieInfo.getJSONArray("actors");
				} catch (JSONException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}  
			    List<String> actorList = new ArrayList<String>();
			    
			    if (actorsArray.length() != 0) {	    
				    System.out.println("actorsArray-->"+actorsArray);
				    
					    for (int index = 0, total = actorsArray.length(); index < total; index++) {
				         try {
							jsonObject = actorsArray.getJSONObject(index);
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				         try {
							actorsNm = jsonObject.getString("peopleNm");
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				         
				      
				         actorList.add(actorsNm);
				        
			         
				         actorNms += actorsNm + delimeter;
		 	             
				    }  
					    
				
			
				    actorNms = CommonUtil.eliminatorLast(actorNms);		    
				    System.out.println("actorNms :" + actorNms  ); 
				    
			    } else {
			    	System.out.println("actorsArray.length() " + actorsArray.length());
			    }   
			    
			    JSONArray directorsArray = null;
				try {
					directorsArray = jsonmovieInfo.getJSONArray("directors");
				} catch (JSONException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			    List<String> directorList = new ArrayList<String>();
			    if (directorsArray.length() != 0) {	    
				    System.out.println("directorsArray-->"+directorsArray);
				    
					    for (int index = 0, total = directorsArray.length(); index < total; index++) {
				         try {
							jsonObject = directorsArray.getJSONObject(index);
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				         try {
							directorNm = jsonObject.getString("peopleNm");
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				         

				         directorList.add(directorNm);
				        
				         
				         directorNms += directorNm + delimeter;
		 	             
				    }   
			
					directorNms = CommonUtil.eliminatorLast(directorNms);		    
				    System.out.println("directorNms :" + directorNms  ); 
				    
			    } else {
			    	System.out.println("directorsArray.length() " + directorsArray.length());
			    }   
			    
			    JSONArray genresArray = null;
				try {
					genresArray = jsonmovieInfo.getJSONArray("genres");
				} catch (JSONException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			    List<String> genreList = new ArrayList<String>();
			    if (genresArray.length() != 0) {	    
				    System.out.println("genresArray-->"+ genresArray);
				    
					    for (int index = 0, total = genresArray.length(); index < total; index++) {
				         try {
							jsonObject = genresArray.getJSONObject(index);
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				         try {
							genreNm = jsonObject.getString("genreNm");
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				         
				         genreList.add(genreNm);
				         
				         genreNms += genreNm + delimeter;
		 	             
				    }   
					
					genreNms = CommonUtil.eliminatorLast(genreNms);		    
				    System.out.println("genreNms :" + genreNms  ); 
				    
			    } else {
			    	System.out.println("genresArray.length() " + genresArray.length());
			    }   
				
			    
				
			    System.out.println("movieContentInfo" + movieContentInfo);
			    
			    //
			    //Naver API call for moviePoster Image Featch
			    //
			    
			    String clientId = "IHe0VrmfNN7Bh383bpqD";//애플리케이션 클라이언트 아이디값";
			    String clientSecret = "iyFkgy3twl";//애플리케이션 클라이언트 시크릿값";

			    try {
			   	    String title = URLEncoder.encode(movieNm, "UTF-8");
			   	    String yearf = URLEncoder.encode("2017", "UTF-8");
			   	    String yeart = URLEncoder.encode("2017", "UTF-8");
			   	    
			   	    String apiURL = "https://openapi.naver.com/v1/search/movie.json?query="+ title +
			   	    		"&yearfrom=" + yearf + "&yearto=" + yeart;
			   	    //		"&yearfrom=" + yearf + "&yearto=" + yeart;
			   	    		 // json 결과
			   	    //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ title; // xml 결과
			   	    URL url = new URL(apiURL);
			   	    HttpURLConnection con = (HttpURLConnection)url.openConnection();
			   	    con.setRequestMethod("GET");
			   	    con.setRequestProperty("X-Naver-Client-Id", clientId);
			   	    con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			   	    int responseCode = con.getResponseCode();
			   	    BufferedReader br;
			     
			   	    if(responseCode==200) { // 정상 호출
			           br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			           
			           String line = null;
			           String values = new String();
			           final StringBuffer buffer = new StringBuffer(2048);
			           while ((line = br.readLine()) != null) {	               
			               values += line;
			           }
			           
			           System.out.println("Naver API info values : " + values.toString());
			           
			        
			           jsonObject = new JSONObject(values);   
			          
			           JSONArray itemsArray = jsonObject.getJSONArray("items");
			           System.out.println("itemsArray-->"+itemsArray);
			          
			   	    
				   	   for (int index = 0, total = itemsArray.length(); index < total; index++) {
				   	         jsonObject = itemsArray.getJSONObject(index);
				   	         postUrl = jsonObject.getString("image");
				   	         System.out.println("postUrl :" + postUrl  );  
				   	    }            
			    
			           
			        } else {  // 에러 발생
			           br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			        }
			   	    
			    } catch(Exception e){
		            System.out.println(e.getMessage());
		        }
			    
			    //Screen Domain loading 			
			    
			  
			    movie.setOpenDt(openDt);
			    movie.setActors(actorNms);
			    movie.setDirector(directorNms);	
			    movie.setGenres(genreNms);
			    movie.setWatchGradeNm(watchGradeNm);
			    movie.setMovieNm(movieNm);
			    movie.setPostUrl(postUrl);	  
			    movie.setShowTm(showTm);
			    movie.setEndDt(movieEndDate);
			    movie.setSynopsis(syonpsis);
			    movie.setTrailer(trailer);
			    
			    System.out.println("actorNms     ::" + movie.getActors());
			    System.out.println("directorNms  ::" + movie.getDirector());
			    System.out.println("genreNms     ::" + movie.getGenres());
			    System.out.println("movieNm      ::" + movie.getMovieNm());
			    System.out.println("postUrl      ::" + movie.getPostUrl());
			    System.out.println("watchGradeNm ::" + movie.getWatchGradeNm());
			    System.out.println("showTm       ::" + movie.getShowTm());
			    System.out.println("openDt       ::" + movie.getOpenDt());
			    System.out.println("movieEndDate ::" + movie.getEndDt());
			    System.out.println("syonpsis     ::" + movie.getSynopsis());
			    System.out.println("trailer      ::" + movie.getTrailer());
		    
				return   movieDAO.addMovie(movie);

	
	}
	
	@Override
	public int addWish(int movieNo) {
		
		return 0;
	}

	@Override
	public int addMoiveComment(MovieComment movieComment) {
		System.out.println("MovieServieceImpl의 addMoiveComment 시작");
		System.out.println("1. movieComment ==> "+ movieComment);
		System.out.println("MovieServieceImpl의 addMoiveComment 끝");
		
		return movieDAO.addMoiveComment(movieComment);
	}

	@Override
	public int blindMoiveComment(MovieComment movieComment) {
		System.out.println("MovieServieceImpl의 blindMoiveComment 시작");
		System.out.println("1. movieComment ==> "+ movieComment);
		System.out.println("MovieServieceImpl의 blindMoiveComment 끝");
		
		
		return movieDAO.blindMoiveComment(movieComment);
	}

	@Override
	public int updateMovieComment(MovieComment movieComment) {
		
		System.out.println("MovieServieceImpl의 updateMovieComment 시작");
		System.out.println("1. movieComment ==> "+ movieComment);
		System.out.println("MovieServieceImpl의 updateMovieComment 끝");
		
		return movieDAO.updateMovieComment(movieComment);
		
	}
	
	@Override
	public MovieComment getMovieComment(int movieCommentNo) {
		System.out.println("MovieServieceImpl의 addMoiveComment 시작");
		System.out.println("1. movieCommentNo ==> "+ movieCommentNo);
		System.out.println("MovieServieceImpl의 addMoiveComment 끝");
		return movieDAO.getMovieComment(movieCommentNo);
	}
	
	@Override
	public int deleteMovieComment(int movieCommentNo) {
		
		System.out.println("MovieServieceImpl의 deleteMovieComment 시작");
		System.out.println("1. movieCommentNo ==> "+ movieCommentNo);
		System.out.println("MovieServieceImpl의 deleteMovieComment 끝");
		
		return movieDAO.deleteMovieComment(movieCommentNo);
	}

	@Override
	public Map<String, Object> getMovieCommentList(Search search, int movieNo) throws Exception {
		
		System.out.println("MovieServieceImpl의 getMovieCommentList 시작");		
		System.out.println("1. search ==> " + search);
		System.out.println("2. movieNo ==> " + movieNo);
		List<MovieComment> list = movieDAO.getMovieCommentList(search, movieNo);
		int totalCount = movieDAO.getTotalCount(movieNo);
		System.out.println("3. list ==> "+ list);
		System.out.println("4. totalCount ==> " + totalCount);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
	
		System.out.println("5. map ==> " + map);		
		System.out.println("MovieServieceImpl의 getMovieCommentList 끝");		
		return map;
	}

	@Override
	public List<Movie> getChart(int movieNo) {
		
		return null;
	}

	@Override
	public List<Twitter> getTwitterList(String movieName) {
		
		return null;
	}

	
}
