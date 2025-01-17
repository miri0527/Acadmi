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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acadmi.board.BoardVO;
import com.acadmi.board.notice.NoticeService;
import com.acadmi.board.notice.NoticeVO;
import com.acadmi.lecture.LectureVO;
import com.acadmi.period.PeriodVO;
import com.acadmi.report.ReportFilesVO;
import com.acadmi.report.ReportRegistrationVO;
import com.acadmi.report.ReportVO;
import com.acadmi.student.lecture.StudentLectureVO;
import com.acadmi.syllabus.ClassVO;
import com.acadmi.util.FileManager;
import com.acadmi.util.Pagination;
import com.fasterxml.jackson.annotation.JsonCreator.Mode;

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
		//mv.addObject("map", studentService.getYear(lectureVO));
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
	public ModelAndView getReportList( ReportRegistrationVO registrationVO, LectureVO lectureVO, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl)obj;
		Authentication authentication = contextImpl.getAuthentication();
		
		lectureVO = studentService.getLectureDetail(lectureVO);
		registrationVO.setLectureNum(lectureVO.getLectureNum()); 
		
	
		Map<String, Object> map = new HashMap<>();
		
		map.put("lectureNum", registrationVO.getLectureNum());
		map.put("reportName", registrationVO.getReportName());
		
		List<ReportRegistrationVO> ar = studentService.getReportList(map);

		
		mv.addObject("list", ar);
		mv.addObject("lecture", lectureVO);
		

		mv.setViewName("student/lecture/report/list");
		
		return mv;
	}
	
	//과제 상세 페이지
	@GetMapping("lecture/report/detail")
	public ModelAndView getReportDetail(ReportRegistrationVO reportRegistrationVO, LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		lectureVO = studentService.getLectureDetail(lectureVO);
		
		reportRegistrationVO = studentService.getReportDetail(reportRegistrationVO);
		
		mv.addObject("reportRegostrationVO", reportRegistrationVO);
		mv.addObject("lecture", lectureVO);
		mv.setViewName("student/lecture/report/detail");
		
		return mv;
	
	}
	
	//과제 등록
	@GetMapping("lecture/report/add")
	public ModelAndView setReportAdd(ReportVO reportVO, LectureVO lectureVO, ReportRegistrationVO registrationVO,  HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl)obj;
		Authentication authentication = contextImpl.getAuthentication();
		
		reportVO.setRegistrationNum(registrationVO.getRegistrationNum());
		reportVO.setUsername(authentication.getName());
		

		mv.addObject("reportVO", reportVO);
		mv.addObject("lecture", lectureVO);
		mv.setViewName("student/lecture/report/add");
		
		return mv;
	}

	@PostMapping("lecture/report/add")
	public ModelAndView setReportAdd(ReportVO reportVO, LectureVO lectureVO, MultipartFile[] addfiles) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		int result = studentService.setReportAdd(reportVO, addfiles);
		
		String message= "등록 실패";
		
		if(result > 0) {
			message = "과제가 등록되었습니다.";
			
		}
		
		mv.addObject("result", message);
		mv.setViewName("common/result");
		
		mv.addObject("url", "./detail?lectureNum=" + lectureVO.getLectureNum() + "&registrationNum=" + reportVO.getRegistrationNum());
		
		return mv;
		
	}
	
	//과제 제출물
	@GetMapping("lecture/report/submission")
	public ModelAndView getMyReportList(ReportVO reportVO ,HttpSession session, LectureVO lectureVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl)obj;
		Authentication authentication = contextImpl.getAuthentication();
		
		reportVO.setUsername(authentication.getName());
		
		List<ReportVO> ar = studentService.getMyReportList(reportVO);
		
		mv.addObject("list", ar);
		mv.addObject("lecture", lectureVO);
		mv.addObject("registration",reportVO.getRegistrationNum());
		mv.setViewName("student/lecture/report/submission");
		
		
		return mv;
	}
	
	//파일 다운로드
	@GetMapping("fileDown")
	public ModelAndView renderMergedOutputModel(ReportFilesVO reportFilesVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		reportFilesVO = studentService.getFileDetail(reportFilesVO);
		
		
		mv.addObject("reportFilesVO", reportFilesVO);
		mv.setViewName("fileManager");
		
		return mv;
		
	}

	//과제 제출 삭제
	@PostMapping("lecture/report/delete")
	public ModelAndView setReportDelete(ReportFilesVO reportFilesVO, ReportVO reportVO) throws Exception {
		ModelAndView mv = new ModelAndView();

		int result = studentService.setReportDelete(reportFilesVO,reportVO);
		
		String message="삭제 실패";
		
		if(result > 0) {
			message="과제가 삭제되었습니다.";
		}
		
		mv.addObject("result", message);
		mv.setViewName("common/ajaxResult");
		
		return mv;
	}
	
	//과제 제출 수정
	@PostMapping("lecture/report/update")
	public ModelAndView setReportUpdate(ReportFilesVO reportFilesVO, ReportVO reportVO, MultipartFile[] addfiles, LectureVO lectureVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		int result = studentService.setReportUpdate(reportVO, reportFilesVO, addfiles);
		
	
		String message= "등록 실패";
		
		if(result > 0) {
			message = "과제가 수정되었습니다.";
			
		}
		
		mv.addObject("result", message);
		mv.setViewName("common/result");
		mv.addObject("url", "./detail?lectureNum=" + lectureVO.getLectureNum() + "&registrationNum=" + reportVO.getRegistrationNum());

		
		return mv;
		
	}
	
}
