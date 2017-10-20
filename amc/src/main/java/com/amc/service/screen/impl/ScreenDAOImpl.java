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
		System.out.println("ScreenDAOImpl�� getScreenContentList �޼ҵ� ����...");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
	//	map.put("movieNo", movieNo);
		//System.out.println("searchd�� movieNo" + search + "  " + movieNo);

		List<ScreenContent> list = sqlSession.selectList("ScreenContentMapper.getScreenContentList", map);
		map.put("list", list);

		System.out.println("List ���� ���� " + list);

		System.out.println("ScreenDAOImpl�� getScreenContentList �޼ҵ� ��...");
		
		
		
		return null;
	}

	@Override
	public Movie getMovie(int movieNo) {
		System.out.println("ScreenDAOImpl�� getMovie �޼ҵ� ����...");

		
	
		System.out.println("ScreenDAOImpl�� getMovie �޼ҵ� ��...");
		
		return sqlSession.selectOne("MovieMapper.getMovie", movieNo);
		
	}

	@Override
	public Map<String, Object> getScreenContentList(Search search, int movieNo) {
		System.out.println("ScreenDAOImpl�� getScreenContentList �޼ҵ� ����...");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("movieNo", movieNo);
		System.out.println("searchd�� movieNo" + search + "  " + movieNo);

		List<ScreenContent> list = sqlSession.selectList("ScreenContentMapper.getScreenContentList", map);
		map.put("list", list);

		System.out.println("List ���� ���� " + list);

		System.out.println("ScreenDAOImpl�� getScreenContentList �޼ҵ� ��...");
		return map;
	}

	@Override
	public int addScreenContent(ScreenContent screenContent) {
		System.out.println("ScreenDAOImpl�� addScreenContent �޼ҵ� ����...");
		// sqlSession.insert("ScreenContentMapper.addScreenContent",
		// screenContent);
		System.out.println("ScreenDAOImpl�� addScreenContent �޼ҵ� ��...");
		return sqlSession.insert("ScreenContentMapper.addScreenContent", screenContent);
	}

	@Override
	public ScreenContent getScreenContent(int screenContentNo) {
		System.out.println("ScreenDAOImpl�� getScreenContent �޼ҵ� ����...");
		// sqlSession.insert("ScreenContentMapper.addScreenContent",
		// screenContent);
		System.out.println("ScreenDAOImpl�� getScreenContent �޼ҵ� ��...");
		return sqlSession.selectOne("ScreenContentMapper.getScreenContent", screenContentNo);
	}

	@Override
	public int checkScreenDupTime(ScreenContent screenContent) {

		System.out.println("screenDate�� screenOpenTime�� screenEndTime" + screenContent);

		// System.out.println("List ���� ���� " + list);

		System.out.println("ScreenDAOImpl�� getScreenContentList �޼ҵ� ��...");

		return sqlSession.selectOne("ScreenContentMapper.checkScreenDupTime", screenContent);
	}

	@Override
	public int updateScreenContent(ScreenContent screenContent) {
		System.out.println("ScreenDAOImpl�� updateScreenContent �޼ҵ� ����...");
		return sqlSession.update("ScreenContentMapper.updateScreenContent", screenContent);
	}

	@Override
	public int deleteScreenContent(int screenContentNo) {
		System.out.println("ScreenDAOImpl�� deleteScreenContent �޼ҵ� ����...");

		return sqlSession.delete("ScreenContentMapper.deleteScreenContent", screenContentNo);
	}

	@Override
	// ������ �󿵳�¥, �󿵰��� ��ϵǾ��ִ� �ð� ��� ��������
	public List<ScreenContent> notEmptyScreenContent(ScreenContent screenContent) {
		
		System.out.println("ScreenDAOImpl�� notEmptyScreenContent �޼ҵ� ����...");

		List<ScreenContent> list = sqlSession.selectList("ScreenContentMapper.notEmptyScreenContent", screenContent);

		System.out.println("list�� �޾ƿԴ�===========>"+list);
		System.out.println("ScreenDAOImpl�� notEmptyScreenContent �޼ҵ� ��...");
		
		
		return list;
	};

}
