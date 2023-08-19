package com.acadmi.student;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acadmi.board.BoardVO;
import com.acadmi.board.notice.NoticeVO;
import com.acadmi.lecture.LectureVO;
import com.acadmi.period.PeriodVO;
import com.acadmi.report.ReportRegistrationVO;
import com.acadmi.report.ReportVO;
import com.acadmi.student.lecture.StudentLectureVO;
import com.acadmi.syllabus.ClassVO;
import com.acadmi.util.Pagination;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class StudentService {
	
	@Autowired
	private StudentDAO studentDAO;
	
	//현재 수강중인 강의
	public List<LectureVO> getCurrentLectureList(LectureVO lectureVO) throws Exception {
		List<LectureVO> ar =  studentDAO.getCurrentLectureList(lectureVO);
		return ar;
	}
	
	//내 수강 리스트
	public List<LectureVO> getMyLectureList(LectureVO lectureVO) throws Exception {
		
		List<LectureVO> ar =  studentDAO.getMyLectureList(lectureVO);
		
		return ar;
	}
	
	//내 성적 조회
	public List<LectureVO> getMyCreditList(LectureVO lectureVO) throws Exception {
		
		List<LectureVO> ar = studentDAO.getMyCreditList(lectureVO);
		
		return ar;
	}
	
	//입학년도~재학년도
	public Map<String, Object> getYear(LectureVO lectureVO) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("min", studentDAO.getMinYear(lectureVO));
		map.put("max", studentDAO.getMaxYear(lectureVO));
				
		return map;
	}
	
	
	public List<BoardVO> getNoticeList() throws Exception { 
		  return studentDAO.getNoticeList(); 
	}
	
	//강의 메인페이지
	public LectureVO getLectureProfessor(LectureVO lectureVO) throws Exception {
		return studentDAO.getLectureProfessor(lectureVO);
	}
	
	public List<ClassVO> getSyllabusClass(LectureVO lectureVO) throws Exception {
		return studentDAO.getSyllabusClass(lectureVO);
	}
	
	//강의 참여자 목록
	public List<StudentLectureVO> getAttendeeList(Pagination pagination) throws Exception {
		Long totalCount = studentDAO.getTotalCountStudent(pagination);
		
		pagination.makeNum(totalCount);
		pagination.makeStartRow();
		
		return studentDAO.getAttendeeList(pagination);
	}
	
	//강의 계획서 열람
	public LectureVO getLectureDetail(LectureVO lectureVO) throws Exception{
		return studentDAO.getLectureDetail(lectureVO);
	}
	
	public LectureVO getSyllabusDetail(LectureVO lectureVO) throws Exception {
		return studentDAO.getSyllabusDetail(lectureVO);
	}
	
	//수강신청,장바구니 막기
    public PeriodVO getApplication() throws Exception {
    	return studentDAO.getApplication();
    }
    public PeriodVO getFavoirte() throws Exception {
    	return studentDAO.getFavorite();
    }
    
    
    //과제 리스트
    public List<ClassVO> getReportList(Map<String, Object> map) throws Exception {
    	return studentDAO.getReportList(map);
    }
    
    //과제 상세 페이지
    public ReportRegistrationVO getReportDetail(ReportRegistrationVO reportRegistrationVO) throws Exception {
    	return studentDAO.getReportDetail(reportRegistrationVO);
    }
    

    
    //내가 제출한 과제
    public List<ClassVO> getMyReportList(Map<String,Object> map) throws Exception {
    	Long totalCount = studentDAO.getReportTotalCount();
    	
    	Pagination pagination = (Pagination) map.get("pagination");
    	
    	pagination.makeNum(totalCount);
    	pagination.makeStartRow();
    	
    	map.put("startRow", pagination.getStartRow());
    	map.put("perPage", pagination.getPerPage());
    	map.put("reportName", pagination.getReportName());
    	map.put("order", pagination.getOrder());
    	
    	List<ClassVO> ar = studentDAO.getMyReportList(map);
    	
    	return ar;
    }
    	
 } 
