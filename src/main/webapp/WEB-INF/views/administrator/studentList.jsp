<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

</head>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="../temp/style.jsp"></c:import>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<title>Insert title here</title>
<style type="text/css">

	#pagination {
		 display: flex;
   	 	justify-content: center;
	
	}
	#tableStudent {
		width : 90%; 
	}
	h3 {
		margin : 40px;
	}
	.content {
		margin: 30px;
	}
	#add2 {
		float : right;
		clear : both;
		
	} 
	.card-title {
		margin : 20px 0 20px 40px;
	}
	.card-body{
		display: flex;
	  	justify-content: center;
	 	align-items: center;
	 	margin : 10px 0 30px 0;
	}
</style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
	<c:import url="../temp/administrator.jsp"></c:import>
	
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<!-- 2레벨 Sidebar 적용 -->
				
					<c:import url="../temp/sidebar/administrator_memberList.jsp"></c:import>
				
				<!-- 2레벨 Sidebar 끝 -->
				<div class="col" style="background-color : white;">
					<!-- header start -->
	               <div class="row" style="padding-top:10px">
	                  <div class="col-12">
	                     <div class="card">
	                        <h3 class="my-3 mx-3">학생 목록 조회</h3>
	                     </div>
	                  </div>
	               </div>
               <!-- header end -->
					
						<!-- Main content -->
				    <section class="content">
				
				      <!-- Default box -->
				      <div class="card">
				        <div class="card-header">
				          <h3 class="card-title">학생 조회</h3>
				
				          <div class="card-tools">
				            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
				              <i class="fas fa-minus"></i>
				            </button>
				          </div>
				          
				        </div>
				        <div class="card-body p-0">
				          <table class="table table-hover text-nowrap" style="text-align : center;"  id="tableStudent">
				              <thead>
				                  <tr>
				                      <th style="width: 10%">
				                          쪽지
				                      </th>
				                      <th style="width: 10%">
				                          사진
				                      </th>
				                       <th style="width: 15%">
				                      	  학과
				                      </th>
				                      <th style="width : 8%">
				                      	  학번
				                      </th>
				                      <th style="width: 8%" class="text-center">
				                          성명
				                      </th>
				                      <th style="width : 15%">
				                          연락처
				                      </th>
				                      <th style="width: 10%" class="text-center">
				                          단과대학
				                      </th>
				                     
				                      <th style="width:8%">
				                      	학년
				                      </th>
				                      <th style="width: 20%">
				                      	  학적상태
				                      </th>
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
     	 							<c:set var="memberFiles" value="${studentVO.memberFilesVO }"></c:set>
     	 						<tr>
     	 							
	     	 							<td>
	     	 								<sec:authentication property="principal.username" var="username"/>
				     	 					<a href="../chat/detail?roomSender=${username}&roomRecipient=${studentVO.username}"><i class="fa-regular fa-envelope fa-2xl" style="margin:30px 0 0 0;"></i></a>
	     	 							</td>
	     	 							<td>
	   	 									<img alt="" src="/file/${board}/${boardFileVO.fileName}" width="60rem" height="60rem">
	   	 								</td>
	   	 								<td><c:out value="${department}"></c:out></td>
	     	 							<td><c:out value="${studentUsername}"></c:out></td>
				     	 				<td><c:out value="${studentName}"></c:out></td>
				     	 				<td><c:out value="${studentPhone}"></c:out></td>
				     	 				<td><c:out value="${college}"></c:out></td>
				     	 				<td><c:out value="${studentGrade}"></c:out></td>
				     	 				<c:if test="${studentStatus eq 1}">
				     	 					<td>재학</td>
				     	 				</c:if>
				     	 				<c:if test="${studentStatus eq 2 }">
				     	 					<td>휴학</td>
				     	 				</c:if>
				     	 				<c:if test="${studentStatus eq 3 }">
				     	 					<td>퇴학</td>
				     	 				</c:if>
				     	 				<c:if test="${studentStatus eq 4 }">
				     	 					<td>졸업</td>
				     	 				</c:if>
				     	 				<c:if test="${studentStatus eq 5 }">
				     	 					<td>졸업유예</td>
				     	 				</c:if>
     	 						</tr>	
     	 						</c:forEach>
     	 					</c:forEach>
     	 				</tr>
     	 			</c:forEach>
				              </tbody>
				          </table>
				        </div>
				        <!-- /.card-body -->
				      </div>
				      <!-- /.card -->
				
				    </section>
			    	 <div class="row" style="margin: 20px auto;" id="pagination">
							<nav aria-label="Page navigation example">
								<ul class="pagination d-flex justify-content-center">
									<li class="page-item ${pagination.page eq 1? 'disabled' : '' }">
										<a class="page-link" href="./studentList?page=1&kind=${pagination.kind}&search=${pagination.search}" aria-label="Previous" data-board-page="1">
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
									<li class="page-item ${pagination.pre eq false ? 'disabled' : ''}">
										<a class="page-link" href="./studentList?page=${pagination.startNum-1}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Previous" data-board-page="${pagination.startNum-1}">
											<span aria-hidden="true">&lsaquo;</span>
										</a>
									</li>
									<c:forEach begin="${pagination.startNum}" end="${pagination.lastNum}" var="i">
										<li class="page-item"><a class="page-link" href="./studentList?page=${i}&kind=${pagination.kind}&search=${pagination.search}" data-board-page="${i}">${i}</a></li>
									</c:forEach>
									<li class="page-item ${pagination.next eq false ? 'disabled' : ''}">
										<a class="page-link" href="./studentList?page=${pagination.lastNum+1}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Next" data-board-page="${pagination.lastNum+1}">
											<span aria-hidden="true">&rsaquo;</span>
										</a>
									</li>
									<li class="page-item ${pagination.next eq totalPage ? 'disabled' : ''}">
										<a class="page-link" href="./studentList?page=${pagination.totalPage}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Next" data-board-page="${pagination.totalPage}">
											<span aria-hidden="true">&raquo;</span>
										</a>
									</li>
								</ul>
							</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

	
</body>
</html>