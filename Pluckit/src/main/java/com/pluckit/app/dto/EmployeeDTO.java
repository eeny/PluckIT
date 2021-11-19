package com.pluckit.app.dto;

public class EmployeeDTO {
	private int emp_id; // 직원코드
	private String emp_num; // 사원번호
	private String emp_pw; // 비밀번호
	private String emp_name; // 이름
	private String emp_ename; // 영문이름
	private String emp_birth; // 생년월일
	private String emp_gender; // m(남), f(여)
	private String emp_tel; // 연락처
	private String emp_email; // 이메일
	private String emp_postcode; // 주소1(우편번호)
	private String emp_addr; // 주소2(주소)
	private String emp_detailaddr; // 주소3(상세주소)
	private String emp_extraaddr; // 주소4(참고항목)
	private String dept_id; // 부서 코드
	private String rank_id; // 직급 코드
	private String emp_status; // 재직, 휴직, 퇴사
	private String emp_hire; // 입사일자
	private String emp_quit; // 퇴사일자 (재직상태-퇴사랑 같이 update할 것)
	private String emp_photo; // 증명사진
	private int emp_auth; // 0(권한없음), 1(사원), 2(부서장), 3(임원), 4(협력업체), 5(관리자)
	private String emp_remarks; // 비고(사원정보 추가사항 기재용)
	
	// 실제 테이블에 존재하지 않는 변수들
	private int eid; // 사원번호 중복피하기위한 변수 - 회원가입 할 때 사용
	private String deptName; // 부서명 변수 - 로그인 할 때 사용
	private String rankName; // 직급명 변수 - 로그인 할 때 사용
	
	public int getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(int emp_id) {
		this.emp_id = emp_id;
	}
	public String getEmp_num() {
		return emp_num;
	}
	public void setEmp_num(String emp_num) {
		this.emp_num = emp_num;
	}
	public String getEmp_pw() {
		return emp_pw;
	}
	public void setEmp_pw(String emp_pw) {
		this.emp_pw = emp_pw;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_ename() {
		return emp_ename;
	}
	public void setEmp_ename(String emp_ename) {
		this.emp_ename = emp_ename;
	}
	public String getEmp_birth() {
		return emp_birth;
	}
	public void setEmp_birth(String emp_birth) {
		this.emp_birth = emp_birth;
	}
	public String getEmp_gender() {
		return emp_gender;
	}
	public void setEmp_gender(String emp_gender) {
		this.emp_gender = emp_gender;
	}
	public String getEmp_tel() {
		return emp_tel;
	}
	public void setEmp_tel(String emp_tel) {
		this.emp_tel = emp_tel;
	}
	public String getEmp_email() {
		return emp_email;
	}
	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}
	public String getEmp_postcode() {
		return emp_postcode;
	}
	public void setEmp_postcode(String emp_postcode) {
		this.emp_postcode = emp_postcode;
	}
	public String getEmp_addr() {
		return emp_addr;
	}
	public void setEmp_addr(String emp_addr) {
		this.emp_addr = emp_addr;
	}
	public String getEmp_detailaddr() {
		return emp_detailaddr;
	}
	public void setEmp_detailaddr(String emp_detailaddr) {
		this.emp_detailaddr = emp_detailaddr;
	}
	public String getEmp_extraaddr() {
		return emp_extraaddr;
	}
	public void setEmp_extraaddr(String emp_extraaddr) {
		this.emp_extraaddr = emp_extraaddr;
	}
	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getRank_id() {
		return rank_id;
	}
	public void setRank_id(String rank_id) {
		this.rank_id = rank_id;
	}
	public String getEmp_status() {
		return emp_status;
	}
	public void setEmp_status(String emp_status) {
		this.emp_status = emp_status;
	}
	public String getEmp_hire() {
		return emp_hire;
	}
	public void setEmp_hire(String emp_hire) {
		this.emp_hire = emp_hire;
	}
	public String getEmp_quit() {
		return emp_quit;
	}
	public void setEmp_quit(String emp_quit) {
		this.emp_quit = emp_quit;
	}
	public String getEmp_photo() {
		return emp_photo;
	}
	public void setEmp_photo(String emp_photo) {
		this.emp_photo = emp_photo;
	}
	public int getEmp_auth() {
		return emp_auth;
	}
	public void setEmp_auth(int emp_auth) {
		this.emp_auth = emp_auth;
	}
	public int getEid() {
		return eid;
	}
	public void setEid(int eid) {
		this.eid = eid;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getRankName() {
		return rankName;
	}
	public void setRankName(String rankName) {
		this.rankName = rankName;
	}

	public String getEmp_remarks() {
		return emp_remarks;
	}
	public void setEmp_remarks(String emp_remarks) {
		this.emp_remarks = emp_remarks;
	}
}
