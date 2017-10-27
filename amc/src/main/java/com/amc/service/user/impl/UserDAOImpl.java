

package com.amc.service.user.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.domain.User;
import com.amc.service.user.UserDAO;

//==> 회원관리 DAO CRUD 구현
@Repository("userDAO")
public class UserDAOImpl implements UserDAO {

	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	///Constructor
	public UserDAOImpl() {
		System.out.println(this.getClass());
	}
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	///Method
	@Override
	public String getId(User user) throws Exception {
		// TODO Auto-generated method stub
		user = sqlSession.selectOne("UserMapper.getId",  user);
		return user.getUserId();
	}

	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("addUser DAOImpl 값 :" + user);
		sqlSession.insert("UserMapper.addUser", user);
	}

	@Override
	public User getUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.getUser", userId);
	}

	@Override
	public List<User> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getUserList", search);
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("UserMapper.updateUser", user);
	}

	@Override
	public void deleteUser(User user) throws Exception {
		System.out.println("탈퇴 합시다 deleteUser daoimpl "+user);
		
		sqlSession.update("UserMapper.deleteUser", user);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}

	@Override
	public String deleteCheck(User user) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.deleteCheck", user);
	}

}
