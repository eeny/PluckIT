package com.pluckit.app.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.pluckit.app.dto.EmployeeDTO;

@Repository
public class OfficeDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<EmployeeDTO> selectEmployeeListData(HashMap<String, Integer> map) {
		return sqlSession.selectList("office.employeeSelectDate", map);
	}
	
	public List<EmployeeDTO> selcectEmployeeListSearchData(HashMap<String, String> map){
		return sqlSession.selectList("office.employeeSelectOneData", map);
	}

	public int getAllEmployeeCount() {
		return sqlSession.selectOne("office.getAllEmployeeCount");
	}

	public int getSearchEmployeeCount(HashMap<String, String> map) {
		return sqlSession.selectOne("office.getSearchEmployeeCount", map);
	}

}
