package com.amc.web.alarm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@RequestMapping("/json/switchOpenAlarm")
	public String switchOpenAlarm(@ModelAttribute("alarm")Alarm alarm){
		
		alarm.setAlarmFlag("O");
		
		if(alarmService.checkOpenAlarm(alarm).equals("0")){
			alarmService.addOpenAlarm(alarm);
			return "add";
		}else{
			alarmService.deleteOpenAlarm(alarm);
			return "delete";
		}
	}
	
	@RequestMapping("/json/push")
	public String push(@ModelAttribute("alarm")Alarm alarm) throws Exception{
		
		String smsStatus = alarmService.smsPush();
		
		return null;
	}

}
