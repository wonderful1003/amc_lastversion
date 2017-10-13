package com.amc.service.movie.impl;

import java.util.List;

import com.amc.service.domain.MovieAPI;
import com.amc.service.movie.MovieDAOAdapter;

public class MovieApiDAOImpl extends MovieDAOAdapter {
	
	
	
	
		// RESTCONTROLLER 타는 부분

		// 등록을 누른 후 외부 영화 API 목록 불러오기
		public List<MovieAPI> getAPIMoiveList() {
			return null;
		}

		// submit을 누른후 외부 영화 API 상세 + 네이버 영화 포스터 API를 가져온 후 DB등록
		public int addMovie(MovieAPI movieAPI) {
			return 0;
		}
		// 관리목록에서 클릭한경우는 수정화면으로, 영화목록에서 클릭한경우는 상세정보화면으로

	
	
	

}
