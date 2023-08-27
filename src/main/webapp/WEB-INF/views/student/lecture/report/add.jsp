<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/css/sidebar.css">
<head>
<meta charset="UTF-8">
<title>Acadmi!</title>
<c:import url="../../../temp/style.jsp"></c:import>
</head>
<body class="hold-transition sidebar-mini">
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
										과제 제출
									</h3>
								</div>
							</div>
						</div>
						
						<!-- form start -->
						<div class="row">
							<div class="col-md-12" style="margin-top: 10px;">
								<div class="card card-secondary">
									<div class="card-body" style="margin: 0 auto">
										<form id="contactForm" action="./add" method="post" enctype="multipart/form-data">
											<input type="hidden" name="registrationNum" value="${reportVO.registrationNum }">
											<input type="hidden" name="username" value="${reportVO.username}">
											<input type="hidden" name="lectureNum" value="${lecture.lectureNum }">
											<div class="col-md-12 mt-4">
												<label for="contents" class="form-label strongFont2">내용</label>
												<textarea class="form-control" name="contents" id="contents" placeholder="내용을 입력하세요."></textarea>
											</div>
											
											<div class="col-md-12 mt-5">
												<div class="form-group">
								                    <div class="input-group">
								                    	<div class="custom-file">
								                        	<input type="file" class="custom-file-input" id="exampleInputFile" name="addfiles">
								                        	<label class="custom-file-label" for="exampleInputFile">파일을 선택해 주세요.</label>
								                     	</div>
							                    	</div>
						                    	</div>											
											</div> 
		              
											<div class="col-md-12 mt-4">	
												<button type="button" class="btn btn-danger float-right" onclick="window.history.back();">취소</button>	
												<button type="submit" class="submitButton btn btn-info float-right" style="margin-right: 5px;">등록</button>
											</div>
										</form>
									</div>
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