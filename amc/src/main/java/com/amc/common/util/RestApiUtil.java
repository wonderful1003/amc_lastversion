package com.amc.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.codehaus.jackson.map.ObjectMapper;



public class RestApiUtil {
	
	URL url;
	HttpsURLConnection con;
	String requestType;
	Map<String,String> header;
	Map<String,Object> body;
	
	HttpClient httpClient;
	HttpPost httpPost;
	HttpGet httpGet;
	HttpEntity requestHttpEntity;
	HttpEntity responseHttpEntity;
	
	ObjectMapper om;
	

	@SuppressWarnings("unused")
	private RestApiUtil() throws IOException {}
	
	public RestApiUtil(String url, String requestType) throws IOException {
		this.om = new ObjectMapper();
		this.settingConnection(url, requestType);
	}
	
	public void settingConnection(String url,String requestType) throws IOException{
		this.con = null;
		this.httpGet = null;
		this.httpPost = null;
		this.requestHttpEntity = null;
		this.responseHttpEntity = null;
		
		if(url.split("://")[0].equals("https")){
			this.url = new URL(url);
			this.con = (HttpsURLConnection)this.url.openConnection();
			this.con.setDoInput(true);
	        this.con.setDoOutput(true);
	        this.con.setUseCaches(false);
	        this.con.setRequestMethod(requestType);
		}
		else{
			this.httpClient = new DefaultHttpClient();
			if(requestType.equals("POST")){
				this.httpPost = new HttpPost(url);
			}else{
				this.httpGet = new HttpGet(url);
			}
		}
	}
	
	public String restApiResponse(Map<String,String> header) throws IOException{

		return this.getResponseString(header, null, false);
	}
	
	public String restApiResponse(Map<String,String> header,Map<String,Object> body) throws IOException{

		return this.getResponseString(header, body, false);
	}
	
	public String restApiResponse(Map<String,String> header,Map<String,Object> body, boolean isJson) throws IOException{

		return this.getResponseString(header, body, true);
	}
	
	
	private String getResponseString(Map<String,String> header,Map<String,Object> body, boolean isJson) throws IOException{
		//기존의 헤드,바디 설정 초기화
		if(this.header != null){ this.header.clear(); }
		if(this.body != null){	this.body.clear(); }
		
		String result = "";
		
		//https일 경우
		if(this.con != null){
			//지역변수
			int count = 0; //buffer 
			StringBuffer bufferBody = new StringBuffer();
			
			//헤더세팅
			for (String mapKey : header.keySet()){
				 con.setRequestProperty(mapKey, header.get(mapKey));
		    }
			
			//바디세팅
			if (body != null) {
				if (isJson) {
					
					bufferBody.append(om.writeValueAsString(body));
					
				} else {
					for (String mapKey : body.keySet()) {
						if (count == 0) {
							bufferBody.append(mapKey + "=" + body.get(mapKey));
							count++;
						} else {
							bufferBody.append("&" + mapKey + "=" + body.get(mapKey));
						}
					}
				}
			}
			
			
			System.out.println("con : " + this.con.toString());
			for (String mapKey : header.keySet()){
				System.out.println("header : ["+mapKey+":" + this.con.getRequestProperty(mapKey)+"]");
		    }
		    System.out.println("body : "+ bufferBody.toString());
		    
			OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
			
			writer.write(bufferBody.toString());
			writer.flush();
			writer.close();
			
			
		    int responseCode = con.getResponseCode();
	        
	        BufferedReader br = null;
	        
	        if(responseCode==200) {
	        	System.out.println("송수신 상태 : 200");
	            br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
	        }else if(responseCode==202){
	        	System.out.println("송수신 상태 : " + responseCode);
	            br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
	        }
	        else {  // 에러 발생
	        	System.out.println("송수신 상태 : " + responseCode);
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8"));
	        }
	        
	        String oneLine = "";
	        StringBuffer response = new StringBuffer();
	        
	        while ((oneLine = br.readLine()) != null) {
	            response.append(oneLine);
	        }
	        
	        result = response.toString();
	        System.out.println("result :: "+result);
	        
	        br.close();
	        
	        return result;
	     
	     //http의 경우
		}else{
			if(this.httpPost != null){
				for (String mapKey : header.keySet()){
					httpPost.setHeader(mapKey,header.get(mapKey));
			    }
				requestHttpEntity = new StringEntity(om.writeValueAsString(body),"utf-8");
				httpPost.setEntity(requestHttpEntity);
				
				HttpResponse httpResponse = httpClient.execute(httpPost);
				System.out.println("httpResponse :: "+httpResponse);
				System.out.println();
				
				return this.httpResponseString(httpResponse.getEntity());
				
			}else{
				for (String mapKey : header.keySet()){
					httpGet.setHeader(mapKey,header.get(mapKey));
			    }
				
				HttpResponse httpResponse = httpClient.execute(httpGet);
				System.out.println("httpResponse :: "+httpResponse);
				System.out.println();
				
				return this.httpResponseString(httpResponse.getEntity());
			}
		}
	}
	
	private String httpResponseString(HttpEntity httpResponse) throws IllegalStateException, IOException{
		responseHttpEntity = httpResponse;
		InputStream is = responseHttpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		System.out.println("[ http Server 에서 받은 Data 확인]");              
		String serverData = br.readLine();
		return serverData;
	}
	
	public void disConnection(){
		if(this.header != null){ this.header.clear(); }
		if(this.body != null){	this.body.clear(); }
		if(this.con != null){ this.con.disconnect(); }
	}

	public URL getUrl() {
		return url;
	}

	public void setUrl(URL url) {
		this.url = url;
	}

	public HttpsURLConnection getCon() {
		return con;
	}

	public void setCon(HttpsURLConnection con) {
		this.con = con;
	}

	public String getRequestType() {
		return requestType;
	}

	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}

	public Map<String, String> getHeader() {
		return header;
	}

	public void setHeader(Map<String, String> header) {
		this.header = header;
	}

	public Map<String, Object> getBody() {
		return body;
	}

	public void setBody(Map<String, Object> body) {
		this.body = body;
	}

	@Override
	public String toString() {
		return "RestApiUtil [url=" + url + ", con=" + con + ", requestType=" + requestType + ", header=" + header
				+ ", body=" + body + ", httpClient=" + httpClient + ", httpPost=" + httpPost + ", httpGet=" + httpGet
				+ "]";
	}
}
