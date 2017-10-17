package com.amc.service.product;

import java.util.Map;

import com.amc.common.Search;
import com.amc.service.domain.Product;

public interface ProductDAO {
	
	public void addProduct(Product product) throws Exception;
	
	public Product getGoodsProduct(int prodNo) throws Exception;
	
	public Map<String,Object> getGoodsList(Search search) throws Exception;
	
	public Product getSnackProduct(int prodNo) throws Exception;
	
	public Map<String,Object> getSnackList(Search search) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public void deleteProduct(int prodNo) throws Exception;

}
