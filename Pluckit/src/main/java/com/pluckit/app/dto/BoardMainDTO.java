package com.pluckit.app.dto;

public class BoardMainDTO {
	private int bm_num;
	private String b_id;
	private String bm_title;
	private String bm_writer;
	private String bm_content;
	private String bm_regdate;
	private int bm_hit;
	private String bm_file;
	private String bm_savedfile;
	private String bm_filepath;
	private int bm_grpnum;
	private int bm_grpord;
	private int bm_grpdepth;
	
	// 실제 테이블에 존재하지 않는 변수
	private String bTitle; // 게시판이름 변수 - 게시판 화면에 출력할 용도
	
	public int getBm_num() {
		return bm_num;
	}
	public void setBm_num(int bm_num) {
		this.bm_num = bm_num;
	}
	public String getB_id() {
		return b_id;
	}
	public void setB_id(String b_id) {
		this.b_id = b_id;
	}
	public String getBm_title() {
		return bm_title;
	}
	public void setBm_title(String bm_title) {
		this.bm_title = bm_title;
	}
	public String getBm_writer() {
		return bm_writer;
	}
	public void setBm_writer(String bm_writer) {
		this.bm_writer = bm_writer;
	}
	public String getBm_content() {
		return bm_content;
	}
	public void setBm_content(String bm_content) {
		this.bm_content = bm_content;
	}
	public String getBm_regdate() {
		return bm_regdate;
	}
	public void setBm_regdate(String bm_regdate) {
		this.bm_regdate = bm_regdate;
	}
	public int getBm_hit() {
		return bm_hit;
	}
	public void setBm_hit(int bm_hit) {
		this.bm_hit = bm_hit;
	}
	public String getBm_file() {
		return bm_file;
	}
	public void setBm_file(String bm_file) {
		this.bm_file = bm_file;
	}
	public String getBm_savedfile() {
		return bm_savedfile;
	}
	public void setBm_savedfile(String bm_savedfile) {
		this.bm_savedfile = bm_savedfile;
	}
	public String getBm_filepath() {
		return bm_filepath;
	}
	public void setBm_filepath(String bm_filepath) {
		this.bm_filepath = bm_filepath;
	}
	public int getBm_grpnum() {
		return bm_grpnum;
	}
	public void setBm_grpnum(int bm_grpnum) {
		this.bm_grpnum = bm_grpnum;
	}
	public int getBm_grpord() {
		return bm_grpord;
	}
	public void setBm_grpord(int bm_grpord) {
		this.bm_grpord = bm_grpord;
	}
	public int getBm_grpdepth() {
		return bm_grpdepth;
	}
	public void setBm_grpdepth(int bm_grpdepth) {
		this.bm_grpdepth = bm_grpdepth;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
}
