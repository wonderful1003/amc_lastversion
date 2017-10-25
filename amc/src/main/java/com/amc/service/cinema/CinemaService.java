package com.amc.service.cinema;

import java.util.List;
import java.util.Map;

import com.amc.common.Search;

public interface CinemaService {

		public Map<String, Object> unifiedSearch(String searchKeyword);
		
		public Map<String, Object> index();
		
		public String getPanorama(int theaterNo);
		
		public String checkPay(String impUid) throws Exception;
		
		public String cancelPay(String impUid) throws Exception;
		
}
