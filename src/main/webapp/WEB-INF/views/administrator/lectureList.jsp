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
	<div class="wrapper">

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
	
		<div class="content-wrapper">
			<div class="col">
					
				<!-- header start -->
				<div class="row">
					<div class="col mt-3">
						<div class="card">
							<h3 class="my-3 mx-3">강의 목록 조회</h3>
						</div>
					</div>
				</div>
				<!-- header end -->
	
				<!-- Default box -->
				<div class="card">
					<div class="card-header">
							
						<!-- <div class="card-tools">
							<button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
								<i class="fas fa-minus"></i>
							</button>		
						</div> -->
					
						<!-- Search -->
						<form action="./lectureList" id="search-form">
								<input type="hidden" name="page" value="1">
									<div class="row justify-content-center mx-auto my-3" >
										<div class="col-md-8">
											<div class="row">
												<div class="col-3">
													<div class="form-group">
														<label>학과</label>
														<select  class="select2" style="width:100%;" name="deptName" id="dept">
															<option value="">전체</option>
															<c:forEach items="${department}" var="departmentVO">
																<c:if test="${departmentVO.deptNum !=1 && departmentVO.deptNum !=2 }">
																	<option value="${departmentVO.deptName}">${departmentVO.deptName}</option>
																</c:if>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="col-3">
													<div class="form-group">
														<label>연도</label>
														<select class="select2" style="width: 100%;" name="year">
															<option value="">전체</option>
															<c:forEach items="${year}" var="year">
																<option value="${year}">${year}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="col-3">
													<div class="form-group">
														<label>학기</label>
														<select class="select2" style="width: 100%;" name="semester">
															<option value="">전체</option>
															<option value="1">1학기</option>
															<option value="2">2학기</option>
														</select>
													</div>
												</div>
												<div class="col-3">
													<div class="form-group">
														<label>상태</label>
														<select class="select2" style="width: 100%;" name="status">
															<option value="">전체</option>
															<option value="0">폐강</option>
															<option value="1">개강</option>
														</select>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="input-group input-group-lg">
													<input type="text" class="form-control form-control-lg" placeholder="강의 이름을 입력하세요." name="search" value="${pagination.search}">
													<div class="input-group-append">
														<button type="submit" class="btn btn-lg btn-default" id="submit">
															<i class="fa fa-search"></i>
														</button>
													</div>
												</div>
											</div>
									</div>
								</div>
							
						</form>
					</div>
						   <!-- Default box -->
				        <div class="card-body p-0">
				          <table class="table table-hover text-nowrap" style="text-align : center;"  id="tableAdmin">
				              <thead>
				                  <tr>
				                      <th style="width: 10%">
				                          강의 번호
				                      </th>
				                      <th style="width: 20%">
				                          강의 이름
				                      </th>
				                      <th style="width: 10%" class="text-center">
				                          강의 요일
				                      </th>
				                      <th style="width: 10%">
				                          시작 시간
				                      </th>
				                      <th style="width: 10%" class="text-center">
				                          종료 시간
				                      </th>
				                      <th style="width: 10%">
				                      	  수강 인원
				                      </th>
				                      <th style="width: 10%">
				                      	  상태
				                      </th>
				                      <th style="width: 10%">
				                      	강의실
				                      </th>
									  <th></th>
									 
				                  </tr>
				              </thead>
				              <tbody>
					               <c:forEach items="${list}" var="lectureVO">
					               <c:set value="${lectureVO.lectureNum }" var="lectureNum"></c:set>
					               <c:set value="${lectureVO.lectureName }" var="lectureName"></c:set>
					               <c:set value="${lectureVO.weekday }" var="lectureWeekday"></c:set>
					               <c:set value="${lectureVO.startTime }" var="lectureStartTime"></c:set>
					               <c:set value="${lectureVO.endTime }" var="lectureEndTime"></c:set>
					               <c:set value="${lectureVO.personal }" var="lecturePersonal"></c:set>
					               <c:set value="${lectureVO.status }" var="lectureStatus"></c:set>
					               <c:set value="${lectureVO.year}" var="year"></c:set>
					               <c:set value="${lectureVO.departmentVO.deptName}" var="deptName"></c:set>
					               <c:set value="${lectureVO.semester}" var="semester"></c:set>
					               <c:set value="${lectureVO.professorVO.name}" var="professorName"></c:set>
								   <c:set value="${lectureVO.lectureBuilding}" var="lectureBuilding"></c:set>
								    <c:set value="${lectureVO.lectureRoom}" var="lectureRoom"></c:set>
					               <c:set value="${lectureVO.lectureRoomVO.personal}" var="lectureRoomPersonal"></c:set>
						   	 			<c:forEach items="${letureRoomVO.timeTableVOs}" var="timeTableVO">
						   	 				<c:set value="${timeTableVO.weekday}" var="weekday"></c:set>
						   	 				<c:forEach items="${timeTableVO.timeInfoVOs}" var="timeInfoVO">
						   	 					<c:set value="${timeInfoVO.startTime}" var="startTime"></c:set>
						   	 					<c:set value="${timeInfoVO.endTime}" var="endTime"></c:set>
						   	 				</c:forEach>
						   	 			</c:forEach>
						   	 		
						   	
						   	 		<tr class="container">
						   	 			<td style="${lectureStatus==0 ? 'color: #E2E2E2;;' : 'color: black;'}"> ${lectureNum}</td>
						   	 			<td style="${lectureStatus==0 ? 'color: #E2E2E2;;' : 'color: black;'}">${lectureName}</td>
						   	 			<td style="${lectureStatus==0 ? 'color: #E2E2E2;;' : 'color: black;'}">${lectureWeekday}요일</td>
						   	 			<td style="${lectureStatus==0 ? 'color: #E2E2E2;;' : 'color: black;'}">
						   	 				<c:if test="${lectureStartTime eq 1}">09:00</c:if>
											<c:if test="${lectureStartTime eq 2}">10:00</c:if>
											<c:if test="${lectureStartTime eq 3}">11:00</c:if>
											<c:if test="${lectureStartTime eq 4}">12:00</c:if>
											<c:if test="${lectureStartTime eq 5}">13:00</c:if>
											<c:if test="${lectureStartTime eq 6}">14:00</c:if>
											<c:if test="${lectureStartTime eq 7}">15:00</c:if>
											<c:if test="${lectureStartTime eq 8}">16:00</c:if>
											<c:if test="${lectureStartTime eq 9}">17:00</c:if>
						   	 			</td>
						   	 			<td style="${lectureStatus==0 ? 'color: #E2E2E2;;' : 'color: black;'}">
						   	 				<c:if test="${lectureEndTime eq 1}">10:00</c:if>
											<c:if test="${lectureEndTime eq 2}">11:00</c:if>
											<c:if test="${lectureEndTime eq 3}">12:00</c:if>
											<c:if test="${lectureEndTime eq 4}">13:00</c:if>
											<c:if test="${lectureEndTime eq 5}">14:00</c:if>
											<c:if test="${lectureEndTime eq 6}">15:00</c:if>
											<c:if test="${lectureEndTime eq 7}">16:00</c:if>
											<c:if test="${lectureEndTime eq 8}">17:00</c:if>
											<c:if test="${lectureEndTime eq 9}">18:00</c:if>
						   	 			</td>
						   	 			<td style="${lectureStatus==0 ? 'color: #E2E2E2;;' : 'color: black;'}">${lecturePersonal}</td>
						   	 			<c:if test="${lectureStatus eq 1}">
						   	 				<td >개강</td>	
						   	 			</c:if>
						   	 			<c:if test="${lectureStatus eq 0}">
						   	 				<td style="${lectureStatus==0 ? 'color: #E2E2E2;;' : 'color: black;'}">폐강</td>
						   	 			</c:if>
						   	 			<c:if test="${lectureVO.status eq null }">
						   	 				<td>상태 없음</td>
						   	 			</c:if>
						   	 			<td style="${lectureStatus==0 ? 'color: #E2E2E2;;' : 'color: black;'}">
						   	 				${lectureBuilding} ${lectureRoom}
						   	 				<c:if test="${lectureBuilding eq null}">
				                        		<a href="./lectureRoomAssignment?lectureNum=${lectureNum}&startTime=${lectureStartTime}&endTime=${lectureEndTime}&weekday=${lectureWeekday}&personal=${lectureRoomPersonal}"><button class="btn btn-info">강의실 배정</button></a>
				                        	</c:if>
						   	 			</td>
			                        <c:choose>
			                        <c:when test="${lectureBuilding ne null && lectureStatus ne 0}">
			                        	<td ><button  class="btn btn-danger" data-lecturenum="${lectureNum}">폐강</button></td>
					   	 			</c:when>
					   	 			<c:otherwise>
					   	 				<td>&nbsp;</td>
					   	 			</c:otherwise>
					   	 			</c:choose>
					   	 			<td></td>
					   	 			
					   	 			
					   	 		
					   	 		</tr>	
					   	 		</c:forEach>
					   	 		
				              </tbody>
				          </table>
				          
				        </div>
									
					<!-- Pagination -->
				 <div class="row g-3 my-3 justify-content-center" id="pagination">
						<ul class="pagination pagination-sm mx-auto">
							<c:if test="${pagination.pre}">
								<li class="page-item">
									<a class="page-link" href="./lectureList?page=${pagination.startNum-1}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Previous" data-board-page="${pagination.startNum-1}" style="color:#17a2b8;">
										<span aria-hidden="true">&lsaquo;</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pagination.startNum}" end="${pagination.lastNum}" var="i">
								<li class="page-item"><a class="page-link" href="./lectureList?page=${i}&kind=${pagination.kind}&search=${pagination.search}" data-board-page="${i}" style="color:#17a2b8;">${i}</a></li>
							</c:forEach>
							<c:if test="${pagination.next}">
								<li class="page-item">
									<a class="page-link" href="./lectureList?page=${pagination.lastNum+1}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Next" data-board-page="${pagination.totalPage}" style="color:#17a2b8;">
										<span aria-hidden="true">&rsaquo;</span>
									</a>
								</li>
							</c:if>
							
						</ul>
				
					</div>
					<!-- /.card-body -->
				</div>
				
				<!-- /.card -->
			</div>
		</div>
	</div>	
	<!-- ./wrapper -->

<c:import url="../temp/footer.jsp"></c:import>

<script type="text/javascript" src="../js/administrator/lectureList.js"></script>	

<script type="text/javascript">
	/* 토글 */
	let toggleButtons = document.getElementsByClassName("toggleButton");
	let toggleContents = document.getElementsByClassName("toggleContent");
	
	for (let i = 0; i < toggleButtons.length; i++) {
	  let toggleButton = toggleButtons[i];
	
	  toggleButton.addEventListener('click', function() {
	    let toggleContent = toggleContents[i]; 
	
	    if (toggleContent.style.display === 'none') {
	      toggleContent.style.display = 'block';
	    } else {
	      toggleContent.style.display = 'none';
	    }
	  });
	}
	
/* select 디자인 */
   $(function () {
	      $('.select2').select2()
	 });
</script>
</body>
</html>