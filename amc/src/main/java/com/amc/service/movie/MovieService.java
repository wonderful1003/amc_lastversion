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

	// ��ü ��ȭ ��� �ҷ����� (�����ڿ�)
	public List<Movie> getMoiveAdminList(Search search);

	// ���� �� ��ȭ ��� �ҷ�����
	public Map<String, Object> getMovieList(Search search) throws Exception;

	// �� ���� ��ȭ ��� �ҷ�����
	public List<Movie> getMoviePreviewList(Search search);

	// �û�ȸ ��ȭ ��� �ҷ�����
	public List<Movie> getCommingSoonList(Search search);
	
	public Movie getMovie(int movieNo) throws Exception;

	// ��ȭ ����
	public int updateMovie(Movie movie) throws Exception;

	// ��ȭ ����
	public int deleteMovie(int movieNo) throws Exception;

	// �������������� ���ø���Ʈ �ҷ�����
	public List<WishList> getWishList(Search search, String userId);

	// RESTCONTROLLER Ÿ�� �κ�

	// ����� ���� �� �ܺ� ��ȭ API ��� �ҷ�����
	public List<MovieList> getAPIMoiveList() throws Exception;

	// submit�� ������ �ܺ� ��ȭ API �� + ���̹� ��ȭ ������ API�� ������ �� DB���
	public int addMovie(Movie movie);
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
	
	// ��Ʈ��� ��������
	public List<Movie> getChart(int movieNo);
	
	// Ʈ���� ��������
	public List<Twitter> getTwitterList(String movieName);
	

}
