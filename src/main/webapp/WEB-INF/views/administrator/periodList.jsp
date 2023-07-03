<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<style type="text/css">
		#row {
		  display: flex;
		  justify-content: center; /* 가로 방향으로 가운데 정렬 */
		  align-items: center; /* 세로 방향으로 가운데 정렬 */
		}
		
		.col-custom {
		  flex-grow: 1;
		}
	</style>
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
		
		<div class="content-wrapper">
			<div class="col">
				<!-- header start -->
				<div class="row">
					<div class="col mt-3">
						<div class="card">
							<h3 class="my-3 mx-3">기간 조회</h3>
						</div>
					</div>
				</div>
				<!-- header end -->
				
					<!-- Search -->
						
				
				<!-- Default box -->
				<div class="card">
					<div class="card-header">
					
				<form action="./periodList" method="get">
					<div class="row justify-content-center mx-auto mt-2 mb-4">
						<div class="col-3">
							<label>수강 연도</label>
							<select class="select2" style="width: 100%;" name="year">
								<option value="">전체</option>
		               				<c:forEach items="${year}" var="year">
										<option value="${year}"${year eq param.year ? 'selected' : '' }>${year }</option>
									</c:forEach>
		               				<%-- <c:forEach  begin="${map['min']}" end="${map['max']}" varStatus="i">
		               					<option value="${i.index}" ${lectureVO.year eq i.index  ? 'selected' : ''}>${i.index}</option>
		               				</c:forEach> --%>
							</select>
						</div>
						<div class="col-3">
							<label>수강 학기</label>
							<select class="select2" style="width: 100%;" name="semester">
								<option value="">전체</option>
               					<option value="1" ${param.semester eq 1 ? 'selected' : '' }>1학기</option>
               					<option value="2" ${param.semester eq 2 ? 'selected' : '' }>2학기</option>
							</select>
						</div>
						<button type="submit" class="btn btn-default" style="height: 50%; margin-top: auto;">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</form>
					
					</div>
					
					   <!-- Default box -->
					   <div class="card-body p-0">	
					   		<table class="table table-hover text-nowrap" style="text-align : center;">
					   			<thead>
					   				<tr>
					   					<th>수강연도</th>
					   					<th>학기</th>
					   					<th>수강 신청 시작일</th>
					   					<th>수강 신청 종료일</th>
					   					<th>장바구니 시작일</th>
					   					<th>장바구니 종료일</th>
					   					<th>강의 등록 시작일</th>
					   					<th>강의 등록 종료일</th>
					   					<th></th>
					   					
					   				</tr>
					   			</thead>
					   			<tbody>
					   				<c:forEach items="${list}" var="periodVO">
					   					<tr class="container">
					   						<td>${periodVO.year }</td>
					   						<td>${periodVO.semester }</td>
					   						<td>${periodVO.applicationStart}</td>
					   						<td>${periodVO.applicationEnd }</td>
					   						<td>${periodVO.favoriteStart }</td>
					   						<td>${periodVO.favoriteEnd }</td>
					   						<td>${periodVO.registrationStart }</td>
					   						<td>${periodVO.deadline }</td>
					   						<td><a href="./periodUpdate?year=${periodVO.year}&semester=${periodVO.semester}"> <button class="btn btn-primary">기간 수정</button></a></td>
					   						
					   					</tr>
					   				</c:forEach>
					   			</tbody>
					   		</table>
					   </div>
				<!-- Pagination -->
				 <div class="row g-3 my-3 justify-content-center" id="pagination">
					<ul class="pagination pagination-sm mx-auto">
						<c:if test="${pagination.pre}">
							<li class="page-item">
								<a class="page-link" href="./periodList?page=1&kind=${pagination.kind}&search=${pagination.search}" aria-label="Previous" data-board-page="1" style="color:#17a2b8;">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>
						
						<c:forEach begin="${pagination.startNum}" end="${pagination.lastNum}" var="i">
							<li class="page-item"><a class="page-link" href="./periodList?page=${i}&kind=${pagination.kind}&search=${pagination.search}" data-board-page="${i}" style="color:#17a2b8;">${i}</a></li>
						</c:forEach>
						
						<c:if test="${pagination.next }">
							<li class="page-item">
								<a class="page-link" href="./periodList?page=${pagination.totalPage}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Next" data-board-page="${pagination.totalPage}" style="color:#17a2b8;">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:if>
					</ul>
				
				</div>
					   
				 <!-- /.card-body -->
				 <div class="wrapper" style="margin : 0 20px 20px 0;">
					 <a href="./periodAdd"><button type="button" id="periodAdd" class="btn btn-info" style="float : right;">기간 등록</button></a>
				</div>
				</div>
				
				<!-- /.card -->
				
				
			</div>
		</div>
	</div>
	<!-- Footer 적용 -->
	<c:import url="../temp/footer.jsp"></c:import>
	<!-- Footer 끝 -->
<script type="text/javascript">
$(function () {
    $('.select2').select2()
  });

</script>	
</body>
</html>