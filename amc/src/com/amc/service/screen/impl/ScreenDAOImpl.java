package com.amc.service.screen.impl;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.ScreenContent;
import com.amc.service.screen.ScreenDAO;

public class ScreenDAOImpl implements ScreenDAO {

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
