package com.amc.service.booking;

import java.io.IOException;
import java.util.List;

import org.codehaus.jettison.json.JSONException;

import com.amc.common.Search;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.domain.User;

public interface BookingService {
	
	public List<Movie> getScreenMovieList(); //다시확인하기
	
	public List<ScreenContent> getPreviewList();   //다시확인하기
	
	public List<String> getScreenDateList(List<ScreenContent> list);
	
	public List<ScreenContent> getScreenTimeList(String screenDate);
	
	public void addBooking(Booking booking);
	
	public Booking getBookingByInfo(Booking booking);
		
	public void updateStatistic(User user, Booking booking);
	
	public void deleteBooking(String bookingNo) throws IOException, JSONException;
	
	public Booking getBooking(String bookingNo);
	
	public List<Booking> getBookingList(Search search);
		
	public void selectCancelAlarm(int screenContentNo);
	
	public void sendEmailQR(String bookinNo, String email);
	
	public void sendPhoneQR(String bookingNo, String phone);
	
	

	


}
