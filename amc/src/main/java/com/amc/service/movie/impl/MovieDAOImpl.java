package com.amc.service.movie.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.MovieAPI;
import com.amc.service.domain.MovieComment;
import com.amc.service.domain.WishList;

import com.amc.service.domain.onetime.MovieList;
import com.amc.service.domain.onetime.MovieOnScheule;
import com.amc.service.domain.onetime.Twitter;
import com.amc.service.movie.MovieDAO;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;

@Repository("movieDAOImpl")
public class MovieDAOImpl implements MovieDAO {
	
	//Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("::" + getClass() +" .setSqlsession Call....");
		this.sqlSession = sqlSession;
		
	}

	//Constructor
	public MovieDAOImpl() {
		System.out.println("::" + getClass() +" default Construcor call....");
	}
	
	// 전체 영화 목록 불러오기 (관리자용)
	public List<Movie> getMoiveAdminList(Search search) {
		return null;
	}
	
	// 상영 영화 스케줄 달력에 불러오기 
	public List<MovieOnScheule> getScreenCalendar(Search search) {
		List<MovieOnScheule> list = sqlSession.selectList("MovieOnScheduleMapper.getScreenCalendar",search);
		System.out.println("list value show :: " + ((MovieOnScheule)list.get(0)).toString());
		
		
		return (sqlSession.selectList("MovieOnScheduleMapper.getScreenCalendar"));
	}


	// 현재 상영 영화 목록 불러오기
	
	public List<Movie> getMovieList(Search search) {
		
		System.out.println("MovieDAOImpl called ....");
		
		/*for(Object m : sqlSession.selectList("MovieMapper.getMovieList",search)){
			System.out.println((Movie)m);
		}*/
		
		List<Movie> list = sqlSession.selectList("MovieMapper.getMovieList",search);
		//System.out.println("list value show :: " + ((Movie)list.get(0)).toString());
		
		return (sqlSession.selectList("MovieMapper.getMovieList",search));
	}
	

	// 상영 예정 영화 목록 불러오기
	public List<Movie> getMoviePreviewList(Search search) {
		return null;
	}

	// 시사회 영화 목록 불러오기
	public List<Movie> getCommingSoonList(Search search) {
		return null;
	}

		
	public Movie getMovie(int movieNo) throws Exception {
		return sqlSession.selectOne("MovieMapper.getMovie",movieNo);
	}

	
	// 영화 수정
	public int updateMovie(Movie movie) throws Exception{
		System.out.println("MovieDAOImpl updateMovie Movie ===>>>>"  + movie);
		return sqlSession.insert("MovieMapper.updateMovie",movie);	
		
	}

	// 영화 삭제
	public int deleteMovie(int movieNo) throws Exception{
		System.out.println("MovieDAOImpl deleteMovie movieNo ===>>>>"  + movieNo);
		return sqlSession.insert("MovieMapper.deleteMovie",movieNo);
	}

	// 마이페이지에서 위시리스트 불러오기
	public List<WishList> getWishList(Search search, String userId) {
		return null;
	}
	
	// 감상평 보기
	public List<MovieComment> getMovieCommentList(Search search, int movieNo) {
		System.out.println("MovieDAOImpl의 getMovieCommentList 시작 ");
		System.out.println("1. Search ==> "+ search);
		System.out.println("2. movieNo ==> " + movieNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("movieNo", movieNo);
		
		System.out.println("3. map ==> " + map);
		return sqlSession.selectList("MovieCommentMapper.getMovieCommentList", map);
		
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
	@Override	
	public int addMoiveComment(MovieComment movieComment) {
		System.out.println("movieDAOImpl의 addMoiveComment 시작 ");
		System.out.println("1. movieComment ==> " +movieComment);
		System.out.println("movieDAOImpl의 addMoiveComment 끝 ");
		return sqlSession.insert("MovieCommentMapper.addMovieComment",movieComment);
	}

	// 부적절한 감상평 블라인드 처리 유무
	@Override	
	public int blindMoiveComment(MovieComment movieComment) {
		System.out.println("movieDAOImpl의 blindMoiveComment 시작 ");
		System.out.println("1. movieComment ==> " +movieComment);
		System.out.println("movieDAOImpl의 blindMoiveComment 끝 ");
		return sqlSession.insert("MovieCommentMapper.updateBlindCommentFlag",movieComment);
	}

	// 감상평 수정
	@Override	
	public int updateMovieComment(MovieComment movieComment) {
		System.out.println("movieDAOImpl의 updateMovieComment 시작 ");
		System.out.println("1. movieComment ==> " +movieComment);
		System.out.println("movieDAOImpl의 updateMovieComment 끝 ");
		return sqlSession.insert("MovieCommentMapper.updateMovieComment",movieComment);
		
	}
	
	@Override
	public MovieComment getMovieComment(int movieCommentNo) {
		System.out.println("movieDAOImpl의 addMoiveComment 시작 ");
		System.out.println("1. movieCommentNo ==> " +movieCommentNo);
		System.out.println("movieDAOImpl의 addMoiveComment 끝 ");
		return sqlSession.selectOne("MovieCommentMapper.getMovieComment",movieCommentNo);
	}

	// 감상평 삭제
	@Override	
	public int deleteMovieComment(int movieCommentNo) {
		System.out.println("movieDAOImpl의 deleteMovieComment 시작 ");
		System.out.println("1. movieCommentNo ==> " +movieCommentNo);
		System.out.println("movieDAOImpl의 deleteMovieComment 끝 ");
		return sqlSession.delete("MovieCommentMapper.deleteMovieComment",movieCommentNo);
		
	}
	
	@Override	
	public int addMovie(Movie movie) 	 {
		System.out.println("MovieDAOImpl called ... addMovie...");
		
		
		System.out.println("actorNms     ::" + movie.getActors());
	    System.out.println("directorNms  ::" + movie.getDirector());
	    System.out.println("genreNms     ::" + movie.getGenres());
	    System.out.println("movieNm      ::" + movie.getMovieNm());
	    System.out.println("postUrl      ::" + movie.getPostUrl());
	    System.out.println("watchGradeNm ::" + movie.getWatchGradeNm());
	    System.out.println("showTm       ::" + movie.getShowTm());
	    System.out.println("openDt       ::" + movie.getOpenDt());
	    System.out.println("movieEndDate ::" + movie.getEndDt());
	    System.out.println("syonpsis     ::" + movie.getSynopsis());
	    System.out.println("trailer      ::" + movie.getTrailer());
    	
		
		return sqlSession.insert("MovieMapper.addMovie",movie);
		
}

	@Override	
	public List<MovieList> getAPIMoiveList() throws Exception{
		HttpServletRequest request = null;
		HttpServletResponse response;
						
		/*
		String curPage = request.getParameter("curPage")==null?"1":request.getParameter("curPage");					    //현재페이지
		String itemPerPage = request.getParameter("itemPerPage")==null?"200":request.getParameter("itemPerPage");		//결과row수
		String movieNm = request.getParameter("movieNm")==null?"":request.getParameter("movieNm");						//영화명
		String directorNm = request.getParameter("directorNm")==null?"":request.getParameter("directorNm");				//감독명
		String openStartDt = request.getParameter("openStartDt")==null?"":request.getParameter("openStartDt");			//개봉연도 시작조건 ( YYYY )
		String openEndDt = request.getParameter("openEndDt")==null?"":request.getParameter("openEndDt");				//개봉연도 끝조건 ( YYYY )	
		String prdtStartYear = request.getParameter("prdtStartYear")==null?"2017":request.getParameter("prdtStartYear");	//제작연도 시작조건 ( YYYY )
		String prdtEndYear = request.getParameter("prdtEndYear")==null?"":request.getParameter("prdtEndYear");			//제작연도 끝조건    ( YYYY )
		String repNationCd = request.getParameter("repNationCd")==null?"":request.getParameter("repNationCd");			//대표국적코드 (공통코드서비스에서 '2204'로 조회된 국가코드)
		String[] movieTypeCdArr = request.getParameterValues("movieTypeCdArr")==null? null:request.getParameterValues("movieTypeCdArr");	//영화형태코드 배열 (공통코드서비스에서 '2201'로 조회된 영화형태코드)
	    */
		// 발급키
		String key = "430156241533f1d058c603178cc3ca0e";
		//KOBIS 오픈 API Rest Client를 통해 호출
		KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
		
		
		// 영화코드조회 서비스 호출 (boolean isJson, String curPage, String itemPerPage,String directorNm, String movieCd, String movieNm, String openStartDt,String openEndDt, String ordering, String prdtEndYear, String prdtStartYear, String repNationCd, String[] movieTypeCdArr)
		//String movieCdResponse = service.getMovieList(true, curPage, itemPerPage, movieNm, directorNm, openStartDt, openEndDt, prdtStartYear, prdtEndYear, repNationCd, movieTypeCdArr);
		String movieCdResponse = service.getMovieList(true, "1", "200", "", "", "2017", "2017", "", "", "", null);
		
		ObjectMapper mapper = new ObjectMapper();
		System.out.println("movieCdResponse" + movieCdResponse);
		
		
		MovieAPI movieAPI = mapper.readValue(movieCdResponse, MovieAPI.class);
		List<MovieList> list =  movieAPI.getMovieListResult().getMovieList();
		
		System.out.println("MoveList list :: " + list);
		
		return list;

	}

	@Override
	public int existWish(int moiveNo, String userId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteWish(int moiveNo, String userId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Twitter> getTwitterList(String movieName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalCount(Search search) throws Exception {		
		return sqlSession.selectOne("MovieMapper.getTotalCount",search);
	}
	
	
// 해림 메소드 추가
	@Override
	public int getTotalCount(int movieNo) throws Exception {		
		return sqlSession.selectOne("MovieCommentMapper.getTotalCount",movieNo);
	}


	@Override
	public List<Movie> uniMovieList(Search search) {
		return sqlSession.selectList("MovieMapper.uniMovieList",search);
	}
}
