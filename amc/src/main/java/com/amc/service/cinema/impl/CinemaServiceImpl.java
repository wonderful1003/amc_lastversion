package com.amc.service.cinema.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.codehaus.jackson.map.ObjectMapper;
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
	
	static String access_token;
	
	public CinemaServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Map<String, Object> unifiedSearch(String searchKeyword) {
		
		Map<String, Object> unifiedSearch = new HashMap<String,Object>();
		
		unifiedSearch = cinemaDAO.unifiedSearch(searchKeyword);
		
		Search search = new Search();
		search.setSearchCondition(null);
		search.setSearchKeyword("스");
		
		List<ScreenContent> pc = (List<ScreenContent>)(unifiedSearch.get("uniPreviewList"));
		List<Product> goods = (List<Product>)(unifiedSearch.get("uniGoodsList"));
		List<Product> snack = (List<Product>)(unifiedSearch.get("uniSnackList"));
		List<Movie> movie = movieDAO.uniMovieList(search);
		unifiedSearch.put("uniMovieList", movie);
		
		
		for (ScreenContent screenContent : pc) {
			System.out.println("serviceImpl"+screenContent.getPreviewTitle());
		}
		
		for (Movie mv : movie) {
			System.out.println("serviceImpl"+mv.getMovieNm());
		}
		
		for (Product product : goods) {
			System.out.println("serviceImpl"+product.getProdName());
		}
		for (Product product : snack) {
			System.out.println("serviceImpl"+product.getProdName());
		}
			
		return unifiedSearch;
	}

	@Override
	public Map<String, Object> index() {
		Map<String, Object> index = new HashMap<String,Object>();
		index = cinemaDAO.index();
		return null;
	}

	@Override
	public String getPanorama(int theaterNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String checkPay(String impUid) throws Exception{
		
		//token 받기
		JSONObject tokenObj = CinemaServiceImpl.getImportResponseJSONObject("https://api.iamport.kr/users/getToken", "POST");
		//token 설정
		CinemaServiceImpl.access_token = tokenObj.get("access_token").toString();
		
		//결제정보 확인
		JSONObject checkObj = CinemaServiceImpl.getImportResponseJSONObject("https://api.iamport.kr/payments/"+impUid, "GET");
		
		return checkObj.get("status").toString();
	}
	
	static public JSONObject getImportResponseJSONObject(String inputUrl, String requestType) throws Exception{
		
		URL url = new URL(inputUrl);
		StringBuffer body = new StringBuffer();
			
		HttpsURLConnection con = (HttpsURLConnection)url.openConnection();
				
		con.setDoInput(true);
        con.setDoOutput(true);
        con.setUseCaches(false);

        if(requestType.equals("POST")){

        	con.setRequestMethod(requestType);
			con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
					
	        body.append( "imp_key=0683462591653622");
	        body.append( "&imp_secret=ayIf8zscfkAHWOeVVPukrMxUX9sUr9RBIzRQ9j2oED6Askwoa0IBNgwKpYFR7wtQ6kGfDJDinKTP4pde" );
	        
        }else{
        	con.setRequestMethod("GET");
    		con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
    		con.setRequestProperty("Authorization", access_token);
        }
        
        OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream());
        String bodyString = body.toString();
	    writer.write(bodyString);
	    writer.flush();
	    writer.close();
	    
	    int responseCode = con.getResponseCode();
        
        BufferedReader br = null;
        
        if(responseCode==200) {
        	System.out.println("200!");
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
        	System.out.println("NOT 200!");
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
        
        JSONObject jsonobj = (JSONObject)JSONValue.parse(firstJsonData);
        
        
        //jsonData중에 response내용 추출(response가 json형식임)
        String res = jsonobj.get("response").toString();
        System.out.println("res : " + res);
                
		return (JSONObject)JSONValue.parse(res);
	}
}
