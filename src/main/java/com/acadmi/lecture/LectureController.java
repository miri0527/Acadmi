package com.acadmi.lecture;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acadmi.college.CollegeVO;
import com.acadmi.department.DepartmentVO;
import com.acadmi.notification.NotificationService;
import com.acadmi.period.PeriodVO;
import com.acadmi.student.StudentVO;
import com.acadmi.syllabus.ClassVO;
import com.acadmi.syllabus.SyllabusVO;
import com.acadmi.util.Pagination;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lecture/")
public class LectureController {
	@Autowired
	private LectureService lectureService;
	@Autowired
	private NotificationService notificationService;
	
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
	
	//홈 강의 목록
	@GetMapping("homeLecture")
	public ModelAndView getHomeLectureList(LectureVO lectureVO, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl) obj; 
		Authentication authentication = contextImpl.getAuthentication();
		lectureVO.setUsername(authentication.getName());
		List<LectureVO> ar = lectureService.getHomeLectureList(lectureVO);
		mv.addObject("list",ar);
		mv.setViewName("professor/homeLecture");
		return mv;
	}
	
	//강의 목록
	@GetMapping("list")
	public ModelAndView getLectureList(Pagination pagination,LectureVO lectureVO,PeriodVO periodVO, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl) obj; 
		Authentication authentication = contextImpl.getAuthentication();
		pagination.setUsername(authentication.getName());
		List<PeriodVO> period = lectureService.getSemesterList(periodVO);
		List<LectureVO> ar = lectureService.getLectureList(pagination);
		mv.addObject("period",period);
		mv.addObject("list",ar);
		mv.addObject("year", calculateCurrentYear());
		mv.addObject("semester", calculateCurrentSemester());
		mv.setViewName("lecture/list");
		
		return mv;
	}
	
	//강의 등록
	@GetMapping("add")
	public ModelAndView setLectureAdd(@ModelAttribute LectureVO lectureVO,CollegeVO collegeVO, DepartmentVO departmentVO, PeriodVO periodVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		List<DepartmentVO> department = lectureService.getDepartmentList(departmentVO);
		List<CollegeVO> college = lectureService.getCollegeList(collegeVO);
		List<PeriodVO> period = lectureService.getSemesterList(periodVO);
		mv.addObject("period",period);
		mv.addObject("college", college);
		mv.addObject("department",department);
		mv.setViewName("lecture/add");
		return mv;
	}
	@PostMapping("add")
	public ModelAndView setLectureAdd(LectureVO lectureVO, ModelAndView mv, @RequestParam("buttonType")String buttonType,HttpSession session) throws Exception{
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		SecurityContextImpl contextImpl = (SecurityContextImpl) obj; 
		Authentication authentication = contextImpl.getAuthentication();
		lectureVO.setUsername(authentication.getName());
		if(buttonType.equals("1")) {
			int result = lectureService.setLectureAdd(lectureVO);
			mv.addObject("result","강의가 등록되었습니다.");
			result = notificationService.setLecture(lectureVO);
		} else if(buttonType.equals("0")){
			int result = lectureService.setTemporaryAdd(lectureVO);
			mv.addObject("result","강의가 임시등록되었습니다.");
		}
		mv.addObject("url","./list");
		mv.setViewName("common/result");
		return mv;
	}
	
	//강의 수정
	@GetMapping("update")
	public ModelAndView setLectureUpdate(LectureVO lectureVO,CollegeVO collegeVO, DepartmentVO departmentVO, PeriodVO periodVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		List<DepartmentVO> department = lectureService.getDepartmentList(departmentVO);
		List<CollegeVO> college = lectureService.getCollegeList(collegeVO);
		List<PeriodVO> period = lectureService.getSemesterList(periodVO);
		mv.addObject("period",period);
		mv.addObject("college", college);
		mv.addObject("department",department);
		lectureVO = lectureService.getLectureDetail(lectureVO);
		mv.addObject("update",lectureVO);
		collegeVO = lectureService.getCollege(lectureVO.getDeptNum());
		mv.addObject("result", collegeVO);
		mv.setViewName("lecture/update");
		return mv;
	}
	@PostMapping("update")
	public ModelAndView setLectureUpdate(LectureVO lectureVO, ModelAndView mv, @RequestParam("buttonType")String buttonType, HttpSession session) throws Exception{
		if(buttonType.equals("1")) {
			int result = lectureService.setLectureUpdate(lectureVO);
			mv.addObject("result","강의가 등록되었습니다.");
			Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
			SecurityContextImpl contextImpl = (SecurityContextImpl) obj; 
			Authentication authentication = contextImpl.getAuthentication();
			lectureVO.setUsername(authentication.getName());
			result = notificationService.setLecture(lectureVO);
		} else if(buttonType.equals("0")){
			int result = lectureService.setTemporaryUpdate(lectureVO);
			mv.addObject("result","강의가 임시등록되었습니다.");
		}
		mv.addObject("url","./list");
		mv.setViewName("common/result");
		return mv;
	}
	
	//강의 삭제
	@GetMapping("delete")
	public ModelAndView setLectureDelete(LectureVO lectureVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = lectureService.setLectureDelete(lectureVO);
		mv.addObject("result", "강의가 삭제되었습니다.");
		mv.addObject("url", "./list");
		mv.setViewName("common/result");
		return mv;
	}
	
	//강의 메인 페이지
	@GetMapping("main")
	public ModelAndView getLectureMain(LectureVO lectureVO,CollegeVO collegeVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		lectureVO = lectureService.getLectureProfessor(lectureVO);
		mv.addObject("lecture",lectureVO);
		List<ClassVO> ar = lectureService.getSyllabusClass(lectureVO);
		mv.addObject("classes",ar);
		int exists = lectureService.getSyllabusExists(lectureVO);
		mv.addObject("exists",exists);
		collegeVO=lectureService.getCollege(lectureVO.getDeptNum());
		mv.addObject("college",collegeVO);
		mv.setViewName("temp/sidebar/professor_lecture");
		mv.setViewName("temp/lecture_header");
		mv.setViewName("lecture/main");
		return mv;
	}
	
	//강의 정보 페이지
	@GetMapping("info")
	public ModelAndView getLectureInfo(LectureVO lectureVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		lectureVO = lectureService.getLectureDetail(lectureVO);
		mv.addObject("lecture",lectureVO);
		int exists = lectureService.getSyllabusExists(lectureVO);
		mv.addObject("exists",exists);
		mv.setViewName("temp/sidebar/professor_lecture");
		mv.setViewName("temp/lecture_header");
		mv.setViewName("lecture/info");
		return mv;
	}
	
	//강의 참여자 페이지
	@GetMapping("attendee")
	public ModelAndView getLectureAttendee(Pagination pagination,LectureVO lectureVO, StudentVO studentVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		pagination.setLectureNum(lectureVO.getLectureNum());
		
		List<StudentVO> ar = lectureService.getLectureAttendee(pagination);
		mv.addObject("list",ar);
		lectureVO = lectureService.getLectureDetail(lectureVO);
		mv.addObject("lecture",lectureVO);
		int exists = lectureService.getSyllabusExists(lectureVO);
		mv.addObject("exists",exists);
		mv.setViewName("temp/sidebar/professor_lecture");
		mv.setViewName("temp/lecture_header");
		mv.setViewName("lecture/attendee");
		return mv;
	}
	
	//강의 계획서 정보
		@GetMapping("syllabusDetail")
		public ModelAndView setSyllabusDetail(@ModelAttribute LectureVO lectureVO, ClassVO classVO) throws Exception{
			ModelAndView mv = new ModelAndView();
			lectureVO = lectureService.getSyllabusDetail(lectureVO);
			mv.addObject("lecture", lectureVO);
			List<ClassVO> ar = lectureService.getSyllabusClass(lectureVO);
			mv.addObject("classes",ar);
			int exists = lectureService.getSyllabusExists(lectureVO);
			mv.addObject("exists",exists);
			mv.setViewName("temp/sidebar/professor_lecture");
			mv.setViewName("temp/lecture_header");
			mv.setViewName("lecture/syllabusDetail");
			return mv;
		}
	
	//강의 계획서 등록
	@GetMapping("syllabusAdd")
	public ModelAndView setSyllabusAdd(@ModelAttribute LectureVO lectureVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		lectureVO = lectureService.getLectureDetail(lectureVO);
		mv.addObject("lecture",lectureVO);
		int exists = lectureService.getSyllabusExists(lectureVO);
		mv.addObject("exists",exists);
		mv.setViewName("temp/sidebar/professor_lecture");
		mv.setViewName("temp/lecture_header");
		mv.setViewName("lecture/syllabusAdd");
		return mv;
	}
	@PostMapping("syllabusAdd")
	public ModelAndView setSyllabusAdd(LectureVO lectureVO, ModelAndView mv, SyllabusVO syllabusVO,ClassVO classVO,@RequestParam Map<String, String> formData) throws Exception{
		int result = lectureService.setSyllabusAdd(syllabusVO);
		classVO.setSyllabusNum(syllabusVO.getSyllabusNum());
		for(int i=1;i<9;i++) {
			ClassVO newClassVO = new ClassVO();
			newClassVO.setSyllabusNum(classVO.getSyllabusNum());
	        newClassVO.setOrder(i);
	        newClassVO.setSubject(formData.get("subject" + i));
	        newClassVO.setGoal(formData.get("goal" + i));
	        newClassVO.setCapability(formData.get("capability" + i));
	        newClassVO.setNote(formData.get("note" + i));
	        result = lectureService.setClassAdd(newClassVO);
		}
		lectureVO = lectureService.getLectureDetail(lectureVO);
		mv.addObject("result","강의계획서가 등록되었습니다.");
		mv.addObject("url","./syllabusDetail?lectureNum="+lectureVO.getLectureNum());
		mv.setViewName("common/result");
		return mv;
	}
	
	//강의 계힉서 수정
	@GetMapping("syllabusUpdate")
	public ModelAndView setSyllabusUpdate(LectureVO lectureVO,SyllabusVO syllabusVO,ClassVO classVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		lectureVO = lectureService.getSyllabusDetail(lectureVO);
		mv.addObject("lecture", lectureVO);
		List<ClassVO> ar = lectureService.getSyllabusClass(lectureVO);
		int exists = lectureService.getSyllabusExists(lectureVO);
		mv.addObject("exists",exists);
		mv.addObject("classes",ar);
		mv.setViewName("temp/sidebar/professor_lecture");
		mv.setViewName("temp/lecture_header");
		mv.setViewName("lecture/syllabusUpdate");
		
		return mv;
	}
	@PostMapping("syllabusUpdate")
	public ModelAndView setSyllabusUpdate(LectureVO lectureVO,SyllabusVO syllabusVO,ClassVO classVO,ModelAndView mv,@RequestParam Map<String, String> formData) throws Exception{
		int result = lectureService.setSyllabusUpdate(syllabusVO);
		lectureVO = lectureService.getLectureDetail(lectureVO);
		for(int i=1;i<9;i++) {
			ClassVO newClassVO = new ClassVO();
			newClassVO.setSyllabusNum(syllabusVO.getSyllabusNum());
	        newClassVO.setOrder(i);
	        newClassVO.setSubject(formData.get("subject" + i));
	        newClassVO.setGoal(formData.get("goal" + i));
	        newClassVO.setCapability(formData.get("capability" + i));
	        newClassVO.setNote(formData.get("note" + i));
	       
	        result = lectureService.setClassUpdate(newClassVO);
		}
		mv.addObject("result","강의계획서가 수정되었습니다.");
		Long i = lectureVO.getLectureNum();
		mv.addObject("url","./syllabusDetail?lectureNum="+i);
		mv.setViewName("common/result");
		return mv;
	}


}