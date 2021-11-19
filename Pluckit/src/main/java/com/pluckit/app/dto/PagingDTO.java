package com.pluckit.app.dto;

public class PagingDTO {
	// 페이징 SQL에 사용할 변수
	int pageNum; // 현재 페이지
	int pageSize; // 한페이지에 출력할 행의 개수
	int totalCount; // 총 게시글(행) 수
	int totalPage; // 총 페이지 개수
	int offset; // 페이징된 리스트에 적용할 시작 번호
	
	// view 페이지에서 사용할 변수
	int pageCount; // 한페이지에 출력될 페이징 번호 개수
	int startPage; // 출력될 페이징 시작 번호
	int endPage; // 출력될 페이징 끝 번호
	
	public PagingDTO() {}
	
	public PagingDTO(int pageNum, int pageSize, int totalCount, int pageCount) {
		this.pageNum = pageNum;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.totalPage = calTotalPage(totalCount, pageSize);
		this.offset = calOffset(pageNum, pageSize);
		this.pageCount = pageCount;
		this.startPage = calStartPage(pageNum, pageCount);
		this.endPage = calEndPage(getStartPage(), pageCount, getTotalPage());
		
	}

	// 특정 변수 계산하는 메서드
	public int calTotalPage(int totalCount, int pageSize) {
		int totalPage = totalCount / pageSize;
		// 총 페이지 개수가 만약 정수로 안떨어지면 1 증가
		if (totalCount%pageSize > 0) {
			totalPage++;
		}
		return totalPage;
	}
	
	public int calOffset(int pageNum, int pageSize) {
		int offset = (pageNum-1)*pageSize;	
		return offset;
	}
	
	public int calStartPage(int pageNum, int pageCount) {
		int startPage = ((pageNum-1)/pageCount)*pageCount+1;
		return startPage;
	}
	
	public int calEndPage(int startPage, int pageCount, int totalPage) {
		int endPage = startPage-1+pageCount;
		// 페이징 끝 번호가 총 페이지 개수를 넘지 않도록 제한
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		return endPage;
	}

	
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
}
