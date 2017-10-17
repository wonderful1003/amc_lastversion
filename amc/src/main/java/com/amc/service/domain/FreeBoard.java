package com.amc.service.domain;

public class FreeBoard {
	
	private String freeBoardNo;
	private String userId;
	private String freeBoardTitle;
	private String freeBoardRegDate;
	private String freeBoardContent;
	private int freeBoardViews;
	private String freeBoardImage;
	
	public FreeBoard(){
		super();
	}

	public String getFreeBoardNo() {
		return freeBoardNo;
	}

	public void setFreeBoardNo(String freeBoardNo) {
		this.freeBoardNo = freeBoardNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFreeBoardTitle() {
		return freeBoardTitle;
	}

	public void setFreeBoardTitle(String freeBoardTitle) {
		this.freeBoardTitle = freeBoardTitle;
	}

	public String getFreeBoardRegDate() {
		return freeBoardRegDate;
	}

	public void setFreeBoardRegDate(String freeBoardRegDate) {
		this.freeBoardRegDate = freeBoardRegDate;
	}

	public String getFreeBoardContent() {
		return freeBoardContent;
	}

	public void setFreeBoardContent(String freeBoardContent) {
		this.freeBoardContent = freeBoardContent;
	}

	public int getFreeBoardViews() {
		return freeBoardViews;
	}

	public void setFreeBoardViews(int freeBoardViews) {
		this.freeBoardViews = freeBoardViews;
	}

	public String getFreeBoardImage() {
		return freeBoardImage;
	}

	public void setFreeBoardImage(String freeBoardImage) {
		this.freeBoardImage = freeBoardImage;
	}

	@Override
	public String toString() {
		return "FreeBoard [freeBoardNo=" + freeBoardNo + ", userId=" + userId + ", freeBoardTitle=" + freeBoardTitle
				+ ", freeBoardRegDate=" + freeBoardRegDate + ", freeBoardContent=" + freeBoardContent
				+ ", freeBoardViews=" + freeBoardViews + ", freeBoardImage=" + freeBoardImage + "]";
	}
	
	

}
