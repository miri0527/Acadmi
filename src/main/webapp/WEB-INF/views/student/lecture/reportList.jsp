<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Acadmi!</title>
	<!-- CSS/favicon 적용 -->
	<c:import url="../../temp/style.jsp"></c:import>
	<!-- CSS/favicon 끝 -->
<title>Insert title here</title>
<style type="text/css">
	
</style>
</head>
<body class="hold-transition si	debar-mini layout-fixed" >
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
			<c:import url="../../temp/lecture_header.jsp"></c:import>
		</sec:authorize>
		<!-- Header 끝 -->
		
		<!-- Main Contents start -->
		<div class="content-wrapper">
			<div class="container-fluid">
				<div class="row">
					<c:import url="../../temp/sidebar/student_lecture_main.jsp"></c:import>
					
					<!-- Contents start -->
					<div class="col">
						<!-- header start -->
						<div class="row" style="padding-top:10px">
							<div class="col-12">
								<div class="card">
									<h3 class="my-3 mx-3">등록된 과제</h3>
								</div>
							</div>
						</div>
						
 						<!-- table-body start -->
       						<div class="card-body" id="reportList">
         			<table class="table table-bordered" style="text-align: center;">
           				<thead style="background-color: #f8f9fa;color:#17a2b8;">
	             			<tr>
		                    	<th>차수</th>
		                    	<th>과제 제목</th>
		                    	<th>제출일</th>
		                    	<th>작성자</th>
	                    		<th></th>
			                </tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="classVO">
								
									<c:set var="order" value="${classVO.order }"></c:set>
									<c:forEach items="${classVO.reportRegistrationVOs}" var="reportRegistrationVO">
										
										<c:set var="reportName" value="${reportRegistrationVO.reportName }"></c:set>
										<c:forEach items="${reportRegistrationVO.reportVOs}" var="reportVO">
											<tr>
												<c:set var="submissionDate" value="${reportVO.submissionDate }"></c:set>
												<c:forEach items="${reportVO.studentVOs}" var="studentVO">
													<c:set var="name" value="${studentVO.name }"></c:set>
												</c:forEach>
													<td>${order}</td>
													<td>${reportName }</td>
													<td>${submissionDate }</td>
													<td>${name }</td>
													<td><button type="button" class="btn btn-primary">수정</button> </td>
											</tr>
										</c:forEach>
										
									</c:forEach>
								
							</c:forEach>
						</tbody>
						
   	 				
						
             				
					</table>
				</div>
         		<!-- table-body end -->

						
						
					</div>
					<!-- Contents end -->
				</div>
			</div>
		</div>
		<!-- Main Contents end -->

		<!-- Footer 적용 -->
		<c:import url="../../temp/footer.jsp"></c:import>
		<!-- Footer 끝 -->	
			
	</div>
<!-- ./wrapper -->		
</body>
</html>