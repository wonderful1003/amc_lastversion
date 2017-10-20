package com.amc.service.booking.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.booking.BookingDAO;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;

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
	
/*	@Override
	public List<Movie> getScreenMovieList(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("MovieMapper.getMovieList", search);
	}*/

	@Override
	public List<Movie> getPreviewList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addBooking(Booking booking) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getSeatView(int screenContentNo) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public Booking getBookingByInfo(Booking booking) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("BookingMapper.getBookingByInfo", booking);
	}

	@Override
	public void deleteBooking(String bookingNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Booking getBooking(String bookingNo) {
		System.out.println("BookingDAOImpl ¾È, bookingNo : "+bookingNo);
		
		return sqlSession.selectOne("BookingMapper.getBooking", bookingNo);
	}

	@Override
	public List<String> selectRandomSeat(int screenContentNo, int count) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Booking> getBookingList(String userId) {
		
		return null;
	}

	@Override
	public List<Booking> getAdminBookingList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void selectCancelAlarm(int screenContentNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Movie> getScreenDateList(int selectScreenNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Movie> getScreenTimeList(String selectScreenDate) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void sendEmailQR(String bookinNo, String email) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sendPhoneQR(String bookingNo, String phone) {
		// TODO Auto-generated method stub
		
	}


}
