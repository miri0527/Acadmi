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
	<style type="text/css">
		#row {
		  display: flex;
		  justify-content: center; /* 가로 방향으로 가운데 정렬 */
		  align-items: center; /* 세로 방향으로 가운데 정렬 */
		}
		
		.col-custom {
		  flex-grow: 1;
		}
	</style>
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
							<h3 class="my-3 mx-3">학과 조회</h3>
						</div>
					</div>
				</div>
				<!-- header end -->
	
				<!-- Default box -->
				<div class="card">
					<div class="card-header">
					
						<!-- Search -->
						<form action="./departmentList" id="search-form">
								<input type="hidden" name="page" value="1">
									<div class="row justify-content-center mx-auto my-3" >
										<div class="col-custom">
											<div class="row"  id="row">
												<div class="col-2">
													<div class="form-group">
														<label>상태</label>
														<select class="select2" name="status" style="width: 100%;">
															<option value="">전체</option>
															<option value="1">사용 가능</option>
															<option value="0">사용 불가</option>
															
														</select>
													</div>
												</div>
												<div class="col-2">
													<div class="form-group">
														<label>단과대학</label>
														<select class="select2" name="collegeNum" style="width: 100%;">
															<option value="">전체</option>
															<c:forEach items="${college}" var="collegeVO">
																<option value="${collegeVO.collegeNum}">${collegeVO.collegeName}</option>
															</c:forEach>
														</select>
													</div>
												</div>
											<div class="col-4">
												<div class="form-group">
													<label>학과</label>
													<div class="input-group">
														<input type="text" class="form-control" name="search" placeholder="학과를 입력하세요.">
														<div class="input-group-append">
															<button type="submit" class="btn btn-default" id="submit">
																<i class="fas fa-search "></i>
															</button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							
						</form>
					</div>
						   <!-- Default box -->
				        <div class="card-body p-0">
							<table class="table table-hover text-nowrap" style="text-align : center;"  id="table2">
				              <thead>
				                  <tr>
				                      <th style="width: 10%">
				                         학과 번호
				                      </th>
				                      <th style="width: 10%">
				                          단과대학
				                      </th>
				                      <th style="width: 10%" class="text-center">
				                          학과
				                      </th>
				                      <th style="width : 18%">
				                          사용 여부
				                      </th>
				                      <th style="width : 10%"></th>
				                    
				                  </tr>
				              </thead>
				              <tbody>
				              	<c:forEach items="${list}" var="collegeVO">
									<c:set value="${collegeVO.collegeName}" var="collegeName"></c:set>
									<c:forEach items="${collegeVO.departmentVOs}" var="departmentVO">
										<c:set value="${departmentVO.deptNum}" var="deptNum"></c:set>
										<c:set value="${departmentVO.deptName}" var="deptName"></c:set>
										<c:set value="${departmentVO.status}" var="status"></c:set>
										<tr class="dept">
											<c:if test="${status eq 1 }">
												<td><c:out value="${deptNum}"></c:out></td>
												<td><c:out value="${collegeName}"></c:out></td>
												<td><c:out value="${deptName}"></c:out></td>
												<td>사용 가능</td>
													
													
												
											</c:if>
											<c:if test="${status eq 0 }">
												<td style="color: #E2E2E2;"><c:out value="${deptNum}"></c:out></td>
												<td style="color: #E2E2E2;"><c:out value="${collegeName}"></c:out></td>
												<td style="color: #E2E2E2;"><c:out value="${deptName}"></c:out></td>
												<td style="color: #E2E2E2;">사용 불가</td>
													
												
											</c:if>
											<td>
												<a href="./departmentUpdate?deptNum=${deptNum}"><button type="button" class="btn btn-primary" id="update">
												학과 수정
												</button></a>
											</td>
											
										</tr>
									</c:forEach>
									
								</c:forEach>
				            </tbody>
				          </table>
				        </div>
					<!-- /.card-body -->
						<div class="row g-3 my-3 justify-content-center" id="pagination">
							<ul class="pagination pagination-sm mx-auto">
								<c:if test="${pagination.pre}">
									<li class="page-item">
										<a class="page-link" href="./departmentList?page=1&kind=${pagination.kind}&search=${pagination.search}" aria-label="Previous" data-board-page="1" style="color:#17a2b8;">
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
								</c:if>
								
								<c:forEach begin="${pagination.startNum}" end="${pagination.lastNum}" var="i">
									<li class="page-item"><a class="page-link" href="./departmentList?page=${i}&kind=${pagination.kind}&search=${pagination.search}" data-board-page="${i}" style="color:#17a2b8;">${i}</a></li>
								</c:forEach>
								
								<c:if test="${pagination.next }">
									<li class="page-item">
										<a class="page-link" href="./departmentList?page=${pagination.totalPage}&kind=${pagination.kind}&search=${pagination.search}" aria-label="Next" data-board-page="${pagination.totalPage}" style="color:#17a2b8;">
											<span aria-hidden="true">&raquo;</span>
										</a>
									</li>
								</c:if>
							</ul>
									
						</div>
					<div class="wrapper" style="margin : 0 20px 20px 0;">
						 <a href="./departmentAdd"><button type="button" id="add2" class="btn btn-info" style="float : right;">학과 등록</button></a>
					 </div>
				</div>
			</div>
		</div>
	</div>
				
	<!-- ./wrapper -->

<c:import url="../temp/footer.jsp"></c:import>
<script type="text/javascript" src="../js/administrator/departmentList.js"></script>	
<script type="text/javascript">
/* 페이지네이션 선택 색상 */

   $(function () {
      $('.select2').select2()
    });
</script>

</body>
</html>