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
		
		.popup {
		  display:flex;
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
		span{
			line-height:1.5;
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
		    var calinfo = null;
		    var all_events = null;
			all_events = loadingEvents();
			console.log(all_events);
		    // initialize the external events
		    // -----------------------------------------------------------------

		    new Draggable(containerEl, {
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
		        right: 'gd'
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
		      dateClick: function (info) {
		    	  calinfo = info;
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
			    	var cancel_btn = document.querySelector("#cancel_btn");
			    	console.log(cancel_btn);
			    	cancel_btn.value = 1;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
			  },
		      droppable: true, // this allows things to be dropped onto the calendar
			  events: JSON.parse(JSON.stringify(all_events)),//요구되는 데이터 타입은 json - ajax로 받을 때 dataType:json명시해야함
		      drop: function(info) {//태그를 날짜에 drop하는 순간 작동
		    	  console.log(info.view);
		    	  calinfo = info;
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
		    	console.log(start_dt);
		    	console.log(end_dt);
		    	
				for(var i = 0;i<room_subject.options.length;i++){//드래그한 회의 주제를 popup창에서 selected되도록
					
					if(room_subject.options[i].value == infoInnerText){
						room_subject.options[i].selected = true;
					}			
					
				}
				var cancel_btn = document.querySelector("#cancel_btn");
		        // is the "remove after drop" checkbox checked?
		        if (checkbox.checked) {
		          // if so, remove the element from the "Draggable Events" list
		          info.draggedEl.parentNode.removeChild(info.draggedEl);
		        }
		      }
		    });
		    
		    calendar.render();
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
		    console.log(calinfo);
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
	    
	    	$.ajax({
	    		url : '/readReservation?reserveSeq='+node,
	    		type : 'GET',
				dataType  : "json", //리턴 데이터 타입 지정
	    		async : false,
		    	success : function(data){
		    		console.log("data : "+data);
		    			
		    		var start_dt = document.querySelector("#start_dt");//시작 시간 값
			    	var end_dt = document.querySelector("#end_dt");//종료시간 값
			    	for(var i=0;i<start_dt.length;i++){//날짜+시작or종료 시간 가공 (예시)2023-07-11 17:30:00
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
			    	
			    	
			    	room_content.value = data.roomContent;//회의내용 넣기
			    	
	    			console.log(data.regDt);//수정날짜 처리필요
	    			console.log(data.rgtrId);//수정자 처리필요
		    	}
	    	});
	    
	    
	    	var background = document.querySelector(".background");
	    	background.classList.add("show");
	    	
	    	var cancel_btn = document.querySelector("#cancel_btn");
	    	console.log(cancel_btn);
	    	cancel_btn.value = 1;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
	    	var reserv_btn = document.getElementById("reserv_btn");
	    	reserv_btn.style.display = "none";
	    	const updatebutton = document.createElement('button');
	    	updatebutton.innerHTML = '<button id="update_btn" onClick="updateReservation('+node+')">수정하기</button>';//매개변수 넣어주면 좋을것같은데..
	    	document.querySelector('#btn_div').prepend(updatebutton);
	    }
	    
	    
	    function updateReservation(node){//회의실 예약 내용 업데이트
	    	
	    	var room_subject = document.querySelector("#room_subject");//회의주제 select box node
	    	var room_content = document.querySelector("#room_content");//회의 내용 node
	    	console.log(document.querySelector("#start_dt"));
	    	var start_dt_val = document.querySelector("#start_dt").value;//시작 시간 값
	    	var end_dt_val = document.querySelector("#end_dt").value;//종료시간 값
	    	
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
	    	//content_cnt 콘텐츠 글자 수
	    	var param = {roomSubject : room_subject.value,
	    				 roomContent : room_content.value,
	    				 startDt : start_dt_val,
	    				 endDt : end_dt_val,
	    				 reserveSeq : node
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
	    
	    
		function reservationChk(){//예약하기 버튼을 눌렀을 떄
	    	
	    	var room_subject = document.querySelector("#room_subject");//회의주제 select box node
	    	var room_content = document.querySelector("#room_content");//회의 내용 node
	    	console.log(document.querySelector("#start_dt"));
	    	var start_dt_val = document.querySelector("#start_dt").value;//시작 시간 값
	    	var end_dt_val = document.querySelector("#end_dt").value;//종료시간 값
	    	
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
			var background = document.querySelector(".background");
			background.classList.remove("show");//모달팝업 삭제
			var room_content = document.querySelector("#room_content");
			var frame1 = document.querySelector(".fc-event-title-frame");
			var frame = document.getElementsByClassName("fc-event-title-frame");
			var cancel_btn = document.querySelector("#cancel_btn");
	    	console.log(cancel_btn);
			if(cancel_btn.value != 1){
				var frameParent = frame1.parentNode.parentNode.parentNode;
				frameParent.removeChild(frame1.parentNode.parentNode);
			}
			document.getElementById("update_btn").remove();
			cancel_btn.value = 0;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
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
					<button id="cancel_btn" value="0" onClick="modal_close()">취소</button>
				</div>
				</div>
				<div id="history_div" style="display:none">
					<span id="userId">등록자 : </span><br>
					<span id="regDay">등록날짜 : </span>
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