package com.amc.service.screen.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Page;
import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.domain.onetime.MovieList;
import com.amc.service.screen.ScreenDAO;
import com.amc.service.screen.ScreenService;

@Repository("screenServiceImpl")
public class ScreenServiceImpl implements ScreenService {

	@Autowired
	@Qualifier("screenDAOImpl")
	private ScreenDAO screenDAO;

	public void setScreenDAO(ScreenDAO screenDAO) {
		this.screenDAO = screenDAO;
	}

	public ScreenServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public Map<String, Object> getMovieList(Search search) throws Exception {
		
		System.out.println("ScreenServiceImpl의 getMovieList 메소드 시작..");
		int totalCount = screenDAO.getTotalCount(search);
		Map<String,Object> map = screenDAO.getMovieList(search);
		map.put("totalCount", new Integer(totalCount));
		//Page resultPage = new Page(search.getCurrentPage(),)
		
		
		
		System.out.println("ScreenServiceImpl의 getMovieList 메소드 끝..");
		
	
		return map ;
	}

	@Override
	public Movie getMovie(int movieNo) {
		
		System.out.println("ScreenServiceImpl의 getMovie 메소드 시작..");
		
		return screenDAO.getMovie(movieNo);
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

		boolean checkScreenDupTime = checkScreenDupTime(screenContent);

		if (checkScreenDupTime) {
			return screenDAO.addScreenContent(screenContent);
		} else {
			System.out.println("중복임중복");
			return -1;
		}

	}

	@Override
	public boolean checkScreenDupTime(ScreenContent screenContent) {

		System.out.println("ScreenServiceImpl의 checkScreenDupTime 메소드 시작..");

		System.out.println("뭘까 이값은" + screenDAO.checkScreenDupTime(screenContent));
		int checkScreenDupTime = screenDAO.checkScreenDupTime(screenContent);

		if (checkScreenDupTime == 0) {
			return true;
		} else {
			return false;
		}

	}

	@Override
	public ScreenContent getScreenContent(int screenContentNo) {
		System.out.println("ScreenServiceImpl의 getScreenContent 메소드 시작..");

		return screenDAO.getScreenContent(screenContentNo);
	}

	@Override
	public int updateScreenContent(ScreenContent screenContent) {
		System.out.println("ScreenServiceImpl의 updateScreenContent 메소드 시작..");

		System.out.println("screenContent의 값을보자요" +screenContent);
		boolean checkScreenDupTime = checkScreenDupTime(screenContent);

		if (checkScreenDupTime) {
			return screenDAO.updateScreenContent(screenContent);
		} else {
			System.out.println("중복임중복");
			return -1;
		}

	}

	@Override
	public int deleteScreenContent(int screenContentNo) {
		System.out.println("ScreenServiceImpl의 deleteScreenContent 메소드 시작..");

		return screenDAO.deleteScreenContent(screenContentNo);
	}

	@Override
	// 선택한 상영날짜, 상영관에 등록되어있는 시간 목록 가져오기
	public List<ScreenContent> notEmptyScreenContent(ScreenContent screenContent) {

		return screenDAO.notEmptyScreenContent(screenContent);
	};

}
