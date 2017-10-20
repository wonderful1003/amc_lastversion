package com.amc.service.booking.impl;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.booking.BookingDAO;
import com.amc.service.booking.BookingService;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.movie.MovieDAO;
import com.amc.service.screen.ScreenDAO;

import java.util.Calendar;

@Service("bookingServiceImpl")
public class BookingServiceImpl implements BookingService {
	
	@Autowired
	@Qualifier("bookingDAOImpl")
	private BookingDAO bookingDAO;
	
	@Autowired
	@Qualifier("movieDAOImpl")
	private MovieDAO movieDAO;
	
	@Autowired
	@Qualifier("screenDAOImpl")
	private ScreenDAO screenDAO;
	
	public void setBookingDAO(BookingDAO bookingDAO) {
		this.bookingDAO = bookingDAO;
	}

	public void setMovieDAO(MovieDAO movieDAO) {
		this.movieDAO = movieDAO;
	}

	@Override
	public List<Movie> getScreenMovieList() {
		
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM/dd");
        Calendar calendar = Calendar.getInstance();

        String today = simpleDateFormat.format(calendar.getTime());
        System.out.println("Today : " + today);
        Search search = new Search();
        search.setSearchCondition("3");
        search.setSearchKeyword(today);
        
	    List<Movie> todayMovieList = movieDAO.uniMovieList(search);
	    System.out.println("todayMovieList : "+todayMovieList);

		return todayMovieList;
	}
	

	@Override
	public List<Movie> getPreviewList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addBooking(Booking booking) {
		bookingDAO.addBooking(booking);
	}

	@Override
	public Booking getBookingByInfo(Booking booking) {
		
		return bookingDAO.getBookingByInfo(booking);
	}

	@Override
	public void getSeatView(int screenContentNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addStatic() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBooking(String bookingNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Booking getBooking(String bookingNo) {
		System.out.println("BookingServicempl ¾È, bookingNo : "+bookingNo);

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
	public void sendEmailQR(String bookinNo, String email) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sendPhoneQR(String bookingNo, String phone) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ScreenContent> getScreenTimeList() {
		// TODO Auto-generated method stub
		return null;
	}


	
}
