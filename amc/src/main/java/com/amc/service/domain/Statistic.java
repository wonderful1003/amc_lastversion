package com.amc.service.domain;

public class Statistic {

	private String movieNo;
	private int maleCount;
	private int femaleCount;
	private int age10s;
	private int age20s;
	private int age30s;
	private int age40s;
	private int age50s;
	private int age60more;
	
	public Statistic(){
		super();
	}

	public String getMovieNo() {
		return movieNo;
	}

	public void setMovieNo(String movieNo) {
		this.movieNo = movieNo;
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
		return "Static [movieNo=" + movieNo + ", maleCount=" + maleCount + ", femaleCount=" + femaleCount + ", age10s="
				+ age10s + ", age20s=" + age20s + ", age30s=" + age30s + ", age40s=" + age40s + ", age50s=" + age50s
				+ ", age60more=" + age60more + "]";
	}
	
	
	
	
}
