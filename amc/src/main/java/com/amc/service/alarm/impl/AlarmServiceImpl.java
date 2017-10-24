package com.amc.service.alarm.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.alarm.AlarmDAO;
import com.amc.service.alarm.AlarmService;
import com.amc.service.cinema.CinemaService;
import com.amc.service.domain.Alarm;

@Service("alarmServiceImpl")
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	@Qualifier("alarmDAOImpl")
	AlarmDAO alarmDAO;
	
	@Autowired
	@Qualifier("cinemaServiceImpl")
	CinemaService cinemaService;
	
	@Value("#{commonProperties['naver-X-NCP-auth-key'] ?: 'naver-X-NCP-auth-key Plz Check'}")
	String naver_X_NCP_auth_key;
	
	@Value("#{commonProperties['naver-X-NCP-service-secret'] ?: 'naver-X-NCP-service-secret Plz Check'}")
	String naver_X_NCP_service_secret;
	
	@Value("#{commonProperties['naverServiceId'] ?: 'sensServiceId Plz Check'}")
	String naverServiceId;
	
	Map<String, Object> addInfo = new HashMap<String,Object>();
	
	ObjectMapper om = new ObjectMapper();
	
	@Override
	public int addCancelAlarm(Alarm alarm) {

		return 0;
	}

	@Override
	public int addOpenAlarm(Alarm alarm) {

		return alarmDAO.addOpenAlarm(alarm);
	}

	@Override
	public List<Alarm> getCancelAlarmList(Search search) {

		return null;
	}

	@Override
	public List<Alarm> getOpenAlarmList(Search search) {

		return null;
	}

	@Override
	public int deleteCancelAlarm(Alarm alarm) {

		return 0;
	}

	@Override
	public int deleteOpenAlarm(Alarm alarm) {

		return alarmDAO.deleteOpenAlarm(alarm);
	}

	@Override
	public String checkOpenAlarm(Alarm alarm) {
		
		return alarmDAO.checkOpenAlarm(alarm);
		
	}

	@Override
	public String smsPush() throws Exception {
		
		addInfo.put("X-NCP-auth-key", naver_X_NCP_auth_key);
		addInfo.put("X-NCP-service-secret", naver_X_NCP_service_secret);
		
		JSONObject jsonObj = this.smsJsonObject(this.getConAndBody
										("https://api-sens.ncloud.com/v1/sms/services/"+naverServiceId+"/messages", "smsPush", addInfo));
		
		String status = jsonObj.get("status").toString();
        System.out.println("sms push status : " + status);
        
        
        List<String> toList = om.readValue(jsonObj.get("messages").toString(), new TypeReference<List<String>>(){});
        
        for (String string : toList) {
        	jsonObj = (JSONObject)JSONValue.parse(string);
        	System.out.println("to Phone ::" + jsonObj.get("to").toString());
		}
        
        return status;

	}
	
	public JSONObject smsJsonObject(Map<String,Object> conAndBody) throws Exception{
		
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
        
        return jsonObj;
		
	}
	
	public Map<String,Object> getConAndBody(String inputUrl, String behavior, Map<String,Object> addInfo) throws Exception{
		
		Map<String,Object> conAndBody = new HashMap<String, Object>();
		
		URL url = new URL(inputUrl);
		StringBuffer body = new StringBuffer();
			
		HttpsURLConnection con = (HttpsURLConnection)url.openConnection();
				
		con.setDoInput(true);
        con.setDoOutput(true);
        con.setUseCaches(false);

        if(behavior.equals("smsPush")){
        	
        	con.setRequestMethod("POST");
    		con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8;json");
    		con.setRequestProperty("X-NCP-auth-key", (String)addInfo.get("X-NCP-auth-key"));
    		con.setRequestProperty("X-NCP-service-secret", (String)addInfo.get("X-NCP-service-secret"));
    		
    		body.append( "type=sms");
	        body.append( "&from=01071167840" );
	        body.append( "&to=" );
	        
	        
 	        //////////////////////유저 번호 리스트 넣으면 됨
	        List<String> list = new ArrayList<String>(); 
	        list.add("list1");
	        list.add("list2");
	        list.add("list3");
			String jsonString ="";
			jsonString = om.writeValueAsString(list);
			body.append(jsonString);
			/////////////////////유저 번호 리스트 넣으면 됨
	        
	        body.append( "&subject=제목제목제목" );
	        body.append( "&content=내용내용내용" );

        }

        conAndBody.put("con", con);
        conAndBody.put("body", body.toString());
        
        con.disconnect();
        
		return conAndBody;
	}
}
