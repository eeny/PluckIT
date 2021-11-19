package com.pluckit.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pluckit.app.dao.ScheduleDAO;
import com.pluckit.app.dto.ScheduleDTO;

@Service
public class ScheduleService {
	@Autowired
	private ScheduleDAO sdao;

	public int insertSchedule(ScheduleDTO dto) {
		return sdao.insertSchedule(dto);
	}

	public List<ScheduleDTO> getScheduleList() {
		return sdao.getScheduleList();
	}

	public int deleteSchedule(int scId) {
		return sdao.deleteSchedule(scId);
	}
	
	
}
