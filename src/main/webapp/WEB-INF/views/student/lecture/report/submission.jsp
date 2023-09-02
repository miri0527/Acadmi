<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
 
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
<style type="text/css">
 a:hover {
 	color : gray;
 }
</style>
</head>
<body class="hold-transition si	debar-mini layout-fixed" >
	<h5>제출물</h5>
	<c:forEach items="${list}" var="reportVO">
		<div class="reportNum" data-reportnum = "${reportVO.reportNum }"></div>
	
		<c:forEach items="${reportVO.reportFilesVOs}" var="reportFilesVO">
			<div>
				<div style="width : 50%;"  >
					<a href="/student/fileDown?fileNum=${reportFilesVO.fileNum}" class="fileNum" data-filenum="${reportFilesVO.fileNum }" style="padding-top : 10px;">${reportFilesVO.oriName}</a>
					<a href="#" style="float : right;" class="deleteBtn" data-filenum="${reportFilesVO.fileNum }">삭제</a>
					<a href="#" style="float  :right; margin-right : 10px;" >수정</a>
					
				</div>
				
			</div>
		</c:forEach>
		
	</c:forEach>

<script type="text/javascript">
	let fileNum = $(".fileNum").data("filenum")
	let reportNum = $(".reportNum").data("reportnum")
	
	

	 $(".deleteBtn").click("data-filenum", function() {
		let check = confirm("과제를 정말 삭제하시겠습니까?")
		 
		 if(!check) {
			 return;
		 }else {
			  $.ajax ({
				  url : '/student/lecture/report/delete',
				  type : 'POST',
				  data : {
					  fileNum : fileNum,
					  reportNum : reportNum
				  },
				  success : function(response) {
					  alert("과제가 삭제되었습니다.")
					  location.href="";
				  }
			  })
			  
		 }
		
	})
		
</script>
</body>
</html>