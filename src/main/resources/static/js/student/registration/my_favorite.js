//my_lecture_insert
$("#myFavoriteList").on("click", "#mli", function(e) {
    let check = window.confirm("신청하시겠습니까?");
    if (check) {
        const lectureNum = $(this).attr("data-mli-num");
        const year = $(this).attr("data-year");
        const semester = $(this).attr("data-semester");
        const weekday = $(this).attr("data-weekday");
        const startTime = $(this).attr("data-start-time");
        const endTime = $(this).attr("data-end-time");
        const completionGrade = $(this).attr("data-completion-grade");

        fetch("./my_lecture/insert", {
            method: 'POST',
            headers: {
                "Content-type": "application/x-www-form-urlencoded"
            },
            body: "lectureNum=" + lectureNum + "&year=" + year + "&semester=" + semester + "&weekday=" + weekday + "&startTime=" + startTime + "&endTime=" + endTime + "&completionGrade=" + completionGrade
        }).then((response) => {
            return response.text();
        }).then((res) => {
            if (res.trim() == 1) {
                alert('신청되었습니다.');
                document.location.reload();
            } else if (res.trim() == 2) {
                alert('이미 수강한 강의와 요일/시간이 겹칩니다.');
            } else if (res.trim() == 3) {
				alert('이수 가능한 학점을 초과하였습니다.');
			} else {
				alert('신청되지 않았습니다.');
			}
        });
        e.preventDefault();
    }
});

//my_favorite_delete
$("#myFavoriteList").on("click","#mfd",function(e){
	let check = window.confirm("빼시겠습니까?");
    if(check) {
		const favoriteNum = $(this).attr("data-mfd-num");
		
	    fetch("./my_favorite/delete", {
	        method:'POST',
	        headers:{
	           "Content-type":"application/x-www-form-urlencoded"
	       },
	       body: "favoriteNum=" + favoriteNum
	       }).then((response)=>{return response.text()})
	         .then((res)=>{
	           if(res.trim()!=0){
					alert('뺐습니다.');
					document.location.reload();
	           }else {
	               alert('빼기에 실패했습니다.');
	           }
	         })
	         e.preventDefault();
	}
})