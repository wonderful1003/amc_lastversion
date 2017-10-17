package com.amc.service.booking.impl;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.booking.BookingService;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.Statistic;

public class BookingServiceImpl implements BookingService {

	@Override
	public List<Movie> getScreenMovieList() {
		// TODO Auto-generated method stub
		return null;
	}

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
	public void addStatic(Statistic statistic) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBooking(String bookingNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Booking getBooking(String bookingNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> selectRandomSeat(int screenContentNo, int count) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Booking> getBookingList(String userId) {
		// TODO Auto-generated method stub
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
