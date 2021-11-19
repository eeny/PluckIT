package com.pluckit.app.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pluckit.app.dao.BoardDAO;
import com.pluckit.app.dto.BoardDTO;
import com.pluckit.app.dto.BoardMainDTO;
import com.pluckit.app.dto.BoardReplyDTO;
import com.pluckit.util.DownloadView;

@Service
public class BoardService {
	@Autowired
	private BoardDAO bdao;

	private String path; // 파일 업로드시 사용될 변수

	public List<BoardDTO> getAllBoardTitle(String deptName) {
		return bdao.getAllBaordTitle(deptName);
	}

	public List<BoardDTO> getAllBoardTitle() {
		return bdao.getAllBoardTitle();
	}

	public String getBoardTitle(String pageName) {
		return bdao.getBoardTitle(pageName);
	}

	public void writePostProc(ServletContext context, MultipartHttpServletRequest mrequest, String bmNum,
			String bmGrpnum, String bmGrpord, String bmGrpdepth) throws IOException {
		HashMap<String, String> map = new HashMap<>();

		// 파일을 제외한 나머지 값
		String b_id = mrequest.getParameter("b_id");
		String bm_writer = mrequest.getParameter("bm_writer");
		String bm_title = mrequest.getParameter("bm_title");
		String bm_content = mrequest.getParameter("bm_content");

		MultipartFile file = mrequest.getFile("bm_file"); // 넘어온 파일 객체
		String fileName = file.getOriginalFilename(); // 파일 객체 이름 갖고오기

		map.put("b_id", b_id);
		map.put("bm_writer", bm_writer);
		map.put("bm_title", bm_title);
		map.put("bm_content", bm_content);

		// 답글에 사용될 값
		map.put("bmGrpnum", bmGrpnum);
		map.put("bmGrpord", bmGrpord);
		map.put("bmGrpdepth", bmGrpdepth);
		map.put("grpOrd", ""); // selectkey에 사용될 변수

		// 파일 저장 위치 - 실제 서버의 파일 위치
		path = context.getRealPath("/resources/upload/");

		// 설정한 경로에 폴더가 없을 때 폴더 생성
		File dir = new File(path);
		if (dir.exists()) {
			dir.mkdir();
		}

		if (!file.isEmpty()) { // 첨부파일이 존재하는 경우
			// 파일명 중복 안되게 수정(UUID방식)
			String saveFileName = uploadFile(fileName, file.getBytes());

			file.transferTo(new File(path + saveFileName));

			map.put("bm_file", fileName);
			map.put("bm_savedfile", saveFileName);
			map.put("bm_filepath", path + saveFileName);

			if (Integer.parseInt(bmNum) == 0) { // 일반 글작성
				bdao.writePostProc(map);
			} else { // 답글 작성
				map.put("bmNum", bmNum);

				// 몇번째 답글인지 확인
				int minBmGrpord = bdao.getMinBmGrpOrd(map);

				if (minBmGrpord < 1) { // 첫번째 답글인 경우
					bdao.insertFirstAnswer(map);
				} else { // 첫번째 답글이 아닌 경우
					int insert = bdao.insertOtherAnswer(map);
					if (insert > 0) {
						bdao.updateOtherAnswer(map);
					}
				}
			}
		} else { // 첨부파일이 없는 경우
			map.put("bm_file", "");
			map.put("bm_savedfile", "");
			map.put("bm_filepath", "");

			if (Integer.parseInt(bmNum) == 0) { // 일반 글작성
				bdao.writePostProc(map);
			} else { // 답글 작성
				map.put("bmNum", bmNum);

				// 몇번째 답글인지 확인
				int minBmGrpord = bdao.getMinBmGrpOrd(map);

				if (minBmGrpord < 1) { // 첫번째 답글인 경우
					bdao.insertFirstAnswer(map);
				} else { // 첫번째 답글이 아닌 경우
					int insert = bdao.insertOtherAnswer(map);
					if (insert > 0) {
						bdao.updateOtherAnswer(map);
					}
				}
			}
		}

	}

	public void updatePostGrpInfo(MultipartHttpServletRequest mrequest) {
		HashMap<String, String> map = new HashMap<>();
		String bId = mrequest.getParameter("b_id");
		map.put("b_id", bId);
		map.put("bm_num", ""); // selectkey에서 사용될 변수
		bdao.updatePostGrpInfo(map);
	}

	public List<BoardMainDTO> getAllBoardList(String pageName, int offset, int pageSize) {
		HashMap<String, String> map = new HashMap<>();
		map.put("pageName", pageName);
		map.put("offset", Integer.toString(offset));
		map.put("pageSize", Integer.toString(pageSize));
		return bdao.getAllBoardList(map);
	}

