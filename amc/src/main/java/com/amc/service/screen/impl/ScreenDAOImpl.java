package com.amc.service.screen.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.screen.ScreenDAO;

@Repository("screenDAOImpl")
public class ScreenDAOImpl implements ScreenDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public Map<String, Object> getMovieList(Search search) {
		System.out.println("ScreenDAOImpl의 getScreenContentList 메소드 시작...");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
	//	map.put("movieNo", movieNo);
		//System.out.println("searchd와 movieNo" + search + "  " + movieNo);

		List<ScreenContent> list = sqlSession.selectList("ScreenContentMapper.getScreenContentList", map);
		map.put("list", list);

		System.out.println("List 값이 뭐게 " + list);

		System.out.println("ScreenDAOImpl의 getScreenContentList 메소드 끝...");
		
		
		
		return null;
	}

	@Override
	public Movie getMovie(int movieNo) {
		System.out.println("ScreenDAOImpl의 getMovie 메소드 시작...");

		
	
		System.out.println("ScreenDAOImpl의 getMovie 메소드 끝...");
		
		return sqlSession.selectOne("MovieMapper.getMovie", movieNo);
		
	}

	@Override
	public Map<String, Object> getScreenContentList(Search search, int movieNo) {
		System.out.println("ScreenDAOImpl의 getScreenContentList 메소드 시작...");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("movieNo", movieNo);
		System.out.println("searchd와 movieNo" + search + "  " + movieNo);

		List<ScreenContent> list = sqlSession.selectList("ScreenContentMapper.getScreenContentList", map);
		map.put("list", list);

		System.out.println("List 값이 뭐게 " + list);

		System.out.println("ScreenDAOImpl의 getScreenContentList 메소드 끝...");
		return map;
	}

	@Override
	public int addScreenContent(ScreenContent screenContent) {
		System.out.println("ScreenDAOImpl의 addScreenContent 메소드 시작...");
		// sqlSession.insert("ScreenContentMapper.addScreenContent",
		// screenContent);
		System.out.println("ScreenDAOImpl의 addScreenContent 메소드 끝...");
		return sqlSession.insert("ScreenContentMapper.addScreenContent", screenContent);
	}

	@Override
	public ScreenContent getScreenContent(int screenContentNo) {
		System.out.println("ScreenDAOImpl의 getScreenContent 메소드 시작...");
		// sqlSession.insert("ScreenContentMapper.addScreenContent",
		// screenContent);
		System.out.println("ScreenDAOImpl의 getScreenContent 메소드 끝...");
		return sqlSession.selectOne("ScreenContentMapper.getScreenContent", screenContentNo);
	}

	@Override
	public int checkScreenDupTime(ScreenContent screenContent) {

		System.out.println("screenDate와 screenOpenTime와 screenEndTime" + screenContent);

		// System.out.println("List 값이 뭐게 " + list);

		System.out.println("ScreenDAOImpl의 getScreenContentList 메소드 끝...");

		return sqlSession.selectOne("ScreenContentMapper.checkScreenDupTime", screenContent);
	}

	@Override
	public int updateScreenContent(ScreenContent screenContent) {
		System.out.println("ScreenDAOImpl의 updateScreenContent 메소드 시작...");
		return sqlSession.update("ScreenContentMapper.updateScreenContent", screenContent);
	}

	@Override
	public int deleteScreenContent(int screenContentNo) {
		System.out.println("ScreenDAOImpl의 deleteScreenContent 메소드 시작...");

		return sqlSession.delete("ScreenContentMapper.deleteScreenContent", screenContentNo);
	}

	@Override
	// 선택한 상영날짜, 상영관에 등록되어있는 시간 목록 가져오기
	public List<ScreenContent> notEmptyScreenContent(ScreenContent screenContent) {
		
		System.out.println("ScreenDAOImpl의 notEmptyScreenContent 메소드 시작...");

		List<ScreenContent> list = sqlSession.selectList("ScreenContentMapper.notEmptyScreenContent", screenContent);

		System.out.println("list값 받아왔니===========>"+list);
		System.out.println("ScreenDAOImpl의 notEmptyScreenContent 메소드 끝...");
		
		
		return list;
	};

}
