package com.pluckit.app.dto;

public class BoardDTO {
	private String b_id; // 게시판 코드 - 테이블명에 사용
	private String dept_id; // 담당부서
	private String b_writer; // 게시판생성자
	private String b_title; // 게시판제목
	private String b_readAuth; // 읽기권한 0(모두), 1(직원)
	private String b_writeAuth; // 쓰기권한 0(모두), 1(직원)
	private String b_replyAuth; // 댓글권한 0(모두), 1(직원)
	private String b_downAuth; // 다운권한 0(모두), 1(직원)
	private String b_regdate; // 게시판생성일자
	
	// 실제 테이블에 존재하지 않는 변수들
	private String deptName; // 부서명 변수 - 리스트 보여줄 때 사용

	public String getB_id() {
		return b_id;
	}
	public void setB_id(String b_id) {
		this.b_id = b_id;
	}
	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getB_writer() {
		return b_writer;
	}
	public void setB_writer(String b_writer) {
		this.b_writer = b_writer;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_readAuth() {
		return b_readAuth;
	}
	public void setB_readAuth(String b_readAuth) {
		this.b_readAuth = b_readAuth;
	}
	public String getB_writeAuth() {
		return b_writeAuth;
	}
	public void setB_writeAuth(String b_writeAuth) {
		this.b_writeAuth = b_writeAuth;
	}
	public String getB_replyAuth() {
		return b_replyAuth;
	}
	public void setB_replyAuth(String b_replyAuth) {
		this.b_replyAuth = b_replyAuth;
	}
	public String getB_downAuth() {
		return b_downAuth;
	}
	public void setB_downAuth(String b_downAuth) {
		this.b_downAuth = b_downAuth;
	}
	public String getB_regdate() {
		return b_regdate;
	}
	public void setB_regdate(String b_regdate) {
		this.b_regdate = b_regdate;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
}
