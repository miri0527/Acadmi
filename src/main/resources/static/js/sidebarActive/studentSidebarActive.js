/**
 * professor 사이드바 active 표시
 */

if(window.location.pathname == '/student/myLectureList'){
	$('#studentLectureItem').addClass('menu-open')
	$('#studentLectureLink').addClass('active')
	$('#studentLectureList').addClass('active')
} else if(window.location.pathname == '/student/myCreditList'){
	$('#studentLectureItem').addClass('menu-open')
	$('#studentLectureLink').addClass('active')
	$('#studentCreditList').addClass('active')
} else if(window.location.pathname.startsWith('/student/lecture')){
	$('#studentLectureLink').addClass('active')
} else if(window.location.pathname.startsWith('/student/registration')){
	$('#registrationItem').addClass('menu-open')
	$('#registrationLink').addClass('active')
	if(window.location.pathname.includes('/all_lecture')){
		$('#registrationAllLecture').addClass('active')
	} else if(window.location.pathname.includes('/my_lecture')){
		$('#registrationMyLecture').addClass('active')
	} else if(window.location.pathname.includes('/my_favorit')){
		$('#registrationMyFavorite').addClass('active')
	} else {
		$('#registrationTimetable').addClass('active')
	}
} else if(window.location.pathname.startsWith('/notice')){
	$('#boardItem').addClass('menu-open')
	$('#boardLink').addClass('active')
	$('#noticeLink').addClass('active')
} else if(window.location.pathname.startsWith('/qna')){
	$('#boardItem').addClass('menu-open')
	$('#boardLink').addClass('active')
	$('#qnaLink').addClass('active')
} else if(window.location.pathname.startsWith('/lecture')){
	$('#studentLectureLink').addClass('active')
}
