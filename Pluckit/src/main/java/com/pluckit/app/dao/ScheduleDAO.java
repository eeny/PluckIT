package com.pluckit.app.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pluckit.app.dto.ScheduleDTO;

@Repository
public class ScheduleDAO {
	@Autowired
	private SqlSession sqlSession;

	public int insertSchedule(ScheduleDTO dto) {
		return sqlSession.insert("schedule.insertSchedule", dto);
	}

	public List<ScheduleDTO> getScheduleList() {
		return sqlSession.selectList("schedule.getScheduleList");
	}

	public int deleteSchedule(int scId) {
		return sqlSession.delete("schedule.deleteSchedule", scId);
	}
	
	
}
