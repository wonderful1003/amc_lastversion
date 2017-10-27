package com.amc.web.alarm;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.codehaus.jettison.json.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.amc.service.alarm.AlarmService;
import com.amc.service.domain.Alarm;


@RestController
@RequestMapping("/alarm/*")
public class AlarmRestController {
	
	@Autowired
	@Qualifier("alarmServiceImpl")
	AlarmService alarmService;
	
	public AlarmRestController() {
		System.out.println("PurchaseController() default Constructor");
		
	}
	
	@RequestMapping("/json/addCancelAlarm")
	public String addCancelAlarm(@ModelAttribute("alarm")Alarm alarm){
		return alarmService.addCancelAlarm(alarm);
	}
	
	@RequestMapping("/json/switchOpenAlarm")
	public String switchOpenAlarm(@ModelAttribute("alarm")Alarm alarm){
		return alarmService.switchOpenAlarm(alarm);
	}
	
	@RequestMapping("/json/deleteCancelAlarm")
	public int deleteCancelAlarm(@ModelAttribute("alarm")Alarm alarm){
		return alarmService.deleteCancelAlarm(alarm);
	}
	
	@RequestMapping("/json/deleteOpenAlarm")
	public int deleteOpenAlarm(@ModelAttribute("alarm")Alarm alarm){
		return alarmService.deleteOpenAlarm(alarm);
	}
	
	@RequestMapping("/json/push/{type}")
	public String push(@PathVariable("type")String type,
						@RequestParam(value="serialNo",defaultValue="")String serialNo,
						@RequestParam(value="userId",defaultValue="")String userId,
						@RequestParam(value="alarmSeatNo",defaultValue="")String alarmSeatNo
						) throws Exception{
		
		System.out.println("AlarmRestController :: " +type+","+serialNo+","+userId );
		
		return alarmService.smsPush(type,serialNo,userId,alarmSeatNo);
	}
	
	@RequestMapping("/json/test")
	public String test() throws Exception{

	ObjectMapper om = new ObjectMapper();
	JSONObject jsonObj = (JSONObject)JSONValue.parse("{\"status\":\"200\",\"messages\":[{\"messageId\":\"0-ESG-201710-258-1\",\"requestTime\":\"2017-10-25 14:01:59\",\"from\":\"01071167840\",\"to\":\"01071167840\",\"statusCode\":\"0\"},{\"messageId\":\"0-ESG-201710-258-2\",\"requestTime\":\"2017-10-25 14:01:59\",\"from\":\"01071167840\",\"to\":\"01095948119\",\"statusCode\":\"0\"}]}");
	System.out.println("jsonObj::"+jsonObj);
	System.out.println("jsonObj.get(message)::"+jsonObj.get("messages"));
	List toListOfMessage = new ArrayList();
	org.codehaus.jettison.json.JSONObject cdJsonObj = new org.codehaus.jettison.json.JSONObject("{\"status\":\"200\",\"messages\":[{\"messageId\":\"0-ESG-201710-258-1\",\"requestTime\":\"2017-10-25 14:01:59\",\"from\":\"01071167840\",\"to\":\"01071167840\",\"statusCode\":\"0\"},{\"messageId\":\"0-ESG-201710-258-2\",\"requestTime\":\"2017-10-25 14:01:59\",\"from\":\"01071167840\",\"to\":\"01095948119\",\"statusCode\":\"0\"}]}");
	JSONArray jsonArray = cdJsonObj.getJSONArray("messages");
	for(int i = 0; i < jsonArray.length(); i ++){
			toListOfMessage.add(jsonArray.get(i));
			System.out.println("to ::" + ((JSONObject)JSONValue.parse(toListOfMessage.get(i).toString())).get("to"));
			System.out.println("statusCode :: "+((JSONObject)JSONValue.parse(toListOfMessage.get(i).toString())).get("statusCode"));
		}
	return toListOfMessage.toString();
	}
	
}
