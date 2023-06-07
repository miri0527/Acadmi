<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Acadmi!</title>
	<!-- CSS/favicon 적용 -->
	<c:import url="../../temp/style.jsp"></c:import>>
	<!-- CSS/favicon 끝 -->
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">

	<!-- Header 적용 -->
	<c:import url="../../temp/header.jsp"></c:import>
	<!-- Header 끝 -->

	<!-- Main Contents -->
	<div class="container-fluid">
		<div class="content-wrapper">
				
				<!-- Contents -->
				<div class="col">

				<!-- header start -->
				<div class="row" style="padding-top:10px">
					<div class="col-12">
						<div class="card">
							<h3 class="my-3 mx-3">내 수강 신청</h3>
						</div>
					</div>
				</div>
				<!-- header end -->
						
						<!-- Default box -->
						<div class="card">
							<div class="card-header">
								<h3 class="card-title">신청 과목</h3>
								
								<div class="card-tools">
									<button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
										<i class="fas fa-minus"></i>
									</button>
								</div>
							</div>
							
							<div class="card-body p-0" id="myLectureList">
								<table class="table table-hover text-nowrap">
									<thead>
										<tr>
											<th style="width: 8%">강의 번호</th>
											<th style="width: 8%">강의 이름</th>
											<th style="width: 8%">학년</th>
											<th style="width: 8%">구분</th>
											<th style="width: 8%">학과</th>
											<th style="width: 8%">학점</th>
											<th style="width: 8%">요일</th>
											<th style="width: 8%">시작 시간</th>
											<th style="width: 8%">종료 시간</th>
											<th style="width: 8%">강의실</th>
											<th style="width: 8%">수강 인원</th>
											<th style="width: 12%"></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list}" var="lectureVO">
											<tr>
												<td>${lectureVO.lectureNum}</td>
												<td><a>${lectureVO.lectureName}</a><br/><small>${lectureVO.professorVO.username}</small></td>
												<td>${lectureVO.grade}학년</td>
												<td>
													<c:if test="${lectureVO.category eq '전공 필수'}">전공 필수</c:if>
													<c:if test="${lectureVO.category eq '전공 선택'}">전공 선택</c:if>
													<c:if test="${lectureVO.category eq '교양 필수'}">교양 필수</c:if>
													<c:if test="${lectureVO.category eq '교양 선택'}">교양 선택</c:if>
												</td>
												<td>${lectureVO.departmentVO.deptName}</td>
												<td>${lectureVO.completionGrade}</td>
												<td>${lectureVO.weekday}요일</td>
												<td>
													<c:if test="${lectureVO.startTime eq 1}">AM 09:00</c:if>
													<c:if test="${lectureVO.startTime eq 2}">AM 10:00</c:if>
													<c:if test="${lectureVO.startTime eq 3}">AM 11:00</c:if>
													<c:if test="${lectureVO.startTime eq 4}">PM 12:00</c:if>
													<c:if test="${lectureVO.startTime eq 5}">PM 13:00</c:if>
													<c:if test="${lectureVO.startTime eq 6}">PM 14:00</c:if>
													<c:if test="${lectureVO.startTime eq 7}">PM 15:00</c:if>
													<c:if test="${lectureVO.startTime eq 8}">PM 16:00</c:if>
													<c:if test="${lectureVO.startTime eq 9}">PM 17:00</c:if>
													<c:if test="${lectureVO.startTime eq 10}">PM 18:00</c:if>
												</td>
												<td>
													<c:if test="${lectureVO.endTime eq 1}">AM 10:00</c:if>
													<c:if test="${lectureVO.endTime eq 2}">AM 11:00</c:if>
													<c:if test="${lectureVO.endTime eq 3}">PM 12:00</c:if>
													<c:if test="${lectureVO.endTime eq 4}">PM 13:00</c:if>
													<c:if test="${lectureVO.endTime eq 5}">PM 14:00</c:if>
													<c:if test="${lectureVO.endTime eq 6}">PM 15:00</c:if>
													<c:if test="${lectureVO.endTime eq 7}">PM 16:00</c:if>
													<c:if test="${lectureVO.endTime eq 8}">PM 17:00</c:if>
													<c:if test="${lectureVO.endTime eq 9}">PM 18:00</c:if>
													<c:if test="${lectureVO.endTime eq 10}">PM 19:00</c:if>
												</td>
												<td>${lectureVO.lectureRoomVO.lectureBuilding} ${lectureVO.lectureRoomVO.lectureRoom}</td>
												<td>${lectureVO.subscription}/${lectureVO.personal}명</td>
												<td class="project-actions text-right">
													<input type="hidden" name="lectureNum" value="${lectureVO.lectureNum}">
													<input type="hidden" name="username" value="${member.username}">
													<button class="btn btn-danger btn-sm" id="mld" type="button" data-mld-num="${lectureVO.lectureNum}">
														<i class="fas fa-xmark"></i>
														취소
													</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- /.card-body -->
						</div>
						<!-- /.card -->

				</div>
			</div>
		</div>

	<!-- Footer 적용 -->
	<c:import url="../../temp/footer.jsp"></c:import>
	<!-- Footer 끝 -->

	</div>
<!-- ./wrapper -->
<script src="/js/student/lecture/my_lecture.js"></script>
<script>
</script>
</body>
</html>