package com.acadmi.board.lectureQna;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acadmi.board.BoardVO;
import com.acadmi.notification.NotificationService;
import com.acadmi.notification.NotificationVO;
import com.acadmi.lecture.LectureVO;
import com.acadmi.professor.ProfessorVO;
import com.acadmi.student.StudentVO;
import com.acadmi.util.FileVO;
import com.acadmi.util.Pagination;

@Controller
@RequestMapping("/lectureQna/*")
public class LectureQnaController {
	
	@Autowired
	private LectureQnaService lectureQnaService;
	
	@Autowired
	private NotificationService notificationService;
	
	@ModelAttribute("board")
	public String getBoardName() {
		return "lectureQna";
	}
	
	@GetMapping(value = "list")
	public ModelAndView getList(Pagination pagination, LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		List<BoardVO> ar = lectureQnaService.getList(pagination);
		
		List<StudentVO> students = lectureQnaService.getStudent();
		
		List<ProfessorVO> professors = lectureQnaService.getProfessor();
		
		lectureVO.setLectureNum(pagination.getLectureNum());		
		lectureVO = lectureQnaService.getLecture(lectureVO);
		
		mv.addObject("lecture", lectureVO);
		mv.addObject("students", students);
		mv.addObject("professors", professors);
		mv.addObject("list", ar);
		mv.setViewName("board/list");
		
		return mv;
	}
	
	@GetMapping(value = "detail")
	public ModelAndView getDetail(LectureQnaVO lectureQnaVO, NotificationVO notificationVO, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		Long num = lectureQnaService.getQnaList(lectureQnaVO);
		
		lectureQnaVO = (LectureQnaVO)lectureQnaService.getDetail(lectureQnaVO);
		
		if(notificationVO.getNotificationNum() != null) {
			int result = notificationService.setDelete(notificationVO);
		}
		
		session.setAttribute("qnaVO", lectureQnaVO);
		
		LectureVO lectureVO = new LectureVO();
		
		lectureVO.setLectureNum(lectureQnaVO.getLectureNum());
		lectureVO = lectureQnaService.getLecture(lectureVO);
		
		mv.addObject("lecture", lectureVO);
		mv.addObject("num", num);
		mv.addObject("boardVO", lectureQnaVO);
		mv.setViewName("board/detail");
		
		return mv;
	}
	
	@GetMapping(value = "replyDetail")
	public ModelAndView getReplyDetail(LectureQnaVO lectureQnaVO, NotificationVO notificationVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		lectureQnaVO = (LectureQnaVO) lectureQnaService.getReplyDetail(lectureQnaVO);
		
		if(notificationVO.getNotificationNum() != null) {
			int result = notificationService.setDelete(notificationVO);
		}
		
		mv.addObject("reply", lectureQnaVO);
		mv.setViewName("board/replyDetail");
		
		return mv;
	}
	
	@GetMapping(value = "add")
	public ModelAndView setInsert(LectureQnaVO lectureQnaVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("board/add");
		
		return mv;
	}
	
	@PostMapping(value = "add")
	public ModelAndView setInsert(@RequestParam("lectureNum") Long lectureNum, LectureQnaVO lectureQnaVO, MultipartFile [] addfiles) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		int result = lectureQnaService.setInsert(lectureQnaVO, addfiles);
		mv.setViewName("redirect:./list?lectureNum=" + lectureNum);
		if(lectureQnaVO.getSecret() == null) {
			return mv;
		} else if(lectureQnaVO.getSecret()==1) {			
			result = notificationService.setLectureQna(lectureQnaVO);
		}
		
		
		return mv;
	}
	
	@GetMapping(value = "fileDown")
	public ModelAndView getFileDown(FileVO fileVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		fileVO = lectureQnaService.getFileDetail(fileVO);
		
		mv.addObject("fileVO", fileVO);
		mv.setViewName("fileManager");
		
		return mv;
	}
	
	@GetMapping("update")
	public ModelAndView setUpdate(LectureQnaVO lectureQnaVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		lectureQnaVO = (LectureQnaVO)lectureQnaService.getDetail(lectureQnaVO);
		
		mv.addObject("dto", lectureQnaVO);
		mv.setViewName("board/update");
		
		return mv;
	}
	
	@PostMapping("update")
	public ModelAndView setUpdate(ModelAndView mv, LectureQnaVO lectureQnaVO, MultipartFile [] addfiles) throws Exception {
		
		int result = lectureQnaService.setUpdate(lectureQnaVO, addfiles);
		
		lectureQnaVO = (LectureQnaVO)lectureQnaService.getDetail(lectureQnaVO);
		
		mv.setViewName("redirect:./list?lectureNum=" + lectureQnaVO.getLectureNum());
		
		return mv;
	}
	
	@GetMapping("delete")
	public ModelAndView setDelete(BoardVO boardVO, NotificationVO notificationVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		int result = lectureQnaService.setDelete(boardVO);
		
		result = notificationService.setBoardNotificationDelete(notificationVO);
		
		mv.setViewName("redirect:./list");
		
		return mv;
	}
	
	@PostMapping("boardFileDelete")
	public ModelAndView setBoardFileDelete(FileVO fileVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		int result = lectureQnaService.setBoardFileDelete(fileVO);
		
		mv.addObject("result", result);
		mv.setViewName("common/ajaxResult");
		
		return mv;
	}
	
	@GetMapping(value = "reply")
	public ModelAndView setReplyAdd(ModelAndView mv ,LectureQnaVO lectureQnaVO) throws Exception {
		LectureVO lectureVO = new LectureVO();
		lectureVO.setLectureNum(lectureQnaVO.getLectureNum());
		lectureVO = lectureQnaService.getLecture(lectureVO);
		
		mv.addObject("lecture", lectureVO);
		mv.setViewName("board/replyAdd");
		
		return mv;
	}
	
	@PostMapping(value = "reply")
	public ModelAndView setReplyAdd(LectureQnaVO lectureQnaVO, NotificationVO notificationVO, MultipartFile [] addfiles) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		int result = lectureQnaService.setReplyAdd(lectureQnaVO, addfiles);
		
		result = notificationService.setLectureQnaReply(lectureQnaVO);
		
		mv.setViewName("redirect:./detail?num=" + lectureQnaVO.getNum());
		
		return mv;
	}
	
}
