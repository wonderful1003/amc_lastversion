package com.amc.web.alarm;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;

import com.amc.common.Search;
import com.amc.service.domain.ScreenContent;
import com.amc.service.screen.ScreenService;

@Controller
public class AlarmPush implements ApplicationContextAware{

	@Autowired
	@Qualifier("screenServiceImpl")
	ScreenService screenService;
	SimpleDateFormat dateFormat;
	Calendar calendar;
	private static ApplicationContext applicationContext;

	public AlarmPush() {
		this.dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	}

	public void run() {

		calendar = Calendar.getInstance();

		System.out.println("서브 태스크 요이땅 시간 :: " + dateFormat.format(calendar.getTime()));

		Search search = new Search();
		search.setSearchKeyword(dateFormat.format(calendar.getTime()));
		System.out.println(dateFormat.format(calendar.getTime()));

		List<ScreenContent> list = screenService.getTodayTicketOpenList(search);
		System.out.println(list.get(0).getPreviewTitle());
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		AlarmPush.applicationContext = applicationContext;
	}

	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}

}
