package com.amc.service.alarm;

import java.util.List;
import java.util.Map;

import com.amc.service.domain.Alarm;

public interface AlarmDAO {

	public int addCancelAlarm(Alarm alarm);

	public int addOpenAlarm(Alarm alarm);
	
	public List<Alarm> getCancelAlarmList(Map<String,Object> map);
	
	public List<Alarm> getOpenAlarmList(Map<String,Object> map);
	
	public int deleteCancelAlarm(Alarm alarm);
	
	public int deleteOpenAlarm(Alarm alarm);
	
	public String checkOpenAlarm(Alarm alarm);
	
	public String checkCancelAlarm(Alarm alarm);
	
	public String checkDuplicationSeat(Alarm alarm);
	
}
