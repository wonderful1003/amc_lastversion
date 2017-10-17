package com.amc.service.screen.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.domain.ScreenContent;
import com.amc.service.screen.ScreenDAO;

@Repository("screenDAOImpl")
public class ScreenDAOImpl implements ScreenDAO {

	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	@Override
	public List<ScreenContent> getScreenContentList(Search search, int screenNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int addScreenContent(ScreenContent screenContent) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean checkScreenDupTime(String screenOpenTime, String screenEndTime) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int updateScreenContent(ScreenContent screenContent) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteScreenContent(int screenContentNo) {
		// TODO Auto-generated method stub
		return 0;
	}


}
