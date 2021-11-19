package com.pluckit.app.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pluckit.app.dto.BoardDTO;
import com.pluckit.app.dto.BoardMainDTO;
import com.pluckit.app.dto.BoardReplyDTO;

@Repository
public class BoardDAO {
	@Autowired
	private SqlSession sqlSession;

	public List<BoardDTO> getAllBaordTitle(String deptName) {
		return sqlSession.selectList("board.getAllBoardTitleUser", deptName);
	}
	
	public List<BoardDTO> getAllBoardTitle() {
		return sqlSession.selectList("board.getAllBoardTitleAdmin");
	}

	public String getBoardTitle(String pageName) {
		return sqlSession.selectOne("board.getBoardTitle", pageName);
	}

	public int writePostProc(HashMap<String, String> map) {
		return sqlSession.insert("board.writePostProc", map);
	}
	
	public int updatePostGrpInfo(HashMap<String, String> map) {
		return sqlSession.update("board.updatePostGrpInfo", map);
	}

	public List<BoardMainDTO> getAllBoardList(HashMap<String, String> map) {
		return sqlSession.selectList("board.getAllBoardList", map);
	}

	public int getAllBoardCount(String pageName) {
		return sqlSession.selectOne("board.getAllBoardCount", pageName);
	}
	
	public int updateHitCount(HashMap<String, String> map) {
		return sqlSession.update("board.updateHitCount", map);
	}

	public BoardMainDTO getPost(HashMap<String, String> map) {
		return sqlSession.selectOne("board.getPost", map);
	}

	public String getFileName(HashMap<String, String> map) {
		return sqlSession.selectOne("board.getFileName", map);
	}

	public int modifyPost(HashMap<String, String> map) {
		return sqlSession.update("board.modifyPost", map);
	}
	
	public int modifyPostNotFile(HashMap<String, String> map) {
		return sqlSession.update("board.modifyPostNotFile", map);	
	}
	
	public int deletePostReply(HashMap<String, String> map) {
		return sqlSession.delete("board.deletePostReply", map);
	}

	public int deletePost(HashMap<String, String> map) {
		return sqlSession.delete("board.deletePost", map);
	}

	public int writeReplyProc(BoardReplyDTO dto) {
		return sqlSession.insert("board.writeReplyProc", dto);
	}

	public List<BoardReplyDTO> getReplyProc(BoardReplyDTO dto) {
		return sqlSession.selectList("board.getReplyProc", dto);
	}
	
	public BoardReplyDTO getModReply(BoardReplyDTO dto) {
		return sqlSession.selectOne("board.getModReply", dto);
	}

	public int deleteReplyProc(BoardReplyDTO dto) {
		return sqlSession.delete("board.deleteReplyProc", dto);
	}

	public int modifyReplyProc(BoardReplyDTO dto) {
		return sqlSession.update("board.modifyReplyProc", dto);
	}

	public int getMinBmGrpOrd(HashMap<String, String> map) {
		return sqlSession.selectOne("board.getMinBmGrpOrd", map);
	}

	public int insertFirstAnswer(HashMap<String, String> map) {
		return sqlSession.insert("board.insertFirstAnswer", map);
	}

	public int updateOtherAnswer(HashMap<String, String> map) {
		return sqlSession.update("board.updateOtherAnswer", map);
	}

	public int insertOtherAnswer(HashMap<String, String> map) {
		return sqlSession.insert("board.insertOtherAnswer", map);
	}

	public int getSearchPostCount(HashMap<String, String> map) {
		return sqlSession.selectOne("board.getSearchPostCount", map);
	}

	public List<BoardMainDTO> searchPostList(HashMap<String, String> map) {
		return sqlSession.selectList("board.searchPostList", map);
	}

	

	

	

	
	
}
