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
						<div class="card">
							<div class="card-header">
								<form action="./reportList" id="search-form">
									<input type="hidden" name="lectureNum" value="${lecture.lectureNum}">
									<div class="card-title">
					            		<label class="mx-2 my-2">주차</label>
					               		<select  class="select2" name="order" style="width:115px;" id="order" >
					               			<option value="">전체</option>
					               		</select>
					               		<label class="mx-2 my-2">과제 이름</label>
					               		<input type="text" name="reportName" style="width:200px;" id="reportName" value="${param.reportName  }"> 
					               		
					               		<button type="submit" class="btn btn-default ml-1" id="submit">
							            	<i class="fas fa-search"></i>
							            </button>
					                </div>
				                </form>	
							</div>
						</div>
						
						
 					<!-- table-body start -->
       				<div class="card" id="reportList">
         			<table class="table table-bordered" style="text-align: center; margin-top : 30px;">
           				<thead style="background-color: #f8f9fa;color:#17a2b8;">
	             			<tr>
		                    	<th></th>
		                    	<th>과제 제목</th>
		                    	<th>제출일</th>
		                    
	                    	
			                </tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="classVO">
				
									<c:forEach items="${classVO.reportRegistrationVOs}" var="reportRegistrationVO">
										
										<c:set var="order" value="${reportRegistrationVO.order }"></c:set>
										<c:set var="reportName" value="${reportRegistrationVO.reportName }"></c:set>
										
										<c:forEach items="${reportRegistrationVO.reportVOs}" var="reportVO">
											<tr>
												<c:set var="submissionDate" value="${reportVO.submissionDate }"></c:set>
												<c:forEach items="${reportVO.studentVOs}" var="studentVO">
													<c:set var="name" value="${studentVO.name }"></c:set>
													
												</c:forEach>
													<td>${order}주차</td>
													<td>${reportName }</td>
													<td>${submissionDate }</td>
												
												
											</tr>
										</c:forEach>
										
									</c:forEach>
								
							</c:forEach>
							
						</tbody>
					
					</table>
					<!-- table-body end -->
	
					
					<!-- pagination -->
					<div class="row g-3 my-3 justify-content-center" id="pagination">
					
						<ul class="pagination pagination-sm mx-auto">
							<c:if test="${pagination.pre}">
								<li class="page-item">
									<a class="page-link" href="./reportList?page=1&lectureNum=${lecture.lectureNum}&order=${pagination.order}&reportName=${pagination.reportName}" aria-label="Previous" data-board-page="1" style="color:#17a2b8;">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pagination.startNum}" end="${pagination.lastNum}" var="i">
								<li class="page-item"><a class="page-link" href="./reportList?page=1&lectureNum=${lecture.lectureNum}&order=${pagination.order}&reportName=${pagination.reportName}" data-board-page="${i}" style="color:#17a2b8;">${i}</a></li>
							</c:forEach>	
							<c:if test="${pagination.next }">
								<li class="page-item">
									<a class="page-link" href="./reportList?page=1&lectureNum=${lecture.lectureNum}&order=${pagination.order}&reportName=${pagination.reportName}" aria-label="Next" data-board-page="${pagination.totalPage}" style="color:#17a2b8;">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
						</ul>
					</div>
					<!-- pagination -->
				</div>
         		

						
						
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
<script type="text/javascript" src="/js/student/myReportList.js"></script>	
<script type="text/javascript">
$(function () {
    $('.select2').select2()
});
</script>
</body>
</html>