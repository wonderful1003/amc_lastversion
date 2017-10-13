package com.amc.service.domain.onetime;

import com.amc.service.domain.Movie;
import com.amc.service.domain.User;

public class MovieComment {
	private int moiveCommentNo;
	private User User;
	private Movie movie;
	private String movieComment;
	private String commentRegDate;
	private String blindCommentFlag;

	public int getMoiveCommentNo() {
		return moiveCommentNo;
	}

	public void setMoiveCommentNo(int moiveCommentNo) {
		this.moiveCommentNo = moiveCommentNo;
	}

	public User getUser() {
		return User;
	}

	public void setUser(User user) {
		User = user;
	}

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public String getMovieComment() {
		return movieComment;
	}

	public void setMovieComment(String movieComment) {
		this.movieComment = movieComment;
	}

	public String getCommentRegDate() {
		return commentRegDate;
	}

	public void setCommentRegDate(String commentRegDate) {
		this.commentRegDate = commentRegDate;
	}

	public String getBlindCommentFlag() {
		return blindCommentFlag;
	}

	public void setBlindCommentFlag(String blindCommentFlag) {
		this.blindCommentFlag = blindCommentFlag;
	}

}
