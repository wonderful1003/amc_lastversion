package com.amc.service.SNSLogin.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.service.SNSLogin.InstaService;

@Service("instaServiceImpl")
public class InstaServiceImpl implements InstaService{

	///Field
	@Autowired
	@Qualifier("userDAO")

	
	///////////////////////////////////////////////////////////////////////////////////////////////
	//CLIENT ID
	private static final String CLIENT_ID = "ab28d16601684a4da5698a0c3cdcf833";
	//Client_Secret
	private static final String Client_Sectret = "be425817d9b641039ab82fcd604a979a";
	//redirect_uri	
	private static final String REDIRECT_URI = "http://localhost:8080/instaLogin";
	
	
	//TODO : CODE ¹Þ±â.
	public String getCode(){
	/*
	 * https://api.instagram.com/oauth/authorize/?client_id=CLIENT-ID
	 * &redirect_uri=REDIRECT-URI
	 * &response_type=code*/
		System.out.println("¿ØÁö ±×·²°Í°°¾Æ¼­");
		String codeUrl =  "https://api.instagram.com/oauth/authorize/?client_id="+CLIENT_ID
				+"&redirect_uri="+REDIRECT_URI
				+"&response_type=code";
		System.out.println("ÀÌ·±Á¨Àå");
		return codeUrl;
	}

}
