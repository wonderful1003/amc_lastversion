package com.amc.service.domain;

public class WishList {

	int wishNo;
	String userId;
	int screenContentNo;
	
	
	public WishList() {
		super();
	}
	
	public int getWishNo() {
		return wishNo;
	}
	
	public void setWishNo(int wishNo) {
		this.wishNo = wishNo;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public int getScreenContentNo() {
		return screenContentNo;
	}
	
	public void setScreenContentNo(int screenContentNo) {
		this.screenContentNo = screenContentNo;
	}
	
	@Override
	public String toString() {
		return "WishList [wishNo=" + wishNo + ", userId=" + userId + ", screenContentNo=" + screenContentNo + "]";
	}
		
}
