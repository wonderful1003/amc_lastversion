package com.amc.service.alarm.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.alarm.AlarmDAO;
import com.amc.service.alarm.AlarmService;
import com.amc.service.domain.Alarm;

@Service("alarmServiceImpl")
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	@Qualifier("alarmDAOImpl")
	AlarmDAO alarmDAO;
	
	@Override
	public int addCancelAlarm(Alarm alarm) {

		return 0;
	}

	@Override
	public int addOpenAlarm(Alarm alarm) {

		return alarmDAO.addOpenAlarm(alarm);
	}

	@Override
	public List<Alarm> getCancelAlarmList(Search search) {

		return null;
	}

	@Override
	public List<Alarm> getOpenAlarmList(Search search) {

		return null;
	}

	@Override
	public int deleteCancelAlarm(Alarm alarm) {

		return 0;
	}

	@Override
	public int deleteOpenAlarm(Alarm alarm) {

		return alarmDAO.deleteOpenAlarm(alarm);
	}

	@Override
	public String checkOpenAlarm(Alarm alarm) {
		
		return alarmDAO.checkOpenAlarm(alarm);
		
	}

	
	
}
