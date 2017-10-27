package com.amc.service.booking.impl;


import java.io.DataOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.List;


import org.codehaus.jettison.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.booking.BookingDAO;
import com.amc.service.booking.BookingService;
import com.amc.service.domain.Booking;
import com.amc.service.domain.Movie;
import com.amc.service.domain.ScreenContent;
import com.amc.service.domain.User;
import com.amc.service.movie.MovieDAO;
import com.amc.service.screen.ScreenDAO;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedHashSet;

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
	private List<ScreenContent> screenContentList;
	
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
	public List<ScreenContent> getPreviewList() {
		
		Search search = new Search();
		search.setSearchCondition("2");
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM/dd");
        Calendar calendar = Calendar.getInstance();

        String today = simpleDateFormat.format(calendar.getTime());
        search.setSearchKeyword(today);

		return screenDAO.getScreenContentList2(search, 0);
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
	public void updateStatistic(User user, Booking booking) {
		/*searchKeyword(1:남자, 2:여자), serachKeyword2(연령대)
		searchCondition(영화번호), currentPage(인원수)*/
		Search search = new Search();
		
		//search.setSearchCondition(booking.getMovie().getMovieNo()+"");
		search.setSearchCondition("10231");
		search.setCurrentPage(booking.getHeadCount());
		if(user.getGender().equals("M")){
			search.setSearchKeyword("1");
		}else{
			search.setSearchKeyword("2");
		}
		Calendar calendar = Calendar.getInstance(); 
		int yearToday = calendar.get(Calendar.YEAR);
		int birthYear= Integer.parseInt(user.getBirth().substring(0, 4));
		int ages = (yearToday - birthYear)/10;
		
		if(ages>0){
			search.setSearchKeyword2(ages+"");
			if(ages>7){
				search.setSearchKeyword2("7");
			}
			bookingDAO.updateStatistic(search);
		}
	}

	@Override
	public void deleteBooking(String bookingNo) throws IOException, JSONException {
		//1) 예매내역 삭제하기
		bookingDAO.deleteBooking(bookingNo);
		//2) 좌석정보 업데이트하기
	    URL url = new URL("http://localhost:52273/deleteResv");
	    HttpURLConnection conn = (HttpURLConnection)url.openConnection();

	    if ( conn != null ) {
    		String screenContentNo = "10000";
	    	
    		String strPostData = "screencontent_no="+screenContentNo;
    		strPostData += "&seat=1,3,2,4";
    		System.out.println("strPostData : "+strPostData);

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Accept-Language", "en-GB,en;q=0.5");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("Content-length", Integer.toString(strPostData.length()));
            conn.setRequestProperty("charset", "utf-8");
            conn.setUseCaches(false);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            
            DataOutputStream dos = new DataOutputStream(conn.getOutputStream());
            dos.writeBytes(strPostData);
            dos.flush();
            dos.close();
            System.out.println("DataOutputStream closed");
            int intResponse = conn.getResponseCode();
            System.out.println("\nCompleted Sending 'POST' to " + url.toString() + 
                    ", data: " + strPostData + ", rc: " + intResponse);
	    }
	}

	@Override
	public List<String> getScreenDateList(List<ScreenContent> list) {
		
		screenContentList = list;
        List<String> dayList = new ArrayList<String>();
        for(int k = 0; k<screenContentList.size(); k++){
        	
        	String screenDate = screenContentList.get(k).getScreenDate();
        	String screenDay = screenDate.substring(8,10);
        	//필요시 substring조정해서 월 일까지 나오도록 할 수 있다.
        	dayList.add(screenDay);
        }
        
        dayList = new ArrayList<String>(new LinkedHashSet<String>(dayList));
        
        return dayList;
	}
	
	@Override
	public List<ScreenContent> getScreenTimeList(String screenDate) {
		
		List<ScreenContent> timeList = new ArrayList<ScreenContent>();
		
		
		for(int i = 0; i<screenContentList.size(); i++){
        	 
        	if(screenDate.equals( screenContentList.get(i).getScreenDate().substring(8, 10) )){
        		ScreenContent tempContent = new ScreenContent();//안으로 넣어야 함 LIST ADD때무네
        		tempContent.setScreenContentNo(screenContentList.get(i).getScreenContentNo());
        		tempContent.setScreenOpenTime(screenContentList.get(i).getScreenOpenTime());
        		tempContent.setTicketOpenDate((screenContentList.get(i).getTicketOpenDate()));
        		timeList.add(tempContent);
        		System.out.println("tempContent에 들어간다 : "+tempContent.toString());
        	}
        }
		return timeList;
	}
	
	@Override
	public Booking getBooking(String bookingNo) {
		System.out.println("BookingServicempl 안, bookingNo : "+bookingNo);
		
		return bookingDAO.getBooking(bookingNo);
	}


	@Override
	public List<Booking> getBookingList(Search search) {
		return bookingDAO.getBookingList(search);
	}
	
	@Override
	public void selectCancelAlarm(int screenContentNo) {
	}
	
	@Override
	public void sendEmailQR(String bookinNo, String email) {

	}

	@Override
	public void sendPhoneQR(String bookingNo, String phone) {
	}


	
}
