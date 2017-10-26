package com.amc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.amc.common.Search;
import com.amc.service.domain.Product;
import com.amc.service.product.ProductService;
import com.amc.service.product.ProductDAO;


@Service("productService")
public class ProductServiceImpl implements ProductService {

	///Field
	@Autowired
	@Qualifier("productDAO")
	private ProductDAO productDAO;
	
	public ProductServiceImpl() {
		System.out.println(this.getClass()); 
	}
	
	public ProductDAO getProductDao() {
		return productDAO;
	}

	public void setProductDao(ProductDAO productDAO) {
		this.productDAO = productDAO;
	}

	@Override
	public int addProduct(Product product) throws Exception {
		return productDAO.addProduct(product);
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		return productDAO.getProduct(prodNo);
	}

	@Override
	public Map<String, Object> getGoodsList(Search search, Product product) throws Exception {
		List<Product> list = productDAO.getGoodsList(search, product);
		int totalCount = productDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public Map<String, Object> getSnackList(Search search, Product product) throws Exception {
		List<Product> list = productDAO.getSnackList(search, product);
		int totalCount = productDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		productDAO.updateProduct(product);
	}

	@Override
	/*public void deleteProduct(Product product) throws Exception {*/
	public void deleteProduct(int prodNo) throws Exception {
		productDAO.deleteProduct(prodNo);
	}
	
}
