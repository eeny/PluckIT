package com.pluckit.app.dto;

public class BoardReplyDTO {
	private int r_num;
	private int bm_num;
	private String r_writer;
	private String r_content;
	private String r_regdate;
	
	// 실제 테이블에 존재하지 않는 변수
	private String b_id; // 게시판별 댓글 달기 할 때 사용
	
	public int getR_num() {
		return r_num;
	}
	public void setR_num(int r_num) {
		this.r_num = r_num;
	}
	public int getBm_num() {
		return bm_num;
	}
	public void setBm_num(int bm_num) {
		this.bm_num = bm_num;
	}
	public String getR_writer() {
		return r_writer;
	}
	public void setR_writer(String r_writer) {
		this.r_writer = r_writer;
	}
	public String getR_content() {
		return r_content;
	}
	public void setR_content(String r_content) {
		this.r_content = r_content;
	}
	public String getR_regdate() {
		return r_regdate;
	}
	public void setR_regdate(String r_regdate) {
		this.r_regdate = r_regdate;
	}
	
	public String getB_id() {
		return b_id;
	}
	public void setB_id(String b_id) {
		this.b_id = b_id;
	}
}
