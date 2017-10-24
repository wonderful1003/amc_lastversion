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
	
	
	@RequestMapping(value="unifiedSearch", method=RequestMethod.POST) //POST로 바뀌어야함
	public String unifiedSearch(@ModelAttribute("Search")Search search, Model model) throws Exception{
		
		String searchKeyword = search.getSearchKeyword();
		
		System.out.println("통합검색 서치키워드 : " + search.getSearchKeyword());
		
		model.addAttribute("unifiedSearch",cinemaService.unifiedSearch(searchKeyword));
		
		return "forward:/cinema/unifiedSearch.jsp";
	}
	
	@RequestMapping(value="index", method=RequestMethod.GET)
	public String index(Model model) throws Exception{
		
		model.addAttribute("indexList",cinemaService.index());
		
		return "forward:/index.jsp";
	}
	
}