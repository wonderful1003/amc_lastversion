package com.amc.web.booking;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.RestController;

import com.amc.common.Search;
import com.amc.service.booking.BookingService;
import com.amc.service.domain.ScreenContent;
import com.amc.service.screen.ScreenService;

@RestController
@RequestMapping("/booking/*")
public class BookingRestController {
	
		///Field
		@Autowired
		@Qualifier("bookingServiceImpl")
		private BookingService bookingService;
		
		///Field
		@Autowired
		@Qualifier("screenServiceImpl")
		private ScreenService screenService;
		//setter Method 구현 않음
		
		public BookingRestController() {
			System.out.println(this.getClass());
		}
		

		@RequestMapping(value="json/getScreenDate/{movieNo}/{flag}", method=RequestMethod.GET)
		public List<String> getScreenDate(@PathVariable("movieNo") int movieNo, 
											@PathVariable("flag") String flag, 
													Model model) throws Exception{

	        Calendar calendar = Calendar.getInstance();
	        String today =  new SimpleDateFormat("yy/MM/dd").format(calendar.getTime());
	  
	        Search search = new Search();
	        search.setSearchCondition(flag);
	        search.setSearchKeyword(today);
	        List<ScreenContent> list = screenService.getScreenContentList2(search, movieNo);

			return bookingService.getScreenDateList(list);
		}
		
		
		@RequestMapping(value="json/getScreenTime/{screenDate}", method=RequestMethod.GET)
		public List<ScreenContent> getScreenTime(@PathVariable("screenDate") String screenDate, 
													Model model) throws Exception{
			
			return bookingService.getScreenTimeList(screenDate);
		}


}
