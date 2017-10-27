package com.amc.service.user;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.User;

public interface UserDAO {

	// ȸ������ INSERT
	public void addUser(User user) throws Exception;
	
	// ������Ȯ�� / �α��� SELECT ONE
	public User getUser(String userId) throws Exception;
	
	// ȸ����������Ʈ  SELECT LIST
	public List<User> getUserList(Search search) throws Exception;
	
	// ȸ���������� UPDATE
	public void updateUser(User user) throws Exception;
	
	// ȸ�� id ã��
	public String getId(User user) throws Exception ;
			
	// ȸ�� Ż��
	public void deleteUser(User user) throws Exception;
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
	// ȸ��Ż�� ���� Ȯ��
	public String deleteCheck(User user) throws Exception;
		
}