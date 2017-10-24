package com.amc.service.cinema.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.cinema.CinemaDAO;
import com.amc.service.cinema.CinemaService;
import com.amc.service.domain.Movie;
import com.amc.service.domain.Product;
import com.amc.service.domain.ScreenContent;
import com.amc.service.movie.MovieDAO;

@Service("cinemaServiceImpl")
public class CinemaServiceImpl implements CinemaService {

	@Autowired
	@Qualifier("cinemaDAOImpl")
	CinemaDAO cinemaDAO;
	
	@Autowired
	@Qualifier("movieDAOImpl")
	MovieDAO movieDAO;
	
	Map<String, Object> addInfo = new HashMap<String,Object>();
	
	public CinemaServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> unifiedSearch(String searchKeyword) {
		
		Map<String, Object> unifiedSearch = new HashMap<String,Object>();
		
		//무비리스트 파라미터용 search
		Search search = new Search();
		search.setSearchKeyword(searchKeyword);
		
		
		
		//cinemaDAO 를 이용한 시사회,굿즈,스낵 리스트 데이터 가지고오기
		unifiedSearch = cinemaDAO.unifiedSearch(searchKeyword);
		
		List<ScreenContent> pv = (List<ScreenContent>)(unifiedSearch.get("uniPreviewList"));
		List<Product> goods = (List<Product>)(unifiedSearch.get("uniGoodsList"));
		List<Product> snack = (List<Product>)(unifiedSearch.get("uniSnackList"));
		
		for (ScreenContent screenContent : pv) {
			System.out.println("serviceImpl"+screenContent.getPreviewTitle());
		}
		
		for (Product product : goods) {
			System.out.println("serviceImpl"+product.getProdName());
		}
		for (Product product : snack) {
			System.out.println("serviceImpl"+product.getProdName());
		}
		
		
		
		
		//movieDAO 를 이용한 영화 리스트 데이터 가지고오기
		List<Movie> movie = movieDAO.uniMovieList(search);
		unifiedSearch.put("uniMovieList", movie);
		
		for (Movie mv : movie) {
			System.out.println("serviceImpl"+mv.getMovieNm());
		}
			
		return unifiedSearch;
	}

	@Override
	public Map<String, Object> index() {
		Map<String, Object> index = new HashMap<String,Object>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();
        
		Search search = new Search();
		search.setSearchCondition("4"); //MovieMapper에서 조건(if문을 위한) 현재 상영중인 영화
		search.setSearchKeyword(simpleDateFormat.format(calendar.getTime())); //MovieMapper에서 조건(날짜) 현재 상영중인 영화
	
		
		index = cinemaDAO.index();
		index.put("mainMovieList", movieDAO.uniMovieList(search)); //MovieDAO에서 가지고 온 현재 상영중인 영화 List<Movie>를 풋 

		//MovieDAO 에서 잘 가지고 왔나 확인용
		for (Movie movie : movieDAO.uniMovieList(search)) {
			System.out.println(movie.getMovieNm());
		}
		
		return index;
	}

	@Override
	public String getPanorama(int theaterNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String checkPay(String impUid) throws Exception{
		
		//addInfo에 token 추가
		addInfo.put("access_token", this.getToken());
		
		//결제정보 확인
		JSONObject checkObj = 
				this.getImportResponseJSONObject(this.getConAndBody("https://api.iamport.kr/payments/"+impUid, "confirmPay",addInfo));
		
		return checkObj.get("status").toString()+","+checkObj.get("amount").toString();
	}
	
	@Override
	public String cancelPay(String impUid) throws Exception {
		
		String result = "";
		
		if(((this.checkPay(impUid)).split(","))[0].equals("paid")){
			
			//addInfo에 token 추가
			addInfo.put("access_token", this.getToken());
			addInfo.put("impUid", impUid);
			JSONObject cancelObj = 
					this.getImportResponseJSONObject(this.getConAndBody("https://api.iamport.kr/payments/cancel", "cancelPay",addInfo));
			
			return cancelObj.get("status").toString();
			
		}
		
		return result;
	}
	
	public String getToken() throws Exception{
		
		//token 받기
		JSONObject tokenObj = 
				this.getImportResponseJSONObject(this.getConAndBody("https://api.iamport.kr/users/getToken/", "getAccessToken"));
		
		//token 리턴
		return (tokenObj.get("access_token").toString());
		
	}

	public JSONObject getImportResponseJSONObject(Map<String,Object> conAndBody) throws Exception{
		
		HttpsURLConnection con = (HttpsURLConnection)conAndBody.get("con");
		
		String body = (String)conAndBody.get("body");
        
        OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream());
                
	    writer.write(body);
	    writer.flush();
	    writer.close();
	    
	    System.out.println("con : "+con.toString());
	    System.out.println("body : "+body);
	    
	    int responseCode = con.getResponseCode();
        
        BufferedReader br = null;
        
        if(responseCode==200) {
        	System.out.println("송수신 성공 : 200");
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
        	System.out.println("송수신 실패 : " + responseCode);
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        
        //JSON Data 읽기
        String oneLine = "";
        StringBuffer response = new StringBuffer();
        
        while ((oneLine = br.readLine()) != null) {
            response.append(oneLine);
        }
        
        br.close();
        con.disconnect();
        
        String firstJsonData = response.toString();
        
        JSONObject jsonObj = (JSONObject)JSONValue.parse(firstJsonData);
        
        //jsonData중에 response내용 추출(response가 json형식임)
        String res = jsonObj.get("response").toString();
        System.out.println("res : " + res);
                
		return (JSONObject)JSONValue.parse(res);
	}
	
	public Map<String,Object> getConAndBody(String inputUrl, String behavior) throws Exception{
		
		Map<String,Object> conAndBody = new HashMap<String, Object>();
		
		URL url = new URL(inputUrl);
		StringBuffer body = new StringBuffer();
		
			
		HttpsURLConnection con = (HttpsURLConnection)url.openConnection();
				
		con.setDoInput(true);
        con.setDoOutput(true);
        con.setUseCaches(false);

        if(behavior.equals("getAccessToken")){

        	con.setRequestMethod("POST");
			con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
					
	        body.append( "imp_key=0683462591653622");
	        body.append( "&imp_secret=ayIf8zscfkAHWOeVVPukrMxUX9sUr9RBIzRQ9j2oED6Askwoa0IBNgwKpYFR7wtQ6kGfDJDinKTP4pde" );
	        
        }
        
        conAndBody.put("con", con);
        conAndBody.put("body", body.toString());
        
        con.disconnect();
        
        return conAndBody;
	}
	
	public Map<String,Object> getConAndBody(String inputUrl, String behavior, Map<String,Object> addInfo) throws Exception{
		
		Map<String,Object> conAndBody = new HashMap<String, Object>();
		
		URL url = new URL(inputUrl);
		StringBuffer body = new StringBuffer();
			
		HttpsURLConnection con = (HttpsURLConnection)url.openConnection();
				
		con.setDoInput(true);
        con.setDoOutput(true);
        con.setUseCaches(false);

        if(behavior.equals("confirmPay")){
        	
        	con.setRequestMethod("GET");
    		con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
    		con.setRequestProperty("Authorization", (String)addInfo.get("access_token"));
        	
        }else if(behavior.equals("cancelPay")){
        	
        	con.setRequestMethod("POST");
			con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			con.setRequestProperty("Authorization", (String)addInfo.get("access_token"));
					
	        body.append( "imp_uid="+(String)addInfo.get("impUid"));
        }

        conAndBody.put("con", con);
        conAndBody.put("body", body.toString());
        
        con.disconnect();
        
		return conAndBody;
	}
}
