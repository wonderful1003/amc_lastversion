package com.amc.web.booking;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.InternalResourceView;

import com.amc.service.booking.BookingService;
import com.amc.service.domain.Movie;

@Controller
@RequestMapping("/booking/*")
public class BookingController {
	
	///Field
	@Autowired
	@Qualifier("bookingServiceImpl")
	private BookingService bookingService;
	
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
		
		return "redirect:/booking/selectScreenMoive.jsp";
	}
	
	@RequestMapping( value="selectSeat", method=RequestMethod.GET)
	public String selectSeat(Model model) throws Exception{
		
		System.out.println("/booking/getScreenMovieList : GET");
		
		List<Movie> movieList = bookingService.getScreenMovieList();
		
		return "redirect:/booking/selectSeat.jsp";
	}
	
	@RequestMapping( value="pay", method=RequestMethod.POST)
	public String pay(@RequestBody Map<String, Object> jsonD , Model model) throws Exception{
		
		System.out.println("/booking/pay : POST");

		System.out.println("json/pay 안입니다."+jsonD.get("key1"));
		
		return "forward:/booking/addBooking.jsp";
	}
	
	
/*	@RequestParam("prodNo") String prodNo,
	Model model*/
}
