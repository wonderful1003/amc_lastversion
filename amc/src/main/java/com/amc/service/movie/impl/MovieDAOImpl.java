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
	
	// ��ü ��ȭ ��� �ҷ����� (�����ڿ�)
	public List<Movie> getMoiveAdminList(Search search) {
		return null;
	}
	
	// �� ��ȭ ������ �޷¿� �ҷ����� 
	public List<MovieOnScheule> getScreenCalendar(Search search) {
		List<MovieOnScheule> list = sqlSession.selectList("MovieOnScheduleMapper.getScreenCalendar",search);
		System.out.println("list value show :: " + ((MovieOnScheule)list.get(0)).toString());
		
		
		return (sqlSession.selectList("MovieOnScheduleMapper.getScreenCalendar"));
	}


	// ���� �� ��ȭ ��� �ҷ�����
	
	public List<Movie> getMovieList(Search search) {
		
		System.out.println("MovieDAOImpl called ....");
		
		/*for(Object m : sqlSession.selectList("MovieMapper.getMovieList",search)){
			System.out.println((Movie)m);
		}*/
		
		List<Movie> list = sqlSession.selectList("MovieMapper.getMovieList",search);
		//System.out.println("list value show :: " + ((Movie)list.get(0)).toString());
		
		return (sqlSession.selectList("MovieMapper.getMovieList",search));
	}
	

	// �� ���� ��ȭ ��� �ҷ�����
	public List<Movie> getMoviePreviewList(Search search) {
		return null;
	}

	// �û�ȸ ��ȭ ��� �ҷ�����
	public List<Movie> getCommingSoonList(Search search) {
		return null;
	}

		
	public Movie getMovie(int movieNo) throws Exception {
		return sqlSession.selectOne("MovieMapper.getMovie",movieNo);
	}

	
	// ��ȭ ����
	public int updateMovie(Movie movie) throws Exception{
		System.out.println("MovieDAOImpl updateMovie Movie ===>>>>"  + movie);
		return sqlSession.insert("MovieMapper.updateMovie",movie);	
		
	}

	// ��ȭ ����
	public int deleteMovie(int movieNo) throws Exception{
		System.out.println("MovieDAOImpl deleteMovie movieNo ===>>>>"  + movieNo);
		return sqlSession.insert("MovieMapper.deleteMovie",movieNo);
	}

	// �������������� ���ø���Ʈ �ҷ�����
	public List<WishList> getWishList(Search search, String userId) {
		return null;
	}
	
	// ������ ����
	public List<MovieComment> getMovieCommentList(Search search, int movieNo) {
		System.out.println("MovieDAOImpl�� getMovieCommentList ���� ");
		System.out.println("1. Search ==> "+ search);
		System.out.println("2. movieNo ==> " + movieNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("movieNo", movieNo);
		
		System.out.println("3. map ==> " + map);
		return sqlSession.selectList("MovieCommentMapper.getMovieCommentList", map);
		
	}
	
	// ��Ʈ��� ��������
	public List<Movie> getChart(int movieNo) {
		return null;
	}


	// RESTCONTROLLER Ÿ�� �κ�


	// ������Ͽ��� Ŭ���Ѱ��� ����ȭ������, ��ȭ��Ͽ��� Ŭ���Ѱ��� ������ȭ������

	// ȸ���� ��Ʈ�� �������� ���ø���Ʈ�� ���� �ϴ��� ���ϴ��� Ȯ��(Count��), �����ϸ� delete �������������� add
	public int addWish(int movieNo) {
		return 0;
	}

	// ��ȭ�� ���� ������ �Է�
	@Override	
	public int addMoiveComment(MovieComment movieComment) {
		System.out.println("movieDAOImpl�� addMoiveComment ���� ");
		System.out.println("1. movieComment ==> " +movieComment);
		System.out.println("movieDAOImpl�� addMoiveComment �� ");
		return sqlSession.insert("MovieCommentMapper.addMovieComment",movieComment);
	}

	// �������� ������ ����ε� ó�� ����
	@Override	
	public int blindMoiveComment(MovieComment movieComment) {
		System.out.println("movieDAOImpl�� blindMoiveComment ���� ");
		System.out.println("1. movieComment ==> " +movieComment);
		System.out.println("movieDAOImpl�� blindMoiveComment �� ");
		return sqlSession.insert("MovieCommentMapper.updateBlindCommentFlag",movieComment);
	}

	// ������ ����
	@Override	
	public int updateMovieComment(MovieComment movieComment) {
		System.out.println("movieDAOImpl�� updateMovieComment ���� ");
		System.out.println("1. movieComment ==> " +movieComment);
		System.out.println("movieDAOImpl�� updateMovieComment �� ");
		return sqlSession.insert("MovieCommentMapper.updateMovieComment",movieComment);
		
	}
	
	@Override
	public MovieComment getMovieComment(int movieCommentNo) {
		System.out.println("movieDAOImpl�� addMoiveComment ���� ");
		System.out.println("1. movieCommentNo ==> " +movieCommentNo);
		System.out.println("movieDAOImpl�� addMoiveComment �� ");
		return sqlSession.selectOne("MovieCommentMapper.getMovieComment",movieCommentNo);
	}

	// ������ ����
	@Override	
	public int deleteMovieComment(int movieCommentNo) {
		System.out.println("movieDAOImpl�� deleteMovieComment ���� ");
		System.out.println("1. movieCommentNo ==> " +movieCommentNo);
		System.out.println("movieDAOImpl�� deleteMovieComment �� ");
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
		String curPage = request.getParameter("curPage")==null?"1":request.getParameter("curPage");					    //����������
		String itemPerPage = request.getParameter("itemPerPage")==null?"200":request.getParameter("itemPerPage");		//���row��
		String movieNm = request.getParameter("movieNm")==null?"":request.getParameter("movieNm");						//��ȭ��
		String directorNm = request.getParameter("directorNm")==null?"":request.getParameter("directorNm");				//������
		String openStartDt = request.getParameter("openStartDt")==null?"":request.getParameter("openStartDt");			//�������� �������� ( YYYY )
		String openEndDt = request.getParameter("openEndDt")==null?"":request.getParameter("openEndDt");				//�������� ������ ( YYYY )	
		String prdtStartYear = request.getParameter("prdtStartYear")==null?"2017":request.getParameter("prdtStartYear");	//���ۿ��� �������� ( YYYY )
		String prdtEndYear = request.getParameter("prdtEndYear")==null?"":request.getParameter("prdtEndYear");			//���ۿ��� ������    ( YYYY )
		String repNationCd = request.getParameter("repNationCd")==null?"":request.getParameter("repNationCd");			//��ǥ�����ڵ� (�����ڵ弭�񽺿��� '2204'�� ��ȸ�� �����ڵ�)
		String[] movieTypeCdArr = request.getParameterValues("movieTypeCdArr")==null? null:request.getParameterValues("movieTypeCdArr");	//��ȭ�����ڵ� �迭 (�����ڵ弭�񽺿��� '2201'�� ��ȸ�� ��ȭ�����ڵ�)
	    */
		// �߱�Ű
		String key = "430156241533f1d058c603178cc3ca0e";
		//KOBIS ���� API Rest Client�� ���� ȣ��
		KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
		
		
		// ��ȭ�ڵ���ȸ ���� ȣ�� (boolean isJson, String curPage, String itemPerPage,String directorNm, String movieCd, String movieNm, String openStartDt,String openEndDt, String ordering, String prdtEndYear, String prdtStartYear, String repNationCd, String[] movieTypeCdArr)
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
	
	
// �ظ� �޼ҵ� �߰�
	@Override
	public int getTotalCount(int movieNo) throws Exception {		
		return sqlSession.selectOne("MovieCommentMapper.getTotalCount",movieNo);
	}


	@Override
	public List<Movie> uniMovieList(Search search) {
		return sqlSession.selectList("MovieMapper.uniMovieList",search);
	}
}
