package com.amc.service.purchase.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.domain.Purchase;
import com.amc.service.purchase.PurchaseDAO;

@Repository("purchaseDAO")
public class PurchaseDAOImpl implements PurchaseDAO{
	
	/*Field*/
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public PurchaseDAOImpl() {
		System.out.println(this.getClass());
	}
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public Purchase getPurchase(Purchase purchase) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase",purchase);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search) throws Exception {
	
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("totalCount", sqlSession.selectOne("PurchaseMapper.getTotalCount", search));
		map.put("list", sqlSession.selectList("PurchaseMapper.getPurchaseList", search));

		return map;
	}

	@Override
	public void addPurchase(Purchase purchase) throws Exception {
		System.out.println("11111111111111**************purchase : " + purchase);
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
		System.out.println("2222222222222222**************purchase : " + purchase);
		for(int i=1;i<purchase.getPurchaseCount();i++){
			sqlSession.insert("PurchaseMapper.addPurchaseCount", purchase);
		}

	}
	
	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		sqlSession.delete("PurchaseMapper.deletePurchaseForUpdate", purchase.getOrderNo());
		
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
		
		for(int i=1;i<purchase.getPurchaseCount();i++){
			sqlSession.insert("PurchaseMapper.insertPurchaseForUpdate", purchase);
		}
	}

	@Override
	public Purchase getPurchaseByProd(int prodNo) throws Exception {
	
		return null;
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
	
		
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
	
		return 0;
	}

}
