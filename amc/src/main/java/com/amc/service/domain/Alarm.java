package com.amc.service.domain;

public class Alarm {

		//! °ø°Ý·Â
		int alarmNo;
		int screenContentNo;
		String userId;
		String alarmRegDate;
		String alarmSeatNo;
		String alarmFlag;
		
		public Alarm() {
			super();
		}

		public int getAlarmNo() {
			return alarmNo;
		}

		public void setAlarmNo(int alarmNo) {
			this.alarmNo = alarmNo;
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

		public String getAlarmRegDate() {
			return alarmRegDate;
		}

		public void setAlarmRegDate(String alarmRegDate) {
			this.alarmRegDate = alarmRegDate;
		}

		public String getAlarmSeatNo() {
			return alarmSeatNo;
		}

		public void setAlarmSeatNo(String alarmSeatNo) {
			this.alarmSeatNo = alarmSeatNo;
		}

		public String getAlarmFlag() {
			return alarmFlag;
		}

		public void setAlarmFlag(String alarmFlag) {
			this.alarmFlag = alarmFlag;
		}

		@Override
		public String toString() {
			return "Alarm [alarmNo=" + alarmNo + ", screenContentNo=" + screenContentNo + ", userId=" + userId
					+ ", alarmRegDate=" + alarmRegDate + ", alarmSeatNo=" + alarmSeatNo + ", alarmFlag=" + alarmFlag
					+ "]";
		}
		
}
