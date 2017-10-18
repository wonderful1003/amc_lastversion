package com.amc.service.booking.impl;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.booking.BookingDAO;
import com.amc.service.booking.BookingService;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.Statistic;
import com.amc.service.screen.ScreenDAO;

import java.util.ArrayList;
import java.util.Calendar;

@Service("bookingServiceImpl")
public class BookingServiceImpl implements BookingService {
	
	@Autowired
	@Qualifier("bookingDAOImpl")
	private BookingDAO bookingDAO;
	
	public void setBookingDAO(BookingDAO bookingDAO) {
		this.bookingDAO = bookingDAO;
	}
	

	@Override
	public List<Movie> getScreenMovieList() {
		
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();

        String dateToday = simpleDateFormat.format(calendar.getTime());
        System.out.println("Today : " + dateToday);
        
	    //List<Movie> todayMovieList = movieDAO.
         

        List<Movie> list = new ArrayList<Movie>();
		
		return list;
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

		return bookingDAO.getBooking(bookingNo);
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
