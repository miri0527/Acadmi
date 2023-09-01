<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/css/sidebar.css">
<style>
	a:hover{
		color : white;
	}
	
	.sidebar-dropdown-content .card .wrapper a {
		padding : 0px;
	}

</style>    
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Acadmi!</title>
	<!-- CSS/favicon 적용 -->
	<c:import url="../../../temp/style.jsp"></c:import>
	<!-- CSS/favicon 끝 -->
	
</head>
<body class="hold-transition si	debar-mini layout-fixed">
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
			<div class="content-fluid">
				<div class="row">
					<c:import url="../../../temp/sidebar/student_lecture_main.jsp"></c:import>
					
					<!-- Contents start -->
					<div class="col" style="margin-top : 30px; margin-left : 10px;">
						<div class="row">
							<form action="./list" id="search-form">
								<input type="hidden" name="lectureNum" value="${lecture.lectureNum}">
								<div class="card-title">
				          			
				               		<input type="text" name="reportName" style="width:220px;" id="reportName" value="${param.reportName}" placeholder="과제 검색"> 
				               		
				               		<button type="submit" class="btn btn-default ml-1" id="submit">
						            	<i class="fas fa-search"></i>
						            </button>
						              
				                </div>
				               
			                </form>	
		                </div>
		                
		                <div class="card" style="margin-top : 10px; ">
		                	
		                	<div class="sidebar-dropdown">
		                		<!-- Submenu_1 -->
		                		<c:if test="${empty list}">
		                			<button onclick="myFunction_5()" class="sidebar-menu">
										<i class="fas fa-angle-down fa-2xs"></i>&nbsp
										<span style="font-weight : bold;">과제</span>
									</button>
									<div class="card" style="background-color: #e9ecef; margin-left : 22px; margin-right : 50px;">
								        <div style="text-align: center; ">
								            <span>과제를 찾을 수 없습니다</span>
								        </div>
							        </div>
							    </c:if>
							  
		                		<c:if test="${not empty list}">
		                			<c:forEach items="${list}" var="reportRegistrationVO">
						            	<c:forEach items="${reportRegistrationVO.reportVOs}" var="reportVO">
						                <c:set var="order" value="${reportRegistrationVO.order}" />
						                <c:if test="${order eq 1}">
						                   <button onclick="myFunction_5()" class="sidebar-menu">
												<i class="fas fa-angle-down fa-2xs"></i>&nbsp
												<span style="font-weight : bold;">1차수</span>
											</button>
						                    <div id="submenu_5" class="sidebar-dropdown-content">
						                        <div class="card" style="background-color: #e9ecef; margin-left: 22px; margin-right: 50px;">
						                            <div class="wrapper" style="padding: 10px;">
						                                <div class="col">
						                                    <a href="./detail?lectureNum=${lecture.lectureNum}&registrationNum=${reportRegistrationVO.registrationNum}">
						                                        <span style="font-weight: bold; font-size: 20px;">${reportRegistrationVO.reportName}</span>
						                                    </a>
						                                </div>
						                                <div class="col">
						                                    <span style="font-weight: bold; font-size: 13px;">마감일</span>
						                                    <span style="font-weight: bold; font-size: 13px; padding-left: 10px;">
						                                        <fmt:formatDate value="${reportRegistrationVO.submissionDate}" type="both" pattern="yyyy년 MM월 dd일 a hh:mm" />
						                                    </span>
						                                    <c:if test="${reportVO.score ne null}">
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                        <span style="padding-left: 10px;">${reportVO.score}/${reportRegistrationVO.registrationScore}점</span>
						                                       
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 0}">
						                                        <span style="padding-left: 10px; font-size: 13px;">미채점</span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 1}">
						                                        <span style="padding-left: 10px; font-weight: bold; font-size: 13px;">채점 완료</span>
						                                    </c:if>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </c:if>
						                
						                <c:if test="${order eq 2}">
						                    <button onclick="myFunction_6()" class="sidebar-menu">
						                        <i class="fas fa-angle-down fa-2xs"></i>&nbsp
						                        <span style="font-weight: bold;">2차수</span>
						                    </button>
						                    <div id="submenu_6" class="sidebar-dropdown-content">
						                        <div class="card" style="background-color: #e9ecef; margin-left: 22px; margin-right: 50px;">
						                            <div class="wrapper" style="padding: 10px;">
						                                <div class="col">
						                                    <a href="./detail?lectureNum=${lecture.lectureNum}&registrationNum=${reportRegistrationVO.registrationNum}">
						                                        <span style="font-weight: bold; font-size: 20px;">${reportRegistrationVO.reportName}</span>
						                                    </a>
						                                </div>
						                                <div class="col">
						                                    <span style="font-weight: bold; font-size: 13px;">마감일</span>
						                                    <span style="font-weight: bold; font-size: 13px; padding-left: 10px;">
						                                        <fmt:formatDate value="${reportRegistrationVO.submissionDate}" type="both" pattern="yyyy년 MM월 dd일 a hh:mm" />
						                                    </span>
						                                    <c:if test="${reportVO.score ne null}">
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                        <span style="padding-left: 10px;">${reportVO.score}/${reportRegistrationVO.registrationScore}점</span>
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 0}">
						                                        <span style="padding-left: 10px; font-size: 13px;">미채점</span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 1}">
						                                        <span style="padding-left: 10px; font-weight: bold; font-size: 13px;">채점 완료</span>
						                                    </c:if>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </c:if>
						                
						                <c:if test="${order eq 3}">
						                    <button onclick="myFunction_7()" class="sidebar-menu">
						                        <i class="fas fa-angle-down fa-2xs"></i>&nbsp
						                        <span style="font-weight: bold;">3차수</span>
						                    </button>
						                    <div id="submenu_7" class="sidebar-dropdown-content">
						                        <div class="card" style="background-color: #e9ecef; margin-left: 22px; margin-right: 50px;">
						                            <div class="wrapper" style="padding: 10px;">
						                                <div class="col">
						                                    <a href="./detail?lectureNum=${lecture.lectureNum}&registrationNum=${reportRegistrationVO.registrationNum}">
						                                        <span style="font-weight: bold; font-size: 20px;">${reportRegistrationVO.reportName}</span>
						                                    </a>
						                                </div>
						                                <div class="col">
						                                    <span style="font-weight: bold; font-size: 13px;">마감일</span>
						                                    <span style="font-weight: bold; font-size: 13px; padding-left: 10px;">
						                                        <fmt:formatDate value="${reportRegistrationVO.submissionDate}" type="both" pattern="yyyy년 MM월 dd일 a hh:mm" />
						                                    </span>
						                                    <c:if test="${reportVO.score ne null}">
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                        <span style="padding-left: 10px;">${reportVO.score}/${reportRegistrationVO.registrationScore}점</span>
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 0}">
						                                        <span style="padding-left: 10px; font-size: 13px;">미채점</span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 1}">
						                                        <span style="padding-left: 10px; font-weight: bold; font-size: 13px;">채점 완료</span>
						                                    </c:if>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </c:if>
						                
						                <c:if test="${order eq 4}">
						                    <button onclick="myFunction_8()" class="sidebar-menu">
						                        <i class="fas fa-angle-down fa-2xs"></i>&nbsp
						                        <span style="font-weight: bold;">4차수</span>
						                    </button>
						                    <div id="submenu_8" class="sidebar-dropdown-content">
						                        <div class="card" style="background-color: #e9ecef; margin-left: 22px; margin-right: 50px;">
						                            <div class="wrapper" style="padding: 10px;">
						                                <div class="col">
						                                    <a href="./detail?lectureNum=${lecture.lectureNum}&registrationNum=${reportRegistrationVO.registrationNum}">
						                                        <span style="font-weight: bold; font-size: 20px;">${reportRegistrationVO.reportName}</span>
						                                    </a>
						                                </div>
						                                <div class="col">
						                                    <span style="font-weight: bold; font-size: 13px;">마감일</span>
						                                    <span style="font-weight: bold; font-size: 13px; padding-left: 10px;">
						                                        <fmt:formatDate value="${reportRegistrationVO.submissionDate}" type="both" pattern="yyyy년 MM월 dd일 a hh:mm" />
						                                    </span>
						                                    <c:if test="${reportVO.score ne null}">
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                        <span style="padding-left: 10px;">${reportVO.score}/${reportRegistrationVO.registrationScore}점</span>
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 0}">
						                                        <span style="padding-left: 10px; font-size: 13px;">미채점</span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 1}">
						                                        <span style="padding-left: 10px; font-weight: bold; font-size: 13px;">채점 완료</span>
						                                    </c:if>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </c:if>
						                
						                <c:if test="${order eq 5}">
						                    <button onclick="myFunction_9()" class="sidebar-menu">
						                        <i class="fas fa-angle-down fa-2xs"></i>&nbsp
						                        <span style="font-weight: bold;">5차수</span>
						                    </button>
						                    <div id="submenu_9" class="sidebar-dropdown-content">
						                        <div class="card" style="background-color: #e9ecef; margin-left: 22px; margin-right: 50px;">
						                            <div class="wrapper" style="padding: 10px;">
						                                <div class="col">
						                                    <a href="./detail?lectureNum=${lecture.lectureNum}&registrationNum=${reportRegistrationVO.registrationNum}">
						                                        <span style="font-weight: bold; font-size: 20px;">${reportRegistrationVO.reportName}</span>
						                                    </a>
						                                </div>
						                                <div class="col">
						                                    <span style="font-weight: bold; font-size: 13px;">마감일</span>
						                                    <span style="font-weight: bold; font-size: 13px; padding-left: 10px;">
						                                        <fmt:formatDate value="${reportRegistrationVO.submissionDate}" type="both" pattern="yyyy년 MM월 dd일 a hh:mm" />
						                                    </span>
						                                    <c:if test="${reportVO.score ne null}">
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                        <span style="padding-left: 10px;">${reportVO.score}/${reportRegistrationVO.registrationScore}점</span>
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 0}">
						                                        <span style="padding-left: 10px; font-size: 13px;">미채점</span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 1}">
						                                        <span style="padding-left: 10px; font-weight: bold; font-size: 13px;">채점 완료</span>
						                                    </c:if>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </c:if>
						                
						                <c:if test="${order eq 6}">
						                    <button onclick="myFunction_10()" class="sidebar-menu">
						                        <i class="fas fa-angle-down fa-2xs"></i>&nbsp
						                        <span style="font-weight: bold;">6차수</span>
						                    </button>
						                    <div id="submenu_10" class="sidebar-dropdown-content">
						                        <div class="card" style="background-color: #e9ecef; margin-left: 22px; margin-right: 50px;">
						                            <div class="wrapper" style="padding: 10px;">
						                                <div class="col">
						                                    <a href="./detail?lectureNum=${lecture.lectureNum}&registrationNum=${reportRegistrationVO.registrationNum}">
						                                        <span style="font-weight: bold; font-size: 20px;">${reportRegistrationVO.reportName}</span>
						                                    </a>
						                                </div>
						                                <div class="col">
						                                    <span style="font-weight: bold; font-size: 13px;">마감일</span>
						                                    <span style="font-weight: bold; font-size: 13px; padding-left: 10px;">
						                                        <fmt:formatDate value="${reportRegistrationVO.submissionDate}" type="both" pattern="yyyy년 MM월 dd일 a hh:mm" />
						                                    </span>
						                                    <c:if test="${reportVO.score ne null}">
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                        <span style="padding-left: 10px;">${reportVO.score}/${reportRegistrationVO.registrationScore}점</span>
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 0}">
						                                        <span style="padding-left: 10px; font-size: 13px;">미채점</span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 1}">
						                                        <span style="padding-left: 10px; font-weight: bold; font-size: 13px;">채점 완료</span>
						                                    </c:if>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </c:if>
						                
						                <c:if test="${order eq 7}">
						                    <button onclick="myFunction_11()" class="sidebar-menu">
						                        <i class="fas fa-angle-down fa-2xs"></i>&nbsp
						                        <span style="font-weight: bold;">7차수</span>
						                    </button>
						                    <div id="submenu_11" class="sidebar-dropdown-content">
						                        <div class="card" style="background-color: #e9ecef; margin-left: 22px; margin-right: 50px;">
						                            <div class="wrapper" style="padding: 10px;">
						                                <div class="col">
						                                    <a href="./detail?lectureNum=${lecture.lectureNum}&registrationNum=${reportRegistrationVO.registrationNum}">
						                                        <span style="font-weight: bold; font-size: 20px;">${reportRegistrationVO.reportName}</span>
						                                    </a>
						                                </div>
						                                <div class="col">
						                                    <span style="font-weight: bold; font-size: 13px;">마감일</span>
						                                    <span style="font-weight: bold; font-size: 13px; padding-left: 10px;">
						                                        <fmt:formatDate value="${reportRegistrationVO.submissionDate}" type="both" pattern="yyyy년 MM월 dd일 a hh:mm" />
						                                    </span>
						                                    <c:if test="${reportVO.score ne null}">
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                        <span style="padding-left: 10px;">${reportVO.score}/${reportRegistrationVO.registrationScore}점</span>
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 0}">
						                                        <span style="padding-left: 10px; font-size: 13px;">미채점</span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 1}">
						                                        <span style="padding-left: 10px; font-weight: bold; font-size: 13px;">채점 완료</span>
						                                    </c:if>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </c:if>
						                
						                <c:if test="${order eq 8}">
						                    <button onclick="myFunction_12()" class="sidebar-menu">
						                        <i class="fas fa-angle-down fa-2xs"></i>&nbsp
						                        <span style="font-weight: bold;">8차수</span>
						                    </button>
						                    <div id="submenu_12" class="sidebar-dropdown-content">
						                        <div class="card" style="background-color: #e9ecef; margin-left: 22px; margin-right: 50px;">
						                            <div class="wrapper" style="padding: 10px;">
						                                <div class="col">
						                                    <a href="./detail?lectureNum=${lecture.lectureNum}&registrationNum=${reportRegistrationVO.registrationNum}">
						                                        <span style="font-weight: bold; font-size: 20px;">${reportRegistrationVO.reportName}</span>
						                                    </a>
						                                </div>
						                                <div class="col">
						                                    <span style="font-weight: bold; font-size: 13px;">마감일</span>
						                                    <span style="font-weight: bold; font-size: 13px; padding-left: 10px;">
						                                        <fmt:formatDate value="${reportRegistrationVO.submissionDate}" type="both" pattern="yyyy년 MM월 dd일 a hh:mm" />
						                                    </span>
						                                    <c:if test="${reportVO.score ne null}">
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                        <span style="padding-left: 10px;">${reportVO.score}/${reportRegistrationVO.registrationScore}점</span>
						                                        <span style="border-right: 1px solid black; padding-left: 10px;"></span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 0}">
						                                        <span style="padding-left: 10px; font-size: 13px;">미채점</span>
						                                    </c:if>
						                                    <c:if test="${reportVO.grading == 1}">
						                                        <span style="padding-left: 10px; font-weight: bold; font-size: 13px;">채점 완료</span>
						                                    </c:if>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </c:if>
						                
						            </c:forEach>
						        </c:forEach>
							</c:if>
								
							</div>		
		                </div>
		             </div>
					 
				</div>
				
		</div>
	</div>

</div>
<script type="text/javascript" src="/js/student/lecture/report/list.js"></script>
<script type="text/javascript">
 	function myFunction_5() {
	    document.getElementById("submenu_5").classList.toggle("show");
	}
	function myFunction_6() {
	    document.getElementById("submenu_6").classList.toggle("show");
	}
	function myFunction_7() {
	    document.getElementById("submenu_7").classList.toggle("show");
	}
	function myFunction_8() {
	    document.getElementById("submenu_8").classList.toggle("show");
	}
	function myFunction_9() {
	    document.getElementById("submenu_9").classList.toggle("show");
	}
	function myFunction_10() {
	    document.getElementById("submenu_10").classList.toggle("show");
	}
	function myFunction_11() {
	    document.getElementById("submenu_11").classList.toggle("show");
	}
	function myFunction_12() {
	    document.getElementById("submenu_12").classList.toggle("show");
	} 

</script>
</body>
</html>