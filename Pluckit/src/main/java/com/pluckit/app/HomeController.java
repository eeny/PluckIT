package com.pluckit.app;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pluckit.app.dto.BoardDTO;
import com.pluckit.app.dto.BoardMainDTO;
import com.pluckit.app.dto.BoardReplyDTO;
import com.pluckit.app.dto.EmployeeDTO;
import com.pluckit.app.dto.PagingDTO;
import com.pluckit.app.dto.ScheduleDTO;
import com.pluckit.app.service.AdminService;
import com.pluckit.app.service.BoardService;
import com.pluckit.app.service.MainService;
import com.pluckit.app.service.OfficeService;
import com.pluckit.app.service.ScheduleService;
import com.pluckit.util.DownloadView;

@Controller
public class HomeController {
	@Autowired
	private MainService msvc; // [main]

	@Autowired
	private OfficeService osvc; // [office]

	@Autowired
	private AdminService adsvc; // [admin]

	@Autowired
	private BoardService bsvc; // [board]

	@Autowired
	private ScheduleService ssvc; // [schedule]

	@Autowired
	ServletContext context; // 파일 전송시 사용 

	// 웹사이트 최초 메인화면으로 이동
	@RequestMapping("/Home.do")
	public String home(Model model) {
		return "home";
	}

	// ===================== 로그인 & 회원가입 시작 =====================

	// 로그인 페이지로 이동
	@RequestMapping("/Login.do")
	public String login() {
		return "main/login";
	}

	// 로그인 처리
	@RequestMapping("/LoginProc.do")
	public String loginProc(Model model, HttpSession session, EmployeeDTO dto) {
		// 존재하는 아이디인지 확인
		int isExistEmpNum = msvc.chkEmpNum(dto);
		
		String msg;

		if (isExistEmpNum == 0) { // 존재하지 않는 사원번호
			msg = "<i class='fas fa-exclamation-circle'></i>&nbsp;&nbsp;사원번호를 다시 확인해주세요.";
			model.addAttribute("msg", msg);
			return "main/login";
			
		} else {
			EmployeeDTO empInfo = msvc.selectLoginData(dto);
			
			// 로그인 실패
			if (empInfo == null) {
				msg = "<i class='fas fa-exclamation-circle'></i>&nbsp;&nbsp;사원 정보가 올바르지 않습니다.";
				model.addAttribute("msg", msg);
				return "main/login";
				
				// 로그인 성공
			} else {
				int auth = empInfo.getEmp_auth();
				// 권한 확인
				if (auth == 0) {
					msg = "<i class='fas fa-exclamation-circle'></i>&nbsp;&nbsp;접근 권한이 없습니다. 관리자에게 문의하세요";
					model.addAttribute("msg", msg);
					return "main/login";
				}
				
				session.setAttribute("empInfo", empInfo);
				return "home";
			}			
		}
	}

	// 그룹웨어 메인 페이지로 이동
	@RequestMapping("/GroupWareMain.do")
	public String groupWareMain(Model model) {
		// 메인 페이지의 전사공지 목록 가져오기
		model.addAttribute("boardList", msvc.getBoardList());
		
		return "main/main";
	}

	// 로그아웃 처리
	@RequestMapping("/LogoutProc.do")
	public String logoutProc(HttpSession session) {
		session.invalidate();

		return "redirect:/Home.do";
	}

	// 회원가입 페이지로 이동
	@RequestMapping("/Signup.do")
	public String signup() {
		return "main/signup";
	}

	// 회원가입 처리
	@RequestMapping("/SignupProc.do")
	public String signupProc(EmployeeDTO dto) {
		msvc.insertSignupData(dto);

		return "redirect:/Login.do";
	}

	// ===================== 로그인 & 회원가입 끝 =====================

	// ===================== 오피스:직원목록 시작 =====================

	// 직원목록 리스트 출력
	@RequestMapping("/Employee.do")
	public String emloyeeList(@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pNum,
			Model model) {
		// 총 사원 목록수, 페이징 처리
		int totalCount = osvc.getAllEmployeeCount();
		PagingDTO pDto = new PagingDTO(Integer.parseInt(pNum), 10, totalCount, 3);
		List<EmployeeDTO> employeeList = osvc.selectEmployeeListAll(pDto.getOffset(), pDto.getPageSize());

		model.addAttribute("employeeList", employeeList);
		model.addAttribute("paging", pDto);

		return "office/office_employee";
	}

