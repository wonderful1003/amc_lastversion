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

	// �������� ������ ����ε� ó�� ����
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
	

}
