package com.amc.service.screen;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.ScreenContent;

public interface ScreenDAO {
	


	// 레스트 컨트롤러
	// 상영 번호에 대한 상영 내용 정보 목록 보여줌
	public List<ScreenContent> getScreenContentList(Search search, int screenNo);

	// 상영 내용 등록
	public int addScreenContent(ScreenContent screenContent);

	// 상영 내용 등록 전 상영시간 중복 체크
	public boolean checkScreenDupTime(String screenOpenTime, String screenEndTime);

	// 상영 내용 수정
	public int updateScreenContent(ScreenContent screenContent);

	// 상영 내용 삭제
	public int deleteScreenContent(int screenContentNo);


}
