/**
 * administrator 사이드바 active 표시
 */

if(window.location.pathname.startsWith('/notice')){
	$('#boardItem').addClass('menu-open')
	$('#boardLink').addClass('active')
	$('#noticeLink').addClass('active')
} else if(window.location.pathname.startsWith('/qna')){
	$('#boardItem').addClass('menu-open')
	$('#boardLink').addClass('active')
	$('#qnaLink').addClass('active')
} else if(window.location.pathname == '/administrator/lectureList' || window.location.pathname == '/administrator/lectureRoomAssignment'){
	$('#administratorLectureItem').addClass('menu-open')
	$('#administratorLectureLink').addClass('active')
	$('#administratorLectureList').addClass('active')
} else if(window.location.pathname == '/administrator/studentAdd' || window.location.pathname == '/administrator/professorAdd' || window.location.pathname == '/administrator/administratorAdd'){
	$('#memberItem').addClass('menu-open')
	$('#memberLink').addClass('active')
	$('#acountLink').addClass('active')
} else if(window.location.pathname == '/administrator/studentList' || window.location.pathname == '/administrator/professorList' || window.location.pathname == '/administrator/administratorList'){
	$('#memberItem').addClass('menu-open')
	$('#memberLink').addClass('active')
	$('#acountList').addClass('active')
} else if(window.location.pathname == '/administrator/periodList' || window.location.pathname == '/administrator/periodAdd' || window.location.pathname == '/administrator/periodUpdate'){
	$('#periodItem').addClass('menu-open')
	$('#periodLink').addClass('active')
	$('#periodListLink').addClass('active')
} else if(window.location.pathname == '/administrator/lectureRoomList' || window.location.pathname == '/administrator/lectureRoomAdd' || window.location.pathname == '/administrator/lectureRoomUpdate' ){
	$('#lectureRoomItem').addClass('menu-open')
	$('#lectureRoomLink').addClass('active')
	$('#lectureRoomList').addClass('active')
} else if(window.location.pathname == '/administrator/departmentList' || window.location.pathname == '/administrator/departmentAdd' || window.location.pathname == '/administrator/departmentUpdate'){
	$('#departmentItem').addClass('menu-open')
	$('#departmentLink').addClass('active')
	$('#departmentList').addClass('active')
}
