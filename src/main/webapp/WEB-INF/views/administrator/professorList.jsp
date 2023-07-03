<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
							<div class="col-12 my-3">
								<div class="card">
									<h3 class="my-3 mx-3">교수 목록 조회</h3>
								</div>
							</div>
						</div>
						<!-- header end -->
						
						<!-- Default box -->
						<div class="card">
							<div class="card-header">
								<form action="./professorList" id="search-form">
									<input type="hidden" name="page" value="1">
									<!-- 검색 조건 start -->
									<div class="row justify-content-center mx-auto">
										<div class="col-md-8 my-3">
											<div class="row">
												<div class="col-4">
													<div class="form-group">
														<label>담당대학</label>
														<select class="select2" name="collegeName" style="width : 100%;" id="college" >
														<option value="">전체</option>
															<c:forEach items="${college}" var="collegeVO">
																<c:if test="${collegeVO.collegeNum != 1 && collegeVO.collegeNum != 2}">
																	<option value="${collegeVO.collegeName}"${collegeVO.collegeName eq param.collegeName?'selected' : '' }>${collegeVO.collegeName }</option>
																</c:if>	
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="col-4">
													<div class="form-group">
														<label >담당학과</label>
														<select  class="select2" style="width : 100%;" name="deptName" id="dept">
															<option value="">전체</option>
															<c:forEach items="${department}" var="departmentVO">
																<c:if test="${departmentVO.deptNum !=1 && departmentVO.deptNum !=2 }">
																	<option value="${departmentVO.deptName}" ${departmentVO.deptName eq param.deptName ? 'selected' :'' }>${departmentVO.deptName}</option>
																</c:if>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="col-4">
													<div class="form-group">
														<label >상태</label>
														<select class="select2" name="status" style="width: 100%;">
															<option value="">전체</option>
															<option value="1"${param.status eq 1 ?'selected' :''}>재직</option>
															<option value="2"${param.status eq 2 ?'selected' :''}>휴직</option>
															<option value="3"${param.status eq 3 ?'selected' :''}>퇴직</option>
														</select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-6">
													<div class="form-group">
														<label>교수 번호</label>
														<input type="text" class="form-control" name="username" placeholder="교수 번호를 입력하세요." value="${param.username }">
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
										<!-- 검색 조건 end -->
										
										<!-- 교수 목록 -->
								 		<table class="table table-hover text-nowrap" style="text-align : center;"  id="tableProfessor">
					              			<thead>
					                  			<tr>
					                      			<th style="width: 10%">쪽지</th>
					                      			<th style="width: 10%">사진</th>
					                       			<th style="width: 10%">교수 번호</th>
													<th style="width: 5%" class="text-center">이름</th>
					                     			<th style="width: 15%" class="text-center">담당 대학</th>
													<th style="width: 15%">담당 학과</th>
					                      			<th style="width: 15%">사무실</th>
					                       			<th style="width: 10%">연락처</th>
					                      			<th style="width: 10%">이메일</th>
					                      			<th style="width: 20%">상태</th>
					                  			</tr>
					              			</thead>
					              			<tbody>
					              				<c:forEach items="${list}" var="collegeVO">
								   	 				<tr>
														<c:set var="collegeName" value="${collegeVO.collegeName}"></c:set>
														<c:set var="collegeBuilding" value="${collegeVO.building}"></c:set>
														<c:forEach items="${collegeVO.departmentVOs}" var="departmentVO">
															<c:set var="department" value="${departmentVO.deptName}"></c:set>
															<c:forEach items="${departmentVO.professorVOs}" var="professorVO">
																<c:set var="professorName" value="${professorVO.name}"></c:set>
																<c:set var="professorPhone" value="${professorVO.phone}"></c:set>
																<c:set var="professorEmail" value="${professorVO.email}"></c:set>
																<c:set var="professorRoom" value="${professorVO.professorRoom}"></c:set>
																<c:set var="professorStatus" value="${professorVO.status}"></c:set>
																<c:set var="professoruserName" value="${professorVO.username}"></c:set>
																<c:set var="memberFiles" value="${professorVO.memberFilesVO.fileName }"></c:set>
																<tr>
																	<td>
								     	 								<sec:authentication property="principal.username" var="username"/>
											     	 					<a href="../chat/detail?roomSender=${username}&roomRecipient=${professorVO.username}"><i class="fa-regular fa-envelope fa-2xl" style="margin:30px 0 0 0;"></i></a>
								     	 							</td>
																	<td style="vertical-align:middle;">
											   	 						<c:if test="${empty memberFiles}">
													   	 					<img class="img" src="/images/profile.jpg" alt="User profile picture" width="60rem" height="60rem" style="border-radius:5px">
													   	 				</c:if>
													   	 				<c:if test="${not empty memberFiles}">
													   	 					<img class="img" src="/file/member/${memberFiles}" width="60rem" height="60rem" style="border-radius:5px">
													   	 				</c:if>	
											   	 					</td>
											   	 					<td style="vertical-align:middle;"><c:out value="${professoruserName}"></c:out></td>
																	<td style="vertical-align:middle;"><c:out value="${professorName}"></c:out></td>
																	<td style="vertical-align:middle;"><c:out value="${collegeName}"></c:out></td>	
																	<td style="vertical-align:middle;"><c:out value="${department}"></c:out></td>
																	<td style="vertical-align:middle;">
																		<c:out value="${collegeBuilding} "></c:out><c:out value="${professorRoom}"></c:out>호
																	</td>
																	<td style="vertical-align:middle;">
																		<c:out value="${fn:substring(fn:replace(professorPhone,'-',''), 0, 3)}"></c:out>-<c:out value="${fn:substring(fn:replace(professorPhone,'-',''), 3, 7)}"></c:out>-<c:out value="${fn:substring(fn:replace(professorPhone,'-',''), 7,11)}"></c:out>
																	</td>
																	<td style="vertical-align:middle;"><c:out value="${professorEmail}"></c:out></td>
																	
																	<td style="vertical-align:middle;">

																		<c:if test="${professorStatus eq 1}">재직</c:if>
																		<c:if test="${professorStatus eq 2}">휴직</c:if>
																		<c:if test="${professorStatus  eq 3}">퇴임</c:if>
																	</td>
																</tr>
															</c:forEach>
														</c:forEach>
													</tr>		
	   	 										</c:forEach>
	   	 									</tbody>
	   	 								</table>
	   	 								<!-- 교수 목록 -->
	   	 								
	   	 								<!-- pagination -->
			            	 			<div class="row g-3 my-3 justify-content-center" id="pagination">
											<ul class="pagination pagination-sm mx-auto">
												<c:if test="${pagination.pre}">
													<li class="page-item">
														<a class="page-link" href="./professorList?page=1&kind=${pagination.kind}&search=${pagination.search}" aria-label="Previous" data-board-page="1" style="color:#17a2b8;">
															<span aria-hidden="true">&laquo;</span>
														</a>
													</li>
												</c:if>
												<c:forEach begin="${pagination.startNum}" end="${pagination.lastNum}" var="i">
													<li class="page-item"><a class="page-link" href="./professorList?page=${i}&kind=${pagination.kind}&search=${pagination.search}" data-board-page="${i}" style="color:#17a2b8;">${i}</a></li>
												</c:forEach>
												<c:if test="${pagination.next }">
													<li class="page-item">
														<a class="page-link" href="./professorList?page=${pagination.totalPage}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Next" data-board-page="${pagination.totalPage}" style="color:#17a2b8;">
															<span aria-hidden="true">&raquo;</span>
														</a>
													</li>
												</c:if>
											</ul>
										</div>
										<!-- pagination -->
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer 적용 -->
	<c:import url="../temp/footer.jsp"></c:import>
	<!-- Footer 끝 -->
<!-- ./wrapper -->
</body>
	<script>
	    $(function () {
	      $('.select2').select2()
	    });
	</script>
</html>