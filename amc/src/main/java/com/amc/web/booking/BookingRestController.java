package com.amc.web.booking;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.LinkedHashSet;
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
		
		private List<ScreenContent> list;

		public BookingRestController() {
			System.out.println(this.getClass());
		}
		

		@RequestMapping(value="json/getScreenDate/{movieNo}", method=RequestMethod.GET)
		public List<String> getScreenDate(@PathVariable("movieNo") int movieNo, 
													Model model) throws Exception{
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM/dd");
	        Calendar calendar = Calendar.getInstance();

	        String today = simpleDateFormat.format(calendar.getTime());
	        System.out.println("Today : " + today);
	  
	        Search search = new Search();
	        search.setSearchCondition("1");
	        //search.setSearchKeyword(today);
	        search.setSearchKeyword(today);
	        
	        list = screenService.getScreenContentList2(search, movieNo);
	        for (ScreenContent screenContent : list) {
	        	System.out.println("디비에서 가져옴 : "+screenContent);
			}
	        
	        
	        List<String> dayList = new ArrayList<String>();
	        for(int k = 0; k<list.size(); k++){
	        	
	        	String screenDate = list.get(k).getScreenDate();
	        	String screenDay = screenDate.substring(8,10);
	        	System.out.print(k+">> getScreenDate로 가져온 시간은 : "+list.get(k).getScreenOpenTime());
	        	System.out.print("  >> 날짜는 : "+screenDay);
	        	System.out.println("  >> 상영번호 : "+list.get(k).getScreenContentNo());
	        	
	        	dayList.add(screenDay);
	        
	        }
	        
/*	        for(Iterator<String> it = list.iterator() ; it.hasNext() ; )
	        //for (int i = 0; i < dayList.size(); i++) {
	                for (int j = 0; j < dayList.size(); j++) {
	                    if (i == j) {
	                    } else if (dayList.get(j).equals(dayList.get(i))) {
	                    	dayList.remove(j);
	                    }
	                }
	         }*/

	        
	        LinkedHashSet hs = new LinkedHashSet(dayList);
	        dayList = new ArrayList<String>(hs);
	        for (String st : dayList) {
	        	System.out.println("해쉬셋으로 바꾸고 난 후 리스트 : "+st);
			}
	       
	        
	        return dayList;
		}
		
		
		@RequestMapping(value="json/getScreenTime/{screenDate}", method=RequestMethod.GET)
		public List<ScreenContent> getScreenTime(@PathVariable("screenDate") String screenDate, 
													Model model) throws Exception{
			List<ScreenContent> timeList = new ArrayList<ScreenContent>();
			
			
			for(int i = 0; i<list.size(); i++){
	        	 
	        	if(screenDate.equals( list.get(i).getScreenDate().substring(8, 10) )){
	        		ScreenContent tempContent = new ScreenContent();//안으로 넣어야 함 LIST ADD때무네
	        		tempContent.setScreenContentNo(list.get(i).getScreenContentNo());
	        		tempContent.setScreenOpenTime(list.get(i).getScreenOpenTime());
	        		timeList.add(tempContent);
	        		System.out.println("tempContent에 들어간다 : "+tempContent.toString());
	        	}
	        	System.out.println("timeList는 : "+timeList);
	        }
			return timeList;
		}


}
