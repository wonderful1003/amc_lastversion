package com.amc.service.cinema.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.service.cinema.CinemaDAO;
import com.amc.service.cinema.CinemaService;
import com.amc.service.domain.Movie;
import com.amc.service.domain.Product;
import com.amc.service.domain.ScreenContent;

@Service("cinemaServiceImpl")
public class CinemaServiceImpl implements CinemaService {

	@Autowired
	@Qualifier("cinemaDaoImpl")
	CinemaDAO cinemaDAO;
	
	public CinemaServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Map<String, Object> unifiedSearch(String searchKeyword) {
		
		Map<String, Object> unifiedSearch = new HashMap<String,Object>();
		
		unifiedSearch = cinemaDAO.unifiedSearch(searchKeyword);
		
		
		List<ScreenContent> pc = (List<ScreenContent>)(unifiedSearch.get("uniPreviewList"));
		/*List<Movie> mv = (List<Movie>)(unifiedSearch.get("uniMovieList"));*/
		List<Product> goods = (List<Product>)(unifiedSearch.get("uniGoodsList"));
		List<Product> snack = (List<Product>)(unifiedSearch.get("uniSnackList"));
		
		
		for (ScreenContent screenContent : pc) {
			System.out.println("serviceImpl"+screenContent.getPreviewTitle());
		}
		
/*		for (Movie movie : mv) {
			System.out.println("serviceImpl"+movie.getMovieTitle());
		}*/
		
		for (Product product : goods) {
			System.out.println("serviceImpl"+product.getProdName());
		}
		for (Product product : snack) {
			System.out.println("serviceImpl"+product.getProdName());
		}
			
		return unifiedSearch;
	}

	@Override
	public Map<String, List<Object>> index() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getPanorama(int theaterNo) {
		// TODO Auto-generated method stub
		return null;
	}

}
