<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
<head>
	<link href='/fullcalendar/main.css' rel='stylesheet' />
	<script src='/fullcalendar/main.js'></script>
	<script src='/fullcalendar/locales/ko.js'></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
	<script src="https://unpkg.com/tippy.js@6"></script>
	
	
	<style>
		.fc-event{
			margin-top:2px;
			cursor:move;
		}
		.background {
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 100vh;
		  background-color: rgba(0, 0, 0, 0.3);
		  z-index: -1;
		  display:none;
		}
		
		.show {
		  display:block;
		  z-index: 1000;
		  transition: all 1s;
		}
		
		.window {
		  position: relative;
		  width: 100%;
		  height: 100%;
		}
		
		.historyNode{
			margin-bottom:-9%;
		}
		
		.popup {
		  display:flex;
		  flex-wrap: wrap;
		  align-items:center;
		  position: absolute;
		  top: 50%;
		  left: 50%;
		  transform: translate(-50%, -50%);
		  background-color: #ffffff;
		  box-shadow: 0 2px 15px rgba(0, 0, 0, 0.3);
		  border:2px solid rgb(92, 53, 148);
		  border-radius:0.2rem;
		transition: all 1s;
		  /* 임시 지정 */
		    width: 40rem;
		    height: 27rem;
		
		  /* /* 초기에 약간 아래에 배치 */
		  transform: translate(-50%, -40%);
		}
		.popup > *{
			margin-left:1rem;
		}
		span{
			line-height:1.5;
		}
		
		.fc-day-sun *{
    		color:#FF0000;
		}
		.fc-day-sat *{
			color:#0000FF;
		}
		
		
	</style>
