<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
			<c:import url="../temp/professor_header.jsp"></c:import>
		</sec:authorize>
			
		<sec:authorize access="hasRole('ROLE_STUDENT')">
			<c:import url="../temp/student_header.jsp"></c:import>
		</sec:authorize>
		<!-- Header 끝 -->

		<!-- Main Contents -->
		<div class="content-wrapper">
			<div class="container-fluid">
				<div class="row">
					<!-- 2레벨 Sidebar 적용 -->
					<c:import url="../temp/sidebar/administrator_memberList.jsp"></c:import>
					<!-- 2레벨 Sidebar 끝 -->
				
					<!-- Contents -->
					<div class="col">
						<!-- header start -->
						<div class="row">
							<div class="col-12 mt-3">
								<div class="card">
									<h3 class="my-3 mx-3">학생 목록 조회</h3>
								</div>
							</div>
						</div>
						<!-- header end -->
						
						<!-- Default box -->
						<div class="card">
							<div class="card-header">
							<form action="./studentList" id="search-form">
								<input type="hidden" name="page" value="1">
									<!-- 검색 조건 start -->
									<div class="row justify-content-center mx-auto my-3">
										<div class="col-md-8">
											<div class="row">
												<div class="col-3">
													<div class="form-group">
														<label>단과대학</label>
														<select class=" select2" name="collegeName"  id="college" style="width : 100%;" >
															<option value="">전체</option>
															<c:forEach items="${college}" var="collegeVO">
																<c:if test="${collegeVO.collegeNum != 1 && collegeVO.collegeNum != 2}">
																	<option value="${collegeVO.collegeName}" ${collegeVO.collegeName eq param.collegeName? 'selected' : ''}>${collegeVO.collegeName}</option>
																</c:if>	
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="col-3">
													<div class="form-group">
														<label >학과</label>
														<select  class="select2" style="width: 100%;" name="deptName" id="dept">
															<option value="">전체</option>
															<c:forEach items="${department}" var="departmentVO">
																<c:if test="${departmentVO.deptNum !=1 && departmentVO.deptNum !=2 }">
																	<option value="${departmentVO.deptName}" ${departmentVO.deptName eq param.deptName? 'selected' : '' }>${departmentVO.deptName}</option>
																</c:if>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="col-3">
													<div class="form-grop">
														<label>학년</label>
														<select class="select2" name="grade" style="width : 100%;">
															<option value="" ${param.grade eq '' ? 'selected' : '' }>전체</option>
															<option value="1" ${param.grade == 1 ? 'selected' : '' }>1학년</option>
															<option value="2" ${param.grade == 2 ? 'selected' : '' } >2학년</option>
															<option value="3" ${param.grade == 3 ? 'selected' : '' }>3학년</option>
															<option value="4" ${param.grade == 4 ? 'selected' : '' }>4학년</option>
														</select>
													</div>
												</div>
												<div class="col-3">
													<div class="form-group">
														<label >상태</label>
														<select class="select2" name="status" style="width: 100%;">
															<option value="" ${param.status eq ''? 'selected' : '' }>전체</option>
															<option value="1"${param.status==1 ?'selected' :'' }>재학</option>
															<option value="2"${param.status==2 ?'selected' :'' }>휴학</option>
															<option value="3"${param.status==3 ?'selected' :'' }>퇴학</option>
															<option value="4"${param.status==4 ?'selected' :'' }>졸업</option>
															<option value="5"${param.status==5 ?'selected' :'' }>졸업유예</option>
														</select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-6">
													<div class="form-group">
														<label>학번</label>
														<input type="text" class="form-control" name="username" placeholder=" 학번을 입력하세요." value="${param.username}">
													</div>
												</div>
												<div class="col-6">
													<div class="form-group">
														<label>이름</label>
														<div class="input-group">
															<input type="text" class="form-control" placeholder="이름을 입력하세요." name="search" value="${pagination.search}">
															<div class="input-group-append">
																<button type="submit" class="btn btn-default" id="submit">
																	<i class="fas fa-search "></i>
																</button>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 검색 조건 end -->
									
									<!-- 학생 목록 조회 -->
								 	<table class="table table-hover text-nowrap" style="text-align : center;"  id="tableStudent">
										<thead>
											<tr>
												<th style="width: 10%">쪽지</th>
							                    <th style="width: 10%">사진</th>
							                    <th style="width: 15%">학과</th>
							                    <th style="width: 10%">학번</th>
							                    <th style="width: 10%" class="text-center">이름</th>
							                    <th style="width: 10%" class="text-center">단과 대학</th>
							                    <th style="width: 10%">학년</th>
							                    <th style="width: 15%">연락처</th>
							                    <th style="width: 20%">학적 상태</th>
											</tr>
										</thead>
					              		<tbody>
					                 		<c:forEach items="${list}" var="collegeVO">
	     	 									<tr>
					     	 						<c:set var="college" value="${collegeVO.collegeName}"></c:set>
					     	 						<c:forEach items="${collegeVO.departmentVOs}" var="departmentVO">
					     	 							<c:set var="department" value="${departmentVO.deptName}"></c:set>
					     	 							<c:forEach items="${departmentVO.studentVOs}" var="studentVO">
						     	 							<c:set var="studentName" value="${studentVO.name}"></c:set>
						     	 							<c:set var="studentUsername" value="${studentVO.username}"></c:set>
						     	 							<c:set var="studentPhone" value="${studentVO.phone}"></c:set>
						     	 							<c:set var="studentGrade" value="${studentVO.grade}"></c:set>
						     	 							<c:set var="studentStatus" value="${studentVO.status}"></c:set>
						     	 							<c:set var="memberFiles" value="${studentVO.memberFilesVO.fileName }"></c:set>
					     	 								<tr>
						     	 								<td>
						     	 									<sec:authentication property="principal.username" var="username"/>
									     	 						<a href="../chat/detail?roomSender=${username}&roomRecipient=${studentVO.username}"><i class="fa-regular fa-envelope fa-2xl" style="margin:30px 0 0 0;"></i></a>
						     	 								</td>
						     	 								<td style="vertical-align:middle;">
						   	 										<c:if test="${empty memberFiles}">
																		<img class="img" src="/images/profile.jpg" alt="User profile picture" width="60rem" height="60rem" style="border-radius:5px">
											   	 					</c:if>
											   	 					<c:if test="${not empty memberFiles}">
											   	 						<img class="img" src="/file/member/${memberFiles}" width="60rem" height="60rem" style="border-radius:5px">
											   	 					</c:if>	
						   	 									</td>
						   	 									<td style="vertical-align:middle;"><c:out value="${department}"></c:out></td>
						     	 								<td style="vertical-align:middle;"><c:out value="${studentUsername}"></c:out></td>
									     	 					<td style="vertical-align:middle;"><c:out value="${studentName}"></c:out></td>
									     	 					<td style="vertical-align:middle;"><c:out value="${college}"></c:out></td>
									     	 					<td style="vertical-align:middle;"><c:out value="${studentGrade}"></c:out>학년</td>
									     	 					<td style="vertical-align:middle;">
											     	 				<c:out value="${fn:substring(fn:replace(studentPhone,'-',''), 0, 3)}"></c:out>-<c:out value="${fn:substring(fn:replace(studentPhone,'-',''), 3, 7)}"></c:out>-<c:out value="${fn:substring(fn:replace(studentPhone,'-',''), 7,11)}"></c:out>
									     	 					</td>
									     	 					<td style="vertical-align:middle;">
										     	 					<c:if test="${studentStatus eq 1}">재학</c:if>
										     	 					<c:if test="${studentStatus eq 2 }">휴학</c:if>
											     	 				<c:if test="${studentStatus eq 3 }">퇴학</c:if>
											     	 				<c:if test="${studentStatus eq 4 }">졸업</c:if>
											     	 				<c:if test="${studentStatus eq 5 }">졸업 유예</c:if>
											     	 			</td>
					     	 								</tr>	
					     	 							</c:forEach>
					     	 						</c:forEach>
					     	 					</tr>
					     	 				</c:forEach>
									    </tbody>
									</table>
									<!-- 학생 목록 조회 -->
									
									<!-- pagination -->
			            	  		<div class="row g-3 my-3 justify-content-center" id="pagination">
										<ul class="pagination pagination-sm mx-auto">
											<c:if test="${pagination.pre}">
												<li class="page-item">
													<a class="page-link" href="./studentList?page=1&kind=${pagination.kind}&search=${pagination.search}" aria-label="Previous" data-board-page="1" style="color:#17a2b8;">
														<span aria-hidden="true">&laquo;</span>
													</a>
												</li>
											</c:if>
											<c:forEach begin="${pagination.startNum}" end="${pagination.lastNum}" var="i">
												<li class="page-item"><a class="page-link" href="./studentList?page=${i}&kind=${pagination.kind}&search=${pagination.search}" data-board-page="${i}" style="color:#17a2b8;">${i}</a></li>
											</c:forEach>
											<c:if test="${pagination.next }">
												<li class="page-item">
													<a class="page-link" href="./studentList?page=${pagination.totalPage}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Next" data-board-page="${pagination.totalPage}" style="color:#17a2b8;">
														<span aria-hidden="true">&raquo;</span>
													</a>
												</li>
											</c:if>
										</ul>
									</div>
									<!-- pagination -->
							
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Footer 적용 -->
		<c:import url="../temp/footer.jsp"></c:import>
		<!-- Footer 끝 -->
	
	
	</div>
	<!-- ./wrapper -->
		<script>
		    $(function () {
		      $('.select2').select2()
		    });
		</script>
	
</body>
</html>