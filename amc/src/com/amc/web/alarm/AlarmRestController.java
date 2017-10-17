package com.amc.web.alarm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.amc.service.alarm.AlarmService;


public class AlarmRestController {


	private AlarmService alarmService;

	public AlarmRestController() {
		System.out.println("PurchaseController() default Constructor");
	}
	

	public String deleteCancelAlarm(@RequestParam("CancelAlarmNo")int cancelAlarmNo){
		
		return null;
		
	}
	
}
