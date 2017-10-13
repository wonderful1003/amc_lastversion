package com.amc.service.domain;

public class OpenAlarm {

		int openAlarmNo;
		int screenContentNo;
		String userId;
		String openAlarmRegDate;
		
		public OpenAlarm() {
			super();
		}
		
		public int getOpenAlarmNo() {
			return openAlarmNo;
		}
		
		public void setOpenAlarmNo(int openAlarmNo) {
			this.openAlarmNo = openAlarmNo;
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
		
		public String getOpenAlarmRegDate() {
			return openAlarmRegDate;
		}
		
		public void setOpenAlarmRegDate(String openAlarmRegDate) {
			this.openAlarmRegDate = openAlarmRegDate;
		}
		
		@Override
		public String toString() {
			return "OpenAlarm [openAlarmNo=" + openAlarmNo + ", screenContentNo=" + screenContentNo + ", userId="
					+ userId + ", openAlarmRegDate=" + openAlarmRegDate + "]";
		}
		
}
