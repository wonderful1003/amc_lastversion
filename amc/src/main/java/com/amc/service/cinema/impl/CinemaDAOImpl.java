package com.amc.service.cinema.impl;

import java.util.ArrayList;
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
	public Map<String, Object> unifiedSearch(String searchKeyword) {
		
		Map<String,Object> unifiedSearch = new HashMap<String,Object>();
		

		/*통합검색 영화 리스트 부르기*/
		List<Movie> uniMovieList = sqlSession.selectList("MovieMapper.uniMovieList","스");

		unifiedSearch.put("uniMovieList", uniMovieList);
		
/*		for(int i = 0; i<uniMovieList.size(); i++){
			System.out.println("DAOImpl : "+((Movie)(uniMovieList.get(i))).getMovieTitle());
		}*/
		

		
		/*통합검색 시사회 리스트 부르기*/
		List<ScreenContent> uniPreviewList = sqlSession.selectList("ScreenContentMapper.uniPreviewList","시사회");
		
		unifiedSearch.put("uniPreviewList", uniPreviewList);
		
		for(int i = 0; i<uniPreviewList.size(); i++){
			System.out.println("DAOImpl : "+((ScreenContent)(uniPreviewList.get(i))).getPreviewTitle());
		}
		
		
		/*통합검색 스토어 부르기*/
		List<Product> uniProductList = sqlSession.selectList("ProductMapper.uniProductList",searchKeyword);
		List<Product> uniGoodsList = new ArrayList<Product>();
		List<Product> uniSnackList = new ArrayList<Product>();
		
		for(int i = 0; i<uniProductList.size(); i++){
			System.out.println("DAOImpl : "+((Product)(uniProductList.get(i))).getProdName());
			if(((Product)(uniProductList.get(i))).getProdType().equals("G")){
				uniGoodsList.add(((Product)(uniProductList.get(i))));
			}else{
				uniSnackList.add(((Product)(uniProductList.get(i))));
			}
		}
		
		unifiedSearch.put("uniGoodsList", uniGoodsList);
		unifiedSearch.put("uniSnackList", uniSnackList);
		
		return unifiedSearch;
	}

	@Override
	public Map<String, List<Object>> index() {
		// TODO Auto-generated method stub
		return null;
	}

}
