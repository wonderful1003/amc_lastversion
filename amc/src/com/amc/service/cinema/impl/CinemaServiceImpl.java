package com.amc.service.cinema.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.cinema.CinemaDAO;
import com.amc.service.cinema.CinemaService;

@Service("cinemaServiceImpl")
public class CinemaServiceImpl implements CinemaService {

	@Autowired
	@Qualifier("cinemaDaoImpl")
	CinemaDAO cinemaDAO;
	
	public CinemaServiceImpl() {
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

	@Override
	public String getPanorama(int theaterNo) {
		// TODO Auto-generated method stub
		return null;
	}

}
