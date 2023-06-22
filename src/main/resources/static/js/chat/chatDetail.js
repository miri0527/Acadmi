/**
 * chat/detail에서 웹소켓 연결 및 자바스크립트 처리
 */
let websocket = new WebSocket("ws://localhost/chat")

let count = 0;
let max = 1;
let idx = 0;

function setCount(c){
	count = c;
}

function setMax(m){
	max = m;
}

//파일 전송 취소
$('#formSend').on('click','#deleteFile',function(){
	$(this).parent().parent().remove()
	count--
})

//파일 전송
$('#fileButton').click(function(){
	if(count >= max){
		alert('점부파일은 최대 ' + max + '개 까지만 가능')
		return
	}
	count++
	let child = '<div class="input-group my-2" id="fileSend"><div class="custom-file">'
	child = child + '<input type="file" class="custom-file-input" id="fileInput">'
	child = child + '<label class="custom-file-label" for="fileInput">파일 선택</label></div>'
	child = child + '<div class="input-group-append"><span class="btn btn-danger" style="width : 42px;" id="deleteFile"><i class="fa-solid fa-xmark"></i></span></div>'
	$(function () {
	  bsCustomFileInput.init();
	});
	$('#formSend').prepend(child)
})



$('#addButton').hide()
$('.deleteMessage').hide()

$('.card-header').on('mouseenter',function(){
	$('#addButton').show();	
})

	
$('.card-header').on('mouseleave',function(){
	$(this).find('#addButton').hide()
})

$('.direct-chat-msg, .direct-chat-msg.right').on('mouseenter',function(){
	$(this).find('.deleteMessage').show()
})

$('.direct-chat-msg, .direct-chat-msg.right').on('mouseleave',function(){
	$(this).find('.deleteMessage').hide()
})

//채팅방 나가기 버튼	
$('#deleteButton').on('click', function(){
	let check = confirm('채팅방을 나가시겠습니까?')
	if(check){		
		let chatNum = $(this).data('chat-num')
		let roomSender = $(this).data('room-sender')
		let roomRecipient = $(this).data('room-recipient')
		$.ajax({
			type : "POST",
			url : "./chatRoomDelete",
			data : {
				chatNum : chatNum,
				roomSender : roomSender,
				roomRecipient : roomRecipient
			},
			success : function(result){
				if(result>=1){
					alert('채팅방에서 나왔습니다.')
					location.href='./list'
				} else {
					alert('나가지 못했습니다.')
					location.href='./list'
				}
			},
			error : function(){
				console.log('error')
			}
		})
	}
})

//상대방 재초대 버튼
$('#addButton').on('click', function(){
	let check = confirm('상대방을 다시 초대하시겠습니까?')
	if(check){		
		let roomSender = $(this).data('room-sender')
		let roomRecipient = $(this).data('room-recipient')
		$.ajax({
			type : "POST",
			url : "./inviteChat",
			data : {
				roomSender : roomSender,
				roomRecipient : roomRecipient
			},
			success : function(result){
				if(result>=1){
					alert('초대에 성공하였습니다.')
					location.href='./detail?roomSender='+roomSender+'&roomRecipient='+roomRecipient
				} else {
					alert('실패했습니다.')
				}
			},
			error : function(){
				console.log('error')
			}
		})
	}
})

//메세지 내 채팅방에서만 삭제
$('.deleteMessage').on('click',function(){
	let roomSender = getUrlParameter('roomSender')
	let roomRecipient = getUrlParameter('roomRecipient')
	let check = confirm('메세지를 삭제하시겠습니까? 나의 채팅방에서만 삭제됩니다')
	if(check){
		let msgNum = $(this).data('msg-num')
		$.ajax({
			type : "POST",
			url : "./deleteMessage",
			data : {
				msgNum : msgNum
			},
			success : function(result){
				if(result>=1){
					alert('삭제하였습니다')
					location.href='./detail?roomSender='+roomSender+"&roomRecipient="+roomRecipient
				} else {
					alert('실패했습니다.')
				}
			},
			error : function(){
				console.log('error')
			}
		})
	}
})

// 웹소켓이 연결되었을때
websocket.onopen = function(event){
	console.log("웹소켓 연결 성공")
}

