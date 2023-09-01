<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/css/sidebar.css">
<head>
<meta charset="UTF-8">
<title>Acadmi!</title>
<c:import url="../../../temp/style.jsp"></c:import>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
	
	<div>
		<div class="form-group">
			<form action="./add" method="post" enctype="multipart/form-data">
				<input type="hidden" name="lectureNum" value="${lecture.lectureNum }">
				<input type="hidden" name="registrationNum" value="${reportVO.registrationNum }">
				<input type="hidden" name="username" value="${reportVO.username }">
	           <div class="input-group">
	           		<div class="custom-file">
                      	<input type="file" class="custom-file-input" id="exampleInputFile" name="addfiles">
                      	<label class="custom-file-label" for="exampleInputFile">파일을 선택해 주세요.</label>
                   	</div>
	          </div>
	         
	          <button type="submit" class="btn btn-info" style="float : right;  margin-top : 20px; width : 75px;">등록</button>
            </form>	
        
        </div>										
	</div> 
</div>
<script type="text/javascript">
const fileInput = document.getElementById('exampleInputFile');
const fileLabel = document.querySelector('.custom-file-label');

fileInput.addEventListener('change', function() {
  const fileName = this.files[0].name;
  fileLabel.textContent = fileName;
});
</script>
</body>
</html>