package com.amc.service.movie.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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


@Repository("movieApiDAOImpl")
public class MovieApiDAOImpl implements MovieDAO {	
	
	//Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("::" + getClass() +" .setSqlsession Call....");
		this.sqlSession = sqlSession;
	}

	//Constructor
	public MovieApiDAOImpl() {
		System.out.println("::" + getClass() +" default Construcor call....");
	}
	
	// RESTCONTROLLER Ÿ�� �κ�
	// ����� ���� �� �ܺ� ��ȭ API ��� �ҷ�����
	
	public List<MovieList> getAPIMoiveList(	HttpServletRequest request, 
											HttpServletResponse response
											) throws Exception{
		
			System.out.println("movieApiDaoImpl called ...");
			System.out.println("/movie/json/listMovie : GET");
			
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
			
			// �߱�Ű
			String key = "430156241533f1d058c603178cc3ca0e";
			// KOBIS ���� API Rest Client�� ���� ȣ��
		    KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);

		    
			// ��ȭ�ڵ���ȸ ���� ȣ�� (boolean isJson, String curPage, String itemPerPage,String directorNm, String movieCd, String movieNm, String openStartDt,String openEndDt, String ordering, String prdtEndYear, String prdtStartYear, String repNationCd, String[] movieTypeCdArr)
		    String movieCdResponse = service.getMovieList(true, curPage, itemPerPage, movieNm, directorNm, openStartDt, openEndDt, prdtStartYear, prdtEndYear, repNationCd, movieTypeCdArr);
		
			ObjectMapper mapper = new ObjectMapper();
		    System.out.println("movieCdResponse" + movieCdResponse);
		    
		
		    MovieAPI movieAPI = mapper.readValue(movieCdResponse, MovieAPI.class);
		    //System.out.println("�����׽�Ʈ");
		    List<MovieList> list =  movieAPI.getMovieListResult().getMovieList();
		    
		    //System.out.println("MoveList list :: " + list);
		
			return list;
		}

	@Override
	public List<Movie> getMoiveAdminList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Movie> getMovieList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Movie> getMoviePreviewList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Movie> getCommingSoonList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Movie getMovie(int movieNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateMovie(Movie movie) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMovie(int movieNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<WishList> getWishList(Search search, String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MovieList> getAPIMoiveList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public int addWish(int movieNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int addMoiveComment(MovieComment movieComment) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int blindMoiveComment(int movieCommentNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateMovieCommnet(MovieComment movieComment) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMovieComment(int movieCommentNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MovieComment> getMovieCommentList(Search search, int movieNo) {
		// TODO Auto-generated method stub
		return null;
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
	public List<Movie> getChart(int movieNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Twitter> getTwitterList(String movieName) {
		// TODO Auto-generated method stub
		return null;
	}

	// submit�� ������ �ܺ� ��ȭ API �� + ���̹� ��ȭ ������ API�� ������ �� DB���
	public int addMovie(Screen screen) 	 {
			System.out.println("MovieAPIDAOImpl called ....");
		
			return sqlSession.insert("MovieMapper.addMovie",screen);
			
	}
	
	// ������Ͽ��� Ŭ���Ѱ��� ����ȭ������, ��ȭ��Ͽ��� Ŭ���Ѱ��� ������ȭ������

	

}