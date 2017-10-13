package com.amc.service.domain;

public class CancelAlarm {
	
	int cancelAlarmNo;
	int screenContentNo;
	String userId;
	String cancelAlarmRegDate;
	String alarmSeatNo;

	public CancelAlarm() {
		super();
	}

	public int getCancelAlarmNo() {
		return cancelAlarmNo;
	}

	public void setCancelAlarmNo(int cancelAlarmNo) {
		this.cancelAlarmNo = cancelAlarmNo;
	}

	public int getScreenContentNo() {
		return screenContentNo;
	}

	public void setScreenContentNo(int screenContentNo) {
		this.screenContentNo = screenContentNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCancelAlarmRegDate() {
		return cancelAlarmRegDate;
	}

	public void setCancelAlarmRegDate(String cancelAlarmRegDate) {
		this.cancelAlarmRegDate = cancelAlarmRegDate;
	}

	public String getAlarmSeatNo() {
		return alarmSeatNo;
	}

	public void setAlarmSeatNo(String alarmSeatNo) {
		this.alarmSeatNo = alarmSeatNo;
	}

	@Override
	public String toString() {
		return "CancelAlarm [cancelAlarmNo=" + cancelAlarmNo + ", screenContentNo=" + screenContentNo + ", userId="
				+ userId + ", cancelAlarmRegDate=" + cancelAlarmRegDate + ", alarmSeatNo=" + alarmSeatNo + "]";
	}
	
	
}
