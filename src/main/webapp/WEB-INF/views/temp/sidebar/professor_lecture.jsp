<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<link rel="stylesheet" href="/css/sidebar.css">

<div class="sidebar-dropdown" style="padding-top:70px;">

	<!-- Menu -->
	
	<!-- 더 많은 개수의 submenu가 필요할 경우
	필요한 수 만큼 복사하고 div 태그의 아이디 'submenu_숫자' 형식으로 수정하여 사용하면 됨 -->
	<!-- Submenu_1 -->
	<button onclick="myFunction_1()" class="sidebar-menu">
		<i class="fas fa-angle-down fa-2xs"></i>&nbsp
		강의 정보
	</button>
	<div id="submenu_1" class="sidebar-dropdown-content">
		<a href="/lecture/info?lectureNum=${lecture.lectureNum}" id="professorLectureDetail">강의 상세</a>
		<c:choose>
			<c:when test="${exists==1}">
				<a href="/lecture/syllabusDetail?lectureNum=${lecture.lectureNum}" id="professorSyllabus">강의 계획서</a>
			</c:when>
			<c:otherwise>
				<a href="/lecture/syllabusAdd?lectureNum=${lecture.lectureNum}" id="professorSyllabus">강의 계획서</a>
			</c:otherwise>
		</c:choose>
		<a href="/lecture/attendee?lectureNum=${lecture.lectureNum}" id="professorAttendee">참여자 목록</a>
	</div>
	
	<!-- Submenu_2 -->
	<button onclick="myFunction_2()" class="sidebar-menu">
		<i class="fas fa-angle-down fa-2xs"></i>&nbsp
		과목 게시판
	</button>
	<div id="submenu_2" class="sidebar-dropdown-content">
		<a href="/lectureNotice/list?lectureNum=${lecture.lectureNum}" id="lectureNoticeList">강의 공지사항</a>
		<a href="/lectureQna/list?lectureNum=${lecture.lectureNum}" id="lectureQnaList">강의 질의응답</a>
	</div>
	
	<!-- Submenu_3 -->
	<button onclick="myFunction_3()" class="sidebar-menu">
		<i class="fas fa-angle-down fa-2xs"></i>&nbsp
		학습 활동
	</button>
</div>

<script type="text/javascript">
	/* 더 많은 개수의 submenu가 필요할 경우
	필요한 숫자 만큼 'myFunction_숫자()' 함수를 복사하고 아이디 수정하여 사용하면 됨 */
	function myFunction_1() {
	    document.getElementById("submenu_1").classList.toggle("show");
	}
	function myFunction_2() {
	    document.getElementById("submenu_2").classList.toggle("show");
	}
	function myFunction_3() {
	    document.getElementById("submenu_3").classList.toggle("show");
	}
	
	// Close the dropdown menu if the user clicks outside of it
	window.onclick = function(event) {
	  if (!event.target.matches('.menu')) {
	
	    var dropdowns = document.getElementsByClassName("dropdown-content");
	    var i;
	    for (i = 0; i < dropdowns.length; i++) {
	      var openDropdown = dropdowns[i];
	      if (openDropdown.classList.contains('show')) {
	        openDropdown.classList.remove('show');
	      }
	    }
	  }
	}
</script>
<script src="/js/sidebarActive/professorLectureSidebarActive.js"></script>