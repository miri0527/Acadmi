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
</body>
</html>