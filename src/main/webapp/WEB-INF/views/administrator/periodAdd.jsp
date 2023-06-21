<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Acadmi!</title>
	<!-- CSS/favicon 적용 -->
	<c:import url="../temp/style.jsp"></c:import>
	<!-- CSS/favicon 끝 -->
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	
	<!-- Header 적용 -->
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<c:import url="../temp/administrator_header.jsp"></c:import>
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_ADMINISTRATOR')">
		<c:import url="../temp/administrator_header.jsp"></c:import>
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_PROFESSOR')">
		<c:import url="../temp/professor_header.jsp"></c:import>
	</sec:authorize>
		
	<sec:authorize access="hasRole('ROLE_STUDENT')">
		<c:import url="../temp/student_header.jsp"></c:import>
	</sec:authorize>
	<!-- Header 끝 -->
		
		<!-- Main Contents -->
		<div class="container-fluid">
			<div class="content-wrapper">
				<div class="col">
					<!-- header start -->
					<div class="row" style="padding-top:10px">
						<div class="col-12">
							<div class="card">
								<h3 class="my-3 mx-3">기간 등록</h3>
							</div>
						</div>
					</div>
					<!-- header end -->
					
					<section class="content">
						<div class="card">
							<div class="card-header" style="color: gray;">
								<i class="fa-solid fa-clock"></i>
								<span class="mt-2 mb-1"> 시작 시간 10:00:00 | 종료 시간 23:59:59</span>
								<p style="font-size: 14px; margin-bottom: 0px;">이미 존재하는 기간이면 등록되어 있는 정보가 수정됩니다.</p>
							</div>	
							<div class="card-body row">
								
								<div class="col">
									<form action="./periodAdd" method="post">
										<div class="wrapper">
											<div class="form-group">
								          	  <label>수강 연도</label>
								                <select  class="form-control select2" style="width: 100%;" name="year" id="year" >
													<c:forEach items="${year}" var="year">
														<option value="${year}">${year }</option>
													</c:forEach>
													
												</select>
											</div>
											<div class="form-group">
								          	  <label>수강 학기</label>
								                <select  class="form-control select2" style="width: 100%;" name="semester" id="semester">
													<option value="1">1학기</option>
													<option value="2">2학기</option>
												</select>
											</div>
										</div>
										
										<div>
											
											<div class="row" style="margin-top : 30px;">
											  <div class="col">
											  <label style="font-size: 20px;">강의 기간 설정</label>
											    <div class="form-group">
											      <label>강의 등록 시작일</label>
											      <br>
											      <input type="date" class="form-control" name="registrationStart" style=" display: inline-block; margin-right: 40px;">
											    </div>
											  </div>
											
											  <div class="col" style="margin-top : 37px;">
											    <div class="form-group">
											      <label>강의 등록 종료일</label>
											      <br>
											      <input type="date" class="form-control" id="deadline" " name="deadline" style=" display: inline-block;" >
											    </div>
											  </div>
											</div>
										</div>
										
										<div>
											<div class="row" style="margin-top : 20px;">
											  <div class="col">
											    <label style="font-size: 20px;">수강 신청 기간 설정</label>
											    <div class="form-group">
											      <label>수강 신청 시작일</label>
											      <br>
											      <input type="date" class="form-control" name="applicationStart" style=" display: inline-block; margin-right: 40px;">
											    </div>
											  </div>
											
											  <div class="col" style="margin-top : 37px;">
											    <div class="form-group">
											      <label>수강 신청 종료일</label>
											      <br>
											      <input type="date" class="form-control" id="applicationEnd" " name="applicationEnd" style=" display: inline-block;">
											    </div>
											  </div>
											</div>
											
										</div>
										
										
										<div>
											<div class="row" style="margin-top : 15px;">
											  <div class="col">
											    <label style="font-size: 20px;">장바구니 기간 설정</label>
											    <div class="form-group">
											      <label>장바구니 시작일</label>
											      <br>
											      <input type="date" class="form-control" name="favoriteStart" style="display: inline-block; margin-right: 40px;">
											    </div>
											  </div>
											
											  <div class="col" style="margin-top: 37px;">
											    <div class="form-group">
											      <label>장바구니 종료일</label>
											      <br>
											      <input type="date" class="form-control" id="favoriteEnd" onchange="updateApplicationEnd()" name="favoriteEnd" style=" display: inline-block;">
											    </div>
											  </div>
											</div>
										</div>
										<div style="width:auto; float: right;">
								            <button type="submit" class="btn btn-info" id="periodBtn">등록</button> 
								            <button type="button" class="btn btn-danger" id="backBtn">취소</button>
						            	</div>
									</form>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	<!-- Footer 적용 -->
		<c:import url="../temp/footer.jsp"></c:import>
	<!-- Footer 끝 -->
	
<script type="text/javascript">

//수강 신청 종료일 자동 설정
function updateApplicationEnd(){
	let favoriteEnd = $("#favoriteEnd").val()
	console.log(favoriteEnd)
	
	$("#applicationEnd").val(favoriteEnd)
}

//취소 
$("#backBtn").click(function() {
    let back = confirm("취소하시겠습니까?")

    if(back == true) {
        location.href="./periodList"
    }else {
        return;
    }
})


</script>
</body>
</html>