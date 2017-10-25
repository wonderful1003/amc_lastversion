package com.amc.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

public class RestApiUtil {
	
	URL url;
	HttpsURLConnection con;
	String requestType;
	Map<String,String> header;
	Map<String,String> body;
	

	@SuppressWarnings("unused")
	private RestApiUtil() throws IOException {

	}
	
	public RestApiUtil(String url, String requestType) throws IOException {
		this.url = new URL(url);
		this.con = (HttpsURLConnection)this.url.openConnection();
		this.con.setDoInput(true);
        this.con.setDoOutput(true);
        this.con.setUseCaches(false);
        this.con.setRequestMethod(requestType);
	}
	
	public String restApiResponse(Map<String,String> header) throws IOException{

		return this.getResponseString(header, null);
	}
	
	public String restApiResponse(Map<String,String> header,Map<String,String> body) throws IOException{

		return this.getResponseString(header, body);
	}
	
	private String getResponseString(Map<String,String> header,Map<String,String> body) throws IOException{
		int count = 0;
		StringBuffer bufferBody = new StringBuffer();
		String result;
		
		for (String mapKey : header.keySet()){
			 con.setRequestProperty(mapKey, header.get(mapKey));
	    }
		

		if(body != null){
			for (String mapKey : body.keySet()) {
				if (count == 0) {
					bufferBody.append(mapKey + "=" + body.get(mapKey));
					count ++;
				} else {
					bufferBody.append("&"+mapKey + "=" + body.get(mapKey));
				}
			}
		}
		
		System.out.println("con : " + this.con.toString());
		for (String mapKey : header.keySet()){
			System.out.println("header : Key->"+mapKey+"  value->" + this.con.getRequestProperty(mapKey));
	    }
	    System.out.println("body : "+ bufferBody.toString());
		
		OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream());
		
		writer.write(bufferBody.toString());
		writer.flush();
		writer.close();
		
	    int responseCode = con.getResponseCode();
        
        BufferedReader br = null;
        
        if(responseCode==200) {
        	System.out.println("송수신 성공 : 200");
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
        	System.out.println("송수신 실패 : " + responseCode);
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        
        String oneLine = "";
        StringBuffer response = new StringBuffer();
        
        while ((oneLine = br.readLine()) != null) {
            response.append(oneLine);
        }
        
        result = response.toString();
        
        return result;
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

	public Map<String, String> getBody() {
		return body;
	}

	public void setBody(Map<String, String> body) {
		this.body = body;
	}

	@Override
	public String toString() {
		return "RestApiUtil [url=" + url + ", con=" + con + ", requestType=" + requestType + ", header=" + header
				+ ", body=" + body + "]";
	}

}
