package com.acadmi.report;

import java.sql.Date;
import java.util.List;

import com.acadmi.student.StudentVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportVO {
	private Long reportNum;
	private Long registrationNum;
	private String username;
	private String contents;
	private Float score;
	private Integer grading;
	private Date submissiondate;
	
	private List<StudentVO> studentVOs;
}
