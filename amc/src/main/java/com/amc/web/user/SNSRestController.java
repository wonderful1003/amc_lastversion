package com.amc.web.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.amc.service.SNSLogin.InstaService;
import com.amc.service.SNSLogin.KakaoService;
import com.amc.service.SNSLogin.NaverService;

@RestController
@RequestMapping("/*")
public class SNSRestController {
	
	@Autowired
	@Qualifier("kakaoServiceImpl")
	private KakaoService kakaoService;
	
	@Autowired
	@Qualifier("naverServiceImpl")
	private NaverService naverService;
	
	@Autowired
	@Qualifier("instaServiceImpl")
	private InstaService instaService;

	
	//인스타그램 로그인 API 시작///////////////////////////////////////////////////////////////////////////////////////////////////////////		
	@RequestMapping(value="/AMC")
	public String getCode() throws Exception{
		System.out.println("UserRestController의 getCode 메소드");
		return "redirect:"+instaService.getCode();
	}
	
	@RequestMapping(value="/instaLogin")
	public String start(@RequestParam("code")String code) throws Exception{
		System.out.println("code : "+code);
		
		return null;
	}

}
