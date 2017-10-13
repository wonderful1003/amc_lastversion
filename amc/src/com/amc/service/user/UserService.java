package com.amc.service.user;

import java.util.Map;

import com.amc.common.Search;
import com.amc.service.domain.User;

public interface UserService {
	
	// ȸ������
	public void addUser(User user) throws Exception;
	
	// ������Ȯ�� / �α���
	public User getUser(String userId) throws Exception;
	
	// ȸ����������Ʈ 
	public Map<String, Object> getUserList(Search search) throws Exception;
	
	// ȸ����������
	public void updateUser(User user) throws Exception;
	
	// ȸ�� ID �ߺ� Ȯ��	
	public boolean checkDuplication(String userId) throws Exception;
	
	// ȸ�� Ż��
	public void deleteUser(User user) throws Exception;
	
	//kakao
	public String getCode() throws Exception;
		
	public String getAccessToken(String authorize_code) throws Exception;
	
	public String getHtml(String accesstoken) throws Exception;
	
	public Map<String,String> JsonStringMap(String data) throws Exception;
	
	public String getAllList(String access_token) throws Exception;
	
	
	
	

}
