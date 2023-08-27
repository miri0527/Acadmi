<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/css/sidebar.css">
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Acadmi!</title>
	<!-- CSS/favicon 적용 -->
	<c:import url="../../../temp/style.jsp"></c:import>
	<!-- CSS/favicon 끝 -->
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
									<c:if test="${reportVO.reportNum eq null }">
										<a href="./add?lectureNum=${lecture.lectureNum}&registrationNum=${reportRegostrationVO.registrationNum}" class="btn btn-info float-right" style="margin-right: 10px">제출</a>
									</c:if>
									<c:if test="${reportVO.reportNum ne null }">
										
									</c:if>
									
								</c:forEach>
									
								</div>
								
							</div>
							
						</div>
						
						
					</div>
					
			</div>
		</div>
	</div>
		
		
</div>
</body>
</html>