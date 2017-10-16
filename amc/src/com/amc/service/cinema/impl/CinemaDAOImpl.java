package com.amc.service.cinema.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.cinema.CinemaDAO;

@Repository("cinemaDaoImpl")
public class CinemaDAOImpl implements CinemaDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;

	public CinemaDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Map<String, List<Object>> unifiedSearch(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, List<Object>> index() {
		// TODO Auto-generated method stub
		return null;
	}

}
