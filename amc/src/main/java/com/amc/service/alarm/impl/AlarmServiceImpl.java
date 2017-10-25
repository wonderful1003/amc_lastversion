package com.amc.service.alarm.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.codehaus.jettison.json.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.common.util.RestApiUtil;
import com.amc.service.alarm.AlarmDAO;
import com.amc.service.alarm.AlarmService;
import com.amc.service.cinema.CinemaService;
import com.amc.service.domain.Alarm;
import com.amc.service.domain.ScreenContent;
import com.amc.service.screen.ScreenDAO;

@Service("alarmServiceImpl")
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	@Qualifier("alarmDAOImpl")
	AlarmDAO alarmDAO;
	
	@Autowired
	@Qualifier("screenDAOImpl")
	ScreenDAO screenDAO;

	@Autowired
	@Qualifier("cinemaServiceImpl")
	CinemaService cinemaService;

	@Value("#{commonProperties['naver-X-NCP-auth-key'] ?: 'naver-X-NCP-auth-key Check Plz'}")
	String naver_X_NCP_auth_key;

	@Value("#{commonProperties['naver-X-NCP-service-secret'] ?: 'naver-X-NCP-service-secret Check Plz'}")
	String naver_X_NCP_service_secret;

	@Value("#{commonProperties['naverServiceId'] ?: 'sensServiceId Check Plz'}")
	String naverServiceId;
	
	@Value("#{commonProperties['fromPhoneNo'] ?: '00000000000'}")
	String fromPhoneNo;

	Map<String, String> header = new HashMap<String, String>();
	Map<String, Object> body = new HashMap<String, Object>();

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

	@SuppressWarnings("unchecked")
	@Override
	public String smsPush(String type, String serialNo, String userId) throws Exception {

		RestApiUtil restApiUtil = new RestApiUtil(
				"https://api-sens.ncloud.com/v1/sms/services/" + naverServiceId + "/messages", "POST");
		
		//naver sms 헤더 설정
		header.clear();
		header.put("Content-Type", "application/json; charset=UTF-8");
		header.put("X-NCP-auth-key", naver_X_NCP_auth_key);
		header.put("X-NCP-service-secret", naver_X_NCP_service_secret);

		
		////////////naver sms 바디 설정 start//////////////
		body.clear();
		body.put("type", "sms");
		body.put("from", fromPhoneNo);

		// userId가 있다 = 한사람에게 보낸다 <-----> userId가 없다 한사람or여러사람에게 보낸다
		if (!userId.equals("")) {
			System.out.println("AlarmServiceImpl :: userId 는 Null");
			body.put("to", userId);
		} else {
			System.out.println("AlarmServiceImpl :: userId 는 Not Null");
			List<String> list = new ArrayList<>(); 
			
			//문자를 보낼 대상을 뽑아온다(알람은 0~* 명으로 인원을 뽑아와야함)
			for(String phone : (List<String>)this.userList(type, serialNo).get("phone")){
				list.add(phone);
			}
			if(list.size() == 0){
				return "noOne";
			}
			body.put("to", list);
		}
		
		body.put("subject", this.pushValue(type, serialNo).get("subject"));
		body.put("content", this.pushValue(type, serialNo).get("content"));
		////////////naver sms 바디 설정 end//////////////
		
		
		String responseJsonString = restApiUtil.restApiResponse(header, body, true);

		//Simple JSONObject로 jsonString JSONObjbect화 -> 단순 status를 뽑기 위해
		JSONObject jsonObj = (JSONObject) JSONValue.parse(responseJsonString);
		
		//codehaus 로 jsonString 을 JSONObject화 -> jsonArray를 뽑기 위해
		org.codehaus.jettison.json.JSONObject cdJsonObj = new org.codehaus.jettison.json.JSONObject(responseJsonString);

		String status = jsonObj.get("status").toString();

		System.out.println("sms push status : " + status);
		
		List toListOfMessage = new ArrayList(); 

		//메세지 내용 상세보기 (한사람 한사람에 대한 송수신이 Array로 옴)
		JSONArray jsonArray = cdJsonObj.getJSONArray("messages");
		
		for(int i = 0; i < jsonArray.length(); i ++){
				toListOfMessage.add(jsonArray.get(i));
				System.out.print("[" + ((JSONObject)JSONValue.parse(toListOfMessage.get(i).toString())).get("to")+ "] 에게 SMS전송 ");
				//status 가 0 이면 전송 성공, 그 외는 실패
				if(((JSONObject)JSONValue.parse(toListOfMessage.get(i).toString())).get("statusCode").equals("0")){
					System.out.println("성공!");
				}else{
					System.out.println("실패!");
				}
			}

		restApiUtil.disConnection();
		
		
		return status;
	}

	public Map<String, Object> userList(String type, String serialNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> userList = new HashMap<String, Object>();
		List<String> phone = new ArrayList<String>();
		List<String> uuid = new ArrayList<String>();
		Search search = new Search();
		
		search.setSearchCondition(type);
		search.setSearchKeyword(serialNo);
		map.put("search", search);
		
		
		switch (type) {
		case "openAlarm":
			for (Alarm alarm : alarmDAO.getOpenAlarmList(map)) {
				phone.add(alarm.getUser().getPhone1()+alarm.getUser().getPhone2()+alarm.getUser().getPhone3());
				uuid.add(alarm.getUser().getUuId());
			}
			userList.put("phone", phone);
			userList.put("uuid", uuid);
			break;

		case "cancelAlarm":

			break;

		default:
			break;
		}
		return userList;
	}

	public Map<String, String> pushValue(String type, String serialNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, String> pushValue = new HashMap<String, String>();
		Search search = new Search();
		search.setSearchKeyword(serialNo);
		
		switch (type) {
		case "booking":

			break;
		case "purchase":

			break;
		case "openAlarm":
			ScreenContent sc = screenDAO.getScreenContent(Integer.parseInt(serialNo));
			pushValue.put("subject", "티켓 오픈 알림!");
			pushValue.put("content", "[티켓 오픈 알림]"+sc.getPreviewTitle());
			break;
		case "cancelAlarm":

			break;

		default:
			break;
		}

		return pushValue;
	}
}
