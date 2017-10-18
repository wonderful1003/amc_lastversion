package com.amc.web.screen;

import java.util.List;
import java.util.Map;

import javax.swing.plaf.synth.SynthSplitPaneUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.screen.ScreenService;

@RestController
@RequestMapping("/screen/*")
public class ScreenRestController {

	@Autowired
	@Qualifier("screenServiceImpl")
	private ScreenService screenService;

	public ScreenRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	
	@RequestMapping(value = "json/getScreenContentList/{movieNo}", method = RequestMethod.GET)
	public List<ScreenContent> getScreenContentList(@ModelAttribute("search") Search search, @PathVariable int movieNo, Model model) {
		System.out.println("json/screen/getScreenContentList :: GET");
		
		System.out.println("movieNo ===>" +movieNo);
		
		
		Map<String, Object> map = screenService.getScreenContentList(search, movieNo);
		
		List<ScreenContent> list = (List<ScreenContent>)map.get("list");
		
		System.out.println("List값이 뭘까" + list);
		//Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		//System.out.println(resultPage);
		
		//model.addAttribute("list",map.get("list"));
		//model.addAttribute("resultPage", resultPage);
		//model.addAttribute("search", search);
		System.out.println("json/screen/getScreenContentList :: GET 끝이니");
		return list;
	}
	

	@RequestMapping(value = "json/addScreenContent/{movieNo}", method = RequestMethod.POST)
	public int addScreenContent(@RequestBody ScreenContent screenContent, @PathVariable int movieNo) {

		System.out.println("screen/json/addScreenContent :: POST");
		//System.out.println("movieNo값있니"+movieNo);
		screenContent.setMovie(new Movie());
		screenContent.getMovie().setMovieNo(10000);
		System.out.println("screenContent값 확인해볼까"+screenContent);
		///screenService.addScreenContent(screenContent);
		System.out.println("screen/json/addScreenContent :: POST 끝.....");
		
		return screenService.addScreenContent(screenContent);
	
	};

	// 상영 내용 수정
	@RequestMapping(value = "json/updateScreenContent/{screenContentNo}", method = RequestMethod.GET)
	public ScreenContent updateScreenContent(@PathVariable int screenContentNo) {
		System.out.println("screen/json/updateScreenContent :: GET 시작...");
		ScreenContent screenContent = screenService.getScreenContent(screenContentNo);

		System.out.println("screenContent 잘 가져오나 볼까"+screenContent);
		System.out.println("screen/json/updateScreenContent :: GET 끝...");

		return screenContent;
	};

	@RequestMapping(value = "json/updateScreenContent", method = RequestMethod.POST)
	public String updateScreenContent(ScreenContent screenContent) {
		System.out.println("screen/json/updateScreenContent :: POST");
		screenService.updateScreenContent(screenContent);

		return null;
	};

	// 상영 내용 삭제
	@RequestMapping(value = "json/deleteScreenContent/{screenContentNo}", method = RequestMethod.GET)
	public String deleteScreenContent(@PathVariable int screenContentNo) {
		System.out.println("screen/json/updateScreenContent :: GET");
		screenService.deleteScreenContent(screenContentNo);
		
		return null;
	};

}
