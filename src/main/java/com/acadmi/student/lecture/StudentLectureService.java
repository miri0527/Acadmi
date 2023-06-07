package com.acadmi.student.lecture;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acadmi.lecture.LectureVO;
import com.acadmi.util.Pagination;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class StudentLectureService {
	
	@Autowired
	private StudentLectureDAO studentLectureDAO;
	
	/** SELECT **/
	//수강 신청 & 장바구니 조회
	public List<LectureVO> getAllLectureList(Pagination pagination) throws Exception {
		pagination.makeStartRow();
		pagination.makeNum(studentLectureDAO.getAllLectureCount(pagination));
		
		if(studentLectureDAO.getAllLectureCount(pagination) == 0) {
			pagination.setLastNum(1L);
			pagination.setNext(false);
		}
		
//		log.error("{}", studentLectureDAO.getAllLectureList(pagination).isEmpty());
		
		return studentLectureDAO.getAllLectureList(pagination);
	}
	
	//내 수강 신청 조회
	public List<StudentLectureVO> getMyLectureList(StudentLectureVO studentLectureVO) throws Exception {
		return studentLectureDAO.getMyLectureList(studentLectureVO);
	}
	
	//내 장바구니 조회
	public List<FavoriteLectureVO> getMyFavoriteList(FavoriteLectureVO favoriteLectureVO) throws Exception {
		return studentLectureDAO.getMyFavoriteList(favoriteLectureVO);
	}
	
	//수강한 강의인지 아닌지 확인
	public StudentLectureVO getMyLecture(StudentLectureVO studentLectureVO) throws Exception {
		return studentLectureDAO.getMyLecture(studentLectureVO);
	}
	
	//장바구니에 담은 강의인지 아닌지 확인
	public FavoriteLectureVO getMyFavorite(FavoriteLectureVO favoriteLectureVO) throws Exception {
		return studentLectureDAO.getMyFavorite(favoriteLectureVO);
	}
	
	//수강한 강의 총 학점 계산
	public Long getGradeCount(StudentLectureVO studentLectureVO) throws Exception {
		return studentLectureDAO.getGradeCount(studentLectureVO);
	}
	
	//이미 수강한 강의와 시간이 겹치는지 확인
	public List<LectureVO> getDuplicateTime(LectureVO lectureVO) throws Exception {
		return studentLectureDAO.getDuplicateTime(lectureVO);
	}
	
	/** INSERT **/
	//수강 신청
	public int insertToStudentLecture(StudentLectureVO studentLectureVO, LectureVO lectureVO, HttpSession session) throws Exception {
		return studentLectureDAO.insertToStudentLecture(studentLectureVO);
	}
	
	//장바구니 담기
	public int insertToFavoriteLecture(FavoriteLectureVO favoriteLectureVO, LectureVO lectureVO, HttpSession session) throws Exception {
		return studentLectureDAO.insertToFavoriteLecture(favoriteLectureVO);
	}
	
	/** UPDATE **/
	//수강 신청 인원 증가
	public int addToSubscription(LectureVO lectureVO) throws Exception {
		return studentLectureDAO.addToSubscription(lectureVO);
	}
	
	//수강 신청 인원 감소
	public int deleteToSubscription(LectureVO lectureVO) throws Exception {
		return studentLectureDAO.deleteToSubscription(lectureVO);
	}
	
	//장바구니에 담음
	public int addToFavorite(LectureVO lectureVO) throws Exception {
		return studentLectureDAO.addToFavorite(lectureVO);
	}
	
	//장바구니에서 뺌
	public int deleteToFavorite(LectureVO lectureVO) throws Exception {
		return studentLectureDAO.deleteToFavorite(lectureVO);
	}
	
	/** DELETE **/
	//수강 취소
	public int deleteToStudentLecture(StudentLectureVO studentLectureVO, LectureVO lectureVO, HttpSession session) throws Exception {
		return studentLectureDAO.deleteToStudentLecture(studentLectureVO);
	}
	
	//장바구니 빼기
	public int deleteToFavoriteLecture(FavoriteLectureVO favoriteLectureVO, LectureVO lectureVO, HttpSession session) throws Exception {
		return studentLectureDAO.deleteToFavoriteLecture(favoriteLectureVO);
	}
	
}
