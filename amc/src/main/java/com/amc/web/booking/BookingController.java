package com.amc.web.booking;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.InternalResourceView;

import com.amc.service.booking.BookingService;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.domain.User;
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
	
	@RequestMapping( value="selectSeat", method=RequestMethod.GET)
	public String selectSeat(@RequestParam("screenContentNo") String screenContentNo, Model model) throws Exception{
		
		///////////////
		screenContentNo = "1021";		
		///////////////	

		System.out.println("/booking/selectSeat : GET");
		model.addAttribute("screenContentNo",screenContentNo);

		return "forward:/booking/selectSeat.jsp";
	}
	
	@RequestMapping( value="requestPay", method=RequestMethod.POST)
	public String requestPay(@RequestParam("screenContentNo") String screenContentNo,
			@RequestParam("seats") String seats, Model model) throws Exception{	
		System.out.println("/booking/requestPay : POST");
		
		//ScreenContent screenContent = screenService.getScreenContent(Integer.parseInt(screenContentNo));
		ScreenContent screenContent = screenService.getScreenContent(10000);
		model.addAttribute("screenContent",screenContent);
		model.addAttribute("seats",seats);
		
		/*int headCount = (seats.안의 콤마의 개수+1)/2
		model.addAttribute("headCount", headCount);
		model.addAttribute("totalTicketPrice", screenContent.getTicketPrice()*headCount);*/
		
		return "forward:/booking/addBooking.jsp";
	}
	
	@RequestMapping( value="addBooking", method=RequestMethod.POST)
	public String addBooking(@ModelAttribute("booking") Booking booking,
						Model model) throws Exception{	
		System.out.println("/booking/addBooking : POST");
		
		bookingService.addBooking(booking);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("userId", booking.getUserId());
		map.put("screenContentNo", booking.getScreenContentNo());
		map.put("bookingSeatNo", booking.getBookingSeatNo());
		
		//이거해야됨
		//Booking booking = bookingService.getBookingByInfo(map); 
		model.addAttribute("booking",booking);

		return "forward:/booking/addBookingConfirm.jsp";
	}
	
	
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
	
	
	
	
}