	// 직원목록 검색 처리
	@RequestMapping("/SearchProc.do")
	public String searchEmployeeList(@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pNum,
			Model model, String select, String search) {
		// 검색한 사원 목록수, 페이징 처리
		int totalCount = osvc.getSearchEmployeeCount(select, search);
		PagingDTO pDto = new PagingDTO(Integer.parseInt(pNum), 10, totalCount, 3);
		List<EmployeeDTO> employeeList = osvc.selectEmployeeListOne(select, search, Integer.toString(pDto.getOffset()), Integer.toString(pDto.getPageSize()));

		model.addAttribute("employeeList", employeeList);
		model.addAttribute("paging", pDto);

		return "office/office_employee";
	}

	// ===================== 오피스:직원목록 끝 =====================

	// ===================== 관리자메뉴:게시판 관리 시작 =====================

	// 관리자메뉴 페이지 이동
	@RequestMapping("/Admin.do")
	public String admin(@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pNum,
			Model model) {
		// 총 게시판 개수, 페이징 처리
		int totalCount = adsvc.getAllBoardCount();
		PagingDTO pDto = new PagingDTO(Integer.parseInt(pNum), 10, totalCount, 3);

		List<BoardDTO> boardList = adsvc.getAllBoardList(pDto.getOffset(), pDto.getPageSize());
		model.addAttribute("boardList", boardList);
		model.addAttribute("paging", pDto);

		return "admin/admin_mngboard";
	}

	// 게시판 등록 처리
	@RequestMapping("/MakeBoard.do")
	public String makeBoard(BoardDTO dto, Model model) {
		adsvc.makeBoard(dto);
		adsvc.createMainTable(dto.getB_id());
		adsvc.createReplyTable(dto.getB_id());

		return "redirect:/Admin.do";
	}

	// 게시판 코드 중복 확인 처리
	@RequestMapping(value = "/IsBIdExist.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Integer> isBIdExist(@RequestBody BoardDTO dto) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", adsvc.isBIdExist(dto.getB_id()));

