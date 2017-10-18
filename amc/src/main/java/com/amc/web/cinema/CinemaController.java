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
import com.amc.service.movie.MovieService;

@Controller
@RequestMapping("/cinema/*")
public class CinemaController {

	@Autowired
	@Qualifier("cinemaServiceImpl")
	private CinemaService cinemaService;
	
	public CinemaController(){
		System.out.println("cinemaController() default Constructor");
	}
	
	
	@RequestMapping(value="unifiedSearch", method=RequestMethod.GET) //POST·Î ¹Ù²î¾î¾ßÇÔ
	public String unifiedSearch(@ModelAttribute("Search")Search search, Model model) throws Exception{
		
		search.setSearchKeyword("¶Ò");
		
		search.setSearchCondition(null);
		
		String searchKeyword = search.getSearchKeyword();
		
		model.addAttribute("unifiedSearch",cinemaService.unifiedSearch(searchKeyword));
		
		return "forward:/cinema/unifiedSearch.jsp";
	}
	
	@RequestMapping(value="index", method=RequestMethod.GET)
	public String index(Model model) throws Exception{
		
		return "forward:/index.jsp";
	}
	
}