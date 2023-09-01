<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="/css/sidebar.css">
<style>
	a:hover{
		color : white;
	}
</style>

<div class="sidebar-dropdown" style="padding-top:70px;">

	<!-- Menu -->
	
	<!-- Submenu_1 -->
	<button onclick="myFunction_1()" class="sidebar-menu">
		<i class="fas fa-angle-down fa-2xs"></i>&nbsp
		강의 정보
	</button>
		<div id="submenu_1" class="sidebar-dropdown-content">
			<a href="/student/lecture/syllabusDetail?lectureNum=${lecture.lectureNum}" id="studentSyllabusDetail">강의계획서 열람 </a>
			<a href="/student/lecture/attendee?lectureNum=${lecture.lectureNum}" id="studentAttendeeList">참여자 목록</a>
		</div>
	
	<!-- Submenu_2 -->
	<button onclick="myFunction_2()" class="sidebar-menu">
		<i class="fas fa-angle-down fa-2xs"></i>&nbsp
		과목 게시판
	</button>
	<div id="submenu_2" class="sidebar-dropdown-content">
		<a href="/lectureNotice/list?lectureNum=${lecture.lectureNum}" id="lectureNoticeList">공지사항 게시글</a>
		<a href="/lectureQna/list?lectureNum=${lecture.lectureNum}" id="lectureQnaList">질의응답 게시글</a>
	</div>	
	
	<!-- Submenu_3 -->
	<button onclick="myFunction_3()" class="sidebar-menu">
		<i class="fas fa-angle-down fa-2xs"></i>&nbsp
		학습 활동
	</button>
	<div id="submenu_3" class="sidebar-dropdown-content">
		<a href="/student/lecture/report/list?lectureNum=${lecture.lectureNum}" id="report">과제 및 평가</a>
		
	</div>	
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
<script src="/js/sidebarActive/studentLectureMainSidebarActive.js"></script>
