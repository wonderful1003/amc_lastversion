package com.amc.service.alarm;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.CancelAlarm;
import com.amc.service.domain.OpenAlarm;

public interface AlarmDAO {

public void addCancelAlarm(CancelAlarm cancelAlarm);
	
	public void addOpenAlarm(OpenAlarm openAlarm);
	
	public List<CancelAlarm> getCancelAlarmList(Search search);
	
	public List<OpenAlarm> getOpenAlarmList(Search search);
	
	public void deleteCancelAlarm(int cancelAlarmNo);
	
	public void deleteOpenAlarm(int openAlarmNo); 
	
}
