
$("#tableAdmin").on("click", '[data-lecturenum]', function() {
    let lectureNum = $(this).attr('data-lecturenum')
    let status = $('[data-status]').attr('data-status')
    let flag = true;

   while(flag) {

    let confirm = prompt("강의 번호를 입력하세요.") 

    console.log(confirm)
    console.log(lectureNum)
    


    if(confirm === lectureNum) {
       flag = false;
    $.ajax ({
        url : "./lectureList",
        type : 'POST',
        data : {
            lectureNum : lectureNum,
            status : status
            
        },
        
        success : function() {
			if(status == 1) {
				 alert("폐강되었습니다.")
			}else {
				alert("개강되었습니다.")
			}
           
           
            location.href="./lectureList"
            
        }
    })
    }else if(confirm === null){
        flag = false;
        
        
    }else{
        alert("강의 번호를 다시 입력해주세요.")

    }
}

})