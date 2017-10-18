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
	public void addCancelAlarm(Alarm cancelAlarm) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addOpenAlarm(Alarm openAlarm) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Alarm> getCancelAlarmList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Alarm> getOpenAlarmList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteCancelAlarm(int cancelAlarmNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteOpenAlarm(int openAlarmNo) {
		// TODO Auto-generated method stub
		
	}

	
	
}
