package com.amc.service.alarm;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.Alarm;

public interface AlarmService {
	
	public String addCancelAlarm(Alarm alarm);
	
	public int addOpenAlarm(Alarm alarm);
	
	public List<Alarm> getCancelAlarmList(Search search);
	
	public List<Alarm> getOpenAlarmList(Search search);
	
	public int deleteCancelAlarm(Alarm alarm);
	
	public int deleteOpenAlarm(Alarm alarm);
	
	public String checkOpenAlarm(Alarm alarm);
	
	public String switchOpenAlarm(Alarm alarm);
	
	public String smsPush(String type, String serialNo, String userId, String alarmSeatNo) throws Exception;

}
