package com.amc.web.alarm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.amc.service.alarm.AlarmService;


@Controller
@RequestMapping("/alarm/*")
public class AlarmRestController {

	/*
	@Autowired
	@Qualifier("alarmServiceImpl") */
	AlarmService alarmService;
	
	

	public AlarmRestController() {
		System.out.println("PurchaseController() default Constructor");
		
	}
	
	/**
	 * 
	 * @param cancelAlarmNo
	 * @return
	 */
	@RequestMapping("/json/alarm/deleteCancelAlarm")
	public String deleteCancelAlarm(@RequestParam("CancelAlarmNo")int cancelAlarmNo){
		
		return null;
		
	}

	
}
