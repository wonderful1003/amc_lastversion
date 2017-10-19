package com.amc.service.screen;

import java.util.List;
import java.util.Map;

import com.amc.common.Search;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;

public interface ScreenService {

	// �󿵰����� ���� ��ȭ��� ��������
	public List<Movie> getMovieList(Search search);

	// �󿵰����� ���� ��ȭ ��������
	public Movie getMovie(int movieNo);

	// �� ���� ����Ʈ �ҷ�����
	public Map<String, Object> getScreenContentList(Search search, int movieNo);
	
	// [����1�ܰ�] �� ���� ����Ʈ �ҷ�����
	public List<ScreenContent> getScreenContentList2(Search search, int movieNo);

	// �� ���� ���
	public int addScreenContent(ScreenContent screenContent);

	// �� ���� ��� �� �󿵽ð� �ߺ� üũ
	public boolean checkScreenDupTime(String screenOpenTime, String screenEndTime);

	// �� ���� ������ ���� �� ���� ��������
	public ScreenContent getScreenContent(int screenContentNo);

	// �� ���� ����
	public int updateScreenContent(ScreenContent screenContent);

	// �� ���� ����
	public int deleteScreenContent(int screenContentNo);

}
