package com.amc.service.domain;

import java.util.List;

public class Movie {

	private int movieNo;
	private String movieCd;
	private String movieOpenDate;
	private String movieEndDate;
	private String movieTitle;
	private String poster;
	private List<String> director;
	private List<String> actor;
	private List<String> genre;
	private String rating;
	private String runningTime;
	private String synopsis;
	private String steelCut1;
	private String steelCut2;
	private String steelCut3;
	private String trailer;
	private String movieRegDate;
	
	// statistic VO Ãß°¡
	
	private int maleCount;
	private int femaleCount;
	private int age10s;
	private int age20s;
	private int age30s;
	private int age40s;
	private int age50s;
	private int age60more;
	

	public int getMovieNo() {
		return movieNo;
	}
	
	public String getMovieCd() {
		return movieCd;
	}

	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
	}

	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}

	public String getMovieOpenDate() {
		return movieOpenDate;
	}

	public void setMovieOpenDate(String movieOpenDate) {
		this.movieOpenDate = movieOpenDate;
	}

	public String getMovieEndDate() {
		return movieEndDate;
	}

	public void setMovieEndDate(String movieEndDate) {
		this.movieEndDate = movieEndDate;
	}

	public String getMovieTitle() {
		return movieTitle;
	}

	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public List<String> getDirector() {
		return director;
	}

	public void setDirector(List<String> director) {
		this.director = director;
	}

	public List<String> getActor() {
		return actor;
	}

	public void setActor(List<String> actor) {
		this.actor = actor;
	}

	public List<String> getGenre() {
		return genre;
	}

	public void setGenre(List<String> genre) {
		this.genre = genre;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getRunningTime() {
		return runningTime;
	}

	public void setRunningTime(String runningTime) {
		this.runningTime = runningTime;
	}

	public String getSynopsis() {
		return synopsis;
	}

	public void setSynopsis(String synopsis) {
		this.synopsis = synopsis;
	}

	public String getSteelCut1() {
		return steelCut1;
	}

	public void setSteelCut1(String steelCut1) {
		this.steelCut1 = steelCut1;
	}

	public String getSteelCut2() {
		return steelCut2;
	}

	public void setSteelCut2(String steelCut2) {
		this.steelCut2 = steelCut2;
	}

	public String getSteelCut3() {
		return steelCut3;
	}

	public void setSteelCut3(String steelCut3) {
		this.steelCut3 = steelCut3;
	}

	public String getTrailer() {
		return trailer;
	}

	public void setTrailer(String trailer) {
		this.trailer = trailer;
	}

	public String getMovieRegDate() {
		return movieRegDate;
	}

	public void setMovieRegDate(String movieRegDate) {
		this.movieRegDate = movieRegDate;
	}

	public int getMaleCount() {
		return maleCount;
	}

	public void setMaleCount(int maleCount) {
		this.maleCount = maleCount;
	}

	public int getFemaleCount() {
		return femaleCount;
	}

	public void setFemaleCount(int femaleCount) {
		this.femaleCount = femaleCount;
	}

	public int getAge10s() {
		return age10s;
	}

	public void setAge10s(int age10s) {
		this.age10s = age10s;
	}

	public int getAge20s() {
		return age20s;
	}

	public void setAge20s(int age20s) {
		this.age20s = age20s;
	}

	public int getAge30s() {
		return age30s;
	}

	public void setAge30s(int age30s) {
		this.age30s = age30s;
	}

	public int getAge40s() {
		return age40s;
	}

	public void setAge40s(int age40s) {
		this.age40s = age40s;
	}

	public int getAge50s() {
		return age50s;
	}

	public void setAge50s(int age50s) {
		this.age50s = age50s;
	}

	public int getAge60more() {
		return age60more;
	}

	public void setAge60more(int age60more) {
		this.age60more = age60more;
	}

	@Override
	public String toString() {
		return "Movie [movieNo=" + movieNo + ", movieOpenDate=" + movieOpenDate + ", movieEndDate=" + movieEndDate
				+ ", movieTitle=" + movieTitle + ", poster=" + poster + ", director=" + director + ", actor=" + actor
				+ ", genre=" + genre + ", rating=" + rating + ", runningTime=" + runningTime + ", synopsis=" + synopsis
				+ ", steelCut1=" + steelCut1 + ", steelCut2=" + steelCut2 + ", steelCut3=" + steelCut3 + ", trailer="
				+ trailer + ", movieRegDate=" + movieRegDate + ", maleCount=" + maleCount + ", femaleCount="
				+ femaleCount + ", age10s=" + age10s + ", age20s=" + age20s + ", age30s=" + age30s + ", age40s="
				+ age40s + ", age50s=" + age50s + ", age60more=" + age60more + "]";
	}

	
	
}
