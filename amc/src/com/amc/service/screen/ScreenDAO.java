package com.amc.service.screen;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.ScreenContent;

public interface ScreenDAO {
	


	// ����Ʈ ��Ʈ�ѷ�
	// �� ��ȣ�� ���� �� ���� ���� ��� ������
	public List<ScreenContent> getScreenContentList(Search search, int screenNo);

	// �� ���� ���
	public int addScreenContent(ScreenContent screenContent);

	// �� ���� ��� �� �󿵽ð� �ߺ� üũ
	public boolean checkScreenDupTime(String screenOpenTime, String screenEndTime);

	// �� ���� ����
	public int updateScreenContent(ScreenContent screenContent);

	// �� ���� ����
	public int deleteScreenContent(int screenContentNo);


}
