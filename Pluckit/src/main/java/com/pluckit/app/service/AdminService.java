package com.pluckit.app.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pluckit.app.dao.AdminDAO;
import com.pluckit.app.dao.BoardDAO;
import com.pluckit.app.dto.BoardDTO;
import com.pluckit.app.dto.EmployeeDTO;

@Service
public class AdminService {
	@Autowired
	private AdminDAO addao;

	@Autowired
	private BoardDAO bddao;

	private String path; // 파일 업로드시 사용될 변수

	public void makeBoard(BoardDTO dto) {
		addao.makeBaord(dto);
	}

	public List<BoardDTO> getAllBoardList(int offset, int pageSize) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("offset", offset);
		map.put("pageSize", pageSize);
		return addao.getAllBoardList(map);
	}

	public void createMainTable(String bId) {
		String str = "CREATE TABLE board_main_" + bId;
		str += " (bm_num INT NOT NULL AUTO_INCREMENT,";
		str += " b_id VARCHAR(45),";
		str += " bm_title VARCHAR(200),";
		str += " bm_writer VARCHAR(45),";
		str += " bm_content TEXT,";
		str += " bm_regdate DATETIME,";
		str += " bm_hit INT,";
		str += " bm_file VARCHAR(300),";
		str += " bm_savedfile VARCHAR(300),";
		str += " bm_filepath VARCHAR(300),";
		str += " bm_grpnum INT,";
		str += " bm_grpord INT,";
		str += " bm_grpdepth INT,";
		str += " CONSTRAINT PK_board_main_" + bId + " PRIMARY KEY (bm_num),";
		str += " CONSTRAINT FK_board_main_" + bId + "_b_id_board_b_id FOREIGN KEY (b_id)";
		str += " REFERENCES board (b_id) ON DELETE RESTRICT ON UPDATE RESTRICT);";

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("main", str);

		addao.createMainTable(map);
	}

	public void createReplyTable(String bId) {
		String str = "CREATE TABLE board_reply_" + bId;
		str += " (r_num INT NOT NULL AUTO_INCREMENT,";
		str += " bm_num INT NOT NULL,";
		str += " r_writer VARCHAR(45),";
		str += " r_content TEXT,";
		str += " r_regdate DATETIME,";
		str += " CONSTRAINT PK_board_reply_" + bId + " PRIMARY KEY (r_num, bm_num),";
		str += " CONSTRAINT FK_board_reply_" + bId + "_bm_num_board_main_" + bId + "_bm_num FOREIGN KEY (bm_num)";
		str += " REFERENCES board_main_" + bId + " (bm_num) ON DELETE RESTRICT ON UPDATE RESTRICT);";

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("reply", str);

		addao.createReplyTable(map);
	}

	public int isBIdExist(String bId) {
		return addao.isBIdExist(bId);
	}

	public BoardDTO getBoardInfo(String bId) {
		return addao.getBoardInfo(bId);
	}

	public int updateBoardInfo(BoardDTO dto) {
		return addao.updateBoardInfo(dto);
	}

	public int isBoardDataExist(String bId) {
		String tblName = "board_main_" + bId;
		return addao.isBoardDataExist(tblName);
	}

	public void dropReplyTable(String bId) {
		String str = "DROP TABLE board_reply_" + bId;
		HashMap<String, String> map = new HashMap<>();
		map.put("reply", str);

		addao.dropReplyTable(map);
	}

	public void dropMainTable(String bId) {
		String str = "DROP TABLE board_main_" + bId;
		HashMap<String, String> map = new HashMap<>();
		map.put("main", str);

		addao.dropMainTable(map);
	}

	public int deleteBoardInfo(String bId) {
		return addao.deleteBoardInfo(bId);
	}

	public List<BoardDTO> searchBoardList(HashMap<String, String> map) {
		return addao.searchBoardList(map);
	}

	public int getAllBoardCount() {
		return addao.getAllBoardCount();
	}

	public int getSearchBoardCount(HashMap<String, String> map) {
		return addao.getSearchBoardCount(map);
	}

	public int getAllEmployeeCount() {
		return addao.getAllEmplyeeCount();
	}

	public List<BoardDTO> getAllEmployeeList(int offset, int pageSize) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("offset", offset);
		map.put("pageSize", pageSize);
		return addao.getAllEmployeeList(map);
	}

	public EmployeeDTO getEmployeeInfo(int empId) {
		return addao.getEmployeeInfo(empId);
	}

	public int modifyEmpAuthNStatusProc(EmployeeDTO dto) {
		return addao.modifyEmpAuthNStatusProc(dto);
	}

	public int deleteEmployee(int empId) {
		return addao.deleteEmployee(empId);
	}

	public void insertEmpInfoProc(ServletContext context, MultipartHttpServletRequest mrequest) throws IOException {
		HashMap<String, String> map = new HashMap<>();

		// 파일을 제외한 나머지 값
		String emp_hire = mrequest.getParameter("emp_hire");
		String emp_name = mrequest.getParameter("emp_name");
		String emp_ename = mrequest.getParameter("emp_ename");
		String dept_id = mrequest.getParameter("dept_id");
		String rank_id = mrequest.getParameter("rank_id");
		String emp_gender = mrequest.getParameter("emp_gender");
		String emp_birth = mrequest.getParameter("emp_birth");
		String emp_tel = mrequest.getParameter("emp_tel");
		String emp_email = mrequest.getParameter("emp_email");
		String emp_postcode = mrequest.getParameter("emp_postcode");
		String emp_addr = mrequest.getParameter("emp_addr");
		String emp_detailaddr = mrequest.getParameter("emp_detailaddr");
		String emp_extraaddr = mrequest.getParameter("emp_extraaddr");
		String emp_status = mrequest.getParameter("emp_status");
		String emp_quit = mrequest.getParameter("emp_quit");
		String emp_remarks = mrequest.getParameter("emp_remarks");

		// 넘어온 파일 객체
		MultipartFile file = mrequest.getFile("emp_photo");
		// 파일 객체 이름 가져오기 (여기서는 사용안함)
		String fileName = file.getOriginalFilename();

		// 사원번호 생성 (현재년도 + 부서코드 + 직급코드) + 직원코드
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy");
		String year = now.format(fmt);
		String deptId = dept_id;
		String rankId = rank_id;

		String empNum = year + deptId + rankId;
		
		// Date 타입 빈값 처리
		if (emp_quit == null || emp_quit.equals("")) {
			map.put("emp_quit", "");
		} else {
			map.put("emp_quit", emp_quit);
		}
		
		if (emp_birth == null || emp_birth.equals("")) {
			map.put("emp_birth", "");
		} else {
			map.put("emp_birth", emp_birth);
		}
		
		if (emp_hire == null || emp_hire.equals("")) {
			map.put("emp_hire", "");
		} else {
			map.put("emp_hire", emp_hire);
		}
		
		map.put("emp_name", emp_name);
		map.put("emp_ename", emp_ename);
		map.put("dept_id", dept_id);
		map.put("rank_id", rank_id);
		map.put("emp_gender", emp_gender);
		map.put("emp_tel", emp_tel);
		map.put("emp_email", emp_email);
		map.put("emp_postcode", emp_postcode);
		map.put("emp_addr", emp_addr);
		map.put("emp_detailaddr", emp_detailaddr);
		map.put("emp_extraaddr", emp_extraaddr);
		map.put("emp_status", emp_status);
		map.put("emp_remarks", emp_remarks);
		map.put("emp_num", empNum);
		map.put("eid", ""); // selectKey에 사용될 변수

		// 파일 저장 위치 - 실제 서버의 파일 위치
		path = context.getRealPath("/resources/upload/");

		// 설정한 경로에 폴더가 없을 때 폴더 생성
		File dir = new File(path);
		if (dir.exists()) {
			dir.mkdir();
		}

		if (!file.isEmpty()) { // 첨부파일이 존재하는 경우
			// 파일명 중복 방지(UUID방식)
			String saveFileName = uploadFile(fileName, file.getBytes());

			file.transferTo(new File(path + saveFileName));

			map.put("emp_photo", saveFileName); // 실제 저장되는 파일명을 저장

			addao.insertEmpInfoProc(map);
		} else { // 첨부파일이 없는 경우
			map.put("emp_photo", "");
			addao.insertEmpInfoProc(map);
		}
	}

	public void updateEmpInfoProc(ServletContext context, MultipartHttpServletRequest mrequest) throws IOException {
		HashMap<String, Object> map = new HashMap<>();

		// 파일을 제외한 나머지 값
		String emp_id = mrequest.getParameter("emp_id");
		String emp_hire = mrequest.getParameter("emp_hire");
		String emp_name = mrequest.getParameter("emp_name");
		String emp_ename = mrequest.getParameter("emp_ename");
		String dept_id = mrequest.getParameter("dept_id");
		String rank_id = mrequest.getParameter("rank_id");
		String emp_gender = mrequest.getParameter("emp_gender");
		String emp_birth = mrequest.getParameter("emp_birth");
		String emp_tel = mrequest.getParameter("emp_tel");
		String emp_email = mrequest.getParameter("emp_email");
		String emp_postcode = mrequest.getParameter("emp_postcode");
		String emp_addr = mrequest.getParameter("emp_addr");
		String emp_detailaddr = mrequest.getParameter("emp_detailaddr");
		String emp_extraaddr = mrequest.getParameter("emp_extraaddr");
		String emp_status = mrequest.getParameter("emp_status");
		String emp_quit = mrequest.getParameter("emp_quit");
		String emp_remarks = mrequest.getParameter("emp_remarks");

		// Date 타입 빈값 처리
		if (emp_quit == null || emp_quit.equals("")) {
			map.put("emp_quit", "");
		} else {
			map.put("emp_quit", emp_quit);
		}
		
		if (emp_birth == null || emp_birth.equals("")) {
			map.put("emp_birth", "");
		} else {
			map.put("emp_birth", emp_birth);
		}

		MultipartFile file = mrequest.getFile("emp_photo"); // 넘어온 파일 객체
		String fileName = file.getOriginalFilename(); // 파일 객체 이름 가져오기

		map.put("emp_id", emp_id);
		map.put("emp_hire", emp_hire);
		map.put("emp_name", emp_name);
		map.put("emp_ename", emp_ename);
		map.put("dept_id", dept_id);
		map.put("rank_id", rank_id);
		map.put("emp_gender", emp_gender);
		map.put("emp_tel", emp_tel);
		map.put("emp_email", emp_email);
		map.put("emp_postcode", emp_postcode);
		map.put("emp_addr", emp_addr);
		map.put("emp_detailaddr", emp_detailaddr);
		map.put("emp_extraaddr", emp_extraaddr);
		map.put("emp_status", emp_status);
		map.put("emp_remarks", emp_remarks);

		// 파일 저장 위치 - 실제 서버의 파일 위치
		path = context.getRealPath("/resources/upload/");

		// 설정한 경로에 폴더가 없을 때 폴더 생성
		File dir = new File(path);
		if (dir.exists()) {
			dir.mkdir();
		}

		if (!file.isEmpty()) { // 첨부파일이 존재하는 경우
			// 기존에 저장된 파일 삭제하기
			File oldFile = new File(path + addao.getFileName(map));
			if (oldFile.exists()) {
				oldFile.delete();
				System.out.println("기존파일 삭제완료");
			}

			// 파일명 중복 방지(UUID방식)
			String saveFileName = uploadFile(fileName, file.getBytes());

			file.transferTo(new File(path + saveFileName));

			map.put("emp_photo", saveFileName);
			
			addao.updateEmpInfoProc(map);
		} else { // 첨부파일이 없는 경우
			addao.updateEmpInfoProcNotFile(map);
		}
	}

	// 파일명 중복 안되게 수정하는 메서드 (UUID방식)
	private String uploadFile(String originalName, byte[] fileData) throws IOException {
		// UUID(범용 고유 식별자) 생성
		UUID uuid = UUID.randomUUID();

		// 랜덤 생성 + 파일이름 저장
		String saveFileName = uuid.toString() + "_" + originalName;
		File target = new File(path, saveFileName);

		// 임시디렉토리에 저장된 업로드파일을 지정된 디렉토리로 복사
		// FileCopyUtils (바이트배열, 파일객체)
		FileCopyUtils.copy(fileData, target);

		return saveFileName;
	}

	public int getSearchEmployeeCount(HashMap<String, String> map) {
		return addao.getSearchEmployeeCount(map);
	}

	public List<BoardDTO> getSearchEmployeeList(HashMap<String, String> map) {
		// 검색어 처리
		if (map.get("select") == "e.rank_id") { // 직위 검색
			map.replace("select", "r.rank_name");
			
		} else if (map.get("select") == "e.dept_id") { // 소속 검색
			map.replace("select", "d.dept_name");			
		
		} else if (map.get("select") == "e.emp_auth") { // 접근권한 검색
			switch (map.get("search")) {
				case "권한없음": map.replace("search", "0"); break;
				case "사원": map.replace("search", "1"); break;
				case "부서장": map.replace("search", "2"); break;
				case "임원": map.replace("search", "3"); break;
				case "협력업체": map.replace("search", "4"); break;
				case "관리자": map.replace("search", "5"); break;
				default: map.replace("search", "");	break;
			}
		}
		
		return addao.getSearchEmployeeList(map);
	}

	

}// AdminService 끝
