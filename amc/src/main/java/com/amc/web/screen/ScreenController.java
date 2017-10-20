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
import com.amc.service.domain.Movie;
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
	@RequestMapping(value = "getScreenList")
	public String getScreenList(@ModelAttribute("search") Search search, Model model) throws Exception {
		System.out.println("/screen/getScreenList :: POST");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		System.out.println("search�� Ȯ��" + search);
		
		
		
		Map<String, Object> map = screenService.getMovieList(search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);
		
		model.addAttribute("search",map.get("search"));
		model.addAttribute("list",map.get("list"));
		model.addAttribute("resultPage", resultPage);
		
		System.out.println("search"+map.get("search"));
		System.out.println("list"+map.get("list"));
		System.out.println("totalCount" + map.get("totalCount") );
		System.out.println("resultPage"+ resultPage);
		
		System.out.println("/screen/getScreenList :: POST ��");
		return "forward:/screen/listScreenManage.jsp";
	};
	


	// @RequestMapping("/getScreenContentList")
	@RequestMapping(value = "getScreenContentList/{movieNo}", method = RequestMethod.GET)
	public String getScreenContentList(@ModelAttribute("search") Search search, @PathVariable(value="movieNo") int movieNo, Model model) throws Exception {
		System.out.println("screen/getScreenContentList :: GET ������");
	
		//System.out.println("movie��Ȯ��" + movie);
		//Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
	//	movieNo = movie.getMovieNo();
		//System.out.println(resultPage);
		Map<String, Object> map = screenService.getScreenContentList(search, movieNo);
		
	
		
		Movie movie = screenService.getMovie(movieNo);
		

		model.addAttribute("list",map.get("list"));
		model.addAttribute("movie", movie);
		
		System.out.println("33333333333333333"+map.get("list"));
		System.out.println("4444444444444444"+movie);
		System.out.println("screen/getScreenContentList :: GET ����");
		//model.addAttribute("resultPage", resultPage);
		/*model.addAttribute("search", search);
		System.out.println("����������"+search);*/

		
		//model.addAttribute("movie", movie);

		return "forward:/screen/listScreenContent.jsp";
	}
}
