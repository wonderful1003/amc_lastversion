package com.amc.service.purchase;

import java.util.Map;

import com.amc.common.Search;
import com.amc.service.domain.Purchase;

public interface PurchaseDAO {
	
	// item 구매 추가
	public void addPurchase(Purchase purchase) throws Exception; 

	// 구매한 item 찾기 by purchase
	public  Purchase getPurchase(Purchase purchase) throws Exception; 
	
	// 구매 item 목록
	public  Map<String, Object> getPurchaseList(Search search) throws Exception;
	
	// 구매한 item 관련 정보 수정
	public  void updatePurchase(Purchase purchase)  throws Exception; 
	
	// 구매완료 -> 배송중 -> 배송완료 수정
	public  void updateTranCode(Purchase purchase)  throws Exception; 
	
	// 구매한 item 찾기 by prodNo
	public  Purchase getPurchaseByProd(int prodNo) throws Exception; 

	// 게시판 처리
	public int getTotalCount(Search search) throws Exception;

}