<meta charset="UTF-8">
<title>회의실 예약</title>


  <script>
	  
	  document.addEventListener('DOMContentLoaded', function() {
		    var Calendar = FullCalendar.Calendar;
		    var Draggable = FullCalendar.Draggable;

		    var containerEl = document.getElementById('external-events');
		    var calendarEl = document.getElementById('calendar');
		    var checkbox = document.getElementById('drop-remove');
		    var all_events = null;
			all_events = loadingEvents();
			console.log(all_events);
			
		    // initialize the external events
		    // -----------------------------------------------------------------

		    new Draggable(containerEl, {//드래그 이벤트
		      itemSelector: '.fc-event',
		      eventData: function(eventEl) {
		        return {
		          title: eventEl.innerText
		        };
		      }
		    });

		    // initialize the calendar
		    // -----------------------------------------------------------------
			
		    var calendar = new Calendar(calendarEl, {
		      headerToolbar: {
		        left: 'prev,next today',
		        center: 'title',
		        right: ''
		      },
			  initialView: 'dayGridMonth',
		      locale : 'ko',
		      editable: true,
		      select: function(selectionInfo) {
		    	  console.log("selectionInfo");
		    	  console.log(selectionInfo);
		          calendar.addEvent({
		            title: 'dynamic event',
		            start: selectionInfo.start,
		            end: selectionInfo.end //need these and not endTime/startTime, otherwise they won't re-render
		          });
		          calendar.unselect();
	          },
	          /* dayMaxEventRows: true, // for all non-TimeGrid views
	          views: {
	            timeGrid: {
	              dayMaxEventRows: 6 // adjust to 6 only for timeGridWeek/timeGridDay
	            }
	          }, */
		      dateClick: function (info) {//날짜 공간 클릭시 event 작동
		    	  console.log(info);
		    	  console.log(info.view);
		    	  var background = document.querySelector(".background");
					background.classList.add("show");
					var room_subject = document.querySelector("#room_subject");
					
					console.log(room_subject.options);
					console.log(room_subject.options[0].value);
					
					var start_dt = document.querySelector("#start_dt");//시작 시간 값
			    	var end_dt = document.querySelector("#end_dt");//종료시간 값
			    	for(var i=0;i<start_dt.length;i++){//날짜+시작or종료 시간 가공 (예시)2023-07-11 17:30:00
			    		start_dt.options[i].value = info.dateStr+" "+start_dt.options[i].value; 
			    		end_dt.options[i].value = info.dateStr+" "+end_dt.options[i].value;
			    	}
			    	console.log(start_dt);
			    	console.log(end_dt);
			    	var close_btn = document.querySelector("#close_btn");
			    	console.log(close_btn);
			    	close_btn.value = 1;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
			  },
		      droppable: true, // this allows things to be dropped onto the calendar
			  events: JSON.parse(JSON.stringify(all_events)),//요구되는 데이터 타입은 json - ajax로 받을 때 dataType:json명시해야함
			  eventDidMount: function(info) {
				  var startStr = info.event.startStr;
				  var endStr = info.event.endStr;
				  console.log(startStr,endStr); 
				  console.log(info);
				  console.log(info.event);
				  /* const firstIconElements = document.querySelectorAll(
				    '.event-icon.first');
				  const secondIconElements = document.querySelectorAll(
				    '.event-icon.second'
				  );

				  // Element를 하나씩 for문으로 돌려서 이벤트를 걸어준다.
				  firstIconElements.forEach((element, key, parent) => {
				    element.addEventListener('click', firstIconClickHandler);
				  });
				  secondIconElements.forEach((element, key, parent) => {
				    element.addEventListener('click', secondIconClickHandler);
				  }); */
				  console.log(info.event.id);
				  var roomContent = "";
				  for (var i = 0; i < all_events.length; i++) {
					  if(all_events[i].id== info.event.id){
						  roomContent = all_events[i].roomContent;
					  }
					  console.log(all_events[i]);
					} 
				  console.log(all_events);
				  tippy(info.el, {
				      content: roomContent//회의 내용을 툴팁으로 가져옴.
				      });
				  },
		      drop: function(info) {//태그를 날짜에 drop하는 순간 작동
		    	  console.log(info.view);
		    	console.log(info);
		        console.log("drop됨");
		    	var background = document.querySelector(".background");
				background.classList.add("show");
				var infoInnerText = info.draggedEl.innerText; 
				var room_subject = document.querySelector("#room_subject");
				
				console.log(room_subject.options);
				console.log(infoInnerText);
				console.log(room_subject.options[0].value);
				
				var start_dt = document.querySelector("#start_dt");//시작 시간 값
		    	var end_dt = document.querySelector("#end_dt");//종료시간 값
		    	for(var i=0;i<start_dt.length;i++){//날짜+시작or종료 시간 가공 (예시)2023-07-11 17:30:00
		    		start_dt.options[i].value = info.dateStr+" "+start_dt.options[i].value; 
		    		end_dt.options[i].value = info.dateStr+" "+end_dt.options[i].value;
		    	}
		    	
				for(var i = 0;i<room_subject.options.length;i++){//드래그한 회의 주제를 popup창에서 selected되도록
					
					if(room_subject.options[i].value == infoInnerText){
						room_subject.options[i].selected = true;
					}			
					
				}
				var close_btn = document.querySelector("#close_btn");
		        // is the "remove after drop" checkbox checked?
		        if (checkbox.checked) {
		          // if so, remove the element from the "Draggable Events" list
		          info.draggedEl.parentNode.removeChild(info.draggedEl);
		        }
		      }
		    });
		    
		    
		    
		    calendar.render();//캘린더 렌더링
		    /* var items = document.querySelectorAll('.fc-event');
		    console.log(items);
		    items.forEach(function(item){
		    	alert("안녕?");
				item.addEventListener('dragstart', handleDragStart);
				item.addEventListener('dragover', handleDragOver);
				item.addEventListener('drop', handleDrop);
		    	console.log(item);
		    	console.log(this);
		    }); */
		    var dayevents = document.querySelectorAll('.fc-daygrid-event-harness');
		    
		    var dayEl = document.getElementsByClassName("fc-daygrid-event-harness");
		    console.log(dayEl);
		    console.log(all_events);
		    all_events.forEach(function(event){
		    	console.log(event);
		    	console.log("all_events 진입");
		    	console.log(event.id);
		    	console.log(event.location);
		    })
		    dayevents.forEach(function(dayevent){
		    	console.log(dayevent);
		    	console.log(dayevent.querySelector('.fc-daygrid-event-dot').id);
		    	console.log('');
		    	dayevent.addEventListener('click',function(){readReservation(dayevent.querySelector('.fc-daygrid-event-dot').id)});	
		    });
		  });
	  
	  
	  /* function handleDrop(e){//회의 주제를 날짜에 놓았을 때 발생
		  e.stopPropagation();//브라우저 리다이렉트 방지
		  alert("작동중?");
		  var background = document.querySelector(".background");
		  background.classList.add("show");
	  }
	  
	  function handleDragStart(e) {
			console.log("dragStart");
			this.style.opacity = '0.4';
	  }

		function handleDragOver(e) {
			if (e.preventDefault) {
			  e.preventDefault();//링크와 같은 것을 드래그할 경우 해당 링크로 이동하는 브라우저의 기본 동작을 방지
			}
			return false;
	    } */
	    /* new Date().toISOString().substring(0, 10); */
	    function loadingEvents(){//db에서 데이터 가져오기
	    	
	    	var result_data = null;
	    	
	    	$.ajax({
	    		url : '/getReservation',
	    		type : 'GET',
				dataType  : "json", //리턴 데이터 타입 지정
	    		data : {},
	    		async : false,
	    		success : function(data){
	    			result_data = data;
	    		}
	    		
	    	});
	    	
	    	return result_data;
	    }
	    
	    function readReservation(node){//캘린더에 예약되어있는 내역을 클릭해 modal popup 활성화
	    	console.log("node : "+node);
	    
	    	var background = document.querySelector(".background");
	    	background.classList.add("show");
	    	
	    	var close_btn = document.querySelector("#close_btn");
	    	console.log(close_btn);
	    	close_btn.value = 1;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
	    	var reserv_btn = document.getElementById("reserv_btn");
	    	reserv_btn.style.display = "none";
	    	const updatebutton = document.createElement('span');
	    	updatebutton.innerHTML = '<button id="cancel_btn" onClick="cancelReservation('+node+')">예약취소</button>';
	    	updatebutton.innerHTML += '<button id="update_btn" onClick="updateReservation('+node+')">수정하기</button>';
	    	document.querySelector('#btn_div').prepend(updatebutton);
	    
	    	$.ajax({
	    		url : '/readReservation?reserveSeq='+node,
	    		type : 'GET',
				dataType  : "json", //리턴 데이터 타입 지정
	    		async : false,
		    	success : function(data){
		    		console.log("data : "+data);
		    			
		    		document.getElementById("history_div").style.display = "block";//과거 내역 block
		    		
		    		var start_dt = document.querySelector("#start_dt");//시작 시간 값
			    	var end_dt = document.querySelector("#end_dt");//종료시간 값
			    	for(var i=0;i<start_dt.length;i++){//날짜+시작or종료 시간 가공 (예시)17:30:00 >> 2023-07-11 17:30:00
			    		start_dt.options[i].value = data.startDt.split(" ")[0]+" "+start_dt.options[i].value; 
			    		end_dt.options[i].value = data.endDt.split(" ")[0]+" "+end_dt.options[i].value;	
			    		if(start_dt.options[i].value == data.startDt){//시작값과 일치한다면 selected
			    			start_dt.options[i].selected = true;
			    		}
			    		if(end_dt.options[i].value == data.endDt){//종료값과 일치한다면 selected
			    			end_dt.options[i].selected = true;
			    		}
			    	}
			    	var room_content = document.querySelector("#room_content");
			    	var room_subject = document.querySelector("#room_subject");
			    	console.log(room_content);
			    	for(var i = 0;room_subject.length>i;i++){
			    		if(room_subject.options[i].value == data.roomSubject){
			    			room_subject.options[i].selected = true;
			    		}	
			    	}
			    	if(data.rgtrDepName != data.mdfrDepName){//만약 부서가 같지 않다면
						document.getElementById("update_btn").remove();//수정하기 버튼은 보이지 않음
						document.getElementById("cancel_btn").remove();//예약취소 버튼은 보이지 않음
			    	}
			    	
			    	///예약 히스토리 입력
			    	document.getElementById("rgtr_name").innerHTML = '등록자 : '+data.rgtrName+'('+data.rgtrDepName+')';//등록자이름
			    	document.getElementById("reg_dt").innerHTML = '등록일 : '+data.regDt;//등록날짜
			    	console.log("null 확인 실험");
			    	console.log(typeof null);
			    	console.log(data.mdfrName != null);
			    	console.log(data.mdfrName !== null);
			    	if(data.mdfrName !== null){
			    		document.getElementById("mdfr_name").innerHTML = '수정자 : '+data.mdfrName+'('+data.mdfrDepName+')';//수정자이름
			    		document.getElementById("mdfcn_dt").innerHTML = '수정일 : '+data.mdfcnDt;//수정날짜
			    	}
			    	
			    	console.log(data.rgtrDepName);//등록자 부서명
			    	console.log(data.mdfrDepName);//수정자 부서명
			    	console.log(data.rgtrName);//등록자 이름
			    	console.log(data.mdfrName);//수정자 이름
			    	room_content.value = data.roomContent;//회의내용 넣기
			    	
	    			console.log(data.regDt);//등록날짜 
	    			console.log(data.mdfcnDt);//수정 날짜
		    	}
	    	});
	    }
	    
	    function cancelReservation(node){//회의실 예약 취소
	    	
	    	console.log("node : "+node);
	    	var room_subject = document.querySelector("#room_subject");//회의주제 select box node
	    	var room_content = document.querySelector("#room_content");//회의 내용 node
	    	console.log(document.querySelector("#start_dt"));
	    	var start_dt_val = document.querySelector("#start_dt").value;//시작 시간 값
	    	var end_dt_val = document.querySelector("#end_dt").value;//종료시간 값
	    	
	    	$.ajax({
	    		url : '/cancelReservation?reserveSeq='+node,
	    		type : 'GET',
				contentType: 'application/json; charset=utf-8', // 파라미터 데이터 타입 지정
				dataType  : "json", //리턴 데이터 타입 지정
	    		async : false,
		    	success : function(data){
		    		console.log("data : "+data);
		    		switch(Number(data)){
		    		case 0:
		    			alert("예약이 취소되지 않았습니다.");
		    			break;
		    		case 1: 
		    			alert("성공적으로 예약이 취소되었습니다");
		    			location.reload(true);
		    			break;
		    		case 9999:
		    			alert("예상치 못 한 오류가 발생했습니다. 로그인 페이지로 이동합니다.");
		    			location.href="/login/logout";
		    			break;
		    		}
		    		
	    		}
	    		
	    	});
	    }
	    
	    
	    function updateReservation(node){//회의실 예약 내용 업데이트
	    	
	    	console.log("node : "+node);
	    	var room_subject = document.querySelector("#room_subject");//회의주제 select box node
	    	var room_content = document.querySelector("#room_content");//회의 내용 node
	    	
	    	var start_dt = document.querySelector("#start_dt");//시작 시간 값
	    	var start_dt_val = start_dt.options[start_dt.selectedIndex].value;
	    	var end_dt = document.querySelector("#end_dt");
	    	var end_dt_val = end_dt.options[end_dt.selectedIndex].value;//종료시간 값
	    	var start_hour = Number(start_dt_val.split(" ")[1].split(":")[0]);//시작 시간 (예)2023-07-11 17:30:00 >>17:30:00>>17 
	    	var start_minuet = Number(start_dt_val.split(" ")[1].split(":")[1]);//시작 분 
	    	var end_hour = Number(end_dt_val.split(" ")[1].split(":")[0]);//종료 시간
	    	var end_minuet = Number(end_dt_val.split(" ")[1].split(":")[1]);//종료 분
	    	
	    	
	    	console.log("업데이트 시작시간 : "+start_dt_val);
	    	console.log("업데이트 종료시간 : "+end_dt_val);
	    	
	    	
	    	if(room_content.value.trim().length == 0){//띄어쓰기만으로 작성할 수 없음
	    		alert("회의 내용을 입력해주세요");
	    		room_content.value = "";
	    		room_content.focus();
	    		return false;
	    	}
	    	console.log("start_dt_val : "+start_dt_val);
	    	if(room_content.value.length>2000){//회의 내용은 2000자를 넘길 수 없음
	    		alert("회의 내용은 2000자를 초과할 수 없습니다.");
	    		return false;
	    	}
	    	
	    	if(start_dt_val == end_dt_val){
	    		alert("시작시간과 종료시간은 같을 수 없습니다.");
	    		return false;
	    	}
	    	
	    	if(start_hour >= end_hour){//시작 시간과 종료시간이 같거나 종료시간이 큰 경우
	    		if(start_hour > end_hour||start_minuet > end_minuet){
	    			alert("시작시간보다 종료시간이 이전일 수 없습니다.");
		    		return false;	
	    		}
	    	}
	    	
	    	//content_cnt 콘텐츠 글자 수
	    	var param = {roomSubject : room_subject.value,
	    				 roomContent : room_content.value,
	    				 startDt : start_dt_val,
	    				 endDt : end_dt_val,
	    				 reserveSeq : node
	    				 };
	    	
	    	console.log(JSON.stringify(param));
	    	
	    	$.ajax({
	    		url : '/updateReservation',
	    		type : 'POST',
				contentType: 'application/json; charset=utf-8', // 파라미터 데이터 타입 지정
				dataType  : "json", //리턴 데이터 타입 지정
	    		data : JSON.stringify(param),
	    		async : false,
		    	success : function(data){
		    		console.log("data : "+data);
		    		switch(Number(data)){
		    		case 0:
		    			alert("예약이 변경되지 않았습니다.");
		    			break;
		    		case 1: 
		    			alert("성공적으로 예약이 변경되었습니다");
		    			location.reload(true);
		    			break;
		    		case 7777:
		    			alert("이미 예약이 존재합니다. 시작시간을 변경해주세요.");
		    			break;
		    		case 8888:
		    			alert("이미 예약이 존재합니다. 종료시간을 변경해주세요.");
		    			break;
		    		case 9999:
		    			alert("예상치 못 한 오류가 발생했습니다. 로그인 페이지로 이동합니다.");
		    			location.href="/login/logout";
		    		case 0000:
	    				alert("같은 부서 팀원만 수정할 수 있습니다.");
	    				break;
		    		}
		    		
	    		}
	    		
	    	});
	    	
	    }
	    
	    
		function reservationChk(){//예약하기 버튼을 눌렀을 떄
	    	
	    	var room_subject = document.querySelector("#room_subject");//회의주제 select box node
	    	var room_content = document.querySelector("#room_content");//회의 내용 node
	    	
	    	
	    	var start_dt = document.querySelector("#start_dt");//시작 시간 값
	    	var start_dt_val = start_dt.options[start_dt.selectedIndex].value;//시작 시간 selected 값
	    	var end_dt = document.querySelector("#end_dt");//종료 시간 값
	    	var end_dt_val = end_dt.options[end_dt.selectedIndex].value;//종료시간 selected 값
	    	var start_hour = Number(start_dt_val.split(" ")[1].split(":")[0]);//시작 시간 (예)2023-07-11 17:30:00 >> 17:30:00 >> 17
	    	var start_minuet = Number(start_dt_val.split(" ")[1].split(":")[1]);//시작 분 (예)2023-07-11 17:30:00 >> 17:30:00 >> 30
	    	var end_hour = Number(end_dt_val.split(" ")[1].split(":")[0]);//종료 시간
	    	var end_minuet = Number(end_dt_val.split(" ")[1].split(":")[1]);//종료 분
	    	
	    	console.log("업데이트 시작시간 : "+start_dt_val);
	    	console.log("업데이트 종료시간 : "+end_dt_val);
	    	
	    	
	    	if(room_content.value.trim().length == 0){//띄어쓰기만으로 작성할 수 없음
	    		alert("회의 내용을 입력해주세요");
	    		room_content.value = "";
	    		room_content.focus();
	    		return false;
	    	}
	    	
	    	if(room_content.value.length>2000){//회의 내용은 2000자를 넘길 수 없음
	    		alert("회의 내용은 2000자를 초과할 수 없습니다.");
	    		return false;
	    	}
	    	if(start_dt_val == end_dt_val){
	    		alert("시작시간과 종료시간은 같을 수 없습니다.");
	    		return false;
	    	}
	    	
	    	if(start_hour >= end_hour){//시작 시간과 종료시간이 같거나 종료시간이 큰 경우
	    		if(start_hour > end_hour||start_minuet > end_minuet){
	    			alert("시작시간보다 종료시간이 이전일 수 없습니다.");
		    		return false;	
	    		}
	    	}
	    	//content_cnt 콘텐츠 글자 수
	    	var param = {roomSubject : room_subject.value,
	    				 roomContent : room_content.value,
	    				 startDt : start_dt_val,
	    				 endDt : end_dt_val
	    				 };
	    	
	    	console.log(JSON.stringify(param));
	    	
	    	$.ajax({
	    		url : '/makeReservation',
	    		type : 'POST',
				contentType: 'application/json; charset=utf-8', // 파라미터 데이터 타입 지정
				dataType  : "json", //리턴 데이터 타입 지정
	    		data : JSON.stringify(param),
	    		async : false,
	    	success : function(data){
	    		console.log("data : "+data);
	    		switch(Number(data)){
	    		case 0:
	    			alert("예약되지 않았습니다.");
	    			break;
	    		case 1: 
	    			alert("성공적으로 예약되었습니다");
	    			location.reload(true);
	    			break;
	    		case 7777:
	    			alert("이미 예약이 존재합니다. 시작시간을 변경해주세요.");
	    			break;
	    		case 8888:
	    			alert("이미 예약이 존재합니다. 종료시간을 변경해주세요.");
	    			break;
	    		case 9999:
	    			alert("예상치 못 한 오류가 발생했습니다. 로그인 페이지로 이동합니다.");
	    			location.href="/login/logout";
	    		}
	    		
	    	}
	    	});
	    	
		}
		
		function modal_close(){//취소 버튼을 눌렀을 때  -- 아직 보류중
			
			var start_dt = document.querySelector("#start_dt");//시작 시간 값
	    	var end_dt = document.querySelector("#end_dt");//종료시간 값
	    	for(var i=0;i<start_dt.length;i++){//날짜+시작or종료 시간 삭제 (예시)2023-07-11 17:30:00 >>17:30:00 
	    		start_dt.options[i].value = start_dt.options[i].value.split(" ")[1]; 
	    		end_dt.options[i].value = end_dt.options[i].value.split(" ")[1];	
	    	}
			
			var background = document.querySelector(".background");//팝업창 배경(팝업이 뜨는지 유무를 background에서 처리)
			var room_content = document.querySelector("#room_content");//회의 내용 node
			var frame = document.querySelector(".fc-event-title-frame");//예약되어있는 목록들 node
			var reserv_btn = document.getElementById("reserv_btn");//예약 버튼 element
			var close_btn = document.querySelector("#close_btn");//모달 팝업 닫기 버튼 node
			
			var btn_div = document.getElementById("btn_div");//버튼div element선택
			
			background.classList.remove("show");//모달팝업 안보이게			
			room_content.value="";//글내용 초기화
			start_dt.options[0].selected = true;//시작시간 초기화
	    	end_dt.options[0].selected = true;//종료시간 초기화
	    	if(reserv_btn){//예
	    		reserv_btn.style.display = "block";//예약버튼 보이게
	    	}
	    	
	    	if(btn_div.childNodes[0].nodeName == "SPAN"){//btn_div의 0번째 노드의 이룸이 "SPAN"일 때만 - 예약된 회의 클릭시만 작동
	    		btn_div.childNodes[0].remove();//<span>태그 삭제
	    	}
	    	
			if(close_btn.value != 1){//드래그 해온 일정라벨 삭제(미완..) - 드래그 해서 라벨을 가져왔으나 팝업취소할 경우
				var frameParent = frame.parentNode.parentNode.parentNode;//상위 부모노드 찾아서
				frameParent.removeChild(frame.parentNode.parentNode);//자녀노드 전부 삭제
			}
			if(document.getElementById("update_btn")){//update버튼이 있다면  -- 위의 span태그 삭제하면 없어지긴 하는데 일단 방치
				document.getElementById("update_btn").remove();//예약 수정버튼 삭제
				document.getElementById("cancel_btn").remove();//예약 취소버튼 삭제
			}
			document.getElementById("history_div").style.display = "none";//과거 내역 none
			close_btn.value = 0;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
			/* frame[0].remove(); */
		}
		
  </script>
  
