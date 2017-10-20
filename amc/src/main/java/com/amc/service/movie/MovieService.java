package com.amc.service.movie;

import java.util.List;
import java.util.Map;

import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.MovieAPI;
import com.amc.service.domain.WishList;
import com.amc.service.domain.onetime.MovieComment;
import com.amc.service.domain.onetime.MovieList;
import com.amc.service.domain.onetime.Twitter;


public interface MovieService {

	// 전체 영화 목록 불러오기 (관리자용)
	public List<Movie> getMoiveAdminList(Search search);

	// 현재 상영 영화 목록 불러오기
	public Map<String, Object> getMovieList(Search search) throws Exception;

	// 상영 예정 영화 목록 불러오기
	public List<Movie> getMoviePreviewList(Search search);

	// 시사회 영화 목록 불러오기
	public List<Movie> getCommingSoonList(Search search);
	
	public Movie getMovie(int movieNo) throws Exception;

	// 영화 수정
	public int updateMovie(Movie movie) throws Exception;

	// 영화 삭제
	public int deleteMovie(int movieNo) throws Exception;

	// 마이페이지에서 위시리스트 불러오기
	public List<WishList> getWishList(Search search, String userId);

	// RESTCONTROLLER 타는 부분

	// 등록을 누른 후 외부 영화 API 목록 불러오기
	public List<MovieList> getAPIMoiveList() throws Exception;

	// submit을 누른후 외부 영화 API 상세 + 네이버 영화 포스터 API를 가져온 후 DB등록
	public int addMovie(Movie movie);
	// 관리목록에서 클릭한경우는 수정화면으로, 영화목록에서 클릭한경우는 상세정보화면으로

	// 회원이 하트를 눌렀을때 위시리스트에 존재 하는지 안하는지 확인(Count로), 존재하면 delete 존재하지않으면 add
	public int addWish(int movieNo);

	// 영화에 대한 감상평 입력
	public int addMoiveComment(MovieComment movieComment);

	// 부적절한 감상평 블라인드 처리 유무
	public int blindMoiveComment(int movieCommentNo);

	// 감상평 수정
	public int updateMovieCommnet(MovieComment movieComment);

	// 감상평 삭제
	public int deleteMovieComment(int movieCommentNo);
	
	// 감상평 보기
	public List<MovieComment> getMovieCommentList(Search search, int movieNo);
	
	// 차트목록 가져오기
	public List<Movie> getChart(int movieNo);
	
	// 트위터 가져오기
	public List<Twitter> getTwitterList(String movieName);
	

}
