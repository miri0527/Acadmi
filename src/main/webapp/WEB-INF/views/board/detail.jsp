<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title>Acadmi</title>
	<!-- CSS/favicon 적용 -->
	<c:import url="../temp/style.jsp"></c:import>
	<!-- CSS/favicon 끝 -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
</head>
<body class="hold-transition sidebar-mini layout-fixed">

	<div class="wrapper">
		<sec:authentication property="principal.username" var="userName" />
					
		<sec:authentication property="principal.category" var="category" />

		<!-- Header 적용 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
	     	<c:import url="../temp/administrator_header.jsp"></c:import>
	  	</sec:authorize>
	  	
	  	<sec:authorize access="hasRole('ROLE_ADMINISTRATOR')">
	     	<c:import url="../temp/administrator_header.jsp"></c:import>
	  	</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_PROFESSOR')">
			<c:choose>
				<c:when test="${board eq 'lectureNotice'}">
					<c:import url="../temp/lecture_header.jsp"></c:import>
				</c:when>
				<c:when test="${board eq 'lectureQna'}">
					<c:import url="../temp/lecture_header.jsp"></c:import>
				</c:when>
				<c:otherwise>
					<c:import url="../temp/professor_header.jsp"></c:import>
				</c:otherwise>
			</c:choose>
		</sec:authorize>
	
		<sec:authorize access="hasRole('ROLE_STUDENT')">
			<c:choose>
				<c:when test="${board eq 'lectureNotice'}">
					<c:import url="../temp/lecture_header.jsp"></c:import>
				</c:when>
				<c:when test="${board eq 'lectureQna'}">
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
					
						<div class="card" style="padding-top: 10px; margin-top: 10px;">
							<div class="card-body">
								<div class="row">
									<table class="table" data-board-name="${board}">
										<tr>
										    <th width=20% class="text-center warning" style="background-color:#f8f9fa">번호</th>
										    <td width=30% class="text-center">${boardVO.num}</td>
										    <th width=20% class="text-center warning" style="background-color:#f8f9fa; border-bottom: 1px solid #d6d6cd;">작성일</th>
									        <td width=30% class="text-center" style="border-bottom: 1px solid #d6d6cd;">${boardVO.regDate}</td>
									    </tr>     
										 <tr>
											<th width=20% class="text-center warning" style="background-color:#f8f9fa">작성자</th>
											<td width=30% class="text-center">${boardVO.writer}</td>
											<c:if test="${board eq 'notice' or board eq 'lectureNotice'}">
												<th width=20% class="text-center warning" style="background-color:#f8f9fa; border-bottom: 1px solid #d6d6cd;">수정일</th>
												<td width=30% class="text-center" style="border-bottom: 1px solid #d6d6cd;">${boardVO.modifyDate}</td>
											</c:if>
								         </tr>
										 <tr>
									         <th width=20% class="text-center warning" style="background-color:#f8f9fa">제목</th>
									         <td colspan="3">
									         	<div style="margin-left: 20px;">${boardVO.title}</div>
									         </td>
								         </tr>
								         <tr>
									         <th width=20% class="text-center warning" style="background-color:#f8f9fa">첨부 파일</th>
									         <td colspan="3">
									         	<div style="margin-left: 20px;">
										         	<c:forEach items="${boardVO.fileVOs}" var="fileVO">
														<img class="fileIcon" width="30" height="30" src="/images/fileIcon.png" style="margin-right: 5px">
								                        <a href="./fileDown?fileNum=${fileVO.fileNum}">${fileVO.oriName}</a>
							                    	</c:forEach>
						                    	</div>
									         </td>
								         </tr>
				         
								         <tr>
									         <td colspan="4" class="text-left" valign="top" height="200">
									         	<pre style="white-space: pre-wrap;border:none;background-color: white; font-size: 23px;">${boardVO.contents}</pre>
									         </td>   
								         </tr>
					
										<tr>
								          <td colspan="4" class="text-right" style="border: none;">
									        <c:if test="${board eq 'qna'}">
												<c:if test="${num ne 2}">
													<c:if test="${boardVO.step ne 1}">
														<c:if test="${category == 0}">
															<a href="./reply?num=${boardVO.num}" class="btn btn-primary" style="margin-right: 5px">답글</a>
														</c:if>
													</c:if>
												</c:if>
											</c:if>
											
											<c:if test="${board eq 'lectureQna'}">
												<c:if test="${num ne 2}">
													<c:if test="${boardVO.step ne 1}">
														<c:if test="${category == 1}">
															<a href="./reply?num=${boardVO.num}&lectureNum=${boardVO.lectureNum}" class="btn btn-primary" style="margin-right: 5px">답글</a>
														</c:if>
													</c:if>
												</c:if>
											</c:if>
											
											<c:if test="${board eq 'notice'}">
												<sec:authorize access="hasRole('ROLE_ADMINISTRATOR')">
													<a id="delete" data-board-num="${boardVO.num}" data-board-name="${board}" class="btn btn-danger float-right">삭제</a>
													<a href="./update?num=${boardVO.num}" id="update" class="btn btn-info float-right" style="margin-right: 5px">수정</a>
												</sec:authorize>
											</c:if>
											<c:if test="${userName eq boardVO.writer &&board eq 'qna'}">
												<a id="delete" data-board-num="${boardVO.num}" data-board-name="${board}" class="btn btn-danger float-right">삭제</a>
												<a href="./update?num=${boardVO.num}" id="update" class="btn btn-info float-right" style="margin-right: 5px">수정</a>
											</c:if>
								            <c:if test="${userName eq boardVO.writer &&(board eq 'lectureQna' || board eq 'lectureNotice')}">
												<a id="delete" data-board-num="${boardVO.num}" data-board-name="${board}" data-board-lectureNum="${boardVO.lectureNum}" class="btn btn-danger float-right">삭제</a>
												<a href="./update?num=${boardVO.num}" id="update" class="btn btn-info float-right" style="margin-right: 5px">수정</a>
											</c:if>
											<c:if test="${board eq 'qna' || board eq 'notice'}">
								            	<a href="./list" class="btn btn-light float-right" style="margin-right: 5px">목록</a>
								            </c:if>
								            <c:if test="${board eq 'lectureQna' || board eq 'lectureNotice'}">
								            	<a href="./list?lectureNum=${boardVO.lectureNum}" class="btn btn-light float-right" style="margin-right: 5px">목록</a>
								            </c:if>
								          </td>
								        </tr>
									</table>
						  		</div>
							</div>
						</div>
			
						<c:if test="${board eq 'qna' || board eq 'lectureQna'}">
							<c:if test="${num eq 2}">
								<div class="card" style="padding-top: 10px; margin-top: 3px;">
									<div class="card-body">
										<div class="row">
											<div class="col-12">
												<div class="post" style="margin-top: 20px;">
													<div class="user-block">
														<div class="replyDetail" data-num-id="${boardVO.num}">
																				
														</div>
													</div>
												</div> 
											</div>
						  				</div>
						  			</div>
						  		</div>
					  		</c:if>
					  	</c:if>	  		
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
	<script src="/js/board/qnaReply.js"></script>
</body>
</html>