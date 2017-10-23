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
		
		//���񸮽�Ʈ �Ķ���Ϳ� search
		Search search = new Search();
		search.setSearchKeyword(searchKeyword);
		
		
		
		//cinemaDAO �� �̿��� �û�ȸ,����,���� ����Ʈ ������ ���������
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
		
		
		
		
		//movieDAO �� �̿��� ��ȭ ����Ʈ ������ ���������
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
		search.setSearchCondition("4"); //MovieMapper���� ����(if���� ����) ���� ������ ��ȭ
		search.setSearchKeyword(simpleDateFormat.format(calendar.getTime())); //MovieMapper���� ����(��¥) ���� ������ ��ȭ
	
		
		index = cinemaDAO.index();
		index.put("mainMovieList", movieDAO.uniMovieList(search)); //MovieDAO���� ������ �� ���� ������ ��ȭ List<Movie>�� ǲ 

		//MovieDAO ���� �� ������ �Գ� Ȯ�ο�
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
		
		//addInfo�� token �߰�
		addInfo.put("access_token", this.getToken());
		
		//�������� Ȯ��
		JSONObject checkObj = 
				this.getImportResponseJSONObject(this.getConAndBody("https://api.iamport.kr/payments/"+impUid, "confirmPay",addInfo));
		
		return checkObj.get("status").toString()+","+checkObj.get("amount").toString();
	}
	
	@Override
	public String cancelPay(String impUid) throws Exception {
		
		String result = "";
		
		if(((this.checkPay(impUid)).split(","))[0].equals("paid")){
			
			//addInfo�� token �߰�
			addInfo.put("access_token", this.getToken());
			addInfo.put("impUid", impUid);
			JSONObject cancelObj = 
					this.getImportResponseJSONObject(this.getConAndBody("https://api.iamport.kr/payments/cancel", "cancelPay",addInfo));
			
			return cancelObj.get("status").toString();
			
		}
		
		return result;
	}
	
	public String getToken() throws Exception{
		
		//token �ޱ�
		JSONObject tokenObj = 
				this.getImportResponseJSONObject(this.getConAndBody("https://api.iamport.kr/users/getToken/", "getAccessToken"));
		
		//token ����
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
        	System.out.println("�ۼ��� ���� : 200");
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // ���� �߻�
        	System.out.println("�ۼ��� ���� : " + responseCode);
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        
        //JSON Data �б�
        String oneLine = "";
        StringBuffer response = new StringBuffer();
        
        while ((oneLine = br.readLine()) != null) {
            response.append(oneLine);
        }
        
        br.close();
        con.disconnect();
        
        String firstJsonData = response.toString();
        
        JSONObject jsonObj = (JSONObject)JSONValue.parse(firstJsonData);
        
        //jsonData�߿� response���� ����(response�� json������)
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
