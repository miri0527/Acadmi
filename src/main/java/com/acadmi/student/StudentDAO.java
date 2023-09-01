package com.acadmi.student;

import java.time.Period;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.acadmi.board.BoardVO;
import com.acadmi.board.notice.NoticeVO;
import com.acadmi.lecture.LectureVO;
import com.acadmi.period.PeriodVO;
import com.acadmi.report.ReportFilesVO;
import com.acadmi.report.ReportRegistrationVO;
import com.acadmi.report.ReportVO;
import com.acadmi.student.lecture.StudentLectureVO;
import com.acadmi.syllabus.ClassVO;
import com.acadmi.util.FileVO;
import com.acadmi.util.Pagination;

@Mapper
public interface StudentDAO {
	
	//현재 수강중인 강의
	public List<LectureVO> getCurrentLectureList(LectureVO lectureVO) throws Exception;
	
	//내 수강 강좌
	public List<LectureVO> getMyLectureList(LectureVO lectureVO) throws Exception;
	public List<LectureVO> getMyCreditList(LectureVO lectureVO) throws Exception;
	
	//입학년도~재학년도
	public Integer getMaxYear(LectureVO lectureVO) throws Exception;
	public Integer getMinYear(LectureVO lectureVO) throws Exception;
	
	//메인페이지 공지사항
	 public List<BoardVO> getNoticeList() throws Exception; 
	 
	//강의 메인페이지
	 public LectureVO getLectureProfessor(LectureVO lectureVO) throws Exception; 
	 public List<ClassVO> getSyllabusClass(LectureVO lectureVO) throws Exception;
	 
	//강의 참여자 목록
	public List<StudentLectureVO> getAttendeeList(Pagination pagination) throws Exception; 
	public Long getTotalCountStudent(Pagination pagination) throws Exception;
	
	//강의 계획서 열람
	public LectureVO getLectureDetail(LectureVO lectureVO) throws Exception;
	public LectureVO getSyllabusDetail(LectureVO lectureVO) throws Exception;
	
	//수강신청,장바구니 막기
	public PeriodVO getApplication() throws Exception;
	public PeriodVO getFavorite() throws Exception;
	
	//과제 리스트
	public List<ReportRegistrationVO> getReportList(Map<String, Object> map) throws Exception;

	
	//과제 상세 페이지
	public ReportRegistrationVO getReportDetail(ReportRegistrationVO reportRegistrationVO) throws Exception;
 	
	//과제 등록
	public int setReportAdd(ReportVO reportVO) throws Exception;
	public int setReportFilesAdd(ReportFilesVO reportFilesVO) throws Exception;
	
	//과제 제출물
	public List<ReportVO> getMyReportList(ReportVO reportVO) throws Exception;
	public ReportFilesVO getFileDetail(ReportFilesVO reportFilesVO) throws Exception;
}
