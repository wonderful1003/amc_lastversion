package com.amc.service.alarm;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.Alarm;

public interface AlarmService {
	
	public void addCancelAlarm(Alarm cancelAlarm);
	
	public void addOpenAlarm(Alarm openAlarm);
	
	public List<Alarm> getCancelAlarmList(Search search);
	
	public List<Alarm> getOpenAlarmList(Search search);
	
	public void deleteCancelAlarm(int cancelAlarmNo);
	
	public void deleteOpenAlarm(int openAlarmNo); 

}
