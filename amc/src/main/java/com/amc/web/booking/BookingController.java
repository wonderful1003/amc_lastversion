package com.amc.web.booking;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.amc.common.Search;
import com.amc.service.booking.BookingService;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.screen.ScreenService;

@Controller
@RequestMapping("/booking/*")
public class BookingController {
	
	///Field
	@Autowired
	@Qualifier("bookingServiceImpl")
	private BookingService bookingService;

	@Autowired
	@Qualifier("screenServiceImpl")
	private ScreenService screenService;
	
	///Constructor
	public BookingController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	///Method
	@RequestMapping( value="getScreenMovieList", method=RequestMethod.GET)
	public String getScreenMovieList(Model model) throws Exception{
		
		System.out.println("/booking/getScreenMovieList : GET");
		
		List<Movie> movieList = bookingService.getScreenMovieList();
		model.addAttribute("movieList", movieList);
		
		return "forward:/booking/selectScreenMoive.jsp";
	}
	
	//예매1단계(영화)
	@RequestMapping( value="selectSeat", method=RequestMethod.GET)
	public String selectSeat(@RequestParam("screenContentNo") String screenContentNo, Model model) throws Exception{
		
		System.out.println("/booking/selectSeat : GET");
		model.addAttribute("screenContentNo",screenContentNo);

		return "forward:/booking/selectSeat.jsp";
	}
	
	//예매1단계(시사회)
	
	
	//예매2단계
	@RequestMapping( value="requestPay", method=RequestMethod.POST)
	public String requestPay(@RequestParam("screenContentNo") String screenContentNo,
			@RequestParam("seats") String seats, Model model) throws Exception{	
		System.out.println("/booking/requestPay : POST");
		
		//ScreenContent screenContent = screenService.getScreenContent(Integer.parseInt(screenContentNo));
		ScreenContent screenContent = screenService.getScreenContent(10000);
				
		Booking booking = new Booking();
		booking.setScreenContent(screenContent);
		booking.setBookingSeatNo(seats);	
		int headCount = (StringUtils.countOccurrencesOf(seats, ",")+1)/2;
		booking.setHeadCount(headCount);
		booking.setTotalTicketPrice(screenContent.getTicketPrice()*headCount);
		model.addAttribute(booking);
		
		return "forward:/booking/addBooking.jsp";
	}
	
	//예매3단계
	@RequestMapping( value="addBooking", method=RequestMethod.POST)
	public String addBooking(@ModelAttribute("booking") Booking booking,
						Model model) throws Exception{	
		System.out.println("/booking/addBooking : POST");
		
		//bookingService.addBooking(booking);
		
		booking.setScreenContentNo("10000");
		booking.setImpId("aaa111");
		
		booking = bookingService.getBookingByInfo(booking);
		
		System.out.println("add 후 no까지 포함된 booking : " + booking);
		
		model.addAttribute("booking",booking);

		return "forward:/booking/addBookingConfirm.jsp";
	}
	
	//예매상세조회
	@RequestMapping( value="getBooking", method=RequestMethod.GET)
	public String getBooking(@RequestParam("bookingNo") String bookingNo, 
												Model model) throws Exception{
		//127.0.0.1:8080/booking/getBooking?bookingNo=b10000
		System.out.println("/booking/getBooking : GET");
	
		
		System.out.println("BookingController 안, bookingNo : "+bookingNo);

		Booking booking = bookingService.getBooking(bookingNo); 
		System.out.println("booking : "+booking);
		model.addAttribute("booking", booking);
	
		return "forward:/booking/getBooking.jsp";
	}
	
	//관리자 예매목록조회
	@RequestMapping( value="getAdminBookingList", method=RequestMethod.GET)
	public String getAdminBookingList(@ModelAttribute("Search") Search search,
												Model model) throws Exception{

		System.out.println("/booking/getAdminBookingList : GET");
		
		List<Booking> bookingList = bookingService.getAdminBookingList(search); 
		
		System.out.println("bookingList : "+bookingList);
		model.addAttribute("list", bookingList);
	
		return "forward:/booking/listBookingAdmin.jsp";
	}
	
	
	
}
