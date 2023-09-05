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
					<a href="/student/fileDown?fileNum=${reportFilesVO.fileNum}" data-oriname="${reportFilesVO.oriName }" class="file" data-filenum="${reportFilesVO.fileNum }" style="padding-top : 10px;">${reportFilesVO.oriName}</a>
					<a href="#" style="float : right;" class="deleteBtn" data-filenum="${reportFilesVO.fileNum }">삭제</a>
					<a href="#" style="float  :right; margin-right : 10px;" class="updateBtn" data-filenum="${reportVilesVO.fileNum}" >수정</a>
					
				</div>
				<div class="innerHtml"></div>
				
			</div>
		</c:forEach>
		
	</c:forEach>

<script type="text/javascript">
	let fileNum = $(".file").data("filenum")
	let reportNum = $(".reportNum").data("reportnum")
	let oriName = $(".file").data("oriname")
	let lecture = ${lecture.lectureNum}
	let registration = ${registration}
	

	
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
	
	$(".updateBtn").click("data-filenum", function() {
		let html = "<div class='form-group' style='width : 80%;'>"
			html +="<form action='/student/lecture/report/update' method='post' enctype='multipart/form-data' id='updateFrm'>"
			html +="<input type='hidden' name='lectureNum' value='" + lecture + "' >"
			html +="<input type='hidden' name='registrationNum' value='" + registration + "' >"
			html +="<input type='hidden' name='reportNum' value='" + reportNum + "' >"
			html +="<input type='hidden' name='fileNum' value='" + fileNum + "' >"
			html += "<div class='custom-file' style='width : 80%;'>" 
			html += "<input type='file' class='custom-file-input' id='exampleInputFile' name='addfiles' >"
			html +="<label class='custom-file-label' for='exampleInputFile'>" + oriName + "</label>"
			html +="</div>"
			html +="<div class='wrapper' style='margin-top : 20px; margin-left : 680px;'>"
			html +="<input type='submit' value='등록' class='btn btn-info'>"
			html +="<button type='button' id='remove' class='btn btn-danger' style='margin-left : 10px;'>취소</button>"
			html +="</div>"
			html += "</form>"
			html +="</div>"
		
		$(".innerHtml").append(html)
		
		$(".innerHtml").on("click", '#remove', function() {
			$(".form-group").remove();
		})
		
		const fileInput = document.getElementById('exampleInputFile');
		const fileLabel = document.querySelector('.custom-file-label');

		fileInput.addEventListener('change', function() {
		  const fileName = this.files[0].name;
		  fileLabel.textContent = fileName;
		});
	})
	
	
	
		
</script>
</body>
</html>