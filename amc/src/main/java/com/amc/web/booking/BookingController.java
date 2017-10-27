package com.amc.web.booking;

import java.util.List;

import javax.servlet.http.HttpSession;

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
import com.amc.service.cinema.CinemaService;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.domain.User;
import com.amc.service.movie.MovieService;
import com.amc.service.screen.ScreenService;
import com.amc.service.user.UserService;
import com.amc.web.cinema.HttpRequestToNode;

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
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	@Autowired
	@Qualifier("cinemaServiceImpl")
	private CinemaService cinemaService;
	@Autowired
	@Qualifier("movieServiceImpl")
	private MovieService movieService;
	
	///Constructor
	public BookingController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	///Method
	//����1�ܰ�(��ȭ)
	@RequestMapping( value="getScreenMovieList", method=RequestMethod.GET)
	public String getScreenMovieList(Model model) throws Exception{
		
		System.out.println("/booking/getScreenMovieList : GET");
		
		List<Movie> movieList = bookingService.getScreenMovieList();
		model.addAttribute("movieList", movieList);
		
		return "forward:/booking/selectScreenMoive.jsp";
	}
	
	//����1�ܰ�(�û�ȸ)
	@RequestMapping( value="getPreviewList", method=RequestMethod.GET)
	public String getPreviewList(Model model) throws Exception{
		
		System.out.println("/booking/getPreviewList : GET");
		
		List<ScreenContent> screenContentList = bookingService.getPreviewList();
		model.addAttribute("screenContentList", screenContentList);
		
		return "forward:/booking/selectPreview.jsp";
	}
	
	
	//����2�ܰ� :�⺻ �¼�����
	@RequestMapping( value="selectSeat", method=RequestMethod.GET)
	public String selectSeat(@RequestParam("screenContentNo") String screenContentNo, Model model) throws Exception{
		
		System.out.println("/booking/selectSeat : GET");
		model.addAttribute("screenContentNo",screenContentNo);

		return "forward:/booking/selectSeat.jsp";
	}
	
	//����2�ܰ� : ���� �¼�����
	@RequestMapping( value="selectRandomSeat", method=RequestMethod.GET)
	public String selectRandomSeat(@RequestParam("screenContentNo") String screenContentNo,
			@RequestParam("headCount") int headCount, Model model) throws Exception{
		
		System.out.println("/booking/selectRandomSeat : GET");
		ScreenContent screenContent = screenService.getScreenContent(Integer.parseInt(screenContentNo));
		model.addAttribute("screenContent",screenContent);
		model.addAttribute("headCount", headCount);
		System.out.println(":::::::ȣ�� : :"+screenContent);

		return "forward:/booking/selectRandomSeat.jsp";
	}
	
	//����3�ܰ�
	@RequestMapping( value="requestPay", method=RequestMethod.POST)
	public String requestPay(@RequestParam("screenContentNo") String screenContentNo,
			@RequestParam("seats") String seats, Model model) throws Exception{	
		System.out.println("/booking/requestPay : POST");
		
		ScreenContent screenContent = screenService.getScreenContent(10335);
		//ScreenContent screenContent = screenService.getScreenContent(10000);
		/////////////////////////
		//edit screenContent mapper to get movie name.
		/////////////////////////
		
		
		Booking booking = new Booking();
		booking.setScreenContent(screenContent);
		booking.setBookingSeatNo(seats);	
		int headCount = (StringUtils.countOccurrencesOf(seats, ",")+1)/2;
		System.out.println("headCount : "+headCount+", Ƽ�ϰ��� : "+screenContent.getTicketPrice());
		booking.setHeadCount(headCount);
		booking.setTotalTicketPrice(screenContent.getTicketPrice()*headCount);
		
		model.addAttribute(booking);
		
		return "forward:/booking/addBooking.jsp";
	}
	
	//�����Ϸ�� ����Ȯ��
	@RequestMapping( value="addBooking", method=RequestMethod.POST)
	public String addBooking(@ModelAttribute("booking") Booking booking,
						Model model, HttpSession session) throws Exception{	
		System.out.println("/booking/addBooking : POST");
		
		//1. ADD booking
		System.out.println("insert�Ϸ��� booking : "+booking);
		bookingService.addBooking(booking);
		
		//3. GET booking
		booking = bookingService.getBookingByInfo(booking);
		System.out.println("add �� no���� ���Ե� booking : " + booking);
		
		//2. ADD statistic
		User user = (User) session.getAttribute("user");
		////////////////////////////////////////////////////////
		//System.out.println(":::::::::session�� UserȮ�� : "+user);
		//user.setBirth("1970/01/01");
		//user.setGender("M");
		////////////////////////////////////////////////////////
		bookingService.updateStatistic(user, booking);
		
		
		
		model.addAttribute("booking",booking);
		return "forward:/booking/addBookingConfirm.jsp";
	}
	
	//���Ż���ȸ
	@RequestMapping( value="getBooking", method=RequestMethod.GET)
	public String getBooking(/*@RequestParam("bookingNo") String bookingNo,*/ 
												Model model) throws Exception{

		System.out.println("/booking/getBooking : GET");

		/*Booking booking = bookingService.getBooking(bookingNo); 
		model.addAttribute("booking", booking);*/
		
		return "forward:/booking/getBooking.jsp";
	}
	
	//�������
	@RequestMapping( value="deleteBooking", method=RequestMethod.GET)
	public String deleteBooking(@RequestParam("bookingNo") String bookingNo,
								HttpSession session,	Model model) throws Exception{
		System.out.println("/booking/deleteBooking : GET");
		//1. ȯ����ġ�ϱ�
		Booking booking = bookingService.getBooking(bookingNo);
		String status = cinemaService.cancelPay(booking.getImpId());
		System.out.println("1. ȯ�� �Ϸ�");
		//String status = "cancelled"; //�ӽ�
		//ȯ�� ������
		if(status.equals("cancelled")){
			//2. ������� ������Ʈ�ϱ� 
			User user = (User) session.getAttribute("user");
			////////////////////////////////////////////////////////
			//user = new User();
			//System.out.println(":::::::::session�� UserȮ�� : "+user);
			//user.setBirth("1970/01/01");
			//user.setGender("M");
			////////////////////////////////////////////////////////
			booking.setHeadCount(booking.getHeadCount()*(-1));
			bookingService.updateStatistic(user,booking);
			System.out.println("2. ���� ��� �ѹ� �Ϸ�");
			//3. ���ų��� �����ϱ� & �¼���Ȳ ������Ʈ�ϱ�
			bookingService.deleteBooking(bookingNo);
			System.out.println("3. ���� ��������, �¼���Ȳ �ѹ� �Ϸ�");
			//4. ���ǥ �˸��� �߼��ϱ�
			
			return "redirect:/booking/getAdminBookingList";			
		}else{
			
			model.addAttribute("status", "success");
			return "forward:/booking/getBooking?bookingNo="+bookingNo;
		}
	}
	
	//ȸ���� ���Ÿ��
	
	//������ ���Ÿ����ȸ
	@RequestMapping( value="getAdminBookingList", method=RequestMethod.GET)
	public String getAdminBookingList(@ModelAttribute("Search") Search search,
												Model model) throws Exception{
		System.out.println("/booking/getAdminBookingList : GET");
		
		search.setCurrentPage(1);
		search.setPageSize(10);
		List<Booking> bookingList = bookingService.getBookingList(search); 
		model.addAttribute("list", bookingList);
	
		return "forward:/booking/listBookingAdmin.jsp";
	}
	
	@RequestMapping( value="testCode", method=RequestMethod.GET)
	public String testCode(HttpSession session) throws Exception {
		
		String screenContentNo = "10000";
		String seats = "2,8,9,10";
		
		String urlStr = "http://localhost:52273/deleteResv";
		String body = "screencontent_no="+screenContentNo+"&seat="+seats;
		HttpRequestToNode.httpRequest(urlStr, body);
	    
	    return "redirect:/booking/getPreviewList";
	}
	
	
}
