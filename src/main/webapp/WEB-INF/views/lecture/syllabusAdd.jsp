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
	<c:import url="../temp/style.jsp"></c:import>
	<!-- CSS/favicon 끝 -->
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">

		<!-- Header 적용 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<c:import url="../temp/administrator_header.jsp"></c:import>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_ADMINISTRATOR')">
			<c:import url="../temp/administrator_header.jsp"></c:import>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_PROFESSOR')">
			<c:import url="../temp/lecture_header.jsp"></c:import>
		</sec:authorize>
			
		<sec:authorize access="hasRole('ROLE_STUDENT')">
			<c:import url="../temp/student_header.jsp"></c:import>
		</sec:authorize>
		<!-- Header 끝 -->

		<!-- Main Contents start -->
		<div class="content-wrapper">
			<div class="container-fluid">
				<div class="row">
					<!-- 2레벨 Sidebar 적용 -->
					<c:import url="../temp/sidebar/professor_lecture.jsp"></c:import>
					<!-- 2레벨 Sidebar 끝 -->
					
					<!-- Contents start -->
					<div class="col">
						<!-- header start -->
						<div class="row" style="padding-top:10px">
							<div class="col-12">
								<div class="card">
									<h3 class="my-3 mx-3">강의계획서 등록</h3>
								</div>
							</div>
						</div>
						<!-- header end -->
						
						<!-- form start -->
						<form action="./syllabusAdd" method="post">
							<div class="card card-default">
	          					<!-- card-header start -->
								<div class="card-body">
									<input type="hidden" id="lectureNum" name="lectureNum" value="${lecture.lectureNum}">
									<h3 class="my-3 mx-3" style="text-align:center;margin-top:40px;">${lecture.year}년도 ${lecture.semester}학기 강의계획서</h3>
									<div class="row" style="margin-top: 20px">
	              						<!-- table-body start -->
	              						<div class="card-body">
	                						<table class="table table-bordered" style="text-align: center;">
								                <tbody>
								                	<tr>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">강의 이름</th>
								                		<td colspan="3">${lecture.lectureName}</td>
								                	</tr>
								                	<tr>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">교과 개요</th>
								                		<td colspan = "3"><input type="text" name="curriculumOutline" class="form-control" id="curriculumOutline"value=""></td>
								                	</tr>
								                	<tr>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;"rowspan="2">목표</th>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">수업 방식</th>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">목표</th>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">평가 방법</th>
								                	</tr>
								                	<tr>
								                		<td><input type="text" name="method" class="form-control" id="method"value=""></td>
								                		<td><input type="text" name="goal" class="form-control" id="gaol"value=""></td>
								                		<td><input type="text" name="evaluation" class="form-control" id="evaluation"value=""></td>
								                	</tr>
												</tbody>
											</table>
											
											<table class="table table-bordered" style="text-align: center;margin-top: 20px">
								                <tbody>
								                	<tr>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;vertical-align:middle;width:210px" rowspan="4">교재 및 참고 문서</th>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">교재명</th>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">저자</th>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">출판사</th>
								                	</tr>
								                	<tr>
								                		<td><input type="text" name="bookName" class="form-control" id="bookName"value=""></td>
								                		<td><input type="text" name="bookAuthor" class="form-control" id="bookAuthor"value=""></td>
		                    							<td><input type="text" name="bookPublisher" class="form-control" id="bookPublisher"value=""></td>
								                	</tr>
								                	<tr>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">출판 연도</th>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">ISBN</th>
								                		<th style="background-color:#f8f9fa;color:#17a2b8;">비고</th>
								                	</tr>
								                	<tr>
								                		<td><input type="text" name="bookPublicationDate" class="form-control" id="bookPublicationDate"value=""></td>
								                		<td><input type="text" name="bookISBN" class="form-control" id="bookISBN"value=""></td>
		                    							<td><input type="text" name="bookNote" class="form-control" id="bookNote" value=""></td>
								                	</tr>
												</tbody>
											</table>
											
											<table class="table table-bordered" style="text-align: center;margin-top: 20px">
	                    						<tbody>
		                    						<tr style="background-color:#17a2b8; color:white;">
		                    							<th>차수</th>
	                    								<th>수업 주제</th>
	                    								<th>주차별 수업 목표</th>
	                    								<th>관련 역량</th>
	                    								<th>비고</th>
		                    						</tr>
			                    					<c:forEach begin="1" end="8" var="i">
			                    						<tr>
			         
			                    							<td><input type="hidden" name="order" value="${i}">${i}차수</td>
		                    								<td><input type="text" name="subject${i}" class="form-control" id="subject${i}" value=""></td>
		                    								<td><input type="text" name="goal${i}" class="form-control" id="goal${i}"value=""></td>
		                    								<td><input type="text" name="capability${i}" class="form-control" id="capability${i}"value=""></td>
		                    								<td><input type="text" name="note${i}" class="form-control" id="bookNote${i}"value=""></td>
		                    							</tr>
			                    					</c:forEach>
	                    						</tbody>
	                    					</table>
										</div>
	              						<!-- table-body end -->
									</div>
									<div style="width:auto; float: right; margin-top: 25px">
						                <button class="btn btn-info" type="submit">등록</button>
						                <a class="btn btn-danger" href="/lecture/main?lectureNum=${lecture.lectureNum}" style="color: white;">취소</a>
					                </div>
								</div>
							</div>
						</form>
					</div>
					<!-- Contents end -->
				</div>
			</div>
		</div>
		<!-- Main Contents end -->
	               		
		<!-- Footer 적용 -->
		<c:import url="../temp/footer.jsp"></c:import>
		<!-- Footer 끝 -->
	</div>
	<!-- ./wrapper -->
</body>
</html>