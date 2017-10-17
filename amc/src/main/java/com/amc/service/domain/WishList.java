package com.amc.service.domain;

public class WishList {

	int wishNo;
	String userId;
	int movieNo;
	
	
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

	public int getMovieNo() {
		return movieNo;
	}

	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}

	@Override
	public String toString() {
		return "WishList [wishNo=" + wishNo + ", userId=" + userId + ", movieNo=" + movieNo + "]";
	}
		
}
