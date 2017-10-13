package com.amc.service.movie.impl;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.MovieAPI;
import com.amc.service.domain.WishList;
import com.amc.service.domain.onetime.MovieComment;
import com.amc.service.domain.onetime.Twitter;
import com.amc.service.movie.MovieDAOAdapter;

public class MovieDAOImpl extends MovieDAOAdapter {


	// 전체 영화 목록 불러오기 (관리자용)
	public List<Movie> getMoiveAdminList(Search search) {
		return null;
	}

	// 현재 상영 영화 목록 불러오기
	public List<Movie> getMovieList(Search search) {
		return null;
	}

	// 상영 예정 영화 목록 불러오기
	public List<Movie> getMoviePreviewList(Search search) {
		return null;
	}

	// 시사회 영화 목록 불러오기
	public List<Movie> getCommingSoonList(Search search) {
		return null;
	}

	public Movie getMovie(int movieNo) {
		return null;
	}

	// 영화 수정
	public void updateMovie(Movie movie) {
	}

	// 영화 삭제
	public void deleteMovie(int movieNo) {
	}

	// 마이페이지에서 위시리스트 불러오기
	public List<WishList> getWishList(Search search, String userId) {
		return null;
	}
	
	// 감상평 보기
	public List<MovieComment> getMovieCommentList(Search search, int movieNo) {
		return null;
	}
	
	// 차트목록 가져오기
	public List<Movie> getChart(int movieNo) {
		return null;
	}


	// RESTCONTROLLER 타는 부분


	// 관리목록에서 클릭한경우는 수정화면으로, 영화목록에서 클릭한경우는 상세정보화면으로

	// 회원이 하트를 눌렀을때 위시리스트에 존재 하는지 안하는지 확인(Count로), 존재하면 delete 존재하지않으면 add
	public int addWish(int movieNo) {
		return 0;
	}

	// 영화에 대한 감상평 입력
	public int addMoiveComment(MovieComment movieComment) {
		return 0;
	}

	// 부적절한 감상평 블라인드 처리 유무
	public int blindMoiveComment(int movieCommentNo) {
		return 0;
	}

	// 감상평 수정
	public int updateMovieCommnet(MovieComment movieComment) {
		return 0;
	}

	// 감상평 삭제
	public int deleteMovieComment(int movieCommentNo) {
		return 0;
	}
	

}
