<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Acadmi!</title>
	<!-- CSS/favicon 적용 -->
	<c:import url="../../temp/style.jsp"></c:import>
	<link rel="stylesheet" href="/css/timetable.css">
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
							<h3 class="my-3 mx-3">시간표 조회</h3>
						</div>
					</div>
				</div>
				<!-- header end -->

					<!-- Content -->
					<div class="container-fluid">
						<div class="card card-primary">
							<div class="card-body p-0">

							<!-- time-table -->
							<div class="content">
								<div class="container">
									<div class="row">
										<div class="table-responsive">
											<table class="timetable table table-striped ">
												<thead>
													<tr class="text-center">
														<th scope="col" style="width: 10%"></th>
														<th scope="col" style="width: 15%">Monday</th>
														<th scope="col" style="width: 15%">Tuesday</th>
														<th scope="col" style="width: 15%">Wednesday</th>
														<th scope="col" style="width: 15%">Thursday</th>
														<th scope="col" style="width: 15%">Friday</th>
													</tr>
												</thead>				
												<tbody>
													<c:forEach begin="1" end="10" var="hour">
														<tr>
															<th scope="row">${hour + 8}:00</th>
															<c:set var="lectureExists" value="false" />
															<c:forEach items="${day}" var="day">
																<c:set var="hasLecture" value="false" />
																<c:forEach items="${list}" var="lectureVO">
																	<c:if test="${lectureVO.weekday eq day && lectureVO.startTime <= hour && lectureVO.endTime >= hour}">
																		<td class="timetable-workout">${lectureVO.lectureName}<br>
																			<small>${lectureVO.professorVO.username}</small><br>
																			<small>${lectureVO.lectureRoomVO.lectureBuilding} ${lectureVO.lectureRoomVO.lectureRoom}</small>
																		</td>
																		<c:set var="hasLecture" value="true" />
																		<c:set var="lectureExists" value="true" />
																	</c:if>
																</c:forEach>
																<c:if test="${not hasLecture}">
																	<td></td>
																</c:if>
															</c:forEach>	
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
										<!-- timetable -->
									</div>
								</div>
							</div>
							<!-- /.time-table -->

							</div>
							<!-- /.card-body -->
						</div>
					<!-- /.card -->
					</div>
					<!-- the events -->
					<div id="external-events"></div>
				<!-- /.content -->
				</div>
			</div>
		</div>

		<!-- Footer 적용 -->
		<c:import url="../../temp/footer.jsp"></c:import>
		<!-- Footer 끝 -->

	</div>
<!-- ./wrapper -->


<script>
</script>
</body>
</html>