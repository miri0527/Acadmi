package com.acadmi.report;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportRegistrationVO {
	
	private Long registrationNum;
	private String username;
	private Long syllabusNum;
	private Long lectureNum;
	private Integer order;
	private String reportName;
	private String contents;
	private Integer registrationScore;
	private java.util.Date startDate;
	private java.util.Date submissionDate;
	
	private List<ReportVO> reportVOs;
	
}
