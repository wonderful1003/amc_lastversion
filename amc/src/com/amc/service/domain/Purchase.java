package com.amc.service.domain;

import java.sql.Date;

public class Purchase {
	
	private String orderNo;
	private String receiverName;
	private String paymentOption;
	private String addrDlvy;
	private String addrDlvyDetail;
	private int orderStock;
	private String receiverPhone1;
	private String receiverPhone2;
	private String receiverPhone3;
	private int totalProdPrice;
	private int tranCode;
	private Date orderRegDate;
	private String impId;
	
	private Product prodNo;
	private User userId;
	
	public Purchase() {
	}

	public String getImpId() {
		return impId;
	}

	public void setImpId(String impId) {
		this.impId = impId;
	}
	
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getPaymentOption() {
		return paymentOption;
	}

	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption;
	}

	public String getAddrDlvy() {
		return addrDlvy;
	}

	public void setAddrDlvy(String addrDlvy) {
		this.addrDlvy = addrDlvy;
	}

	public String getAddrDlvyDetail() {
		return addrDlvyDetail;
	}

	public void setAddrDlvyDetail(String addrDlvyDetail) {
		this.addrDlvyDetail = addrDlvyDetail;
	}

	public int getOrderStock() {
		return orderStock;
	}

	public void setOrderStock(int orderStock) {
		this.orderStock = orderStock;
	}

	public String getReceiverPhone1() {
		return receiverPhone1;
	}

	public void setReceiverPhone1(String receiverPhone1) {
		this.receiverPhone1 = receiverPhone1;
	}

	public String getReceiverPhone2() {
		return receiverPhone2;
	}

	public void setReceiverPhone2(String receiverPhone2) {
		this.receiverPhone2 = receiverPhone2;
	}

	public String getReceiverPhone3() {
		return receiverPhone3;
	}

	public void setReceiverPhone3(String receiverPhone3) {
		this.receiverPhone3 = receiverPhone3;
	}

	public int getTotalProdPrice() {
		return totalProdPrice;
	}

	public void setTotalProdPrice(int totalProdPrice) {
		this.totalProdPrice = totalProdPrice;
	}

	public int getTranCode() {
		return tranCode;
	}

	public void setTranCode(int tranCode) {
		this.tranCode = tranCode;
	}

	public Date getOrderRegDate() {
		return orderRegDate;
	}

	public void setOrderRegDate(Date orderRegDate) {
		this.orderRegDate = orderRegDate;
	}

	public Product getProdNo() {
		return prodNo;
	}

	public void setProdNo(Product prodNo) {
		this.prodNo = prodNo;
	}

	public User getUserId() {
		return userId;
	}

	public void setUserId(User userId) {
		this.userId = userId;
	}
	
}
