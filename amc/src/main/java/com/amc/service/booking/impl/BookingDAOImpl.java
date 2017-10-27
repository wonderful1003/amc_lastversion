package com.amc.service.booking.impl;

import java.util.List;
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
		System.out.println("BookingDAOImpl ¾È, bookingNo : "+bookingNo);
		
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




}
