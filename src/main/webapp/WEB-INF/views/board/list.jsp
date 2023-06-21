<%@page import="com.acadmi.board.lectureNotice.LectureNoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
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
			<c:choose>
				<c:when test="${board eq 'lectureNotice' || board eq 'lectureQna'}">
					<c:import url="../temp/lecture_header.jsp"></c:import>
				</c:when>
				<c:otherwise>
					<c:import url="../temp/professor_header.jsp"></c:import>
				</c:otherwise>
			</c:choose>
		</sec:authorize>
	
		<sec:authorize access="hasRole('ROLE_STUDENT')">
			<c:choose>
				<c:when test="${board eq 'lectureNotice' || board eq 'lectureQna'}">
					<c:import url="../temp/lecture_header.jsp"></c:import>
				</c:when>
				<c:otherwise>
					<c:import url="../temp/student_header.jsp"></c:import>
				</c:otherwise>
			</c:choose>
		</sec:authorize>	
		<!-- Header 끝 -->

		<!-- Main Contents -->
		<div class="content-wrapper">
			<div class="container-fluid">
				<div class="row">

					<!-- 2레벨 Sidebar 적용 -->
					<c:if test="${board eq 'lectureNotice' || board eq 'lectureQna'}">
						<sec:authorize access="hasRole('ROLE_PROFESSOR')">
							<c:import url="../temp/sidebar/professor_lecture.jsp"></c:import>
						</sec:authorize>
									
						<sec:authorize access="hasRole('ROLE_STUDENT')">
							<c:import url="../temp/sidebar/student_lecture_main.jsp"></c:import>
						</sec:authorize>
					</c:if>
					<!-- 2레벨 Sidebar 끝 -->
				
					<!-- Contents -->
					<div class="col">
					
						<!-- header start -->
						<div class="row" style="padding-top:20px">
							<div class="col-12">
								<div class="card">
									<h3 class="my-3 mx-3">
										<c:if test="${board eq 'notice'}">
											공지사항
										</c:if>
										<c:if test="${board eq 'qna'}">
											질의응답
										</c:if>
										<c:if test="${board eq 'lectureNotice'}">
											강의 공지사항
										</c:if>
										<c:if test="${board eq 'lectureQna'}">
											강의 질의응답
										</c:if>
									</h3>
								</div>
							</div>
						</div>
						
						<div class="card">
							<div class="card-header">
								<!-- search -->
								<c:if test="${board eq 'qna' || board eq 'notice'}">
									<form class="row g-3 " action="./list" method="get" id="searchForm">
										<div class="col-auto ml-auto">
											<div class="input-group" style="relative; top: 9px;">
												<input type="hidden" name="page" value="1" id="page">
												<div style="margin-right: 5px;">
													<label for="kind" class="visually-hidden"></label>
													<select class="form-select select2" name="kind" id="kind" aria-label="Default select example" style="width: 100px;">
														<option value="title" ${pagination.kind eq 'title' ? 'selected' :''}>제목</option>
														<option value="contents" ${pagination.kind eq 'contents' ?'selected':''}>내용</option>
													</select>
												</div>
													
												<div class="form-group">
													<div class="input-group">
														<input type="text" class="form-control" placeholder="검색어를 입력하세요." id="search" name="search" value="${pagination.search}">
														<div class="input-group-append">
															<button type="submit" class="btn btn-default" id="submit">
																<i class="fa fa-search"></i>
															</button>
														</div>
													</div>
												</div>	
											</div>
										</div>
									</form>
								</c:if>
									
								<c:if test="${board eq 'lectureQna' || board eq 'lectureNotice'}">
									<form class="row g-3 " action="./list" method="get" id="searchForm">
										<div class="col-auto ml-auto">
											<div class="input-group" style="relative; top: 9px;">
												<input type="hidden" name="page" value="1" id="page">
												<div style="margin-right: 5px;">
													<label for="kind" class="visually-hidden"></label>
													<select class="form-select select2" name="kind" id="kind" aria-label="Default select example" style="width: 100px;">
														<option value="title" ${pagination.kind eq 'title' ? 'selected' :''}>제목</option>
														<option value="contents" ${pagination.kind eq 'contents' ?'selected':''}>내용</option>
													</select>
												</div>
												
												<div class="form-group">
													<div class="input-group" >
														<input type="text" class="form-control" placeholder="검색어를 입력하세요." id="search" name="search" value="${pagination.search}">
														<div class="input-group-append">
															<button type="submit" class="btn btn-default lectureSearch" id="submit">
																<i class="fa fa-search"></i>
															</button>
														</div>
													</div>
												</div>										
											</div>
										</div>
									</form>
								</c:if>
								</div>
								<!-- search end -->
							
								<!-- header end -->
								<div class="card-body p-0">
									<table class="table table-hover text-nowrap" data-board-name="${board}">
										<thead class="table-light" style="text-align: center; line-height: 22.5px;">
											<tr>
												<th>No</th>
												<th>제목</th>
												<c:if test="${board eq 'qna' || board eq 'lectureQna'}">
													<th>작성자</th>
												</c:if>
												<th>등록일</th>
												<c:if test="${board eq 'notice' || board eq 'lectureNotice'}">
													<th>조회수</th>
												</c:if>
											</tr>
										</thead>
										<c:if test="${board eq 'notice'}">
											<tbody class="importantList">		
										</c:if>
									
										<sec:authentication property="principal.username" var="userName" />
													
										<sec:authentication property="principal.category" var="category" />
													
										<c:forEach items="${list}" var="dto">
											<c:if test="${board eq 'notice'}">
												<tr class="check-item" data-num-important="${dto.important}" style="text-align: center; line-height: 22.5px;">
													<td class="noticeNum" data-num-id="${dto.num}">${dto.num}</td>
													<td class="d-flex align-items-center">								
														<a class="title" href="./detail?num=${dto.num}">${dto.title}</a>
														<c:forEach items="${dto.fileVOs}" var="fileVO">
															<c:if test="${fileVO.oriName ne null}">
																<img class="fileIcon" width="25" height="25" src="/images/fileIcon.png" style="margin-left: 5px">
															</c:if>
														</c:forEach>
													</td>
													<td>${dto.regDate}</td>
													<td>${dto.hit}</td>
												</tr>
											</c:if>
													
											<c:if test="${board eq 'qna'}">
												<tr class="check-item" style="text-align: center;">
													<td class="qnaNum" data-num-id="${dto.num}">${dto.num}</td>
													<td class="d-flex align-items-center">
														<c:catch>
															<c:forEach begin="1" end="${dto.depth}">
																<img class="fileIcon2" width="20" height="20" src="/images/reply.png" style="margin-right: 5px">
															</c:forEach>							
														</c:catch>					
														<c:if test="${dto.writer eq userName}">			
															<a class="title" href="./detail?num=${dto.num}">${dto.title}</a>
														</c:if>
														<c:if test="${dto.writer ne userName}">			
															<span>비밀글입니다.</span>
														</c:if>
														<c:forEach items="${dto.fileVOs}" var="fileVO">
															<c:if test="${fileVO.oriName ne null}">
																<img class="fileIcon" width="25" height="25" src="/images/fileIcon.png" style="margin-left: 5px">
															</c:if>
														</c:forEach>
													</td>
													<td>
														<c:forEach items="${students}" var="student">
															<c:if test="${student.username eq dto.writer}">
																${student.name}
															</c:if>
														</c:forEach>
														<c:forEach items="${professors}" var="professor">
															<c:if test="${professor.username eq dto.writer}">
																${professor.name} 교수님
															</c:if>
														</c:forEach>
														<c:forEach items="${administrators}" var="administrator">
															<c:if test="${administrator.username eq dto.writer}">
																관리자
															</c:if>
														</c:forEach>
													</td>
													<td>${dto.regDate}</td>
												</tr>
											</c:if>	
																					
											<c:if test="${board eq 'lectureNotice'}">
												<tr class="check-item" style="text-align: center; line-height: 22.5px;">
													<td class="noticeNum" data-num-id="${dto.num}" data-lectureNum-id="${dto.lectureNum}">${dto.num}</td>
													<td class="d-flex align-items-center">								
														<a class="title" href="./detail?num=${dto.num}">${dto.title}</a>
														<c:forEach items="${dto.fileVOs}" var="fileVO">
															<c:if test="${fileVO.oriName ne null}">
																<img class="fileIcon" width="25" height="25" src="/images/fileIcon.png" style="margin-left: 5px">
															</c:if>
														</c:forEach>
													</td>	
													<td>${dto.regDate}</td>
													<td>${dto.hit}</td>
												</tr>
											</c:if>
													
											<c:if test="${board eq 'lectureQna'}">										
												<tr class="check-item" style="text-align: center; line-height: 22.5px;">
													<td class="qnaNum" data-num-id="${dto.num}" data-lectureNum-id="${dto.lectureNum}">${dto.num}</td>
													<td class="d-flex align-items-center">
														<c:catch>
															<c:forEach begin="1" end="${dto.depth}">
																<img class="fileIcon2" width="20" height="20" src="/images/reply.png" style="margin-right: 5px">
															</c:forEach>							
														</c:catch>
																											 																				 
														<c:if test="${dto.secret == 1 && dto.writer ne userName}">																	
															<c:choose>
															    <c:when test="${category == 1}">
															        <a class="title" href="./detail?num=${dto.num}">${dto.title}</a>
															    </c:when>
															    <c:otherwise>
															        <a class="title" style="color:gray;">비밀글입니다.</a>	
															    </c:otherwise>
															</c:choose>																	
														</c:if>
																			
														<c:if test="${dto.secret == 1 && dto.writer eq userName}">
															<a class="title" href="./detail?num=${dto.num}">${dto.title}</a>						
														</c:if>		
																							
														<c:if test="${dto.secret == 0 || empty dto.secret}">		
															<a class="title" href="./detail?num=${dto.num}">${dto.title}</a>
														</c:if>
																
														<c:if test="${dto.secret == 1}">
															<img class="lockIcon" width="25" height="25" src="/images/lock.png" style="margin-left: 5px">
														</c:if>
																 
														<c:forEach items="${dto.fileVOs}" var="fileVO">
															<c:if test="${fileVO.oriName ne null}">
																<img class="fileIcon" width="25" height="25" src="/images/fileIcon.png" style="margin-left: 5px">						
															</c:if>
														</c:forEach>
													</td>			
													<td>
														<c:forEach items="${students}" var="student">
															<c:if test="${student.username eq dto.writer}">
																${student.name}
															</c:if>
														</c:forEach>
														<c:forEach items="${professors}" var="professor">
															<c:if test="${professor.username eq dto.writer}">
																${professor.name} 교수님
															</c:if>
														</c:forEach>
													</td>
													<td>${dto.regDate}</td>
												</tr>
											</c:if>	
										</c:forEach>
									</tbody>
								</table>
								
								<div class="col-12 float-right mr-2 my-3">
									<c:if test="${board eq 'notice'}">
										<sec:authorize access="hasRole('ROLE_ADMIN')">
								    		<a class="float-right btn btn-info" href="./add">작성</a>
								  		 </sec:authorize>
									</c:if>
											
									<c:if test="${board eq 'notice'}">
										<sec:authorize access="hasRole('ROLE_ADMINISTRATOR')">
								    		<a class="float-right btn btn-info" href="./add">작성</a>
								  		 </sec:authorize>
									</c:if>
											
									<c:if test="${board eq 'qna'}">
										<sec:authorize access="hasRole('ROLE_STUDENT')">
									   		<a class="float-right btn btn-info" href="./add">작성</a>
								  		 </sec:authorize>
									</c:if>
										   
									<c:if test="${board eq 'qna'}">
										<sec:authorize access="hasRole('ROLE_PROFESSOR')">
											<a class="float-right btn btn-info" href="./add">작성</a>
										</sec:authorize>
									</c:if>
											
									<c:if test="${board eq 'lectureNotice'}">
										<sec:authorize access="hasRole('ROLE_PROFESSOR')">
										   	<a class="float-right btn btn-info" href="./add?lectureNum=${pagination.lectureNum}">작성</a>
										</sec:authorize>
									</c:if>
											
									<c:if test="${board eq 'lectureQna'}">
										<sec:authorize access="hasRole('ROLE_STUDENT')">
											<a class="float-right btn btn-info" href="./add?lectureNum=${pagination.lectureNum}">작성</a>
										</sec:authorize>
									</c:if>
								</div>
							</div>
							
						<!-- pagination -->
						<div class="row justify-content-center mx-auto">
							<c:if test="${board eq 'qna' || board eq 'notice'}">
								<ul class="pagination pagination-sm">
									<c:if test="${pagination.pre}">
										<li class="page-item">
											<a class="page-link" href="./list?page=1&kind=${pagination.kind}&search=${pagination.search}" aria-label="Previous" data-board-page="1" style="color:#17a2b8;">
												<span aria-hidden="true">&laquo;</span>
											</a>
										</li>
									</c:if>
									<c:forEach begin="${pagination.startNum}" end="${pagination.lastNum}" var="i">
										<li class="page-item">
											<a class="page-link" href="./list?page=${i}&kind=${pagination.kind}&search=${pagination.search}" data-board-page="${i}" style="color:#17a2b8;">${i}</a>
										</li>
									</c:forEach>
									<c:if test="${pagination.next}">
										<li class="page-item">
											<a class="page-link" href="./list?page=${pagination.totalPage}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Next" data-board-page="${pagination.totalPage}" style="color:#17a2b8;">
												<span aria-hidden="true">&raquo;</span>
											</a>
										</li>
									</c:if>
								</ul>
							</c:if>						  	
						
							<c:if test="${board eq 'lectureQna' || board eq 'lectureNotice'}">	
								<div class="row lectureNums" data-lectureNum-id="${pagination.lectureNum}">
									<ul class="pagination">
										<c:if test="${pagination.pre}">
											<li class="page-item">
												<a class="page-link" href="./list?lectureNum=${pagination.lectureNum}&page=1&kind=${pagination.kind}&search=${pagination.search}" aria-label="Previous" data-board-page="1" style="color:#17a2b8;">
													<span aria-hidden="true">&laquo;</span>
												</a>
											</li>
										</c:if>
										<c:forEach begin="${pagination.startNum}" end="${pagination.lastNum}" var="i">
											<li class="page-item">
												<a class="page-link" href="./list?lectureNum=${pagination.lectureNum}&page=${i}&kind=${pagination.kind}&search=${pagination.search}" data-board-page="${i}" style="color:#17a2b8;">${i}</a>
											</li>
										</c:forEach>
										<c:if test="${pagination.next}">
											<li class="page-item">
												<a class="page-link" href="./list?lectureNum=${pagination.lectureNum}&page=${pagination.totalPage}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Next" data-board-page="${pagination.totalPage}" style="color:#17a2b8;">
													<span aria-hidden="true">&raquo;</span>
												</a>
											</li>
										</c:if>
									</ul>
								</div>	
							</c:if>		
						</div>
						<!-- pagination end -->
						
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
	
	<script src="/js/board/notice.js"></script>
	
	<script>
	  $(document).ready(function() {

	    $('.lectureSearch').on('click', function(event) {
	      event.preventDefault();
	      
	      let boardName = $(".table").attr("data-board-name");
	      
	      if(boardName == 'lectureNotice'){
	    	  let lectureNum = $(".lectureNums").attr("data-lectureNum-id");
	    	  let page = $(".page-link").attr("data-board-page");
		      let kind = $('#kind').val();
		      let search = $('#search').val();
		      
		      let newUrl = './list?lectureNum=' + lectureNum + "&page=" + page + "&kind=" + kind + "&search=" + search;
		      
		      window.location.href = newUrl;    	 
	      } else if (boardName == 'lectureQna') {
	    	  let lectureNum = $(".lectureNums").attr("data-lectureNum-id");
	    	  let page = $(".page-link").attr("data-board-page");
		      let kind = $('#kind').val();
		      let search = $('#search').val();
		          
		      let newUrl = './list?lectureNum=' + lectureNum + "&page=" + page + "&kind=" + kind + "&search=" + search;
		      
		      window.location.href = newUrl; 
	      } else {
	    	  console.log("게시판 없음")
	      }  
	    });
	  });
	  
	  $(function () {
	      $('.select2').select2()
	    });
	</script>
</body>
</html>