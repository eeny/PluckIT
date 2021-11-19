package com.pluckit.app.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pluckit.app.dto.BoardDTO;
import com.pluckit.app.dto.EmployeeDTO;

@Repository
public class AdminDAO {
	@Autowired
	private SqlSession sqlSession;

	public int makeBaord(BoardDTO dto) {
		return sqlSession.insert("admin.makeBoard", dto);
	}

	public List<BoardDTO> getAllBoardList(HashMap<String, Integer> map) {
		return sqlSession.selectList("admin.getAllBoardList", map);
	}

	public int createMainTable(HashMap<String, String> map) {
		return sqlSession.insert("admin.createMainTable", map);
	}

	public int createReplyTable(HashMap<String, String> map) {
		return sqlSession.insert("admin.createReplyTable", map);
	}

	public int isBIdExist(String bId) {
		return sqlSession.selectOne("admin.isBIdExist", bId);
	}

	public BoardDTO getBoardInfo(String bId) {
		return sqlSession.selectOne("admin.getBoardInfo", bId);
	}

	public int updateBoardInfo(BoardDTO dto) {
		return sqlSession.update("admin.updateBoardInfo", dto);
	}

	public int isBoardDataExist(String tblName) {
		return sqlSession.selectOne("admin.isBoardDataExist", tblName);
	}

	public int dropReplyTable(HashMap<String, String> map) {
		return sqlSession.insert("admin.dropReplyTable", map);
	}

	public int dropMainTable(HashMap<String, String> map) {
		return sqlSession.insert("admin.dropMaintable", map);
	}

	public int deleteBoardInfo(String bId) {
		return sqlSession.delete("admin.deleteBoardInfo", bId);
	}

	public List<BoardDTO> searchBoardList(HashMap<String, String> map) {
		return sqlSession.selectList("admin.searchBoardList", map);
	}

	public int getAllBoardCount() {
		return sqlSession.selectOne("admin.getAllBoardCount");
	}

	public int getSearchBoardCount(HashMap<String, String> map) {
		return sqlSession.selectOne("admin.getSearchBoardCount", map);
	}

	public int getAllEmplyeeCount() {
		return sqlSession.selectOne("admin.getAllEmplyeeCount");
	}

	public List<BoardDTO> getAllEmployeeList(HashMap<String, Integer> map) {
		return sqlSession.selectList("admin.getAllEmployeeList", map);
	}

	public EmployeeDTO getEmployeeInfo(int empId) {
		return sqlSession.selectOne("admin.getEmployeeInfo", empId);
	}

	public int modifyEmpAuthNStatusProc(EmployeeDTO dto) {
		return sqlSession.update("admin.modifyEmpAuthNStatusProc", dto);
	}

	public int deleteEmployee(int empId) {
		return sqlSession.delete("admin.deleteEmployee", empId);
	}

	public int insertEmpInfoProc(HashMap<String, String> map) {
		return sqlSession.insert("admin.insertEmpInfoProc", map);
	}

	public String getFileName(HashMap<String, Object> map) {
		return sqlSession.selectOne("admin.getFileName", map);
	}

	public int updateEmpInfoProc(HashMap<String, Object> map) {
		return sqlSession.update("admin.updateEmpInfoProc", map);
	}

	public int updateEmpInfoProcNotFile(HashMap<String, Object> map) {
		return sqlSession.update("admin.updateEmpInfoProcNotFile", map);
	}

	public int getSearchEmployeeCount(HashMap<String, String> map) {
		return sqlSession.selectOne("admin.getSearchEmployeeCount", map);
	}

	public List<BoardDTO> getSearchEmployeeList(HashMap<String, String> map) {
		return sqlSession.selectList("admin.getSearchEmployeeList", map);
	}
	
	
	
	
	
	
	
}// AdminDAO 끝