// 메세지를 받았을때 
websocket.onmessage = function(event){
	let msgContents = event.data
	let msgSender = getUrlParameter('roomRecipient')
	let msgRecipient = getUrlParameter('roomSender')
	let chatNum = $('#chatNum').val();
	let date = new Date().toLocaleTimeString();
	let recipientName = $('#chatSend').data('recipient-name')
	let recipientProfile = $('#recipientProfile').data('file-name')
	console.log(recipientProfile)
	let message = {
		type : 'text',
		msgContents : msgContents,
		msgRecipient : msgRecipient,
		msgSender : msgSender,
		chatNum : chatNum
	}
	let child = '<div class="direct-chat-msg">'
	child = child + '<span class="direct-chat-name float-left">'+recipientName+'('+msgSender+')'+'</span>'
	child = child + '<span class="direct-chat-timestamp float-right">'+date+'</span></div>'
	if(recipientProfile == ''){
		child = child +'<img class="direct-chat-img" src="/images/profile.jpg" alt="message user image">'
	} else {
		child = child + '<img class="direct-chat-img"  src="/file/member/'+recipientProfile+'" alt="message user image">'
	}
	child = child + '<div class="direct-chat-text">'+msgContents+'</div></div>'
	$('#messageList').append(child)
	sendMessage(JSON.stringify(message))
	scrollToBottom()
}

// 메세지를 보낼때
//send 버튼 클릭
$('#chatSend').click(function(event){
	event.preventDefault()
	let msgContents = $('#message').val()
	let msgSender = getUrlParameter('roomSender')
	let msgRecipient = getUrlParameter('roomRecipient')
	let chatNum = $('#chatNum').val();
	let date = new Date().toLocaleTimeString();
	let senderProfile = $('#senderProfile').data('file-name')
	let senderName = $(this).data('sender-name')
	
	let fileInput = $('#fileInput')
	if(fileInput.length != 0 && fileInput[0].files.length > 0) {
		let file = fileInput[0].files[0]
		let fileName=file.name
		let reader = new FileReader()
		reader.onload = function(){
			let child
			if(msgContents != ''){
				child = '<div class="direct-chat-msg right">'
				child = child + '<div class="direct-chat-infos clearfix">'
				child = child + '<span class="direct-chat-name float-right">'+senderName+'('+msgSender+')'+'</span>'
				child = child + '<span class="direct-chat-timestamp float-left">'+date+'</span></div>'
				if(senderProfile == ''){
					child = child +'<img class="direct-chat-img" src="/images/profile.jpg" alt="message user image">'
				} else {
					child = child + '<img class="direct-chat-img"  src="/file/member/'+senderProfile+'" alt="message user image">'
				}
				child = child + '<div class="direct-chat-text text-right">'+msgContents+'</div></div>'
				$('#messageList').append(child)
				let message = {
					type : 'text',
					msgContents : msgContents,
					msgRecipient : msgRecipient,
					msgSender : msgSender,
					chatNum : chatNum
				}
				
				sendMessage(JSON.stringify(message))
			}
			child = '<div class="direct-chat-msg right">'
			child = child + '<div class="direct-chat-infos clearfix">'
			child = child + '<span class="direct-chat-name float-right">'+senderName+'('+msgSender+')'+'</span>'
			child = child + '<span class="direct-chat-timestamp float-left">'+date+'</span></div>'
			if(senderProfile == ''){
				child = child +'<img class="direct-chat-img" src="/images/profile.jpg" alt="message user image">'
			} else {
				child = child + '<img class="direct-chat-img"  src="/file/member/'+senderProfile+'" alt="message user image">'
			}
			child = child + '<div class="direct-chat-text text-right"><a href="#">'+fileName+'</a></div></div>'
			msgContents=fileName
			$('#messageList').append(child)
			let message = {
				type : 'file',
				file : file,
				fileName : fileName,
				msgContents : msgContents,
				msgRecipient : msgRecipient,
				msgSender : msgSender,
				chatNum : chatNum
			}
			
			sendMessage(JSON.stringify(message))
			let arrayBuffer=this.result
			console.log(arrayBuffer)
			sendMessage(arrayBuffer)
			scrollToBottom()
			$('#message').val('')
		}
		reader.readAsArrayBuffer(file)
		$('#fileSend').remove()
		count--
	} else {
		if(msgContents==''){
			return
		}
		let message = {
			type : 'text',
			msgContents : msgContents,
			msgRecipient : msgRecipient,
			msgSender : msgSender,
			chatNum : chatNum
		}
		
		let child = '<div class="direct-chat-msg right">'
		child = child + '<div class="direct-chat-infos clearfix">'
		child = child + '<span class="direct-chat-name float-right">'+senderName+'('+msgSender+')'+'</span>'
		child = child + '<span class="direct-chat-timestamp float-left">'+date+'</span></div>'
		if(senderProfile == ''){
			child = child +'<img class="direct-chat-img" src="/images/profile.jpg" alt="message user image">'
		} else {
			child = child + '<img class="direct-chat-img"  src="/file/member/'+senderProfile+'" alt="message user image">'
		}
		child = child + '<div class="direct-chat-text text-right">'+msgContents+'</div></div>'
		$('#messageList').append(child)
		sendMessage(JSON.stringify(message))
		scrollToBottom()
		$('#message').val('')
		$('#fileSend').remove()
		if(count=1){
			count--
		}
	}
	
})

