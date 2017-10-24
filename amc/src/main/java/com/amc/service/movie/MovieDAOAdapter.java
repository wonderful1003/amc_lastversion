package com.amc.service.movie;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.MovieComment;
import com.amc.service.domain.WishList;
import com.amc.service.domain.onetime.MovieList;
import com.amc.service.domain.onetime.Twitter;

//@Repository("movieApiDAOImpl")
public abstract class MovieDAOAdapter implements MovieDAO {
	
	MovieDAO movieDAO;
	
	//Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("::" + getClass() +" .setSqlsession Call....");
		this.sqlSession = sqlSession;
	}

	//Constructor
	public MovieDAOAdapter() {
		System.out.println("::" + getClass() +" default Construcor call....");
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
	public int updateMovie(Movie movie) {
		
		return 0;
	}

	@Override
	public int deleteMovie(int movieNo) {
		return 0;

	}

	@Override
	public List<WishList> getWishList(Search search, String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<MovieList> getAPIMoiveList() throws Exception{

		return null;
		}
				
	
	@Override
	public int addMovie(Movie movie) {
		// TODO Auto-generated method stub
		return 0;
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
	public int blindMoiveComment(MovieComment movieComment) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateMovieComment(MovieComment movieComment) {
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

}
