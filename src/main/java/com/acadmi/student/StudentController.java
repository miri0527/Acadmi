package com.acadmi.student;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.acadmi.board.BoardVO;
import com.acadmi.board.notice.NoticeService;
import com.acadmi.board.notice.NoticeVO;
import com.acadmi.lecture.LectureVO;
import com.acadmi.period.PeriodVO;
import com.acadmi.report.ReportRegistrationVO;
import com.acadmi.report.ReportVO;
import com.acadmi.student.lecture.StudentLectureVO;
import com.acadmi.syllabus.ClassVO;
import com.acadmi.util.Pagination;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/student/*")
@Slf4j
public class StudentController {
	
	@Autowired
	private StudentService studentService;
	
	//현재 연도 계산
	private int calculateCurrentYear() {
		LocalDate currentDate = LocalDate.now();
		int year = currentDate.getYear();
		return year;
	}
	
	//현재 학기 계산
	private int calculateCurrentSemester() {
		LocalDate currentDate = LocalDate.now();
		int month = currentDate.getMonthValue();
		int semester;
		
		//1학기인지 2학기인지 판단
	    if (month >= 3 && month <= 8) {
	        semester = 1; //3월부터 8월까지는 1학기
	    } else {
	    	semester = 2; //9월부터 2월까지는 2학기
	    }
	    return semester;
	}

	//홈 진행중인 강의 리스트
	@GetMapping("homeLecture")
	public ModelAndView getCurrentLectureList(HttpSession session, LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl) obj; 
		Authentication authentication = contextImpl.getAuthentication();
		lectureVO.setUsername(authentication.getName());
		List<LectureVO> ar = studentService.getCurrentLectureList(lectureVO);
		mv.addObject("list", ar);
		mv.setViewName("student/homeLecture");
		
		return mv;
	}
	
	//내 수강 리스트
	@GetMapping("myLectureList")
	public ModelAndView getMyLectureList(HttpSession session, LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl)obj;
		Authentication authentication = contextImpl.getAuthentication();
		
		lectureVO.setUsername(authentication.getName()); 
		
//		log.error("name ::{}", authentication.getName());
	
		
		List<LectureVO> ar =  studentService.getMyLectureList(lectureVO);
		
		mv.addObject("list", ar);
		
		
		mv.addObject("map", studentService.getYear(lectureVO));
		mv.addObject("obj", lectureVO);
		mv.addObject("year", calculateCurrentYear());
		mv.addObject("semester", calculateCurrentSemester());
		mv.setViewName("student/myLectureList");
		return mv;
		
	}
	
	
	//내 성적 조회
	@GetMapping("myCreditList")
	public ModelAndView getMyCreditList(HttpSession session, LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl)obj;
		Authentication authentication = contextImpl.getAuthentication();
		
		lectureVO.setUsername(authentication.getName());
		
		List<LectureVO> ar = studentService.getMyCreditList(lectureVO);
		mv.addObject("year", calculateCurrentYear());
		mv.addObject("semester", calculateCurrentSemester());
		mv.addObject("list", ar);
		mv.addObject("map", studentService.getYear(lectureVO));
		mv.setViewName("student/myCreditList");
		
		return mv;
	}
	
	//강의 메인페이지
	@GetMapping("lecture/main")
	public ModelAndView getLectureProfessor(LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		lectureVO =  studentService.getLectureProfessor(lectureVO);
		List<ClassVO> ar = studentService.getSyllabusClass(lectureVO); 
		mv.addObject("lecture", lectureVO);
		mv.addObject("classes",ar);
		mv.setViewName("temp/lecture_header");
		mv.setViewName("student/lecture/main");
		return mv;
		
	}
	
	//강의 참여자 목록
	@GetMapping("lecture/attendee")
	public ModelAndView getAttendeeList(Pagination pagination, LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		List<StudentLectureVO> ar = studentService.getAttendeeList(pagination);
		lectureVO = studentService.getLectureProfessor(lectureVO);
		mv.addObject("list", ar);
		mv.addObject("lecture", lectureVO);
		mv.setViewName("temp/lecture_header");
		mv.setViewName("student/lecture/attendee");
		
		return mv;
		
		
	}
	
	//강의 계획서 열람
	@GetMapping("lecture/syllabusDetail")
	public ModelAndView getSyllabusDetail(LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		lectureVO = studentService.getLectureDetail(lectureVO);
		mv.addObject("lecture", lectureVO);
		lectureVO =  studentService.getSyllabusDetail(lectureVO);
		mv.addObject("lectureVO", lectureVO);
		List<ClassVO> ar = studentService.getSyllabusClass(lectureVO);
		mv.addObject("classes", ar);
		
		mv.setViewName("temp/lecture_header");
		mv.setViewName("student/lecture/syllabusDetail");
		
		return mv;
	}
	
	//과제 열람
	@GetMapping("lecture/report/list")
	public ModelAndView getReportList(ClassVO classVO, ReportVO reportVO, ReportRegistrationVO registrationVO, LectureVO lectureVO, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl)obj;
		Authentication authentication = contextImpl.getAuthentication();
		
		lectureVO = studentService.getLectureDetail(lectureVO);
		classVO.setLectureNum(lectureVO.getLectureNum());
		
	
		Map<String, Object> map = new HashMap<>();
		
		map.put("lectureNum", classVO.getLectureNum());
		map.put("reportName", registrationVO.getReportName());
		
		List<ClassVO> ar = studentService.getReportList(map);
		
		mv.addObject("list", ar);
		mv.addObject("lecture", lectureVO);
	
	
		mv.setViewName("student/lecture/report/list");
		
		return mv;
	}
	
	//내가 제출한 과제 열람
	@GetMapping("lecture/myReportList")
	public ModelAndView getMyReportList(ClassVO classVO, ReportVO reportVO , LectureVO lectureVO, Pagination pagination, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl)obj;
		Authentication authentication = contextImpl.getAuthentication();
		
		lectureVO = studentService.getLectureDetail(lectureVO);
		classVO.setLectureNum(lectureVO.getLectureNum());
		reportVO.setUsername(authentication.getName());
	
		Map<String, Object> map = new HashMap<>();
		
		map.put("lectureNum", classVO.getLectureNum());
		map.put("username", reportVO.getUsername());
		map.put("pagination", pagination);
		
		
		
		
		List<ClassVO> ar = studentService.getMyReportList(map);
		
		mv.addObject("list", ar);
		mv.addObject("lecture", lectureVO);
	
	
		mv.setViewName("student/lecture/myReportList");
		
		
		return mv;
	}
	
	@GetMapping("lecture/reportAdd")
	public ModelAndView setReportAdd(LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("student/lecture/reportAdd");
		
		return mv;
	}
	


	
}
