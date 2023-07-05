package com.acadmi.report;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportRegistrationVO {
	
	private Long registrationNum;
	private Long syllabusNum;
	private Integer order;
	private String reportName;
	private String contents;
	private Date startDate;
	private Date submissionDate;
	
	private List<ReportVO> reportVOs;
	
}
