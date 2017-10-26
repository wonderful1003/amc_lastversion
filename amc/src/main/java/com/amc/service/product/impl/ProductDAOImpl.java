package com.amc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.domain.Product;
import com.amc.service.product.ProductDAO;

@Repository("productDAO")
public class ProductDAOImpl implements ProductDAO{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("::"+getClass()+".sqlSqlSession() 콜");
		this.sqlSession = sqlSession;
	}

	public ProductDAOImpl() {
		System.out.println("::"+getClass()+".ProductDaoImpl() 생성자 콜");
	}

	@Override
	public int addProduct(Product product) throws Exception {
		System.out.println("productdaoimpl");
		System.out.println("####################"+product.toString());
		return sqlSession.insert("ProductMapper.addProduct",product);
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		return (Product)sqlSession.selectOne("ProductMapper.getProduct", prodNo);
	}

	@Override
	public List<Product> getGoodsList(Search search, Product product) throws Exception {
		Map<String , Object> map= new HashMap<String, Object>();
		map.put("search", search);
		map.put("product", product);
		System.out.println("############ product dao impl 의 getGoodsList 의 map" + map);
		return sqlSession.selectList("ProductMapper.getGoodsList", map);
	}

	@Override
	public List<Product> getSnackList(Search search, Product product) throws Exception {
		Map<String , Object> map= new HashMap<String, Object>();
		map.put("search", search);
		map.put("product", product);
		System.out.println("############ product dao impl 의 getSnackList 의 map" + map);
		return sqlSession.selectList("ProductMapper.getSnackList", map);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		sqlSession.update("ProductMapper.updateProduct",product);
	}

	@Override
	/*public void deleteProduct(Product product) throws Exception {*/
	public void deleteProduct(int prodNo) throws Exception {
		sqlSession.update("ProductMapper.deleteProduct", prodNo);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.getTotalCount" , search);
	}

}
