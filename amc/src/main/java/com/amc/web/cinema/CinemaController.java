package com.amc.web.cinema;

import java.util.HashMap;
import java.util.Map;

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
	@Qualifier("cinemaServiceImpl")
	private CinemaService cinemaService;
	
	public CinemaController(){
		System.out.println("alarmController() default Constructor");
	}
	
	@RequestMapping(value="unifiedSearch", method=RequestMethod.GET)
	public String unifiedSearch(@ModelAttribute("Search")Search search, Model model) throws Exception{
		
		search.setSearchKeyword("ถา");
		
		String searchKeyword = search.getSearchKeyword();
		
		Map<String,Object> unifiedSearch = new HashMap<String,Object>();
		
		unifiedSearch = cinemaService.unifiedSearch(searchKeyword);
		
		System.out.println("Controller" + unifiedSearch.get("uniProdctList"));
		
		model.addAttribute("unifiedSearch",unifiedSearch);
		
		return "forward:/cinema/unifiedSearch.jsp";
	}
	
}