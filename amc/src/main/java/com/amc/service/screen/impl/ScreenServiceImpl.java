package com.amc.service.screen.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.screen.ScreenDAO;
import com.amc.service.screen.ScreenService;

@Repository("screenServiceImpl")
public class ScreenServiceImpl implements ScreenService {
	
	@Autowired
	@Qualifier("screenDAOImpl")
	private ScreenDAO screenDAO;
	
	public void setScreenDAO(ScreenDAO screenDAO){
		this.screenDAO = screenDAO;
	}
	
	public ScreenServiceImpl() {
		System.out.println(this.getClass());	
	}

	@Override
	public List<Movie> getMovieList(Search search) {
		return null;
	}

	@Override
	public Movie getMovie(int movieNo) {
		return null;
	}

	@Override
	public Map<String, Object> getScreenContentList(Search search, int movieNo) {
		System.out.println("ScreenServiceImpl의 getScreenContentList 메소드 시작..");
		
		return screenDAO.getScreenContentList(search, movieNo);
	}
	
	//[예매1단계용]
	@Override
	public List<ScreenContent> getScreenContentList2(Search search, int movieNo) {
		System.out.println("ScreenServiceImpl의 getScreenContentList 메소드 시작..");
		
		return screenDAO.getScreenContentList2(search, movieNo);
	}

	@Override
	public int addScreenContent(ScreenContent screenContent) {
		System.out.println("ScreenServiceImpl의 addScreenContent 메소드 시작..");
		
		
		return screenDAO.addScreenContent(screenContent);
	}

	@Override
	public boolean checkScreenDupTime(String screenOpenTime, String screenEndTime) {
		return false;
	}

	@Override
	public ScreenContent getScreenContent(int screenContentNo) {
		System.out.println("ScreenServiceImpl의 getScreenContent 메소드 시작..");

		return screenDAO.getScreenContent(screenContentNo);
	}

	@Override
	public int updateScreenContent(ScreenContent screenContent) {
		return 0;
	}

	@Override
	public int deleteScreenContent(int screenContentNo) {
		return 0;
	}

}
