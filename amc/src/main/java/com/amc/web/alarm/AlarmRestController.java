package com.amc.web.alarm;

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
	
	public String checkOpenAlarm(@ModelAttribute("alarm")Alarm alarm){
		
		return alarmService.checkOpenAlarm(alarm);
		
	}
	
	@RequestMapping("/json/switchOpenAlarm")
	public String switchOpenAlarm(@ModelAttribute("alarm")Alarm alarm){
		
		alarm.setAlarmFlag("O");
		
		System.out.println(this.getClass().getResource("").getPath()); // 현재 자신의 절대 경로

		System.out.println(this.getClass().getResource("/").getPath()); // classes 폴더의 최상위 경로
		
		if(this.checkOpenAlarm(alarm).equals("0")){
			alarmService.addOpenAlarm(alarm);
			return "add";
		}else{
			alarmService.deleteOpenAlarm(alarm);
			return "delete";
		}
		
		
		
	}
	
	
	
}
