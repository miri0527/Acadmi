<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Acadmi!</title>
	<!-- CSS/favicon 적용 -->
	<c:import url="../../../temp/style.jsp"></c:import>
	<!-- CSS/favicon 끝 -->
	<link rel="stylesheet" href="/css/sidebar.css">

</head>
<body class="hold-transition si	debar-mini layout-fixed">	
<div class="wrapper">
	<!-- Header 적용 -->
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<c:import url="../../temp/administrator_header.jsp"></c:import>
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_ADMINISTRATOR')">
		<c:import url="../../temp/administrator_header.jsp"></c:import>
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_PROFESSOR')">
		<c:import url="../../temp/professor_header.jsp"></c:import>
	</sec:authorize>
		
	<sec:authorize access="hasRole('ROLE_STUDENT')">
		<c:import url="../../..//temp/lecture_header.jsp"></c:import>
	</sec:authorize>
	<!-- Header 끝 -->
	
	<!-- Main Contents start -->
	<div class="content-wrapper">
		<div class="content-fulid">
			<div class="row">
				<c:import url="../../../temp/sidebar/student_lecture_main.jsp"></c:import>
				
					<!-- Contents start -->
					<div class="col">
						<div class="row" style="padding-top:20px">
							<div class="col-12">
								<div class="card">
									<h3 class="my-3 mx-3">
										${reportRegostrationVO.reportName}
									</h3>
								</div>
							</div>
						</div>
						
						<div class="card" style="padding-top: 10px; margin-top: 10px;">
							<div class="card-body">
								<div class="row">
									<table class="table">
										<tr>
											<th width=20% class="text-center warning" style="background-color:#f8f9fa; border-bottom: 1px solid #d6d6cd;">마감일</th>
										    <td width=30% class="text-center" style="border-bottom: 1px solid #d6d6cd;"><fmt:formatDate value="${reportRegostrationVO.submissionDate }" type="both" pattern="yyyy년 MM월 dd일 a hh:mm"/>까지</td>
										    <th width=20% class="text-center warning" style="background-color:#f8f9fa; border-bottom: 1px solid #d6d6cd;">시작일</th>
									        <td width=30% class="text-center" style="border-bottom: 1px solid #d6d6cd;"><fmt:formatDate value="${reportRegostrationVO.startDate }" type="both" pattern="yyyy년 MM월 dd일 a hh:mm"/></td></td>
										</tr>
									</table>
								</div>
							</div>
							
							<div class="card-body">
								${reportRegostrationVO.contents}
								<div style="margin-bottom : 20px;">
									
								</div>
								<div>
									<a href="./list?lectureNum=${lecture.lectureNum}" class="btn btn-light float-right" style="margin-right: 5px">목록</a>
								</div>
								<div>
								<c:forEach items="${reportRegostrationVO.reportVOs}" var="reportVO">
									<div class="registrationNum"  data-num="${reportRegostrationVO.registrationNum}"></div>
									<c:set var="reportNum" value="${reportVO.reportNum }"></c:set>
								</c:forEach>
									
								</div>
								
							</div>
							
						</div>
						
						<c:if test="${reportNum ne null }">
						
							<div class="card"style="padding-top: 15px; margin-top: 10px; padding-bottom : 30px; padding-left : 20px;" id="myReportList" >
							</div>
							
						</c:if>
						<c:if test="${reportNum eq null}">
								<div style="width:200px; height : 36px; float:left;" class="card">
									<div style="text-align : center; font-size : 15px; margin-top : 6px; font-weight : bold;" >과제 제출</div>
								</div>
								<div style="width:83%;  float:left;" id="reportAdd"></div>
							
							
						</c:if>
						
						
					</div>
					
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	let registrationNum = $(".registrationNum").data("num")
	let lectureNum = ${lecture.lectureNum}
	
	$.ajax ({
		url : '/student/lecture/report/submission',
		type : 'GET',
		data : {
			registrationNum : registrationNum
		},
		success: function(response) {
	        $("#myReportList").html(response.trim());
	    }
	})
	
	$.ajax ({
		url : '/student/lecture/report/add',
		type : 'GET',
		data : {
			registrationNum : registrationNum,
			lectureNum : lectureNum
		},
		success : function(response) {
			$("#reportAdd").html(response.trim());
		}
	})
</script>
</body>
</html>