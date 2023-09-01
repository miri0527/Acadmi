<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
 
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
<style type="text/css">
 a:hover {
 	color : red;
 }
</style>
</head>
<body class="hold-transition si	debar-mini layout-fixed" >
	<h5>제출물</h5>
	<c:forEach items="${list}" var="reportVO">
		<c:forEach items="${reportVO.reportFilesVOs}" var="reportFilesVO">
			<div>
				<div>
					<a href="/student/fileDown?fileNum=${reportFilesVO.fileNum}" style="padding-top : 10px;">${reportFilesVO.oriName}</a>
				</div>
				<a href="#" style="color : black;">수정</a>
				<a href="#" style="color : red;">삭제</a>
			</div>
		</c:forEach>
		
	</c:forEach>


</body>
</html>