	public int getAllBoardCount(String pageName) {
		return bdao.getAllBoardCount(pageName);
	}

	public void updateHitCount(String pageName, String bmNum) {
		HashMap<String, String> map = new HashMap<>();
		map.put("pageName", pageName);
		map.put("bmNum", bmNum);
		bdao.updateHitCount(map);
	}

	public BoardMainDTO getPost(String pageName, String bmNum) {
		HashMap<String, String> map = new HashMap<>();
		map.put("pageName", pageName);
		map.put("bmNum", bmNum);
		return bdao.getPost(map);
	}

	public void fileDownload(ServletContext context, String bmFile, String bmSFile, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		// 파일 경로
		path = context.getRealPath("/resources/upload/");

		try {
			// 파일다운로드 객체 생성
			DownloadView fileDown = new DownloadView();
			fileDown.fileDown(request, response, path + "/", bmSFile, bmFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void modifyPost(ServletContext context, MultipartHttpServletRequest mrequest, String bmNum)
			throws IOException {
		HashMap<String, String> map = new HashMap<>();

		// 파일을 제외한 나머지 값
		String b_id = mrequest.getParameter("b_id");
		String bm_writer = mrequest.getParameter("bm_writer");
		String bm_title = mrequest.getParameter("bm_title");
		String bm_content = mrequest.getParameter("bm_content");
		String bm_num = bmNum;

		MultipartFile file = mrequest.getFile("bm_file"); // 넘어온 파일 객체
		String fileName = file.getOriginalFilename(); // 파일 객체 이름 갖고오기

		map.put("b_id", b_id);
		map.put("bm_writer", bm_writer);
		map.put("bm_title", bm_title);
		map.put("bm_content", bm_content);
		map.put("bm_num", bm_num);

		// 파일 저장 위치 - 실제 서버의 파일 위치
		path = context.getRealPath("/resources/upload/");

		// 설정한 경로에 폴더가 없을 때 폴더 생성
		File dir = new File(path);
		if (dir.exists()) {
			dir.mkdir();
		}

		if (!file.isEmpty()) { // 첨부파일이 존재하는 경우
			// 기존에 저장된 파일 삭제하기
			File oldFile = new File(path + bdao.getFileName(map));
			if (oldFile.exists()) {
				oldFile.delete();
				System.out.println("기존파일 삭제완료");
			}

			// 파일명 중복 안되게 수정(UUID방식)
			String saveFileName = uploadFile(fileName, file.getBytes());

			file.transferTo(new File(path + saveFileName));

			map.put("bm_file", fileName);
			map.put("bm_savedfile", saveFileName);
			map.put("bm_filepath", path + saveFileName);

			bdao.modifyPost(map);
		} else { // 첨부파일이 없는 경우
			bdao.modifyPostNotFile(map);
		}
	}

	public void deletePostReply(String pageName, String bmNum) {
		HashMap<String, String> map = new HashMap<>();
		map.put("pageName", pageName);
		map.put("bmNum", bmNum);

		bdao.deletePostReply(map);
	}

	public void deletePost(String pageName, String bmNum) {
		HashMap<String, String> map = new HashMap<>();
		map.put("pageName", pageName);
		map.put("bmNum", bmNum);

		bdao.deletePost(map);
	}

	public String writeReplyProc(BoardReplyDTO dto) {
		int result = bdao.writeReplyProc(dto);
		String str = "";
		if (result > 0) { // insert 된 경우
			str = "success";
		}

		return str;
	}

	public List<BoardReplyDTO> getReplyProc(BoardReplyDTO dto) {
		return bdao.getReplyProc(dto);
	}

	public BoardReplyDTO getModReply(BoardReplyDTO dto) {
		return bdao.getModReply(dto);
	}

	public String deleteReplyProc(BoardReplyDTO dto) {
		int result = bdao.deleteReplyProc(dto);
		String str = "";
		if (result > 0) { // delete 된 경우
			str = "success";
		}

		return str;
	}

	public String modifyReplyProc(BoardReplyDTO dto) {
		int result = bdao.modifyReplyProc(dto);
		String str = "";
		if (result > 0) { // update 된 경우
			str = "success";
		}
		return str;
	}

	public int getSearchPostCount(HashMap<String, String> map) {
		return bdao.getSearchPostCount(map);
	}

	public List<BoardMainDTO> searchPostList(HashMap<String, String> map) {
		return bdao.searchPostList(map);
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

}// BoardService 끝