//enter키 눌렀을때
$('#message').keydown(function(event) {
  if (event.key === 'Enter') {
	  event.preventDefault()
	let msgContents = $('#message').val()
	let msgSender = getUrlParameter('roomSender')
	let msgRecipient = getUrlParameter('roomRecipient')
	let chatNum = $('#chatNum').val();
	let date = new Date().toLocaleTimeString();
	let senderProfile = $('#senderProfile').data('file-name')
	let senderName = $('#chatSend').data('sender-name')
	
	let fileInput = $('#fileInput')
	if(fileInput.length != 0 && fileInput[0].files.length > 0) {
		let file = fileInput[0].files[0]
		let fileName=file.name
		let reader = new FileReader()
		reader.onload = function(){
			let child
			if(msgContents != ''){
				child = '<div class="direct-chat-msg right">'
				child = child + '<div class="direct-chat-infos clearfix">'
				child = child + '<span class="direct-chat-name float-right">'+senderName+'('+msgSender+')'+'</span>'
				child = child + '<span class="direct-chat-timestamp float-left">'+date+'</span></div>'
				if(senderProfile == ''){
					child = child +'<img class="direct-chat-img" src="/images/profile.jpg" alt="message user image">'
				} else {
					child = child + '<img class="direct-chat-img"  src="/file/member/'+senderProfile+'" alt="message user image">'
				}
				child = child + '<div class="direct-chat-text text-right">'+msgContents+'</div></div>'
				$('#messageList').append(child)
				let message = {
					type : 'text',
					msgContents : msgContents,
					msgRecipient : msgRecipient,
					msgSender : msgSender,
					chatNum : chatNum
				}
				
				sendMessage(JSON.stringify(message))
			}
			child = '<div class="direct-chat-msg right">'
			child = child + '<div class="direct-chat-infos clearfix">'
			child = child + '<span class="direct-chat-name float-right">'+senderName+'('+msgSender+')'+'</span>'
			child = child + '<span class="direct-chat-timestamp float-left">'+date+'</span></div>'
			if(senderProfile == ''){
				child = child +'<img class="direct-chat-img" src="/images/profile.jpg" alt="message user image">'
			} else {
				child = child + '<img class="direct-chat-img"  src="/file/member/'+senderProfile+'" alt="message user image">'
			}
			child = child + '<div class="direct-chat-text text-right"><a href="#">'+fileName+'</a></div></div>'
			msgContents=fileName
			$('#messageList').append(child)
			let message = {
				type : 'file',
				file : file,
				fileName : fileName,
				msgContents : msgContents,
				msgRecipient : msgRecipient,
				msgSender : msgSender,
				chatNum : chatNum
			}
			
			sendMessage(JSON.stringify(message))
			let arrayBuffer=this.result
			console.log(arrayBuffer)
			sendMessage(arrayBuffer)
			scrollToBottom()
			$('#message').val('')
		}
		reader.readAsArrayBuffer(file)
		$('#fileSend').remove()
		count--
	} else {
		if(msgContents==''){
			return
		}
		let message = {
			type : 'text',
			msgContents : msgContents,
			msgRecipient : msgRecipient,
			msgSender : msgSender,
			chatNum : chatNum
		}
		
		let child = '<div class="direct-chat-msg right">'
		child = child + '<div class="direct-chat-infos clearfix">'
		child = child + '<span class="direct-chat-name float-right">'+senderName+'('+msgSender+')'+'</span>'
		child = child + '<span class="direct-chat-timestamp float-left">'+date+'</span></div>'
		if(senderProfile == ''){
			child = child +'<img class="direct-chat-img" src="/images/profile.jpg" alt="message user image">'
		} else {
			child = child + '<img class="direct-chat-img"  src="/file/member/'+senderProfile+'" alt="message user image">'
		}
		child = child + '<div class="direct-chat-text text-right">'+msgContents+'</div></div>'
		$('#messageList').append(child)
		sendMessage(JSON.stringify(message))
		scrollToBottom()
		$('#message').val('')
		$('#fileSend').remove()
		if(count=1){
			count--
		}
	}
	
	}
});


//웹소켓 연결 해제
$(window).on('beforeunload', function() {
	websocket.close();
});

//스크롤 아래로 내리는 함수
function scrollToBottom(){
	let messageList = $('#messageList')
	messageList.scrollTop(messageList.prop("scrollHeight"))
}
scrollToBottom()

// url에서 파라미터 값을 뽑아오는 함수
function getUrlParameter(name){
	let urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(name);
}

// 메세지를 보내는 함수
function sendMessage(message){
	websocket.send(message)
}
