package com.acadmi.administrator;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;import org.springframework.jdbc.support.lob.AbstractLobHandler;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

import com.acadmi.college.CollegeVO;
import com.acadmi.department.DepartmentVO;
import com.acadmi.lecture.LectureVO;
import com.acadmi.lecture.room.LectureRoomVO;
import com.acadmi.lecture.room.TimeTableVO;
import com.acadmi.member.MemberSeqVO;
import com.acadmi.member.MemberVO;
import com.acadmi.period.PeriodVO;
import com.acadmi.professor.ProfessorVO;
import com.acadmi.student.StudentVO;
import com.acadmi.util.Pagination;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class AdministratorService{
	
	@Autowired
	private AdministratorDAO administratorDAO;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
		//회원 관리
	
		//아이디
		//username이 string이기 때문에 string으로 변환시켜주기
		
		public List<CollegeVO> getCollege() throws Exception {
			return administratorDAO.getCollege();
		}
		
		public List<DepartmentVO> getDepartment() throws Exception {
			return administratorDAO.getDepartment();
		}
		
		//계정 생성
		public int setStudentAdd(StudentVO studentVO, MemberVO memberVO, MemberSeqVO memberSeqVO) throws Exception {
			memberVO.setPassword(passwordEncoder.encode(memberVO.getPassword()));
			
			int result;
			String year;
			 if(administratorDAO.getYearSeq(memberSeqVO) == null) {
				 result =  administratorDAO.setInsertSeq(memberSeqVO);
				 year=  administratorDAO.getYearSeq(memberSeqVO).toString();
				 Long memberSeq = administratorDAO.getMemberSeq(memberSeqVO);
				 String username;
				 
				 if(memberSeq < 10) {
					  username = year + "000" + memberSeq;
				  }else if(memberSeq < 100) {
					  username = year + "00" + memberSeq;
				  }else if(memberSeq < 1000) {
					  username = year + "0" + memberSeq;
				  }else {
					  username = year + memberSeq;
				  }
				  
				memberVO.setUsername(username);
				
				result = administratorDAO.setMemberAdd(memberVO);
				
				studentVO.setUsername(memberVO.getUsername());
			
				result = administratorDAO.setStudentAdd(studentVO);
				
				Map<String, Object> map = new HashMap<>();
				map.put("username", memberVO.getUsername());
				
				if(memberVO.getCategory() == 0) {
					map.put("roleNum", 2);
				}else if(memberVO.getCategory() == 1) {
					map.put("roleNum", 2);
				}else if(memberVO.getCategory() == 2) {
					map.put("roleNum", 3);
				}else {
					map.put("roleNum", 0);
				}
				
				
				result = administratorDAO.setRoleAdd(map);
				
				return result;
				 
				 
			 }else {
				  year = administratorDAO.getYearSeq(memberSeqVO).toString(); 
				  result = administratorDAO.setUpdateSeq(memberSeqVO);
				  Long memberSeq = administratorDAO.getMemberSeq(memberSeqVO);
				  String username;
				  
				  
				  
				  if(memberSeq < 10) {
					  username = year + "000" + memberSeq;
				  }else if(memberSeq < 100) {
					  username = year + "00" + memberSeq;
				  }else if(memberSeq < 1000) {
					  username = year + "0" + memberSeq;
				  }else {
					  username = year + memberSeq;
				  }
				  
				  
				  memberVO.setUsername(username);
				 
				
				result = administratorDAO.setMemberAdd(memberVO);
				
				studentVO.setUsername(memberVO.getUsername());
				
				result = administratorDAO.setStudentAdd(studentVO);
				
				Map<String, Object> map = new HashMap<>();
				map.put("username", memberVO.getUsername());
				
				if(memberVO.getCategory() == 0) {
					map.put("roleNum", 1);
				}else if(memberVO.getCategory() == 1) {
					map.put("roleNum", 2);
				}else if(memberVO.getCategory() == 2) {
					map.put("roleNum",3);
				}else {
					map.put("roleNum", 0);
				}
				
				
				result = administratorDAO.setRoleAdd(map);
				
				return result;
			 }
		
			
		}
		
		public int setAdministratorAdd(AdministratorVO administratorVO, MemberVO memberVO, MemberSeqVO memberSeqVO) throws Exception {
			memberVO.setPassword(passwordEncoder.encode(memberVO.getPassword()));
			
			int result;
			String year;
			 if(administratorDAO.getYearSeq(memberSeqVO) == null) {
				 result =  administratorDAO.setInsertSeq(memberSeqVO);
				 year=  administratorDAO.getYearSeq(memberSeqVO).toString();
				 Long memberSeq = administratorDAO.getMemberSeq(memberSeqVO);
				 String username;
				 
				 if(memberSeq < 10) {
					  username = year + "000" + memberSeq;
				  }else if(memberSeq < 100) {
					  username = year + "00" + memberSeq;
				  }else if(memberSeq < 1000) {
					  username = year + "0" + memberSeq;
				  }else {
					  username = year + memberSeq;
				  }
				  
				  
				  memberVO.setUsername(username);
				 
				
				result = administratorDAO.setMemberAdd(memberVO);
				
				administratorVO.setUsername(memberVO.getUsername());
				
				result = administratorDAO.setAdministratorAdd(administratorVO);
				
				Map<String, Object> map = new HashMap<>();
				map.put("username", memberVO.getUsername());
				
				if(memberVO.getCategory() == 0) {
					map.put("roleNum", 1);
				}else if(memberVO.getCategory() == 1) {
					map.put("roleNum", 2);
				}else if(memberVO.getCategory() == 2) {
					map.put("roleNum",3);
				}else {
					map.put("roleNum", 0);
				}
				
				
				result = administratorDAO.setRoleAdd(map);
				
				return result;
				
				 
			 }else {
				  year = administratorDAO.getYearSeq(memberSeqVO).toString(); 
				  result = administratorDAO.setUpdateSeq(memberSeqVO);
				  Long memberSeq = administratorDAO.getMemberSeq(memberSeqVO);
				  String username;
				  
				  
				  
				  if(memberSeq < 10) {
					  username = year + "000" + memberSeq;
				  }else if(memberSeq < 100) {
					  username = year + "00" + memberSeq;
				  }else if(memberSeq < 1000) {
					  username = year + "0" + memberSeq;
				  }else {
					  username = year + memberSeq;
				  }
				  
				  
				 memberVO.setUsername(username);
				 
				
				result = administratorDAO.setMemberAdd(memberVO);
				
				administratorVO.setUsername(memberVO.getUsername());
				
				result = administratorDAO.setAdministratorAdd(administratorVO);
				
				Map<String, Object> map = new HashMap<>();
				map.put("username", memberVO.getUsername());
				
				if(memberVO.getCategory() == 0) {
					map.put("roleNum", 1);
				}else if(memberVO.getCategory() == 1) {
					map.put("roleNum", 2);
				}else if(memberVO.getCategory() == 2) {
					map.put("roleNum",3);
				}else {
					map.put("roleNum", 0);
				}
				
				
				result = administratorDAO.setRoleAdd(map);
				
				return result;
			 }
			
		}
		
		public int setProfessorAdd(ProfessorVO professorVO, MemberVO memberVO, MemberSeqVO memberSeqVO) throws Exception {
		memberVO.setPassword(passwordEncoder.encode(memberVO.getPassword()));
			
			int result;
			String year;
			 if(administratorDAO.getYearSeq(memberSeqVO) == null) {
				 result =  administratorDAO.setInsertSeq(memberSeqVO);
				 year=  administratorDAO.getYearSeq(memberSeqVO).toString();
				 Long memberSeq = administratorDAO.getMemberSeq(memberSeqVO);
				 String username;
				 
				 if(memberSeq < 10) {
					  username = year + "000" + memberSeq;
				  }else if(memberSeq < 100) {
					  username = year + "00" + memberSeq;
				  }else if(memberSeq < 1000) {
					  username = year + "0" + memberSeq;
				  }else {
					  username = year + memberSeq;
				  }
				  
				  
				  memberVO.setUsername(username);
				 
				
				result = administratorDAO.setMemberAdd(memberVO);
				
				professorVO.setUsername(memberVO.getUsername());
				
				result = administratorDAO.setProfessorAdd(professorVO);
				
				Map<String, Object> map = new HashMap<>();
				map.put("username", memberVO.getUsername());
				
				if(memberVO.getCategory() == 0) {
					map.put("roleNum", 1);
				}else if(memberVO.getCategory() == 1) {
					map.put("roleNum", 2);
				}else if(memberVO.getCategory() == 2) {
					map.put("roleNum",3);
				}else {
					map.put("roleNum", 0);
				}
				
				
				result = administratorDAO.setRoleAdd(map);
				
				return result;
				
				 
			 }else {
				  year = administratorDAO.getYearSeq(memberSeqVO).toString(); 
				  result = administratorDAO.setUpdateSeq(memberSeqVO);
				  Long memberSeq = administratorDAO.getMemberSeq(memberSeqVO);
				  String username;
				  
				  
				  
				  if(memberSeq < 10) {
					  username = year + "000" + memberSeq;
				  }else if(memberSeq < 100) {
					  username = year + "00" + memberSeq;
				  }else if(memberSeq < 1000) {
					  username = year + "0" + memberSeq;
				  }else {
					  username = year + memberSeq;
				  }
				  
				  
				 memberVO.setUsername(username);
				 
				
				result = administratorDAO.setMemberAdd(memberVO);
				
				professorVO.setUsername(memberVO.getUsername());
				
				result = administratorDAO.setProfessorAdd(professorVO);
				
				Map<String, Object> map = new HashMap<>();
				map.put("username", memberVO.getUsername());
				
				if(memberVO.getCategory() == 0) {
					map.put("roleNum", 1);
				}else if(memberVO.getCategory() == 1) {
					map.put("roleNum", 2);
				}else if(memberVO.getCategory() == 2) {
					map.put("roleNum",3);
				}else {
					map.put("roleNum", 0);
				}
				
				
				result = administratorDAO.setRoleAdd(map);
				
				return result;
			 }
		}
		
		
		//회원 조회
		public List<StudentVO> getStudentList(Pagination pagination) throws Exception {
			Long totalCount = administratorDAO.getTotalCountStudent(pagination);
			
			pagination.makeNum(totalCount);
			pagination.makeStartRow();
			
			
			return administratorDAO.getStudentList(pagination);
		}
		
		public List<ProfessorVO> getProfessorList(Pagination pagination) throws Exception {
			Long totalCount = administratorDAO.getTotalCountProfessor(pagination);
			
			pagination.makeNum(totalCount);
			pagination.makeStartRow();
			
			return administratorDAO.getProfessorList(pagination);
		}
		
		public List<AdministratorVO> getAdministratorList(Pagination pagination) throws Exception {
			Long totalCount = administratorDAO.getTotalCountAdministrator(pagination);
			
			pagination.makeNum(totalCount);
			pagination.makeStartRow();
			
			return administratorDAO.getAdministratorList(pagination);
		}
	
	//강의실 관리
	
	//강의실 조회
	public List<LectureRoomVO> getLectureRoomList(Pagination pagination) throws Exception {
		Long totalCount = administratorDAO.getTotalCountLectureRoom(pagination);
		
		pagination.makeNum(totalCount);
		pagination.makeStartRow();
		
		return administratorDAO.getLectureRoomList(pagination);
	}
	//강의실 등록
	public int setLectureRoomAdd(LectureRoomVO lectureRoomVO) throws Exception {
		
		return administratorDAO.setLectureRoomAdd(lectureRoomVO);
	}
	
	public List<LectureRoomVO> getLectureBuilding() throws Exception {
		
		return administratorDAO.getLectureBuilding();
	}
	
	//강의실 중복 체크
	public LectureRoomVO LectureRoomDuplicateCheck(LectureRoomVO lectureRoomVO) throws Exception {
		return administratorDAO.LectureRoomDuplicateCheck(lectureRoomVO);
	}
	
	//강의실 수정
	public int setLectureRoomUpdate(LectureRoomVO lectureRoomVO) throws Exception {
		return administratorDAO.setLectureRoomUpdate(lectureRoomVO);
	}
	
	//강의실 디테일
	public LectureRoomVO getLectureRoomDetail(LectureRoomVO lectureRoomVO) throws Exception {
		return administratorDAO.getLectureRoomDetail(lectureRoomVO);
	}

	
	//학과 관리
	
	//학과 조회
	public List<DepartmentVO>  getDepartmentList(Pagination pagination) throws Exception {
		Long totalCount = administratorDAO.getTotalCountDepartment(pagination);
		
		pagination.makeNum(totalCount);
		pagination.makeStartRow();
		
		return administratorDAO.getDepartmentList(pagination);
	}
	
	//학과 등록
	public int setDepartmentAdd(DepartmentVO departmentVO) throws Exception {
		return administratorDAO.setDepartmentAdd(departmentVO);
	}
	
	public Integer  getDeptNum() throws Exception {
		return administratorDAO.getDeptNum();
	}
	//학과 상태 수정
	public int setDepartmentStatus(DepartmentVO departmentVO) throws Exception {
		return administratorDAO.setDepartmentStatus(departmentVO);
	}
	
	//학과 수정
	public int setDepartmentUpdate(DepartmentVO departmentVO) throws Exception {
		return administratorDAO.setDepartmentUpdate(departmentVO);
	}
	
	//학과 디테일
	public DepartmentVO getDepartmentDetail(DepartmentVO departmentVO) throws Exception {
		return administratorDAO.getDepartmentDetail(departmentVO);
	}
	
	//학과 중복 체크
	public DepartmentVO departmentDuplicateCheck(DepartmentVO departmentVO) throws Exception {
		return administratorDAO.departmentDuplicateCheck(departmentVO);
	}
	
	//기간 설정
	public int setPeriodAdd(PeriodVO periodVO) throws Exception {
		int result = administratorDAO.setPeriodAdd(periodVO);
		return result;
		
	}
	
	
	public List<PeriodVO> getPeriodList(Pagination pagination) throws Exception {
		Long totalCount = administratorDAO.getTotalCountPeriod(pagination);
		
		pagination.makeNum(totalCount);;
		pagination.makeStartRow();
		
		List<PeriodVO> ar =  administratorDAO.getPeriodList(pagination);
		
		return ar;
	}
	
	public List<String> getCurrentYear() throws Exception {
		List<String> result = administratorDAO.getCurrentYear();
		
		return result;
	}
	
	public List<String> getCurrentYearMinus() throws Exception {
		return administratorDAO.getCurrentYearMinus();
	}
	
	//강의 조회
	public List<LectureVO> getLectureList(Pagination pagination) throws Exception {
		Long totalCount = administratorDAO.getTotalCountLecture(pagination);
		
		pagination.makeNum(totalCount);
		pagination.makeStartRow();
		
		List<LectureVO> ar =  administratorDAO.getLectureList(pagination);
		
		
		return ar;
	}
	
	public List<LectureVO> getLectureListAll(Pagination pagination) throws Exception {
		Long totalCount = administratorDAO.getTotalCountLecture(pagination);
		
		pagination.makeNum(totalCount);
		pagination.makeStartRow();
		
		List<LectureVO> ar =  administratorDAO.getLectureListAll(pagination);
		
		
		return ar;
	}
	
	public Integer getDeptNumDetail(String username) throws Exception {
		return administratorDAO.getDeptNumDetail(username);
	}
	
	//강의 폐강
	public int setLectureUpdate(LectureVO lectureVO) throws Exception {
		return administratorDAO.setLectureUpdate(lectureVO);
	}
	
	//강의실 배정
	public List<LectureRoomVO> getLectureRoomAssignment(Map<String, Object> map) throws Exception {
		
		Long totalCount = administratorDAO.getTotalCountAssiginment();
		
		Pagination pagination = (Pagination) map.get("pagination");
		
		pagination.makeNum(totalCount);
		pagination.makeStartRow();
		
		map.put("startRow", pagination.getStartRow());
		map.put("perPage", pagination.getPerPage());
		
		List<LectureRoomVO> ar = administratorDAO. getLectureRoomAssignment(map);
		
		return ar;
	}
 	
	public int setLectureRoomAssignmentUpdate(LectureVO lectureVO) throws Exception {
		return administratorDAO.setLectureRoomAssignmentUpdate(lectureVO);
	}
	
	public LectureVO getLectureNum(LectureVO lectureVO) throws Exception {
		return administratorDAO.getLectureNum(lectureVO);
	}
	
	public List<LectureRoomVO> getLectureRoom(Pagination pagination) throws Exception {
		return administratorDAO.getLectureRoom(pagination);

	}
	
	public List<TimeTableVO> getTimeTable() throws Exception {
		return administratorDAO.getTimeTable();
	}
}
