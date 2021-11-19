package com.pluckit.app.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pluckit.app.dto.BoardMainDTO;
import com.pluckit.app.dto.DepartmentDTO;
import com.pluckit.app.dto.EmployeeDTO;

@Repository
public class MainDAO {
	@Autowired
	private SqlSession sqlSession;
	
	// 회원가입 처리
	public int insertSignupData(EmployeeDTO dto) {
		return sqlSession.insert("main.insertSignupData", dto);
	}

	// 로그인 처리
	public EmployeeDTO selectLoginData(EmployeeDTO dto) {
		return sqlSession.selectOne("main.selectLoginData", dto);
	}

	public List<BoardMainDTO> getBoardList() {
		return sqlSession.selectList("main.getBoardList");
	}

	public String getEmpPw(String empNum) {
		return sqlSession.selectOne("main.getEmpPw", empNum);
	}

	public int chkEmpNum(EmployeeDTO dto) {
		return sqlSession.selectOne("main.chkEmpNum", dto);
	}
	
}// MainDAO 끝
