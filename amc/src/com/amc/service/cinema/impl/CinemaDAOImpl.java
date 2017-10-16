package com.amc.service.cinema.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.cinema.CinemaDAO;
import com.amc.service.domain.Movie;
import com.amc.service.domain.Product;
import com.amc.service.domain.ScreenContent;

@Repository("cinemaDaoImpl")
public class CinemaDAOImpl implements CinemaDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;

	public CinemaDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Map<String, Object> unifiedSearch(Search search) {
		
		String SearchKeyword = search.getSearchKeyword();
		
		Map<String,Object> unifiedSearch = new HashMap<String,Object>();
		
		//List<Movie> uniMovieList = sqlSession.selectList("MovieMapper.getUniMovieList",SearchKeyword);
		
		//List<ScreenContent> uniPreviewList = sqlSession.selectList("ScreenContentMapper.getUniPreviewList",SearchKeyword); 
		
		List<Product> uniProductList = sqlSession.selectList("ProductMapper.getUniProductList",SearchKeyword);
		
		//unifiedSearch.put("uniMovieList", uniMovieList);
		
		//unifiedSearch.put("uniPreviewList", uniPreviewList);
		
		System.out.println("아이우에오"+((Product)(uniProductList.get(0))).getProdName());
		
		unifiedSearch.put("uniProductList", uniProductList);
		
		return unifiedSearch;
	}

	@Override
	public Map<String, List<Object>> index() {
		// TODO Auto-generated method stub
		return null;
	}

}
