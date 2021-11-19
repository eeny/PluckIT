package com.pluckit.app.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pluckit.app.dao.OfficeDAO;
import com.pluckit.app.dto.EmployeeDTO;

@Service
public class OfficeService {
	
	@Autowired
	private OfficeDAO odao;
	
	public List<EmployeeDTO> selectEmployeeListAll(int offset, int pageSize) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("offset", offset);
		map.put("pageSize", pageSize);
		return odao.selectEmployeeListData(map);
	}
	
	public List<EmployeeDTO> selectEmployeeListOne(String select, String search, String offset, String pageSize) {
		HashMap<String, String> map = new HashMap<String, String>();
		
		// 검색시 부서코드와 직급코드는 따로 구분해서 검색어 변경
		if (select.equals("dept_id")) {
			switch (search) {
				case "인사": search = "100"; break;
				case "영업": search = "200"; break;
				case "마케팅": search = "300"; break;
				case "총무회계": search = "400"; break;
				case "기술지원": search = "500"; break;
				case "전략기획": search = "600"; break;
				default: search = "";	break;
			}
		}
		if (select.equals("rank_id")) {
			switch (search) {
				case "사원": search = "1"; break;
				case "대리": search = "2"; break;
				case "과장": search = "3"; break;
				case "차장": search = "4"; break;
				case "부장": search = "5"; break;
				case "이사": search = "6"; break;
				case "전무": search = "7"; break;
				case "사장": search = "8"; break;
				default: search = "";	break;
			}
		}
		
		map.put("select", select);
		map.put("search", search);
		map.put("offset", offset);
		map.put("pageSize", pageSize);
		
		List<EmployeeDTO> list = odao.selcectEmployeeListSearchData(map);
		return list;
	}

	public int getAllEmployeeCount() {
		return odao.getAllEmployeeCount();
	}

	public int getSearchEmployeeCount(String select, String search) {
		HashMap<String, String> map = new HashMap<String, String>();
		
		// 검색시 부서코드와 직급코드는 따로 구분해서 검색어 변경
		if (select.equals("dept_id")) {
			switch (search) {
				case "인사": search = "100"; break;
				case "영업": search = "200"; break;
				case "마케팅": search = "300"; break;
				case "총무회계": search = "400"; break;
				case "기술지원": search = "500"; break;
				case "전략기획": search = "600"; break;
				default: search = "";	break;
			}
		}
		if (select.equals("rank_id")) {
			switch (search) {
				case "사원": search = "1"; break;
				case "대리": search = "2"; break;
				case "과장": search = "3"; break;
				case "차장": search = "4"; break;
				case "부장": search = "5"; break;
				case "이사": search = "6"; break;
				case "전무": search = "7"; break;
				case "사장": search = "8"; break;
				default: search = "";	break;
			}
		}
		
		map.put("select", select);
		map.put("search", search);
		
		return odao.getSearchEmployeeCount(map);
	}

}