</head>

<body>

	<div class="background">
		<div class="window">
			<div class="popup">
				<div>
				<table style="margin:0 auto;border-collapse:separate;border-spacing: 0 10px;margin-bottom: 100px;">
					<tbody>
						<tr style="margin-bottom:50px;">
							<th><span style="font-size:1.5rem;">회의 주제 : </span></th>
							<td>
								<select id="room_subject">
									<option value="일간 회의">일간 회의</option>
									<option value="주간 회의">주간 회의</option>
									<option value="공부">공부</option>
									<option value="기타">기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><span style="font-size:1.5rem;">회의 내용 : </span></th>
							<td><textArea id="room_content" placeholder="회의 내용을 적어주세요"></textArea></td>
							<td><span id="content_cnt" style="font-size:0.5rem;"></span></td>
						</tr>
						<tr>
							<th><span style="font-size:1.5rem;">시작 시간 : </span></th>
							<td>
								<select id="start_dt">
									<option value="09:00:00">9:00</option>
									<option value="09:30:00">9:30</option>
									<option value="10:00:00">10:00</option>
									<option value="10:30:00">10:30</option>
									<option value="11:00:00">11:00</option>
									<option value="11:30:00">11:30</option>
									<option value="12:00:00">12:00</option>
									<option value="12:30:00">12:30</option>
									<option value="13:00:00">13:00</option>
									<option value="13:30:00">13:30</option>
									<option value="14:00:00">14:00</option>
									<option value="14:30:00">14:30</option>
									<option value="15:00:00">15:00</option>
									<option value="15:30:00">15:30</option>
									<option value="16:00:00">16:00</option>
									<option value="16:30:00">16:30</option>
									<option value="17:00:00">17:00</option>
								</select>
							</td>
							<th><span style="font-size:1.5rem;">종료 시간 : </span></th>
							<td>
								<select id="end_dt">
									<option value="09:30:00">9:30</option>
									<option value="10:00:00">10:00</option>
									<option value="10:30:00">10:30</option>
									<option value="11:00:00">11:00</option>
									<option value="11:30:00">11:30</option>
									<option value="12:00:00">12:00</option>
									<option value="12:30:00">12:30</option>
									<option value="13:00:00">13:00</option>
									<option value="13:30:00">13:30</option>
									<option value="14:00:00">14:00</option>
									<option value="14:30:00">14:30</option>
									<option value="15:00:00">15:00</option>
									<option value="15:30:00">15:30</option>
									<option value="16:00:00">16:00</option>
									<option value="16:30:00">16:30</option>
									<option value="17:00:00">17:00</option>
									<option value="17:30:00">17:30</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				<div id="btn_div">
					<button id="reserv_btn" onClick="reservationChk()">예약하기</button>
					<button id="close_btn" value="0" onClick="modal_close()">닫기</button>
				</div>
				</div>
				<div id="history_div" style="display:none">
					<p class="historyNode" id="rgtr_name"></p>
					<p class="historyNode" id="reg_dt"></p>
					<p class="historyNode" id="mdfr_name"></p>
					<p class="historyNode" id="mdfcn_dt"></p>
				</div>
			</div>		
		</div>
	</div>


  <div id='external-events' style="float:left;width:10%;padding-right:30px;padding-left:20px;margin-top:110px;">
  
	<p>
		<strong>회의를 원하는 날짜에 드래그하여 예약하세요.</strong>
	</p>

    <div draggable = "true" class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
      <div class='fc-event-main'>일간 회의</div>
    </div>
    <div draggable = "true" class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
      <div class='fc-event-main'>주간 회의</div>
    </div>
    <div draggable = "true" class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
      <div class='fc-event-main'>공부</div>
    </div>
    <div draggable = "true" class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
      <div class='fc-event-main'>기타</div>
    </div>
    <p>
      <input type='checkbox' id='drop-remove' />
      <label for='drop-remove'>드래그앤드롭 후 제거</label>
    </p>
  </div>

	<div style="float:left;width:80%">
		<div style="text-align:center;height:30px;font-size:35px;font-weight:bold;margin-bottom:30px;">회의실 예약 달력표</div>
		<div id='calendar' ></div>
	</div>
</body>
</html>