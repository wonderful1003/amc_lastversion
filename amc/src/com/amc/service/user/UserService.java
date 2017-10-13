package com.amc.service.user;

import java.util.Map;

import com.amc.common.Search;
import com.amc.service.domain.User;

public interface UserService {
	
	// 회원가입
	public void addUser(User user) throws Exception;
	
	// 내정보확인 / 로그인
	public User getUser(String userId) throws Exception;
	
	// 회원정보리스트 
	public Map<String, Object> getUserList(Search search) throws Exception;
	
	// 회원정보수정
	public void updateUser(User user) throws Exception;
	
	// 회원 ID 중복 확인	
	public boolean checkDuplication(String userId) throws Exception;
	
	// 회원 탈퇴
	public void deleteUser(User user) throws Exception;
	
	//kakao
	public String getCode() throws Exception;
		
	public String getAccessToken(String authorize_code) throws Exception;
	
	public String getHtml(String accesstoken) throws Exception;
	
	public Map<String,String> JsonStringMap(String data) throws Exception;
	
	public String getAllList(String access_token) throws Exception;
	
	
	
	

}
