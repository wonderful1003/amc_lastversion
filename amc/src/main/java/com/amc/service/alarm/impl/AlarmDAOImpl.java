package com.amc.service.alarm.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.alarm.AlarmDAO;
import com.amc.service.domain.Alarm;

@Repository("alarmDAOImpl")
public class AlarmDAOImpl implements AlarmDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	@Override
	public int addCancelAlarm(Alarm alarm) {
		return sqlSession.insert("AlarmMapper.addAlarm",alarm);
	}

	@Override
	public int addOpenAlarm(Alarm alarm) {
		
		return sqlSession.insert("AlarmMapper.addAlarm", alarm);
	}

	@Override
	public List<Alarm> getCancelAlarmList(Map<String,Object> map) {
		return sqlSession.selectList("AlarmMapper.getCancelAlarmList",map);
	}

	@Override
	public List<Alarm> getOpenAlarmList(Map<String, Object> map) {
		return sqlSession.selectList("AlarmMapper.getOpenAlarmList",map);
	}

	@Override
	public int deleteCancelAlarm(Alarm alarm) {
		return sqlSession.delete("AlarmMapper.deleteAlarm",alarm);
	}

	@Override
	public int deleteOpenAlarm(Alarm alarm) {
		return sqlSession.delete("AlarmMapper.deleteAlarm", alarm);
	}

	@Override
	public String checkOpenAlarm(Alarm alarm) {
		return sqlSession.selectOne("AlarmMapper.checkOpenAlarm",alarm);
	}

	@Override
	public String checkCancelAlarm(Alarm alarm) {
		return sqlSession.selectOne("AlarmMapper.checkCancelAlarm",alarm);
	}

	@Override
	public String checkDuplicationSeat(Alarm alarm) {
		return sqlSession.selectOne("AlarmMapper.checkDuplicationSeat",alarm);
	}
	
}
