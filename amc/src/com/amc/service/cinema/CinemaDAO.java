package com.amc.service.cinema;

import java.util.List;
import java.util.Map;

import com.amc.common.Search;

public interface CinemaDAO {
	
	public Map<String, Object> unifiedSearch(Search search);
	
	public Map<String, List<Object>> index();

}
