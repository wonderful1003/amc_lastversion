package com.amc.common;

public class Page {

	private int currentPage;	 //����������
	private int beginUnitPage;	 //��������
	private int endUnitPage; 	 //������ ����
	private int totalCount;	 //�� ���� ��(�Խù� ��)
	private int maxPage;		 //�� ������ ��
	private int pageUnit;		 //��Ÿ�� ������ ��
	private int pageSize; 	  	 //���������� �హ��
 
	public Page(int currentPage, int totalCount, int pageUnit, int pageSize){
		this.totalCount = totalCount;
		this.pageUnit = pageUnit;
		this.pageSize = pageSize;

		this.maxPage = (pageSize == 0) ? totalCount : (totalCount-1)/pageUnit+1;

		this.currentPage = ( currentPage > maxPage) ? maxPage : currentPage;

		this.beginUnitPage = pageUnit*((currentPage-1)/pageUnit)+1;
		
		if(maxPage <= pageUnit){
			this.endUnitPage= maxPage;
		}else{
			this.endUnitPage = beginUnitPage+(pageUnit-1);
			if(maxPage <= endUnitPage){
				this.endUnitPage = maxPage;
			}
		}
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getBeginUnitPage() {
		return beginUnitPage;
	}

	public void setBeginUnitPage(int beginUnitPage) {
		this.beginUnitPage = beginUnitPage;
	}

	public int getEndUnitPage() {
		return endUnitPage;
	}

	public void setEndUnitPage(int endUnitPage) {
		this.endUnitPage = endUnitPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	@Override
	public String toString() {
		return "Page [currentPage=" + currentPage + ", beginUnitPage=" + beginUnitPage + ", endUnitPage=" + endUnitPage
				+ ", totalCount=" + totalCount + ", maxPage=" + maxPage + ", pageUnit=" + pageUnit + ", pageSize="
				+ pageSize + "]";
	}
	
}