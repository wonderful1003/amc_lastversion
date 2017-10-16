package com.amc.web.cinema;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.amc.common.Search;
import com.amc.service.cinema.CinemaService;

@Controller
@RequestMapping("/cinema/*")
public class CinemaController {

	@Autowired
	@Qualifier("alarmServiceImpl")
	private CinemaService clarmService;
	
	public CinemaController(){
		System.out.println("alarmController() default Constructor");
	}
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String getCancelAlarmList(@ModelAttribute("Search")Search search, Model model) throws Exception{
		
		return null;
		
	}
	
}
