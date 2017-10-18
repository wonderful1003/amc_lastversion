package com.amc.service.booking;


import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.Statistic;

public interface BookingDAO {

/*	public List<Movie> getScreenMovieList(Search search); //�ٽ�Ȯ���ϱ�
*/	
	public List<Movie> getPreviewList();   //�ٽ�Ȯ���ϱ�
	
	public void addBooking(Booking booking);
	
	public void getSeatView(int screenContentNo);
	
	public void addStatic(Statistic statistic);
	
	public void deleteBooking(String bookingNo);
	
	public Booking getBooking(String bookingNo);
	
	public List<String> selectRandomSeat(int screenContentNo, int count);
	
	public List<Booking> getBookingList(String userId);
	
	public List<Booking> getAdminBookingList(Search search);
		
	public void selectCancelAlarm(int screenContentNo);
	
	//���⼭���ʹ� restController�� ���
	public List<Movie> getScreenDateList(int selectScreenNo);
	
	public List<Movie> getScreenTimeList(String selectScreenDate);
	
	public void sendEmailQR(String bookinNo, String email);
	
	public void sendPhoneQR(String bookingNo, String phone);
	
}
