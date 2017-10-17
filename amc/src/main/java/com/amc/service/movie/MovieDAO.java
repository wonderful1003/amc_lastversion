package com.amc.service.movie;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.MovieAPI;
import com.amc.service.domain.WishList;
import com.amc.service.domain.onetime.MovieComment;
import com.amc.service.domain.onetime.MovieList;
import com.amc.service.domain.onetime.Screen;
import com.amc.service.domain.onetime.Twitter;


public interface MovieDAO {

	
	
	// ��ü ��ȭ ��� �ҷ����� (�����ڿ�)
	public List<Movie> getMoiveAdminList(Search search);

	// ���� �� ��ȭ ��� �ҷ�����
	public List<Movie> getMovieList(Search search);

	// �� ���� ��ȭ ��� �ҷ�����
	public List<Movie> getMoviePreviewList(Search search);

	// �û�ȸ ��ȭ ��� �ҷ�����
	public List<Movie> getCommingSoonList(Search search);
	
	
	// ��ȭ ��������
	public Movie getMovie(int movieNo);

	// ��ȭ ����
	public void updateMovie(Movie movie);

	// ��ȭ ����
	public void deleteMovie(int movieNo);
	

	// �������������� ���ø���Ʈ �ҷ�����
	public List<WishList> getWishList(Search search, String userId);

	// RESTCONTROLLER Ÿ�� �κ�

	// ����� ���� �� �ܺ� ��ȭ API ��� �ҷ�����
	public List<MovieList> getAPIMoiveList() throws Exception; 
		

	// submit�� ������ �ܺ� ��ȭ API �� + ���̹� ��ȭ ������ API�� ������ �� DB���
	public int addMovie(Screen screen);
	
	// ������Ͽ��� Ŭ���Ѱ��� ����ȭ������, ��ȭ��Ͽ��� Ŭ���Ѱ��� ������ȭ������

	// ȸ���� ��Ʈ�� �������� ���ø���Ʈ�� ���� �ϴ��� ���ϴ��� Ȯ��(Count��), �����ϸ� delete �������������� add
	public int addWish(int movieNo);

	// ��ȭ�� ���� ������ �Է�
	public int addMoiveComment(MovieComment movieComment);

	// �������� ������ ����ε� ó�� ����
	public int blindMoiveComment(int movieCommentNo);

	// ������ ����
	public int updateMovieCommnet(MovieComment movieComment);

	// ������ ����
	public int deleteMovieComment(int movieCommentNo);

	// ������ ����
	public List<MovieComment> getMovieCommentList(Search search, int movieNo);

	// ȸ���� ��Ʈ�� �������� ���ø���Ʈ�� ���� �ϴ��� ���ϴ��� Ȯ��(Count��)
	public int existWish(int moiveNo, String userId);

	// �����ϸ� delete
	public int deleteWish(int moiveNo, String userId);
	
	// ��Ʈ��� ��������
	public List<Movie> getChart(int movieNo);
	
	// Ʈ���� ��������
	public List<Twitter> getTwitterList(String movieName);
	

}
