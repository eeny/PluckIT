package com.pluckit.app.dto;

public class ScheduleDTO {
	private int sc_id; // 일정코드
	private String sc_title; // 일정내용
	private String sc_start; // 일정시작일
	private String sc_end; // 일정종료일
	private int emp_id; // 직원코드
	
	// DB에 없는 컬럼
	private String deptName;
	private String empName;

	public int getSc_id() {
		return sc_id;
	}

	public void setSc_id(int sc_id) {
		this.sc_id = sc_id;
	}

	public String getSc_title() {
		return sc_title;
	}

	public void setSc_title(String sc_title) {
		this.sc_title = sc_title;
	}

	public String getSc_start() {
		return sc_start;
	}

	public void setSc_start(String sc_start) {
		this.sc_start = sc_start;
	}

	public String getSc_end() {
		return sc_end;
	}

	public void setSc_end(String sc_end) {
		this.sc_end = sc_end;
	}

	public int getEmp_id() {
		return emp_id;
	}

	public void setEmp_id(int emp_id) {
		this.emp_id = emp_id;
	}
	
	public String getDeptName() {
		return deptName;
	}
	
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	public String getEmpName() {
		return empName;
	}
	
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	
}
