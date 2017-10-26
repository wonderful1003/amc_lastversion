package com.amc.service.product;

import java.util.List;
import java.util.Map;

import com.amc.common.Search;
import com.amc.service.domain.Product;

public interface ProductDAO {
	
	public int addProduct(Product product) throws Exception;
	
	public Product getProduct(int prodNo) throws Exception;
	
	public List<Product> getGoodsList(Search search, Product product) throws Exception;
	
	public List<Product> getSnackList(Search search, Product product) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	/*public void deleteProduct(Product product) throws Exception;*/
	public void deleteProduct(int prodNo) throws Exception;

	public int getTotalCount(Search search) throws Exception;
}
