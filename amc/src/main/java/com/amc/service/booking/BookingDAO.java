package com.amc.service.booking;


import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.Booking;


public interface BookingDAO {
	
	public void addBooking(Booking booking);
	
	public Booking getBookingByInfo(Booking booking);
	
	public void deleteBooking(String bookingNo);
	
	public Booking getBooking(String bookingNo);
	
	public List<Booking> getBookingList(Search search);

	public void updateStatistic(Search search);
}
