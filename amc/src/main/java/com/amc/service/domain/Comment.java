package com.amc.service.domain;

import java.util.List;

public class Comment {
	
	private String commentNo;
	private String freeBoardNo;
	private String userId;
	private String commentContent;
	private String parentCommentNo;
	private List<Comment> replyList;
	private String commentRegDate;


	public Comment(){
		super();
	}
	
	public String getCommentRegDate() {
		return commentRegDate;
	}

	public void setCommentRegDate(String commentRegDate) {
		this.commentRegDate = commentRegDate;
	}

	public String getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
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

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public String getParentCommentNo() {
		return parentCommentNo;
	}

	public void setParentCommentNo(String parentCommentNo) {
		this.parentCommentNo = parentCommentNo;
	}

	
	public List<Comment> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<Comment> replyList) {
		this.replyList = replyList;
	}

	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", freeBoardNo=" + freeBoardNo + ", userId=" + userId
				+ ", commentContent=" + commentContent + ", parentCommentNo=" + parentCommentNo + ", replyList="
				+ replyList + "]";
	}

	
	
	
}
