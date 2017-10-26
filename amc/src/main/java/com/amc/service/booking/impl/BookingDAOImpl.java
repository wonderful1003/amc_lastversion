package com.amc.service.booking.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.booking.BookingDAO;
import com.amc.service.domain.Booking;


@Repository("bookingDAOImpl")
public class BookingDAOImpl implements BookingDAO {
		
	//Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
		
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("::" + getClass() +" .setSqlsession Call....");
		this.sqlSession = sqlSession;
	}


	@Override
	public void addBooking(Booking booking) {
		sqlSession.insert("BookingMapper.addBooking", booking);		
	}

	
	@Override
	public Booking getBookingByInfo(Booking booking) {
		return sqlSession.selectOne("BookingMapper.getBookingByInfo", booking);
	}

	@Override
	public void deleteBooking(String bookingNo) {
		sqlSession.delete("BookingMapper.deleteBooking", bookingNo);
	}

	@Override
	public Booking getBooking(String bookingNo) {
		System.out.println("BookingDAOImpl 안, bookingNo : "+bookingNo);
		
		return sqlSession.selectOne("BookingMapper.getBooking", bookingNo);
	}

	@Override
	public List<Booking> getBookingList(Search search) {
		return sqlSession.selectList("BookingMapper.getBookingList", search);
	}


	@Override
	public void updateStatistic(Search search) {
		sqlSession.update("MovieMapper.updateStatistic", search);		
	}


	@Override
	public Map<String, Object> getUserBookingList(Map<String, Object> map) {
		List l = new ArrayList<>();
		l = sqlSession.selectList("BookingMapper.getUserBookingList", map);
		for(int i = 0; i< l.size(); i++){
			System.out.println("유저의 예매리스트 : "+l.get(i).toString());
		}
		return null;
	}


}
