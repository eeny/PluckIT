package com.pluckit.app.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.pluckit.app.dao.MainDAO;
import com.pluckit.app.dto.BoardMainDTO;
import com.pluckit.app.dto.DepartmentDTO;
import com.pluckit.app.dto.EmployeeDTO;

@Service
public class MainService {
	@Autowired
	private MainDAO mdao;
	
	@Autowired
	PasswordEncoder passwordEncoder; // 스프링 시큐리티 비밀번호 암호화
	
	public void insertSignupData(EmployeeDTO dto) {
		// 사원번호 생성 (현재년도 + 부서코드 + 직급코드) + 직원코드
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy");
		String year = now.format(fmt);
		String deptId = dto.getDept_id();
		String rankId = dto.getRank_id();
		
		String empNum = year + deptId + rankId;
		dto.setEmp_num(empNum);
		
		// 스프링 시큐리티 비밀번호 암호화(인코딩)
		String encPw = passwordEncoder.encode(dto.getEmp_pw());
		dto.setEmp_pw(encPw);
		
		mdao.insertSignupData(dto);
	}

	public EmployeeDTO selectLoginData(EmployeeDTO dto) {
		// 스프링 시큐리티 비밀번호 디코딩
		String encPw = mdao.getEmpPw(dto.getEmp_num()); // 암호화된 비밀번호
		String myPw = dto.getEmp_pw();
		
		System.out.println("encPw: " + encPw);
		System.out.println("myPw: " + myPw);
		
		if (passwordEncoder.matches(myPw, encPw)) {
			System.out.println("비밀번호 일치");
			dto.setEmp_pw(encPw);
		} else {
			System.out.println("비밀번호 불일치");
			dto.setEmp_pw(myPw);
		}
		
		return mdao.selectLoginData(dto);
	}

	public List<BoardMainDTO> getBoardList() {
		return mdao.getBoardList();
	}

	public int chkEmpNum(EmployeeDTO dto) {
		return mdao.chkEmpNum(dto);
	}

	

	
	
	
	
	
	
	
	
}// MainService 끝
