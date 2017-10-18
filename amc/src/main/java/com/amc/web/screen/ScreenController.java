package com.amc.web.screen;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.amc.common.Page;
import com.amc.common.Search;
import com.amc.service.screen.ScreenService;

@Controller
@RequestMapping("/screen/*")
public class ScreenController {

	@Autowired
	@Qualifier("screenServiceImpl")
	private ScreenService screenService;

	public ScreenController() {

		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	

	// @RequestMapping("/getMoiveList")
	@RequestMapping(value = "getMoiveList", method = RequestMethod.GET)
	public String getMovieList(@ModelAttribute("search") Search search, Model model) throws Exception {
		System.out.println("/screen/getMovieList :: GET");
		screenService.getMovieList(search);

		return null;
	};

	// @RequestMapping("/getScreenContentList")
	@RequestMapping(value = "getScreenContentList/{movieNo}", method = RequestMethod.GET)
	public String getScreenContentList(@ModelAttribute("search") Search search, @PathVariable int movieNo, Model model) {
		System.out.println("json/screen/getScreenContentList :: GET");
		
		System.out.println("movieNo ===>" +movieNo);
		
		Map<String, Object> map = screenService.getScreenContentList(search, movieNo);
		
		
		System.out.println("왜안돼동나몬ㅇ리ㅗㄴㅁ이ㅏ러;미낭러");
		
		//Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		//System.out.println(resultPage);
		
		model.addAttribute("list",map.get("list"));
		//model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/screen/listScreenContent.jsp";
	}
}
