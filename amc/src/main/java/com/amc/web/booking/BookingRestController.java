package com.amc.web.booking;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
		

		@RequestMapping(value="json/getScreenDate", method=RequestMethod.GET)
		public List<ScreenContent> getScreenDate(@RequestParam("movieNo") int movieNo, 
													Model model) throws Exception{
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM/dd");
	        Calendar calendar = Calendar.getInstance();

	        String today = simpleDateFormat.format(calendar.getTime());
	        System.out.println("Today : " + today);
	  
	        Search search = new Search();
	        search.setSearchCondition("1");
	        search.setSearchKeyword(today);
	        search.setPageSize(10); //??
	        search.setCurrentPage(1); ///??
	        Map<String, Object> map = screenService.getScreenContentList(search, movieNo);
	        
	        List<ScreenContent> list = (List<ScreenContent>)map.get("list");
	        System.out.println("getScreenDate로 가져온 list는 : "+list);
			
	        return list;
		}
		


}
