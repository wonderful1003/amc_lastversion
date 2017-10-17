package com.amc.web.alarm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.amc.common.Search;
import com.amc.service.alarm.AlarmService;

@Controller
@RequestMapping("/alarm/*")
public class AlarmController {
	
	//@Autowired
	//@Qualifier("alarmServiceImpl")
	private AlarmService alarmService;
	
	public AlarmController(){
		System.out.println("alarmController() default Constructor");
	}
	
	@RequestMapping(value="getCancelAlarmList", method=RequestMethod.GET)
	public String getCancelAlarmList(@ModelAttribute("Search")Search search, Model model) throws Exception{
		
		alarmService.getCancelAlarmList(search);
		
		return null;
		
	}

}

	

