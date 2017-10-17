package com.amc.service.movie.impl;

import java.util.List;

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
import com.amc.service.domain.WishList;
import com.amc.service.domain.onetime.MovieComment;
import com.amc.service.domain.onetime.MovieList;
import com.amc.service.domain.onetime.Screen;
import com.amc.service.domain.onetime.Twitter;
import com.amc.service.movie.MovieDAO;
import com.amc.service.movie.MovieDAOAdapter;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import kr.or.kobis.kobisopenapi.consumer.rest.exception.OpenAPIFault;

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

	// ���� �� ��ȭ ��� �ҷ�����
	public List<Movie> getMovieList(Search search) {
		
		return null;
	}

	// �� ���� ��ȭ ��� �ҷ�����
	public List<Movie> getMoviePreviewList(Search search) {
		return null;
	}

	// �û�ȸ ��ȭ ��� �ҷ�����
	public List<Movie> getCommingSoonList(Search search) {
		return null;
	}

	public Movie getMovie(int movieNo) {
		return null;
	}

	// ��ȭ ����
	public void updateMovie(Movie movie) {
	}

	// ��ȭ ����
	public void deleteMovie(int movieNo) {
	}

	// �������������� ���ø���Ʈ �ҷ�����
	public List<WishList> getWishList(Search search, String userId) {
		return null;
	}
	
	// ������ ����
	public List<MovieComment> getMovieCommentList(Search search, int movieNo) {
		return null;
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
	public int addMoiveComment(MovieComment movieComment) {
		return 0;
	}

	// �������� ������ �����ε� ó�� ����
	public int blindMoiveComment(int movieCommentNo) {
		return 0;
	}

	// ������ ����
	public int updateMovieCommnet(MovieComment movieComment) {
		return 0;
	}

	// ������ ����
	public int deleteMovieComment(int movieCommentNo) {
		return 0;
	}
	
	public int addMovie(Screen screen) 	 {
		System.out.println("MovieDAOImpl called ... addMovie...");
		
		
		return sqlSession.insert("MovieMapper.addMovie",screen);
		
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

	
	

}