		return map;
	}

	// 수정할 게시판 정보 가져오기
	@RequestMapping(value = "/GetBoardInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public BoardDTO getBoardInfo(@RequestBody BoardDTO dto) {
		return adsvc.getBoardInfo(dto.getB_id());
	}

	// 게시판 수정 처리
	@RequestMapping("/ModifyBoardProc.do")
	public String modifyBoard(BoardDTO dto) {
		adsvc.updateBoardInfo(dto);

		return "redirect:/Admin.do";
	}

	// 게시판 삭제 전 데이터 존재유무 확인
	@RequestMapping(value = "/IsBoardDataExist.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Integer> IsBoardDataExist(@RequestBody BoardDTO dto) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", adsvc.isBoardDataExist(dto.getB_id()));

		return map;
	}

	// 게시판 삭제 처리
	@RequestMapping("/DeleteBoardProc.do")
	public String deleteBoard(String b_id) {
		adsvc.dropReplyTable(b_id);
		adsvc.dropMainTable(b_id);
		adsvc.deleteBoardInfo(b_id);

		return "redirect:/Admin.do";
	}

	// 게시판 검색 처리
	@RequestMapping("/SearchBoardList.do")
	public String searchBoardList(@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pNum,
			Model model, String select, String search) {
		// 검색어 처리
		HashMap<String, String> map = new HashMap<>();

		if (select.equals("b_id") || select.equals("b_title")) {
			select = "b." + select;
		} else if (select.equals("dept_id")) {
			select = "d.dept_name";
		}

		map.put("select", select);
		map.put("search", search);

		// 총 게시판 개수, 페이징 처리
		int totalCount = adsvc.getSearchBoardCount(map);
		PagingDTO pDto = new PagingDTO(Integer.parseInt(pNum), 10, totalCount, 3);

		map.put("offset", Integer.toString(pDto.getOffset()));
		map.put("pageSize", Integer.toString(pDto.getPageSize()));

		List<BoardDTO> boardList = adsvc.searchBoardList(map);

		model.addAttribute("boardList", boardList);
		model.addAttribute("paging", pDto);

		return "admin/admin_mngboard";
	}

	// ===================== 관리자메뉴:게시판 관리 끝 =====================

	// ===================== 관리자메뉴:인사 관리 시작 =====================

	// 관리자 메뉴 - 인사관리 페이지로 이동
	@RequestMapping("/HumanResources.do")
	public String humanResources(@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pNum,
			Model model) {
		// 총 사원 목록수, 페이징 처리
		int totalCount = adsvc.getAllEmployeeCount();
		PagingDTO pDto = new PagingDTO(Integer.parseInt(pNum), 10, totalCount, 3);

		List<BoardDTO> empList = adsvc.getAllEmployeeList(pDto.getOffset(), pDto.getPageSize());
		model.addAttribute("empList", empList);
		model.addAttribute("paging", pDto);

		return "admin/admin_mngEmp_list";
	}

	// 관리자 메뉴 - 인사관리 팝업 데이터 가져오기
	@RequestMapping("/GetEmployeeInfo.do")
	@ResponseBody
	public EmployeeDTO getEmployeeInfo(@RequestBody EmployeeDTO dto) {
		return adsvc.getEmployeeInfo(dto.getEmp_id());
	}

	// 관리자 메뉴 - 사원 정보 수정 페이지 이동
	@RequestMapping("/ModifyEmployeeAllInfo.do")
	public String modifyEmployeeInfo(int empId, Model model) {
		model.addAttribute("employeeInfo", adsvc.getEmployeeInfo(empId));
		model.addAttribute("pageTitle", "사원 정보 수정");
		return "admin/admin_mngEmp_detail";
	}

	// 관리자 메뉴 - 접근권한, 재직상태 수정
	@RequestMapping("/ModifyEmpAuthNStatusProc.do")
	@ResponseBody
	public HashMap<String, Integer> modifyEmpAuthNStatusProc(@RequestBody EmployeeDTO dto) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", adsvc.modifyEmpAuthNStatusProc(dto));
		return map;
	}

	// 관리자 메뉴 - 사원 삭제
	@RequestMapping("/DeleteEmployee.do")
	@ResponseBody
	public HashMap<String, Integer> deleteEmployee(@RequestBody EmployeeDTO dto) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", adsvc.deleteEmployee(dto.getEmp_id()));
		return map;
	}

	// 관리자 메뉴 - 입사처리 페이지로 이동
	@RequestMapping("/InsertEmpInfo.do")
	public String insertEmpInfo(Model model) {
		model.addAttribute("pageTitle", "입사처리");
		return "admin/admin_mngEmp_detail";
	}

	// 관리자 메뉴 - 입사처리 저장하기
	@RequestMapping("/InsertEmpInfoProc.do")
	public String insertEmpInfoProc(MultipartHttpServletRequest mrequest) throws IOException {
		adsvc.insertEmpInfoProc(context, mrequest);
		return "redirect:/HumanResources.do";
	}

	// 관리자 메뉴 - 사원 전체 정보 수정
	@RequestMapping("/UpdateEmpInfoProc.do")
	public String updateEmpInfoProc(MultipartHttpServletRequest mrequest) throws IOException {
		adsvc.updateEmpInfoProc(context, mrequest);
		return "redirect:/HumanResources.do";
	}

	// 관리자 메뉴 - 사원 정보 인쇄 페이지로 이동
	@RequestMapping("/PrintEmployee.do")
	public String printEmployee(int empId, Model model) {
		model.addAttribute("employeeInfo", adsvc.getEmployeeInfo(empId));
		return "admin/admin_mngEmp_print";
	}

	// 관리자 메뉴 - 사원 검색하기
	@RequestMapping("/SearchEmployeeList.do")
	public String searchEmployeeList(@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pNum,
			String select, String search, Model model) {
		HashMap<String, String> map = new HashMap<>();
		map.put("select", select);

		// 검색어 처리 (접근권한 검색시)
		if (select.equals("e.emp_auth")) {
			switch (search) {
			case "권한없음":
				search = "0";
				break;
			case "사원":
				search = "1";
				break;
			case "부서장":
				search = "2";
				break;
			case "임원":
				search = "3";
				break;
			case "협력업체":
				search = "4";
				break;
			case "관리자":
				search = "5";
				break;
			default:
				search = "";
				break;
			}
		}

		map.put("search", search);

		// 총 사원 목록수, 페이징 처리
		int totalCount = adsvc.getSearchEmployeeCount(map);
		PagingDTO pDto = new PagingDTO(Integer.parseInt(pNum), 10, totalCount, 3);

		map.put("offset", Integer.toString(pDto.getOffset()));
		map.put("pageSize", Integer.toString(pDto.getPageSize()));

		List<BoardDTO> empList = adsvc.getSearchEmployeeList(map);
		model.addAttribute("empList", empList);
		model.addAttribute("paging", pDto);

		return "admin/admin_mngEmp_list";
	}

	// ===================== 관리자메뉴:인사 관리 끝 =====================

	// ===================== 게시판 메뉴 시작 =====================
	// [게시판] 메뉴 페이지 이동
	@RequestMapping("/Board.do")
	public String board(@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pNum,
			String deptName, String empAuth, String pageName, Model model) {
		// 왼쪽 세부 메뉴 목록 가져오기
		if (Integer.parseInt(empAuth) < 5) { // 관리자 권한이 아닌 경우
			model.addAttribute("menuList", bsvc.getAllBoardTitle(deptName));
		} else {
			model.addAttribute("menuList", bsvc.getAllBoardTitle());
		}

		// 세부 메뉴 클릭시 클래스 적용할 때 사용될 변수
		model.addAttribute("pageName", pageName);

		// 어떤 게시판인지 구별하기 (아이콘 옆의 제목)
		model.addAttribute("pageTitle", bsvc.getBoardTitle(pageName));

		// 게시글 목록 가져오기 & 페이징
		int totalCount = bsvc.getAllBoardCount(pageName);
		PagingDTO pDto = new PagingDTO(Integer.parseInt(pNum), 10, totalCount, 3);

		List<BoardMainDTO> boardList = bsvc.getAllBoardList(pageName, pDto.getOffset(), pDto.getPageSize());
		model.addAttribute("boardList", boardList);
		model.addAttribute("paging", pDto);

		return "board/board_main";
	}

	// [게시판] 메뉴 글쓰기 페이지 이동
	@RequestMapping("/WritePost.do")
	public String writePost(String deptName, String empAuth, String pageName, Model model) {
		// 왼쪽 세부 메뉴 목록 가져오기
		if (Integer.parseInt(empAuth) < 5) { // 관리자 권한이 아닌 경우
			model.addAttribute("menuList", bsvc.getAllBoardTitle(deptName));
		} else {
			model.addAttribute("menuList", bsvc.getAllBoardTitle());
		}

		// 세부 메뉴 클릭시 클래스 적용할 때 사용될 변수
		model.addAttribute("pageName", pageName);

		// 어떤 게시판인지 구별하기 (아이콘 옆의 제목)
		model.addAttribute("pageTitle", bsvc.getBoardTitle(pageName));

		return "board/board_write";
	}

	// [게시판] 메뉴 글 작성하기
	@RequestMapping("/WritePostProc.do")
	public String writePostProc(String deptName, String empAuth, String pageName, MultipartHttpServletRequest mrequest,
			RedirectAttributes redirect) throws IOException {
		// 게시글 저장
		bsvc.writePostProc(context, mrequest, "0", "0", "0", "0");
		// 게시글의 답변 관련 정보 저장
		bsvc.updatePostGrpInfo(mrequest);

		// 리다이렉트 시 같이 넘겨야하는 파라미터
		redirect.addAttribute("deptName", deptName);
		redirect.addAttribute("empAuth", empAuth);
		redirect.addAttribute("pageName", pageName);

		return "redirect:/Board.do";
	}

	// [게시판] 메뉴 글 읽기 페이지 이동
	@RequestMapping("/ReadPost.do")
	public String readPost(String deptName, String empAuth, String pageName, String bmNum, Model model) {
		// 왼쪽 세부 메뉴 목록 가져오기
		if (Integer.parseInt(empAuth) < 5) { // 관리자 권한이 아닌 경우
			model.addAttribute("menuList", bsvc.getAllBoardTitle(deptName));
		} else {
			model.addAttribute("menuList", bsvc.getAllBoardTitle());
		}

		// 세부 메뉴 클릭시 클래스 적용할 때 사용될 변수
		model.addAttribute("pageName", pageName);

		// 어떤 게시판인지 구별하기 (아이콘 옆의 제목)
		model.addAttribute("pageTitle", bsvc.getBoardTitle(pageName));

		// 조회수 증가
		bsvc.updateHitCount(pageName, bmNum);

		model.addAttribute("post", bsvc.getPost(pageName, bmNum));

		return "board/board_read";
	}

	// [게시판] 게시글 첨부파일 다운로드
	@RequestMapping("/FileDownload.do")
	public String fileDownload(String bmFile, String bmSFile, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		bsvc.fileDownload(context, bmFile, bmSFile, session, request, response);

		return "";
	}

	// [게시판] 메뉴 글 수정 페이지 이동
	@RequestMapping("/ModifyPost.do")
	public String modifyPost(String deptName, String empAuth, String pageName, String bmNum, Model model) {
		// 왼쪽 세부 메뉴 목록 가져오기
		if (Integer.parseInt(empAuth) < 5) { // 관리자 권한이 아닌 경우
			model.addAttribute("menuList", bsvc.getAllBoardTitle(deptName));
		} else {
			model.addAttribute("menuList", bsvc.getAllBoardTitle());
		}

		// 세부 메뉴 클릭시 클래스 적용할 때 사용될 변수
		model.addAttribute("pageName", pageName);

		// 어떤 게시판인지 구별하기 (아이콘 옆의 제목)
		model.addAttribute("pageTitle", bsvc.getBoardTitle(pageName));

		// 기존 게시글 내용 가져오기
		model.addAttribute("post", bsvc.getPost(pageName, bmNum));

		return "board/board_write";
	}

	// [게시판] 메뉴 글 수정
	@RequestMapping("/ModifyPostProc.do")
	public String modifyPostProc(String deptName, String empAuth, String pageName, String bmNum, Model model,
			MultipartHttpServletRequest mrequest, RedirectAttributes redirect) throws IOException {
		bsvc.modifyPost(context, mrequest, bmNum);

		// 리다이렉트 시 같이 넘겨야하는 파라미터
		redirect.addAttribute("deptName", deptName);
		redirect.addAttribute("empAuth", empAuth);
		redirect.addAttribute("pageName", pageName);
		redirect.addAttribute("bmNum", bmNum);

		return "redirect:/ReadPost.do";
	}

	// [게시판] 메뉴 글 삭제 & 해당 글의 댓글 삭제
	@RequestMapping("/DeletePostProc.do")
	public String deletePostProc(String deptName, String empAuth, String pageName, String bmNum,
			RedirectAttributes redirect) {
		// 댓글 삭제
		bsvc.deletePostReply(pageName, bmNum);
		// 게시글 삭제
		bsvc.deletePost(pageName, bmNum);

		// 리다이렉트 시 같이 넘겨야하는 파라미터
		redirect.addAttribute("deptName", deptName);
		redirect.addAttribute("empAuth", empAuth);
		redirect.addAttribute("pageName", pageName);

		return "redirect:/Board.do";
	}

	// [게시판] 메뉴 댓글 작성
	@RequestMapping(value = "/WriteReplyProc.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> writeReplyProc(@RequestBody BoardReplyDTO dto) {
		HashMap<String, String> map = new HashMap<>();
		map.put("result", bsvc.writeReplyProc(dto));

		return map;
	}

	// [게시판] 메뉴 댓글 조회
	@RequestMapping(value = "/GetReplyProc.do", method = RequestMethod.POST)
	@ResponseBody
	public List<BoardReplyDTO> getReplyProc(@RequestBody BoardReplyDTO dto) {
		return bsvc.getReplyProc(dto);
	}

	// [게시판] 메뉴 수정할 댓글 내용 가져오기
	@RequestMapping(value = "/GetModReply.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, BoardReplyDTO> getModReply(@RequestBody BoardReplyDTO dto) {
		HashMap<String, BoardReplyDTO> map = new HashMap<>();
		map.put("result", bsvc.getModReply(dto));
		return map;
	}

	// [게시판] 메뉴 댓글 수정
	@RequestMapping(value = "/ModifyReplyProc.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> modifyReplyProc(@RequestBody BoardReplyDTO dto) {
		HashMap<String, String> map = new HashMap<>();
		map.put("result", bsvc.modifyReplyProc(dto));
		return map;
	}

	// [게시판] 메뉴 댓글 삭제
	@RequestMapping(value = "/DeleteReplyProc.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> deleteReplyProc(@RequestBody BoardReplyDTO dto) {
		HashMap<String, String> map = new HashMap<>();
		map.put("result", bsvc.deleteReplyProc(dto));
		return map;
	}

	// [게시판] 메뉴 답글 작성 페이지로 이동
	@RequestMapping("/AnswerPost.do")
	public String answerPost(String deptName, String empAuth, String pageName, String bmNum, String bmGrpnum,
			String bmGrpord, String bmGrpdepth, Model model) {
		// 왼쪽 세부 메뉴 목록 가져오기
		if (Integer.parseInt(empAuth) < 5) { // 관리자 권한이 아닌 경우
			model.addAttribute("menuList", bsvc.getAllBoardTitle(deptName));
		} else {
			model.addAttribute("menuList", bsvc.getAllBoardTitle());
		}

		// 세부 메뉴 클릭시 클래스 적용할 때 사용될 변수
		model.addAttribute("pageName", pageName);

		// 어떤 게시판인지 구별하기 (아이콘 옆의 제목)
		model.addAttribute("pageTitle", bsvc.getBoardTitle(pageName));

		// 답변 게시판 구별하기 (작성 버튼을 답글달기 버튼으로 변경)
		String answer = "answer";
		model.addAttribute("answer", answer);

		return "board/board_write";
	}

	// [게시판] 메뉴 답글 작성 처리
	@RequestMapping("/AnswerPostProc.do")
	public String answerPostProc(String deptName, String empAuth, String pageName, String bmNum, String bmGrpnum,
			String bmGrpord, String bmGrpdepth, MultipartHttpServletRequest mrequest, RedirectAttributes redirect)
			throws IOException {
		bsvc.writePostProc(context, mrequest, bmNum, bmGrpnum, bmGrpord, bmGrpdepth);

		// 리다이렉트 시 같이 넘겨야하는 파라미터
		redirect.addAttribute("deptName", deptName);
		redirect.addAttribute("empAuth", empAuth);
		redirect.addAttribute("pageName", pageName);

		return "redirect:/Board.do";
	}

	// [게시판] 메뉴 검색 처리
	@RequestMapping("/SearchPostList.do")
	public String searchPostList(@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pNum,
			String deptName, String empAuth, String pageName, Model model, String select, String search) {
		// 왼쪽 세부 메뉴 목록 가져오기
		if (Integer.parseInt(empAuth) < 5) { // 관리자 권한이 아닌 경우
			model.addAttribute("menuList", bsvc.getAllBoardTitle(deptName));
		} else {
			model.addAttribute("menuList", bsvc.getAllBoardTitle());
		}

		// 세부 메뉴 클릭시 클래스 적용할 때 사용될 변수
		model.addAttribute("pageName", pageName);

		// 어떤 게시판인지 구별하기 (아이콘 옆의 제목)
		model.addAttribute("pageTitle", bsvc.getBoardTitle(pageName));

		// 검색 조건
		HashMap<String, String> map = new HashMap<>();
		map.put("select", select);
		map.put("search", search);
		map.put("pageName", pageName);

		// 총 게시글 개수, 페이징 처리
		int totalCount = bsvc.getSearchPostCount(map);
		PagingDTO pDto = new PagingDTO(Integer.parseInt(pNum), 10, totalCount, 3);

		map.put("offset", Integer.toString(pDto.getOffset()));
		map.put("pageSize", Integer.toString(pDto.getPageSize()));

		List<BoardMainDTO> boardList = bsvc.searchPostList(map);

		model.addAttribute("boardList", boardList);
		model.addAttribute("paging", pDto);

		return "board/board_main";
	}

	// ===================== 게시판 메뉴 끝 =====================

	// ===================== 일정관리 메뉴 시작 =====================
	// [일정관리] 페이지로 이동
	@RequestMapping("/GetSchedule.do")
	public String getSchedule(Model model) {
		return "schedule/schedule";
	}

	// [일정관리] 일정 가져오기
	@RequestMapping("/GetScheduleList.do")
	@ResponseBody
	public List<ScheduleDTO> getScheduleList() {
		List<ScheduleDTO> list = ssvc.getScheduleList();
		return list;
	}

	// [일정관리] 일정 등록하기
	@RequestMapping("/InsertSchedule.do")
	@ResponseBody
	public HashMap<String, Integer> insertSchedule(@RequestBody ScheduleDTO dto) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", ssvc.insertSchedule(dto));
		return map;
	}

	// [일정관리] 일정 삭제하기
	@RequestMapping("/DeleteSchedule.do")
	@ResponseBody
	public HashMap<String, Integer> deleteSchedule(@RequestBody ScheduleDTO dto) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("result", ssvc.deleteSchedule(dto.getSc_id()));
		return map;
	}

	// ===================== 일정관리 메뉴 끝 =====================

}// HomeController 끝
