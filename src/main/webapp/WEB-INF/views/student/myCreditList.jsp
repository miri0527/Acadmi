<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			<div class="container-fluid">
				<div class="row">
					<div class="col">
						<!--header start  -->
						<div class="row">
		                  <div class="col-12 mt-3">
		                     <div class="card">
		                        <h3 class="my-3 mx-3">성적 조회</h3>
		                     </div>
		                  </div>
		               </div>
		               <!--header end  -->
		               
		               	<!-- Default box -->
		               		<div class="card">
		               			<!-- table-header start -->
								<div class="card-header">
		            			   	<form action="./myCreditList" id="search-form">
									<div class="card-title">
					            		<label class="mx-2 my-2">수강 연도</label>
					               		<select  class="select2" name="year" style="width:115px;" id="year" >
					               			<option value="${year}" ${param.year == year ? 'selected' : ''}>${year}</option>
					               			<option value="${year - 1}" ${param.year == year - 1 ? 'selected' : ''}>${year - 1}</option>
					               			<option value="${year - 2}" ${param.year == year - 2 ? 'selected' : ''}>${year - 2}</option>
					               			<option value="${year - 3}" ${param.year == year - 3 ? 'selected' : ''}>${year - 3}</option>
					               			<option value="${year - 4}" ${param.year == year - 4 ? 'selected' : ''}>${year - 4}</option>
					               		</select>
					               		<label class="mx-2">학기</label>
					               		<select class="select2" name="semester"style="width:115px;" id="semester">
					               			<option value="1" ${empty param.semester and semester eq 1 ? 'selected' : (param.semester eq 1 ? 'selected' : '') }>1학기</option>
					               			<option value="2" ${empty param.semester and semester eq 2 ? 'selected' : (param.semester eq 2 ? 'selected' : '') }>2학기</option>
					               		</select>
					               		<button type="submit" class="btn btn-default ml-1" id="submit">
							            	<i class="fas fa-search"></i>
							            </button>
					                </div>
					                </form>
					            </div>
		               			<div class="card-body p-0">
		               				<table class="table table-hover text-nowrap" style="text-align : center;"  id="tableMyLecture">
		               				 <sec:authentication property="principal" var="user"/>
		               					<thead>
		               						<tr>
		               							<th style="width: 30%">강의 이름</th>
		               							<th>담당 교수</th>
		               							<th>구분</th>
		               							<th>총점</th>
		               							<th>성적</th>
		               							
		               						</tr>
		               					</thead>
		               					<tbody>
		               						<c:forEach items="${list}" var="lectureVO" varStatus="status">
		               							<tr>
		               								<td>${lectureVO.lectureName}</td>
		               								<td>${lectureVO.professorVO.name}</td>
		               								<td>${lectureVO.category}</td>
		               								
		               								<c:if test="${lectureVO.studentLectureVO.creditVO.credit==null}">
						                    				<td style="color:gray;">점수 없음</td>
						                    				<td style="color:gray;">성적 없음</td>
					                    				</c:if>
					                    				<c:if test="${lectureVO.studentLectureVO.creditVO.credit!=null}">
																<td>${lectureVO.studentLectureVO.creditVO.credit}</td>
														     <c:choose>
														        <c:when test="${lectureVO.studentVO.rank <=(lectureVO.subscription*50/100)}">
														            <td>A</td>
														        </c:when>
														        <c:otherwise>
														            <td>B</td>
														        </c:otherwise>
														    </c:choose>
														    
					                    				</c:if>
		               							</tr>
		               						</c:forEach>
		               					</tbody>
		               				</table>
		               			</div>
		               		</div>
		               
					</div>
				</div>
			</div>
		</div>
	</div>
<c:import url="../temp/footer.jsp"></c:import>			
<script type="text/javascript">
/*입학년도 ~ 재학년도 */
 	
/* 검색 기능 */
/* $("#year").on("change", function() {
	let year = $(this).val()
	let semester = $("#semester").val()
	
	$.ajax({
		url : "./myCreditList",
		type : "GET",
		data : {
			year : year,
			semester : semester
		},
		
		success : function(response) {
			location.href="./myCreditList?year=" + year + "&semester=" + semester
		}
	})
})

$("#semester").on("change", function() {
	let semester = $(this).val()
	let year = $("#year").val()
	
	$.ajax({
		url : "./myCreditList",
		type : "GET",
		data : {
			year : year,
			semester : semester
		},
		
		success : function(response) {
			location.href="./myCreditList?year=" + year + "&semester=" + semester
		}
	})
}) */

$(function () {
     $('.select2').select2()
 });
</script>	
</body>
</html>