package com.amc.service.booking;

import java.util.List;
import java.util.Map;

import com.amc.common.Search;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;

public interface BookingService {
	
	public List<Movie> getScreenMovieList(); //다시확인하기
	
	public List<Movie> getPreviewList();   //다시확인하기
	
	public List<ScreenContent> getScreenTimeList();
	
	public void addBooking(Booking booking);
	
	public Booking getBookingByInfo(Booking booking);
	
	public void getSeatView(int screenContentNo);
	
	public void addStatic();
	
	public void deleteBooking(String bookingNo);
	
	public Booking getBooking(String bookingNo);
	
	public List<String> selectRandomSeat(int screenContentNo, int count);
	
	public List<Booking> getBookingList(String userId);
	
	public List<Booking> getAdminBookingList(Search search);
		
	public void selectCancelAlarm(int screenContentNo);
	
	//여기서부터는 restController가 사용

	
	public void sendEmailQR(String bookinNo, String email);
	
	public void sendPhoneQR(String bookingNo, String phone);
	
	

	


}
