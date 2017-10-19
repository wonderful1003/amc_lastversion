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
		//setter Method ���� ����
		
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
	        	System.out.println("��񿡼� ������ : "+screenContent);
			}
	        
	        
	        List<String> dayList = new ArrayList<String>();
	        for(int k = 0; k<list.size(); k++){
	        	
	        	String screenDate = list.get(k).getScreenDate();
	        	String screenDay = screenDate.substring(8,10);
	        	System.out.print(k+">> getScreenDate�� ������ �ð��� : "+list.get(k).getScreenOpenTime());
	        	System.out.print("  >> ��¥�� : "+screenDay);
	        	System.out.println("  >> �󿵹�ȣ : "+list.get(k).getScreenContentNo());
	        	
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
	        	System.out.println("�ؽ������� �ٲٰ� �� �� ����Ʈ : "+st);
			}
	       
	        
	        return dayList;
		}
		
		
		@RequestMapping(value="json/getScreenTime/{screenDate}", method=RequestMethod.GET)
		public List<ScreenContent> getScreenTime(@PathVariable("screenDate") String screenDate, 
													Model model) throws Exception{
			List<ScreenContent> timeList = new ArrayList<ScreenContent>();
			
			
			for(int i = 0; i<list.size(); i++){
	        	 
	        	if(screenDate.equals( list.get(i).getScreenDate().substring(8, 10) )){
	        		ScreenContent tempContent = new ScreenContent();//������ �־�� �� LIST ADD������
	        		tempContent.setScreenContentNo(list.get(i).getScreenContentNo());
	        		tempContent.setScreenOpenTime(list.get(i).getScreenOpenTime());
	        		timeList.add(tempContent);
	        		System.out.println("tempContent�� ���� : "+tempContent.toString());
	        	}
	        	System.out.println("timeList�� : "+timeList);
	        }
			return timeList;
		}


}
