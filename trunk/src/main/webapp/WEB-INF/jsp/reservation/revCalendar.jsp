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
<jsp:include page="/WEB-INF/jsp/inc/import.jsp" flush="false" />
<link rel="stylesheet" type="text/css" href="/css/board/board.css">

<style>
.fc-event {
	margin-top: 2px;
	cursor: pointer;
}

.background {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0.3);
	z-index: -1;
	display: none;
}

.show {
	display: block;
	z-index: 1000;
	transition: all 1s;
}

.window {
	position: relative;
	width: 100%;
	height: 100%;
}

.historyNode {
	margin-bottom: -9%;
}

.popup {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background-color: #ffffff;
	box-shadow: 0 2px 15px rgba(0, 0, 0, 0.3);
	border: 2px solid rgb(92, 53, 148);
	border-radius: 0.2rem;
	transition: all 1s;
	/* 임시 지정 */
	width: 600px;
	height: 440px;
	/* /* 초기에 약간 아래에 배치 */
	transform: translate(-50%, -40%);
}

.popup>* {
	margin-left: 1rem;
}

span {
	line-height: 1.5;
}

.fc-day-sun * {
	color: #FF0000;
}

.fc-day-sat * {
	color: #0000FF;
}

#reserve_table{
	table-layout:fixed;
}

textArea{
	height:auto;
	resize: none;
}

.fc-sticky{
	white-space: nowrap;
}

.fc-daygrid-event .fc-event-time,.fc-event-title{
	white-space: nowrap;
}
 
#btn_div button{
    border-radius: 4px;
	padding: 10px;
} 

.mgt_room_list_ul li:hover{
 	background-color: #6f6b6b;
}
/* .fc-daygrid-event-harness .fc-event-title{
	white-space: normal;
} */
/* #history_div {
	display: none;
	white-space: break-spaces;
	width: 100%;
	margin-bottom: 100px;
} */

.fc-daygrid-event-harness-abs .fc-daygrid-event-dot {
	display: none;
}

#step_list li {
	width: 18%;
	float: none;
	height: 40px;
	font-size: 11px;
	padding: 5px 10px 5px 33px;
	display: flex;
	align-items: center;
	justify-content: center;
}

#step_list {
	display: flex;
	flex-wrap: wrap;
	margin-bottom: 20px;
	justify-content: space-around;
}

li{
	height:48px;
	white-space: nowrap;
}

li a{
	vertical-align:middle;
}

.not_selected {
	display: none;
}

.cal_active {
	visibility: visible; /* invisible로 해야함 */
}

.selected_room {
	border: 1px;
	background-color: #A49D91;
}

#mgt_list{
	position: absolute;
    top: 265px;
    left: 270px;
    width: 100px;
    height: 534px;
}

#mgt_floor_list {
	position: absolute;
    width: 100px;
	padding-top: 2px;
	padding-left: 2px;
	padding-right: 2px;
	border: 0.2px solid #c4c4c4;
 	height: 523px; 
	background-color:#fff;
}

.mgt_room_list{
	position: absolute;
    top:0;
    left:95px;
    height:523px;
    width: 150px; 
    border: 0.2px solid #c4c4c4;
    background-color:#fff; 
    display:none;
}

td{
	white-space: pre;	
}

#mgt_floor_list_ul{
	/*height:470px;*/
}

.floor{
	margin:0 auto;
}
 .floor:hover{
    background-color: #6f6b6b;
}

#external-events{
	float: left;
    padding-right: 30px;
    padding-top: 11.2%;
}

.mgt_room_list_ul{
	text-align:center;
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
		    
		    var mgt_room_id = "${mgtRoomId}";//서버에서 받아온 회의실 고유 id값
		    
		    getRsvtType();//회의실 유형 데이터 가져와 select box에 option으로 추가 하기  - 일회성,정기 회의 명
		    
		    getRoomInfo(mgt_room_id);//예)6F01 형식 
			all_events = loadingEvents(mgt_room_id);
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
		      contentHeight:"auto",
			  initialView: 'dayGridMonth',
		      locale : 'ko',
		      editable: false,
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
	         /*  customButtons: {
	        	  customPrev: {
	        	      icon: 'fc-icon-chevron-left',
	        	      click: function() {
	        	        alert('clicked left custom button!');
	        	      }
	        	    },
		          customNext: {
	        	      icon: 'fc-icon-chevron-right',
	        	      click: function() {
	        	        alert('clicked right custom button!');
	        	      }
	        	    }
        	  }, */
	          
	          /* dayMaxEventRows: true, // for all non-TimeGrid views
	          views: {
	            timeGrid: {
	              dayMaxEventRows: 6 // adjust to 6 only for timeGridWeek/timeGridDay
	            }
	          }, */
		      dateClick: function (info) {//날짜 공간 클릭시 event 작동
		    	  
		    	    console.log(info);
		    	    var background = document.querySelector(".background");
					background.classList.add("show");
					var mgt_type_code = document.querySelector("#mgt_type_code");
					
					document.getElementById("use_bgng_ymd").value = info.dateStr;//시작 날짜 클릭 해당 날짜 초기 세팅
			   		document.getElementById("use_end_ymd").value = info.dateStr;//종료 날짜 클릭 해당 날짜 초기 세팅

			   		console.log("use_bgng_ymd"+document.getElementById("use_bgng_ymd").value);
					console.log(""+document.getElementById("use_end_ymd").value);
					
			    	var close_btn = document.querySelector("#close_btn");
			    	console.log(close_btn);
			    	close_btn.value = 1;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
			  },
		      droppable: true, // this allows things to be dropped onto the calendar
			  events: JSON.parse(JSON.stringify(all_events)),//요구되는 데이터 타입은 json - ajax로 받을 때 dataType:json명시해야함
			  eventClick: function(info) {
				  console.log("eventClick info");
				  readReservation(info.event._def.publicId);
			  },
			  eventDidMount: function(info) {
				  var startStr = info.event.startStr;
				  var endStr = info.event.endStr;
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
				  var mgt_cn = "";
				  for (var i = 0; i < all_events.length; i++) {
					  if(all_events[i].id== info.event.id){//db에서 가져온 id와 캘린더에 가공해서 넣은 id값이 일치할 때
						  mgt_cn = all_events[i].mgtCn;//db에서 가져온 회의 내용을 변수 대입
					  }
				  } 
				  tippy(info.el, {
				      content: mgt_cn//회의 내용을 툴팁으로 넣음.
				      });
				  },
		      drop: function(info) {//태그를 날짜에 drop하는 순간 작동
		    	console.log("info");
		    	console.log(info);
		    	
	    	    console.log(info.view);
		    	var background = document.querySelector(".background");
				background.classList.add("show");
				var infoInnerText = info.draggedEl.innerText; 
				var mgt_type_code = document.querySelector("#mgt_type_code");
				console.log(infoInnerText);
				
				document.getElementById("use_bgng_ymd").value = info.dateStr;//시작 날짜 클릭 해당 날짜 초기 세팅
		   		document.getElementById("use_end_ymd").value = info.dateStr;//종료 날짜 클릭 해당 날짜 초기 세팅
		    	
				for(var i = 0;i<mgt_type_code.options.length;i++){//드래그한 회의 주제를 popup창에서 selected되도록
					
					if(mgt_type_code.options[i].text == infoInnerText){
						mgt_type_code.options[i].selected = true;
					}			
				}
		   		
				/* var barNodes = document.getElementsByClassName("fc-daygrid-event fc-daygrid-block-event fc-h-event fc-event fc-event-start fc-event-end");
				
				console.log(barNodes);
				console.log(barNodes.length);
				console.log(document.getElementsByClassName("fc-daygrid-event fc-daygrid-block-event fc-h-event fc-event fc-event-start fc-event-end").length);
				console.log(barNodes[0]);
				console.log(barNodes[1]);
				console.log(barNodes[2]);
				
				console.log(typeof barNodes[0]);
				console.log(typeof barNodes[1]);
				console.log(typeof barNodes[2]); */
				
				/* console.log(typeof barNodes[0].innerText);
				console.log(typeof barNodes[1].innerText);
				console.log(typeof barNodes[2].innerText);
				console.log(barNodes[0].innerText);
				console.log(barNodes[1].innerText);
				console.log(barNodes[2].innerText); */
				
				/* console.log("barNodes.length : "+barNodes.length);
				for(var i=0;i<barNodes.length;i++){
					
					if(typeof barNodes[i] == "undefined"){
						console.log("undefined");
					}
					if(typeof barNodes[i] != "undefined"){
						
						if(barNodes[i].children[0].children.length == 0){
							barNodes[i].parentNode.style.display = "none";
						}
						
						console.log("not undefined");
						console.log(barNodes[i]);
						console.log(barNodes[i].children[0].children.length);
						console.log(barNodes[i].childNodes[0].childNodes[0]);
						console.log(barNodes[i].childNodes[0].childNodes[0]);
						console.log(barNodes[i].attributes);
					}
				} */ 
				
				/* barNodes.forEach(function(barNode){
					console.log(barNode.innerText);
				}) */
				
		   		console.log(info);
		   		console.log(info.draggedEl);
				var close_btn = document.querySelector("#close_btn");
		        // is the "remove after drop" checkbox checked?
		          // if so, remove the element from the "Draggable Events" list
		          /* info.draggedEl.parentNode.removeChild(info.draggedEl); *///왼쪽 드래그할 회의 유형 바 삭제
		      }
		    });
		    
		    
		    calendar.render();//캘린더 렌더링
		    
		    
		  });
	  
	  
	    function loadingEvents(mgtRoomId){//db에서 데이터 가져오기
	    	console.log("loadingEvents 진입확인");
	    	var result_data = null;
	    	
	    	$.ajax({
	    		url : '/getReservation?mgtRoomId='+mgtRoomId,
	    		type : 'GET',
				dataType  : "json", //리턴 데이터 타입 지정
	    		async : false,
	    		success : function(data){
	    			result_data = data;
	    			console.log(data);
	    		}
	    		
	    	});
	    	
	    	return result_data;
	    }
	    
	    function scrollText(node){//textArea scroll이동시 작동 - 현재 줄로 이동 // 파라미터 node = 엘리먼트
			node.style.height='auto';

			if(document.querySelector('#'+node.id).scrollHeight > 60){//스크롤 높이가 90을 넘었을 경우에
				node.style.height = 60+"px";
			}else{
				node.style.height=document.querySelector('#'+node.id).scrollHeight+8+"px";
			} 
	    }
	    
	    function readReservation(node){//캘린더에 예약되어있는 내역을 클릭해 modal popup 활성화// 파라미터 node = id값
				    
	    	var background = document.querySelector(".background");
	    	background.classList.add("show");
	    	
	    	var select_day_box = document.querySelector("#select_day");
			var select_day_label = document.querySelector("#select_day_label"); 
	    	select_day_box.style.display = "none";
	    	select_day_label.style.display = "none";
	    	
	    	console.log("readReservation  :  "+node);
	    	
	    	var close_btn = document.querySelector("#close_btn");//닫기 버튼
	    	
	    	console.log(close_btn);
	    	close_btn.value = 1;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
	    	var reserv_btn = document.getElementById("reserv_btn");
	    	reserv_btn.style.display = "none";
	    	
	    	const updatebutton = document.createElement('span');//버튼용 span 생성
	    	updatebutton.innerHTML = "<button id='cancel_btn' onClick='cancelReservation(\""+node+"\")'>예약취소</button>";
	    	updatebutton.innerHTML += "<button id='update_btn' onClick='updateReservation(\""+node+"\")'>수정하기</button>";
	    	document.querySelector('#btn_div').prepend(updatebutton);
	    	
	    	console.log(document.querySelector("#update_btn"));
	    	console.log(document.querySelector("#cancel_btn"));
	    	$.ajax({
	    		url : '/readReservation?id='+node,
	    		type : 'GET',
				dataType  : "json", //리턴 데이터 타입 지정
	    		async : false,
		    	success : function(data){
		    			
		    		var use_bgng_ymd = document.querySelector("#use_bgng_ymd");// 시간일자 2023-08-24
		    		var use_end_ymd = document.querySelector("#use_end_ymd");// 종료일자 2023-08-27
		    		var use_bgng_tm = document.querySelector("#use_bgng_tm");//시작 시각 값 예시) 090000
			    	var use_end_tm = document.querySelector("#use_end_tm");//종료시각 값 예시) 100000
	
			    	var use_se_code = document.querySelector("#use_se_code");//연속예약 여부확인 체크박스
			    	
			    	use_bgng_ymd.value = data.useBgngYmd;//시작일자 date타입에 값 입력
			    	use_end_ymd.value = data.useEndYmd;//종료일자 date타입에 값 입력
			    	
			    	for(var i = 1;i<6;i++){//반복요일 selected
			    		if(new Date(data.useBgngYmd).getDay() == i){
			    			select_day_box.options[i-1].selected = true;
				    	}	
			    	}
			    	
			    	for(var i=0;i<use_bgng_tm.length;i++){//팝업창 열었을 때 DB에서 가져온 날짜,시간 selected
			    		if(use_bgng_tm.options[i].value == data.useBgngTm){//시작값과 일치한다면 selected
			    			use_bgng_tm.options[i].selected = true;
			    		}
			    		if(use_end_tm.options[i].value == data.useEndTm){//종료값과 일치한다면 selected
			    			use_end_tm.options[i].selected = true;
			    		}
			    	} 
			    	
			    	var mgt_type_code = document.querySelector("#mgt_type_code");//회의종류
			    	var mgt_nm = document.querySelector("#mgt_nm");//회의제목
			    	var mgt_cn = document.querySelector("#mgt_cn");//회의내용
			    	
			    	for(var i = 0;mgt_type_code.length>i;i++){
			    		if(mgt_type_code.options[i].value == data.mgtTypeCode){//회의종류 확인
			    			mgt_type_code.options[i].selected = true;//일치할 시 selected
			    			if(mgt_type_code.options[i].value == "01"){//일회성 회의일경우
			    				use_bgng_ymd.readOnly = true;
			    		    	use_end_ymd.readOnly = true;	
			    			}
			    			
			    			if(mgt_type_code.options[i].value == "03"){//정기회의 주간 일 경우
			    				select_day_box.style.display = "block";
			    		    	select_day_label.style.display = "block";
			    		    	select_day_box.disabled = true;
			    		    	use_bgng_ymd.readOnly = true;
			    		    	use_end_ymd.readOnly = true;
			    			}
			    		}	
			    	}
			    	
			    	if(data.mgtTypeCode == "04"){
			    		use_bgng_tm.disabled = true;
			    		use_end_tm.disabled = true;	    		
			    	}
			    	
			    	mgt_type_code.disabled = true;//회의 종류 disabled
			    	
			    	if(data.rgtrDepName != data.mdfrDepName){//만약 부서가 같지 않다면
						document.getElementById("update_btn").remove();//수정하기 버튼이 보이지 않음
						document.getElementById("cancel_btn").remove();//예약취소 버튼이 보이지 않음
			    	}
			    	
			    	///예약 히스토리 입력
			    	var reserve_table = document.querySelector("#reserve_table");//팝업창 띄웠을 때 예약정보가 적혀있는 table태그 id
			    	console.log(reserve_table);
			    	console.log(reserve_table.children[0]);
			    	
			    	var reserve_tr = document.createElement("tr");
			    	var reserve_th = document.createElement("th");
			    	var reserve_td = document.createElement("td");
			    	var reserve_th_span = document.createElement("span");
			    	var reserve_td_span = document.createElement("span");
			    	
			    	reserve_th_span.style="font-size: 1.7rem";
			    	reserve_th_span.innerHTML = '예약자 : ';
			    	reserve_th.append(reserve_th_span);
			    	reserve_td_span.style="font-size: 1.7rem";
			    	reserve_td_span.innerHTML = data.rgtrName+'('+data.rgtrDepName+')';//등록자이름
			    	reserve_td.append(reserve_td_span);
			    	
			    	reserve_tr.append(reserve_th);//tr태그에 th태그 추가
			    	reserve_tr.append(reserve_td);//tr태그에 td태그 추가
			    	
			    	reserve_tr.id = "reserve_tr";
			    	
			    	reserve_table.children[1].append(reserve_tr);//tr태그 추가
			    	
			    	mgt_nm.value = data.mgtNm;//회의 제목 값 입력
			    	mgt_nm.style.height='auto';
			    	
					if(mgt_nm.scrollHeight > 60){//스크롤 높이가 90을 넘었을 경우에
						/* document.querySelector('#'+node.id).scrollHeight = 90; */
						mgt_nm.style.height = 60+"px";
					}else{
						mgt_nm.style.height=mgt_nm.scrollHeight+8+"px";				
					}
					
					mgt_cn.value = data.mgtCn;//회의 내용 값 입력
					mgt_cn.style.height='auto';
					
					if(mgt_cn.scrollHeight > 60){//스크롤 높이가 90을 넘었을 경우에
						/* document.querySelector('#'+node.id).scrollHeight = 90; */
						mgt_cn.style.height = 60+"px";
					}else{
						mgt_cn.style.height=mgt_cn.scrollHeight+8+"px";				
					}
		    	}
	    	});
	    }
	    
	    function cancelReservation(node){//회의실 예약 취소
	    	
	    	console.log("node : "+node);
	    	console.log(document.querySelector("#use_bgng_tm"));
	    	var use_bgng_tm_val = document.querySelector("#use_bgng_tm").value;//시작 시간 값
	    	var use_end_tm_val = document.querySelector("#use_end_tm").value;//종료시간 값
	    	
	    	$.ajax({
	    		url : '/cancelReservation?id='+node,
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
	    
 	   	function selectMgtType(node){//회의종류 select box 선택시 , node : this(select객체)

	   		var use_bgng_tm = document.getElementById("use_bgng_tm");//시작 시각 노드
	   		var use_end_tm = document.getElementById("use_end_tm");//종료 시각 노드
			var use_end_ymd = document.querySelector("#use_end_ymd");//종료일자 노드
			var select_day_box = document.querySelector("#select_day");
			var select_day_label = document.querySelector("#select_day_label");

	   		if(node.value == "02"){
	   			alert("선택하는 기간동안 회의실 예약이 되풀이 됩니다");
	   		}
	   		if(node.value == "03"){
	   			alert("선택하는 요일로 매주 회의실 예약이 되풀이 됩니다");
	   			select_day.style.display = "block";
	   			select_day_label.style.display = "block";
	   		}else{
	   			select_day.style.display = "none";
	   			select_day_label.style.display = "none";
	   		}
	   		
	   		if(node.value == "04"){//넘기는 파라미터 시간을 맥스로 해야할듯+화면에 시간표기 
	   			alert("선택하는 기간동안 회의실을 종일 사용합니다.");
	   			console.log(use_bgng_tm);
	   			console.log(use_end_tm);
	   			use_bgng_tm.disabled = true;
	   			use_end_tm.disabled = true;
	   		}else{
	   			use_bgng_tm.disabled = false;
	   			use_end_tm.disabled = false;
	   		}
	   	}
	    
	    function updateReservation(node){//회의실 예약 내용 업데이트 // node - 회의실 고유 번호
	    	console.log("updateReservation");
	    	
	    	var useBgngYmd = node.split("-")[1];
	    	var useBgngTm = node.split("-")[2];
	    	var mgtTypeCode = node.split("-")[3];//회의타입코드
	    	
	    	var mgt_nm = document.querySelector("#mgt_nm");//회의 주제 노드
	    	var mgt_cn = document.querySelector("#mgt_cn");//회의 내용 노드
	    	
	    	var use_bgng_ymd = document.querySelector("#use_bgng_ymd");//시작일자 노드
	    	var use_end_ymd = document.querySelector("#use_end_ymd");//종료일자 노드
	    	var use_bgng_ymd_val = document.querySelector("#use_bgng_ymd").value;//예약 시작 일자 node
	    	console.log("use_bgng_ymd_val : "+use_bgng_ymd_val);
	    	var use_end_ymd_val = document.querySelector("#use_end_ymd").value;//예약 종료 일자 node
	    	console.log("use_end_ymd_val : "+use_end_ymd_val);
	    	
	    	var use_bgng_tm = document.querySelector("#use_bgng_tm");//시작 시간 값
	    	var use_bgng_tm_val = use_bgng_tm.options[use_bgng_tm.selectedIndex].value;
	    	var use_end_tm = document.querySelector("#use_end_tm");
	    	var use_end_tm_val = use_end_tm.options[use_end_tm.selectedIndex].value;//종료시간 값
	    	
	    	console.log("업데이트 시작시간 : "+use_bgng_tm_val);
	    	console.log("업데이트 종료시간 : "+use_end_tm_val);
	    	
	    	if(mgt_nm.value.trim().length == 0){//띄어쓰기만으로 작성할 수 없음
	    		alert("회의 주제를 입력해주세요");
	    		mgt_nm.value = "";
	    		mgt_nm.focus();
	    		return false;
	    	}
	    	
	    	if(mgt_nm.value.length > 250){//회의 주제는 250자 이상 작성할 수 없음
	    		alert("회의주제는 250자 이상 적을 수 없습니다.");
	    		mgt_nm.focus();
	    		return false;
	    	}
	    	
	    	if(mgt_cn.value.trim().length == 0){//띄어쓰기만으로 작성할 수 없음
	    		alert("회의 내용을 입력해주세요");
	    		mgt_cn.value = "";
	    		mgt_cn.focus();
	    		return false;
	    	}
	    	
	    	if(mgt_cn.value.length > 1000){//회의 주제는 1000자 이상 작성할 수 없음
	    		alert("회의 내용은 1000자 이상 적을 수 없습니다.");
	    		mgt_cn.focus();
	    		return false;
	    	}
	    	
	    	console.log("use_bgng_tm_val : "+use_bgng_tm_val);
	    	if(mgt_cn.value.length>2000){//회의 내용은 2000자를 넘길 수 없음
	    		alert("회의 내용은 2000자를 초과할 수 없습니다.");
	    		return false;
	    	}
	    	
	    	if(mgtTypeCode == "01"){//일회성 회의일시 동일 일자로 date 맞춰짐
	    		if(use_bgng_ymd_val > use_end_ymd_val){//시작일자가 종료일자보다 클 경우
	    			alert("일회성 회의 예약시 시작일자와 종료일자가 같아야합니다.");
	    			use_end_ymd.value = use_bgng_ymd_val;
	    			return false;
		    		//일회성회의 탭에서 시작일자가 종료일자보다 크다면 종료일자가 자동으로 시작일자로 바뀌도록 
	    		}
	    		if(use_bgng_ymd_val < use_end_ymd_val){//종료일자가 시작일자보다 클 경우
	    			alert("일회성 회의 예약시 시작일자와 종료일자가 같아야합니다.");
	    			use_bgng_ymd.value = use_end_ymd_val;
	    			return false;
		    		//일회성회의 탭에서 종료일자가 시작일자보다 크다면 시작일자가 자동으로 종료일자로 바뀌도록 
	    		}	
	    	}else{
	    		if(use_bgng_ymd_val > use_end_ymd_val){//시작일자과 종료일자이 같은 경우
		    		alert("시작일자가 종료일자보다 미래일 수 없습니다.");
		    		return false;
	    		}	
	    	}
	    	
	    	if(mgtTypeCode != "04"){//select box의 option이 특정기간 전체사용이 아닐 때
	    		
	    		if(use_bgng_tm_val == use_end_tm_val){//시작시각과 종료시각이 같은 경우
		    		alert("시작시각과 종료시각은 같을 수 없습니다.");
		    		return false;
		    	}
	    	
	    		if(use_bgng_tm_val > use_end_tm_val){//종료시각이 시작시각보다 큰 경우
		    		if(use_bgng_tm_val > use_end_tm_val){
		    			alert("시작시각보다 종료시간이 이전일 수 없습니다.");
			    		return false;	
		    		}
		    	}
	    		
	    	}

	    	if(mgtTypeCode == "04"){//특정기간 전체사용일 경우
	    		if(use_bgng_ymd_val == use_end_ymd_val){//하루일경우 - 바 형태가 아닌, 9시~17시30분까지의 예약으로 됨
	    			use_bgng_tm_val = "090000";
					use_end_tm_val = "173000";	
	    		}else{//당일이 아닐 시 00시~23시59분59초까지 예약
	    			use_bgng_tm_val = "000000";
					use_end_tm_val = "235959";	
	    		}
	    	}
	    	
	    	use_bgng_ymd_val = use_bgng_ymd_val.split("-")[0]+use_bgng_ymd_val.split("-")[1]+use_bgng_ymd_val.split("-")[2];  
	    	use_end_ymd_val = use_end_ymd_val.split("-")[0]+use_end_ymd_val.split("-")[1]+use_end_ymd_val.split("-")[2];
	    	
	    	var param = {mgtNm : mgt_nm.value,
	    				 mgtCn : mgt_cn.value,
	    				 useBgngYmd : use_bgng_ymd_val,
		   				 useBgngTm : use_bgng_tm_val,
		   				 useEndYmd : use_end_ymd_val,
		   				 useEndTm : use_end_tm_val,
	    				 id : node
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
		    			alert("원하시는 시간에 이미 예약이 존재합니다.");
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
	    
	    function getDateObject(yyyymmdd){//해당 일자의 요일,날짜
			var dateObject = [];//date관련 데이터를 담을 객체
			
			var day = new Date(yyyymmdd).getDay();//요일
			var	date = new Date(yyyymmdd);//년월일
			var time = new Date(yyyymmdd).getTime();//밀리초
			
			console.log("time : "+time);
			
			switch(day){//day(0~6)형식을 String 요일로 가공함
				case 0:
					day="일"
					break;
				case 1:
					day="월"
					break;
				case 2:
					day="화"
					break;
				case 3:
					day="수"
					break;
				case 4:
					day="목"
					break;
				case 5:
					day="금"
					break;
				case 6:
					day="토"
					break;
			}
			
			dateObject = [day,date,time];
			return dateObject; 
	    }
	    
	   	function calculateInterval(end,start,select_day_val){//종료일자와 시작일자의 차이를 구하고 예약 일자들을 배열로 가공한다
	   		
	   		console.log("select_day_val : "+select_day_val);
	   		var start_date_object = new Date(start);
	   		var end_date_object = new Date(end);
	   	
	   		var dateArr = [];//정기회의 주간,월간 반복 예약이 될 날짜들
	   		
	   		var strEndInterval;//파라미터로 받은 시작일자와 종료일자의 밀리초 간격

	   		var startTime = start_date_object.getTime();//시작 일자 ISO형식 //배열속[1]요소의 값을 변수에 대입해놓고, 아래에서 month값을 올렸는데 미리 선언한 변수값이 함께 변해버린다.... //밀리초로 선언해야겠다
	   		var startMonth = start_date_object.getMonth();//시작 달
	   		var startDay = start_date_object.getDay();//시작날짜 요일(반복할 요일)
	   		var startWeek = Math.ceil(start_date_object.getDate()/7);//시작날짜가 위치한 n번째 주(다음달로 예약을 반복할 주의 위치 예(3째주))
	   		
	   		var endTime = end_date_object.getTime();
	   		var endMonth = start_date_object.getMonth();//시작 달
	   		var endDay = start_date_object.getDay();//시작날짜 요일(반복할 요일)
	   		var endWeek = Math.ceil(start_date_object.getDate()/7);//시작날짜가 위치한 n번째 주(다음달로 예약을 반복할 주의 위치 예(3째주))
	   		
	   		strEndInterval = endTime - startTime;//파라미터로 받은 시작일자와 종료일자의 밀리초 간격
	   		
	   		var recur_start_date;//반복 예약 시작 일  
	   		
	   		
	   		console.log("startDay : "+startDay);
	   		console.log("select_day_val : "+select_day_val);
	   		console.log("7-startDay : "+Number(7-startDay));
	   		console.log("7-startDay select_day_val number처리 : "+(Number(7-startDay)+Number(select_day_val)));
	   		console.log("7-startDay : "+(Number(7-startDay+select_day_val)));
	   		console.log("7-startDay : "+(Number(7-startDay)+select_day_val));
	   		console.log("7-startDay+select_day_val : "+Number(7-startDay+select_day_val));
	   		
	   		
	   		if(select_day_val == startDay){
	   			recur_start_date = new Date(startTime);
	   		}
	   		
	   		if(select_day_val < startDay){//선택된 요일이 시작 요일보다 작을 때
	   			recur_start_date = new Date(startTime+((7-startDay+Number(select_day_val))*86400000));
	   			console.log("recur_start_date day : "+recur_start_date.getDay());
	   			console.log("recur_start_date : "+recur_start_date);
	   		}
	   		
			if(select_day_val > startDay){//시작 요일이 선택요일보다 작을 때 
				recur_start_date = new Date(startTime+(select_day_val-startDay)*86400000);
				console.log("여기로 진입?");
	   		}
	   		
			var recur_cnt = Math.round(strEndInterval / 604800000);//insert를 위한 for문 반복 횟수
			console.log("recur_cnt : "+recur_cnt);
			
			for(var i = 0;i<=recur_cnt;i++){
				var insertDate = recur_start_date.toISOString().substring(0, 10);
				insertDate = insertDate.split("-")[0]+insertDate.split("-")[1]+insertDate.split("-")[2];
				console.log("insertDate : "+insertDate);
				dateArr.push(insertDate);
				recur_start_date.setTime(recur_start_date.getTime()+604800000);
				if(recur_start_date.getTime()>endTime){
					break;
				}
			}
			
			return dateArr;
			
			/* var firstDay =  new Date("2023-01-01");
			console.log("firstDay : "+firstDay);
			console.log("firstDay : "+firstDay.getTime());
			console.log("firstDay : "+firstDay.getTime()+86400000);
			console.log("firstDay : "+new Date(firstDay.getTime()+86400000));
			
			
			var dateArr = [];
			for(var i = 0;i<10;i++){
				 dateArr.push(new Date(firstDay.getTime()+86400000));
				 firstDay.setTime(firstDay.getTime()+86400000);
			}
			console.log(dateArr); */
			
			
			
	   	 	//하루차이 86400000
			//일주일 차이 604800000	
	   	 		
	   		
			//중요한것은 시작일자 요일은 n주차 n요일일것인데   
				//시작일자와 종료일자 기간 사이에서 몇번 들어갈 수 있느냐
					//구해야할 것 : 시작일자의 n번째 n요일, 시작일자와 종료일자와의 차이(밀리세컨드),
						//그사이에 들어있는 n번째 n요일이 몇번 들어갈 수 있느냐? - 매달의 n번째 n요일에대한 밀리초를 구해서 가능한지 if문으로 봐야할까?
								//month로는 딱 떨어지지않음
						//월간도 한주씩 돌려야하나..!? 그럼 루프한번 마다 현재 해당 일자가 
	   		
			/* console.log("month 확인");
			console.log(new Date('2023-09-29').getMonth()+1);
			
			console.log(new Date('2024-01-30').getMonth()+1);
			
			console.log("start_date_object :"+start_date_object);
			
			console.log("밀리초 차이 확인");
			console.log(new Date('2023-09-22').getTime());
			console.log(new Date('2023-09-28').getTime());
			console.log(new Date('2023-09-29').getTime());
			console.log(new Date('2023-09-29').getTime()-new Date('2023-09-28').getTime());//하루차이 86400000
			console.log(new Date('2023-09-29').getTime()-new Date('2023-09-22').getTime());//일주일 차이 604800000
			
			//무사할시?
					
			var startYear = String(start_date_object).split(" ")[3];//시작 년도 예(2023)
			var endYear = String(end_date_object).split(" ")[3];//종료년도
			
			console.log("startYear");
			
			console.log(startYear);
			console.log(endYear);

			if(startYear == endYear){
				//setMonth할 때 처리 
			}
			
			if(startYear < endYear){
				//setMonth할 때 처리
			}
			
			var nextMonthTime = start_date_object.setMonth(start_date_object.getMonth()+1);//다음달 시간
			
			var nextMonth = new Date(nextMonthTime);//다음달 Date객체
			
			var nextMonthNum = nextMonth.getMonth();//+1달 달(숫자로 0~11)
			var nextMonthDate = nextMonth.getDate();//+1달 일자
			var nextMonthDay = "";//+1달 요일 = startDay(시작요일)과 같아야함 - 시작요일 대입
			var nextMonthWeek = Math.ceil(nextMonth.getDate()/7);//다음달 n번째 주
			
			console.log("nextMonth date :"+new Date(nextMonthTime));
			
			console.log("startWeek : "+startWeek);
			console.log("nextMonthWeek : "+nextMonthWeek);
			
			console.log("nextMonthTime :"+nextMonthTime);
			console.log("startTime :"+startTime);//위에서 미리 선언해둔 시작 밀리초
			console.log("nextMonthTime - startTime");
			console.log(nextMonthTime-startTime);
			
			
			
			
			nextMonthTime
			if(startWeek < nextMonthWeek){
				
				nextMonthDate = nextMonthDate - 7;
				nextMonthWeek = nextMonthWeek-1;//한달뒤 같은날의 n번째 주가 전달보다 크다면 1 내림
			}
			
			if(startWeek > nextMonthWeek){
				
				
				
				nextMonthDate = nextMonthDate - 7;
				nextMonthWeek = nextMonthWeek+1;//한달뒤 같은날의 n번째 주가 전달보다 낮다면 1 올림
			}
			
			nextMonthDay = startDay;//다음달 요잃은 시작 요일과 같음
			
			/* Math.ceil(start_date_object.getDate()/7;
			start_date_object.getDay(); */
			
			//year비교로 같은 해인지, 같은 해라면
				//시작일자부터 시작일자의 +1달의 n번째 n요일까지의 밀리초
					//이 값이 interval보다 낮은지, 낮다면 반복
						//결극 반복믄이네
			
	   		/* console.log("end_date_object");
	   		console.log(end_date_object);
	   		console.log("start_date_object");
	   		console.log(start_date_object);
	   		
	   		strEndInterval = end_date_object.getTime() - startTime;//종료일자의 밀리초와 기존(변수로 만들어둔) 시작시간의 밀리초의 차를 대입한다
	   		
	   		var nextMonthInterval = nextMonthTime-startTime;
	   		
	   		if(nextMonthInterval < strEndInterval){//반복문안에서 추가 진행할지 여부를 위한 if문
	   			
	   		}
	   		
	   		console.log("strEndInterval : "+strEndInterval);
	   		console.log("millisecond : ");
	   		console.log(start_date_object+strEndInterval);//날짜에 다이렉트로 더하기 안 됨
	   		console.log(start_date_object.getDate());

	   		console.log("year 확인");
			console.log((start_date_object+"").split(" ")[3]);
	   		
			console.log(start_date_object);
	   		
	   		console.log("start_date_object 확인");
	   		console.log(start_date_object);
	   		
	   		console.log("getMonth 확인");
	   		console.log(start_date_object.getMonth());
	   		console.log(end_date_object.getMonth());
	   		
	   		if(mgtTypeCode == "02"){
	   			strEndInterval = (end_date_object - start_date_object) / (1000*60*60*24);
	    		quotient = strEndInterval / 7;
	   		}
	   		if(mgtTypeCode == "03"){//input date태그에 03을 선택했으면서, 값이 변했으면 ~번째 ~요일로 예약하겠냐고 alert로 물어볼까? prompt로 4째주인지,마지막주인지 물어보자
	   			
	   		}  */
	   		
	   	}
	    
		function reservationChk(mgtRoomId){//예약하기 버튼을 눌렀을 때 - Insert
		
			var mgt_type_code_val = document.querySelector("#mgt_type_code").value;//회의 유형 select box의 option 값
			console.log(mgt_type_code_val);
	    	var mgt_nm_val = document.querySelector("#mgt_nm").value;//회의주제 select box value
	    	var mgt_cn_val = document.querySelector("#mgt_cn").value;//회의 내용 node
	    	
	    	var use_bgng_ymd = document.querySelector("#use_bgng_ymd");
	    	var use_end_ymd = document.querySelector("#use_end_ymd");
	    	var use_bgng_ymd_val = document.querySelector("#use_bgng_ymd").value;//예약 시작 일자 node
	    	var use_end_ymd_val = document.querySelector("#use_end_ymd").value;//예약 종료 일자 node
	    	
	    	var use_bgng_tm = document.querySelector("#use_bgng_tm");//예약 시작 시각 node
	    	var use_bgng_tm_val = use_bgng_tm.options[use_bgng_tm.selectedIndex].value;//시작 시각 selected 값
	    	var use_end_tm = document.querySelector("#use_end_tm");//종료 시각 node
	    	var use_end_tm_val = use_end_tm.options[use_end_tm.selectedIndex].value;//종료시각 selected 값
	    	
	    	var startDate = new Date(use_bgng_ymd_val).toISOString().substring(0, 10);//
    		var endDate = new Date(use_end_ymd_val);
    		
	    	var dateArr = null;//정기회의 일 경우 반복되는 일자 insert
	    	
	    	console.log("업데이트 시작시각 : "+use_bgng_tm_val);
	    	console.log("업데이트 종료시각 : "+use_end_tm_val);
	    	
	    	console.log(use_bgng_ymd_val);
	    	console.log(use_end_ymd_val);
	    	
	    	console.log(getDateObject(use_bgng_ymd_val));
	    	console.log(getDateObject(use_end_ymd_val));
	    	
	    	if(mgt_nm.value.trim().length == 0){//띄어쓰기만으로 작성할 수 없음
	    		alert("회의 주제를 입력해주세요");
	    		mgt_nm.value = "";
	    		mgt_nm.focus();
	    		return false;
	    	}
	    	
	    	if(mgt_nm.value.length > 250){//회의 주제는 250자 이상 작성할 수 없음
	    		alert("회의주제는 250자 이상 적을 수 없습니다.");
	    		mgt_nm.focus();
	    		return false;
	    	}
	    	
	    	if(mgt_cn.value.trim().length == 0){//띄어쓰기만으로 작성할 수 없음
	    		alert("회의 내용을 입력해주세요");
	    		mgt_cn.value = "";
	    		mgt_cn.focus();
	    		return false;
	    	}
	    	
	    	if(mgt_cn.value.length > 1000){//회의 주제는 1000자 이상 작성할 수 없음
	    		alert("회의 내용은 1000자 이상 적을 수 없습니다.");
	    		mgt_cn.focus();
	    		return false;
	    	}
	    	
	    	if(mgt_type_code_val == "01"){//일회성 회의일시 동일 일자로 date 맞춰짐
	    		if(use_bgng_ymd_val > use_end_ymd_val){//시작일자가 종료일자보다 클 경우
	    			alert("일회성 회의 예약시 시작일자와 종료일자가 같아야합니다.");
	    			use_end_ymd.value = use_bgng_ymd_val;
	    			return false;
		    		//일회성회의 탭에서 시작일자가 종료일자보다 크다면 종료일자가 자동으로 시작일자로 바뀌도록 
	    		}
	    		if(use_bgng_ymd_val < use_end_ymd_val){//종료일자가 시작일자보다 클 경우
	    			alert("일회성 회의 예약시 시작일자와 종료일자가 같아야합니다.");
	    			use_bgng_ymd.value = use_end_ymd_val;
	    			return false;
		    		//일회성회의 탭에서 종료일자가 시작일자보다 크다면 시작일자가 자동으로 종료일자로 바뀌도록 
	    		}	
	    	}else{
	    		if(use_bgng_ymd_val > use_end_ymd_val){//시작일자과 종료일자이 같은 경우
		    		alert("시작일자가 종료일자보다 미래일 수 없습니다.");
		    		return false;
	    		}	
	    	}
	    	
	    	if(mgt_type_code_val != "04"){//select box의 option이 특정기간 전체사용이 아닐 때
	    		
	    		if(use_bgng_tm_val == use_end_tm_val){//시작시각과 종료시각이 같은 경우
		    		alert("시작시각과 종료시각은 같을 수 없습니다.");
		    		return false;
		    	}
	    	
	    		if(use_bgng_tm_val > use_end_tm_val){//종료시각이 시작시각보다 큰 경우
		    		if(use_bgng_tm_val > use_end_tm_val){
		    			alert("시작시각보다 종료시간이 이전일 수 없습니다.");
			    		return false;	
		    		}
		    	}
	    		
	    	}
	    	
	    	if(mgt_type_code_val == "02"||mgt_type_code_val == "03"){//정기회의시
	    		if(use_bgng_ymd_val == use_end_ymd_val){//시작일자과 종료일자이 같은 경우
		    		alert("정기회의는 같은 날짜로 예약할 수 없습니다.");
		    		return false;
	    		}
	    		if(mgt_type_code_val == "03"){
	    			if((new Date(use_end_ymd_val).getTime() - new Date(use_bgng_ymd_val).getTime()) < 604800000){
		    			alert("주간회의는 최소 2주이상의 기간으로 예약해야합니다.");
		    			return false;
		    		}
	    			var select_day = document.querySelector("#select_day");
		    		dateArr = calculateInterval(use_end_ymd_val,use_bgng_ymd_val,select_day.value);	
	    		}
	    		
	    		
	    	}
			
			use_bgng_ymd_val = use_bgng_ymd_val.split("-")[0]+use_bgng_ymd_val.split("-")[1]+use_bgng_ymd_val.split("-")[2];//시작일자 숫자사이 '-'하이픈 없애기  
	    	use_end_ymd_val = use_end_ymd_val.split("-")[0]+use_end_ymd_val.split("-")[1]+use_end_ymd_val.split("-")[2];//종료일자 숫자사이 '-'하이픈 없애기

	    	
	    	if(mgt_type_code_val == "04"){//특정기간 전체사용일 경우
	    		if(use_bgng_ymd_val == use_end_ymd_val){//하루일경우 - 바 형태가 아닌, 9시~17시30분까지의 예약으로 됨
	    			use_bgng_tm_val = "090000";
					use_end_tm_val = "173000";	
	    		}else{//당일이 아닐 시 00시~23시59분59초까지 예약
	    			use_bgng_tm_val = "000000";
					use_end_tm_val = "235959";	
	    		}
	    	}
	    	
	    	
	    	var param = {mgtRoomId : mgtRoomId,
	    				 mgtTypeCode : mgt_type_code_val,
	    				 mgtNm : mgt_nm_val,
	    				 mgtCn : mgt_cn_val,
	    				 useBgngYmd : use_bgng_ymd_val,
	    				 useBgngTm : use_bgng_tm_val,
	    				 useEndYmd : use_end_ymd_val,
	    				 useEndTm : use_end_tm_val,
	    				 dateArr : dateArr
	    				 };
	    	
	    	console.log(JSON.stringify(param));
	    	
	    	 $.ajax({
	    		url : '/makeReservation',
	    		type : 'POST',
				contentType: 'application/json; charset=utf-8',// 파라미터 데이터 타입 지정
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
	    			alert("원하시는 시간에 이미 예약이 존재합니다.");
	    			break;
	    		case 9999:
	    			alert("예상치 못 한 오류가 발생했습니다. 로그인 페이지로 이동합니다.");
	    			location.href="/login/logout";
	    		}
	    		
	    	}
	    	}); 
	    	
		}
		
		/* function beginMgtRoomChk(node){//캘린더 페이지 입장시 층,회의실 선택 체크

			var select_room_div = document.getElementById("select_room_div");
			var begin_mgt_room_nofl = document.getElementById("begin_mgt_room_nofl");//층 선택 selectbox
			var begin_mgt_room_not_selected = document.getElementById("begin_mgt_room_not_selected");
			var begin_mgt_room = document.getElementById("begin_mgt_room_"+node);
			var begin_mgt_room_class = document.getElementsByClassName("begin_mgt_room");
			var not_selected = document.getElementsByClassName("not_selected");
			
			var begin_mgt_room_nofl_val = begin_mgt_room_nofl.options[begin_mgt_room_nofl.selectedIndex].value;//층 선택된 option값

			begin_mgt_room.classList.remove("not_selected");
			
			console.log("begin_mgt_room : "+begin_mgt_room.id);
			
			console.log("begin_mgt_room_nofl_val : "+begin_mgt_room_nofl_val);
			
			
			if(begin_mgt_room_nofl_val != "not_selected"){
				document.getElementById("begin_mgt_room_not_selected").classList.add("not_selected");
			}
			if(begin_mgt_room_nofl_val != "B1"){
				document.querySelector("#begin_mgt_room_B1").classList.add("not_selected");
			}
			if(begin_mgt_room_nofl_val != "1F"){
				document.querySelector("#begin_mgt_room_1F").classList.add("not_selected");
			}
			if(begin_mgt_room_nofl_val != "2F"){
				document.getElementById("begin_mgt_room_2F").classList.add("not_selected");
			}
			if(begin_mgt_room_nofl_val != "5F"){
				document.getElementById("begin_mgt_room_5F").classList.add("not_selected");
			}
			if(begin_mgt_room_nofl_val != "6F"){
				document.getElementById("begin_mgt_room_6F").classList.add("not_selected");
			}
			if(begin_mgt_room_nofl_val != "7F"){
				document.getElementById("begin_mgt_room_7F").classList.add("not_selected");
			}
			if(begin_mgt_room_nofl_val != "8F"){
				document.getElementById("begin_mgt_room_8F").classList.add("not_selected");
			}
			if(begin_mgt_room_nofl_val != "9F"){
				document.getElementById("begin_mgt_room_9F").classList.add("not_selected");
			}
			
			
			//#select_room_div 시작 셀렉트박스 관련 전체 div id
			//#begin_mgt_room_nofl 층정보 id 예시)B1 1F 
			//#begin_mgt_room_not_selected 아무 회의실도 선택되지 않은 셀렉트박스 id
			//#begin_mgt_room_(Number) 각 층의 회의실 번호 id
			//.begin_mgt_room 시작 전체 셀렉트박스 묶는 class
			//.not_selected 시작 셀렉트 display none 효과 class
			
			
			
		} */	
		
		function getRsvtType(){//회의실 유형 데이터 가져와 select box에 option으로 추가 하기  - 일회성,정기 회의 명
			$.ajax({
	    		url : '/getRsvtType',
	    		type : 'GET',
				contentType: 'application/json; charset=utf-8', // 파라미터 데이터 타입 지정
				dataType  : "json", //리턴 데이터 타입 지정
	    		async : false,
		    	success : function(data){
		    		var mgt_type_code = document.getElementById("mgt_type_code");
		    		console.log("getRsvtType() 진입");
					data.forEach(function(item){
						var option = document.createElement("option");
						option.text = item.value;
						option.value = "0"+item.code;
						mgt_type_code.options.add(option);//회의종류 select box의 option 동적생성
					})
		    	}
			})
				
		}
		
 		function mouseEnter(node){//마우스가 올려질 때     parameter : 마우스 대상의 노드id
			var arr = node.split("_");
			var last = arr[arr.length - 1];
 			document.querySelector("#mgt_room_"+last).style.display = "block";
 			console.log(document.querySelector("#floor_"+last).style);
 			document.querySelector("#floor_"+last).style.backgroundColor = "#6f6b6b";
		}
		
		function mouseLeave(node){//마우스가 내려갈 때     parameter : 마우스 대상의 노드id
			var arr = node.split("_");
			var last = arr[arr.length - 1];
			document.querySelector("#mgt_room_"+last).style.display = "none";
			document.querySelector("#floor_"+last).style.backgroundColor = "";
		}
		
		function getRoomInfo(mgtRoomInfo){//회의실 층,이름 정보 가져오기 //파라미터 - 회의 id
			
	    	$.ajax({
	    		url : '/getRoomInfo',
	    		type : 'GET',
				contentType: 'application/json; charset=utf-8', // 파라미터 데이터 타입 지정
				dataType  : "json", //리턴 데이터 타입 지정
	    		async : false,
	    	success : function(data){
	    		console.log("getRoomInfo");
	    		console.log(String(mgtRoomInfo));
	    		
	    		var mgt_floor_list = document.getElementById("mgt_floor_list");
	    		
	    		var mgt_floor_list_ul = document.getElementById("mgt_floor_list_ul");
	    		
	    		var mgt_list = document.getElementById("mgt_list");
	    		
	    		for(var i=0;i<10;i++){//층 정보 div에 li태그 생성 & 층 회의실 div생성
					console.log("i : "+i);
	    			var floor = i+"층"
	    			var floorId = i+"F";
	    		
	    			if(floorId == "0F"){
	    				floor = "지하 1층";
	    				floorId = "B1";
	    			}
	    			
	    			const floor_li_tag = document.createElement("li");//li태그 생성
	    			floor_li_tag.classList.add("floor");
	    			floor_li_tag.id = "floor_"+floorId;
	    			
	    			floor_li_tag.innerHTML = "<a href='#' id='"+floorId+"'>"+floor+"</\a>";//층선택 li태그 생성	    			
	    			mgt_floor_list_ul.append(floor_li_tag);
	    			
 	    			floor_li_tag.onmouseenter=function(){mouseEnter(floor_li_tag.id)};//마우스 올리기 이벤트 추가
	    			floor_li_tag.onmouseleave=function(){mouseLeave(floor_li_tag.id)};//마우스 내리기 이벤트 추가
	    			
	    			if(mgtRoomInfo !== null){
	    				if(mgtRoomInfo.substring(0,2) == floorId){//층 비교 후 동일하다면 
	    					document.getElementById(floorId).classList.add("selected_room");//색 표시	
	    				}
	    			}
	    			
	    			const room_div = document.createElement("div");
	    			room_div.id = "mgt_room_"+floorId;//room_div id입력
	    			room_div.classList.add("mgt_room_list");//room_div class입력
	    			room_div.innerHTML = '<h3 style="text-align:center;margin-top:10px;margin-bottom:20px;">회의실 선택</h3>';
	    			
	    			const room_ul_tag = document.createElement("ul");//li태그 생성
	    			room_ul_tag.classList.add("mgt_room_list_ul");
	    			room_ul_tag.id = "mgt_room_list_ul_"+floorId;//ul태그 id입력
	    			
	    			
	    			
	    			room_div.append(room_ul_tag);//ul태그를 div태그안에 추가
	    			mgt_list.append(room_div);//div태그를 회의실 부모 div에 추가
	    			
	    			room_div.onmouseenter=function(){mouseEnter(room_ul_tag.id)};//마우스 올리기 이벤트 추가
	    			room_div.onmouseleave=function(){mouseLeave(room_ul_tag.id)};//마우스 내리기 이벤트 추가
	    			
	    		}
	    		
	    		data.forEach(function (item) {//층,이름 정보 li태그에 입력
	    			
	    			var floorId = item.mgtRoomId.substring(0,2);
	    		
					var mgt_room_ul = document.getElementById("mgt_room_list_ul_"+floorId); 	    		
	    		
	    			const room_li_tag = document.createElement("li");//li태그 생성
	    			room_li_tag.innerHTML = "<a href='/revCalendar?mgtRoomId="+item.mgtRoomId+"' id='"+item.mgtRoomId+"'>"+item.mgtRoomNm+"</\a>";
	    			
	    			mgt_room_ul.append(room_li_tag);
	    			
	    			if(mgtRoomInfo !== null){
	    				if(mgtRoomInfo == item.mgtRoomId){//선택한 회의실 id값과 db에서 가져온 값이 같다면 class 부여
	    					document.getElementById(item.mgtRoomId).classList.add("selected_room");	
	    				}
	    			}
					
	    		});
	    		
	    		/* data.mgtRoomId//회의실 id
	    		data.mgtRoomNm//회의실 이름
	    		data.mgtRoomNofl//회의실 층 */
	    	}
	    	});
	    }
		
		function changeDate(node){//팝업창의 날짜를 변경할 때 작동
			var use_bgng_ymd = document.querySelector("#use_bgng_ymd"); 
			var use_end_ymd = document.querySelector("#use_end_ymd");
			var mgt_type_code = document.querySelector("#mgt_type_code");
			if(mgt_type_code.value == "01"){//회의종류 값이  
				if(node == use_bgng_ymd){//시작일자를 조작했을 경우
					use_end_ymd.value = use_bgng_ymd.value;  
				}
				if(node == use_end_ymd){//종료일자를 조작했을 경우
					use_bgng_ymd.value = use_end_ymd.value;  
				}
			}
			
		}
		
		
		function modal_close(){//취소 버튼을 눌렀을 때  -- 아직 보류중
			
			var barNodes = document.getElementsByClassName("fc-daygrid-event fc-daygrid-block-event fc-h-event fc-event fc-event-start fc-event-end");
			
			var use_bgng_ymd = document.querySelector("#use_bgng_ymd");//시작 일자 노드
			var use_bgng_ymd = document.querySelector("#use_end_ymd");//시작 일자 노드
			var use_bgng_tm = document.querySelector("#use_bgng_tm");//시작 시각 노드
	    	var use_end_tm = document.querySelector("#use_end_tm");//종료 시각 노드
	    	
	    	use_bgng_ymd.readOnly = false;//시작 일자 readOnly 해제
	    	use_end_ymd.readOnly = false;//종료 일자 readOnly 해제
	    	use_bgng_tm.readOnly = false;//시작 시간 readOnly 해제
	    	use_end_tm.readOnly = false;//종료 시각 readOnly 해제
	    	use_bgng_tm.disabled = false;//시작 시각 dabled 해제
	    	use_end_tm.disabled = false;//종료 시각 dabled 해제
	    	
	    	var mgt_type_code = document.querySelector("#mgt_type_code");
	    	mgt_type_code.disabled = false;//팝업창 닫기시 disabled 사라짐
	    	
	    	
	    	var reserve_table = document.querySelector("#reserve_table");//팝업의 table 태그
	    	
	    	var select_day_box = document.querySelector("#select_day");//요일선택 select box 태그
			var select_day_label = document.querySelector("#select_day_label");
	    	select_day_box.style.display = "none";//요일 셀렉 박스 안보이게
	    	select_day_label.style.display = "none";//요일 셀렉 박스 안보이게
	    	select_day_box.disabled = false;//요일 셀렉 박스 disabled
			document.querySelector("#mgt_type_code").options[0].selected = true;
			var background = document.querySelector(".background");//팝업창 배경(팝업이 뜨는지 유무를 background에서 처리)
			var mgt_nm = document.querySelector("#mgt_nm");//회의 주제 node
			var mgt_cn = document.querySelector("#mgt_cn");//회의 내용 node
			var frame = document.querySelector(".fc-event-title-frame");//예약되어있는 목록들 node
			var reserv_btn = document.getElementById("reserv_btn");//예약 버튼 element
			var close_btn = document.querySelector("#close_btn");//모달 팝업 닫기 버튼 node
			
			var btn_div = document.getElementById("btn_div");//버튼div element선택
			
			var reserve_tr = document.querySelector("#reserve_tr");
			if(reserve_tr){//reserve_tr의 엘리먼트가 있다면(예약자에 대한 tr 태그가 있다면)
				reserve_tr.remove();
			}
			
			mgt_nm.style.height='auto';//회의 주제 크기 원래대로
			mgt_cn.style.height='auto';//회의 주제 크기 원래대로
			
			background.classList.remove("show");//모달팝업 안보이게
			mgt_nm.value="";//회의 주제 초기화 
			mgt_cn.value="";//회의 내용 초기화
			use_bgng_tm.options[0].selected = true;//시작시간 초기화
	    	use_end_tm.options[0].selected = true;//종료시간 초기화
	    	if(reserv_btn){//예
	    		reserv_btn.style.display = "inline";//예약버튼 보이게
	    	}
	    	while (btn_div.childNodes[0].nodeName == "SPAN")//버튼 모아둔 DIV에 SPAN태그(예약취소를 담고있는 태그)삭제
	    	{
	    		btn_div.removeChild(btn_div.firstChild);       
	    	}
	    	
			if(document.getElementById("update_btn")){//update버튼이 있다면  -- 위의 span태그 삭제하면 없어지긴 하는데 일단 방치
				document.getElementById("update_btn").remove();//예약 수정버튼 삭제
				document.getElementById("cancel_btn").remove();//예약 취소버튼 삭제
			}
			close_btn.value = 0;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
		}
		
  </script>

</head>

<body>
	<div class="background">
	<h3 style="text-align:center;margin-top:10px;margin-bottom:20px;">회의실 선택</h3>
		<div class="window">
			<div class="popup">
				<div>
					<table
						style="margin: 0 auto; border-collapse: separate; border-spacing: 0 10px;" id="reserve_table">
						  <colgroup>
						    <col width="15%"/>
						    <col width="25%"/>
						    <col width="15%"/>
						    <col width="25%"/>
						    <col width="15%"/>
						    <col width="5%"/>
						  </colgroup>
						
						<tbody>
							<tr style="margin-bottom: 50px;">
								<th><span style="font-size: 1.7rem;">회의 종류 : </span></th>
								<td><select id="mgt_type_code"
									onChange="selectMgtType(this)">
								</select></td>
							</tr>
							<tr>
								<th><span style="font-size: 1.7rem;">회의 주제 : </span></th>
								<td><textArea id="mgt_nm" rows="1" onKeyUp="scrollText(this)" placeholder="회의 내용을 적어주세요"></textArea></td>
							</tr>
							<tr>
								<th><span style="font-size: 1.7rem;">회의 내용 : </span></th>
								<td><textArea id="mgt_cn" rows="1" onKeyUp="scrollText(this)" placeholder="회의 내용을 적어주세요"></textArea></td>
								<td><span id="mgt_cn_cnt" style="font-size: 0.5rem;"></span></td>
							</tr>
							<tr>
								<th><label for="use_bgng_ymd"><span
										style="font-size: 1.7rem;">시작 일자 : </span></label></th>
								<td><input id="use_bgng_ymd" type="date"
									onChange="changeDate(this)" /></td>
								<th><label for="use_end_ymd"><span
										style="font-size: 1.7rem;">종료 일자 : </span></label></th>
								<td><input id="use_end_ymd" type="date"
									onChange="changeDate(this)" /></td>
								<th><label for="select_day" id="select_day_label"
									style="display: none;"><span style="font-size: 1.7rem;">반복요일
											: </span></label></th>
								<td><select id="select_day" style="display: none;">
										<option value=1>월</option>
										<option value=2>화</option>
										<option value=3>수</option>
										<option value=4>목</option>
										<option value=5>금</option>
								</select></td>
							</tr>
							<tr>
								<th><span style="font-size: 1.7rem;">시작 시간 : </span></th>
								<td><select id="use_bgng_tm">
										<option value="090000">9:00</option>
										<option value="091500">9:15</option>
										<option value="093000">9:30</option>
										<option value="094500">9:45</option>
										<option value="100000">10:00</option>
										<option value="101500">10:15</option>
										<option value="103000">10:30</option>
										<option value="104500">10:45</option>
										<option value="110000">11:00</option>
										<option value="111500">11:15</option>
										<option value="113000">11:30</option>
										<option value="114500">11:45</option>
										<option value="120000">12:00</option>
										<option value="121500">12:15</option>
										<option value="123000">12:30</option>
										<option value="124500">12:45</option>
										<option value="130000">13:00</option>
										<option value="131500">13:15</option>
										<option value="133000">13:30</option>
										<option value="134500">13:45</option>
										<option value="140000">14:00</option>
										<option value="141500">14:15</option>
										<option value="143000">14:30</option>
										<option value="145600">14:45</option>
										<option value="150000">15:00</option>
										<option value="151500">15:15</option>
										<option value="153000">15:30</option>
										<option value="154500">15:45</option>
										<option value="160000">16:00</option>
										<option value="161500">16:15</option>
										<option value="163000">16:30</option>
										<option value="164500">16:45</option>
										<option value="170000">17:00</option>
										<option value="171500">17:15</option>
								</select></td>
								<th><span style="font-size: 1.7rem;">종료 시각 : </span></th>
								<td><select id="use_end_tm">
										<option value="091500">9:15</option>
										<option value="093000">9:30</option>
										<option value="094500">9:45</option>
										<option value="100000">10:00</option>
										<option value="101500">10:15</option>
										<option value="103000">10:30</option>
										<option value="104500">10:45</option>
										<option value="110000">11:00</option>
										<option value="111500">11:15</option>
										<option value="113000">11:30</option>
										<option value="114500">11:45</option>
										<option value="120000">12:00</option>
										<option value="121500">12:15</option>
										<option value="123000">12:30</option>
										<option value="124500">12:45</option>
										<option value="130000">13:00</option>
										<option value="131500">13:15</option>
										<option value="133000">13:30</option>
										<option value="134500">13:45</option>
										<option value="140000">14:00</option>
										<option value="141500">14:15</option>
										<option value="143000">14:30</option>
										<option value="145600">14:45</option>
										<option value="150000">15:00</option>
										<option value="151500">15:15</option>
										<option value="153000">15:30</option>
										<option value="154500">15:45</option>
										<option value="160000">16:00</option>
										<option value="161500">16:15</option>
										<option value="163000">16:30</option>
										<option value="164500">16:45</option>
										<option value="170000">17:00</option>
										<option value="171500">17:15</option>
										<option value="173000">17:30</option>
								</select></td>
							</tr>
						</tbody>
					</table>
					<div id="btn_div">
						<button id="reserv_btn" onClick="reservationChk('${mgtRoomId}')">예약하기</button>
						<button id="close_btn" value="0" onClick="modal_close()">닫기</button>
					</div>
				</div>
				<!-- <div id="history_div">
					<p class="historyNode" id="rgtr_name"></p>
					<p class="historyNode" id="reg_dt"></p>
					<p class="historyNode" id="mdfr_name"></p>
					<p class="historyNode" id="mdfcn_dt"></p>
				</div> -->
			</div>
		</div>
	</div>

	<div id="page-wrapper">
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false" />
		
		<div id="container">
			<div class="content">


					<!-- <div id="mgt_room_nofl_depth">
				<div id="mgt_room_B1" style="display:none;">
					<ul>
						<li value="01">대강당</li>
					</ul>
				</div>
				<div id="mgt_room_1">
					<ul>
						<li value="01">대회의실</li>
						<li value="02">소희의실1</li>
						<li value="03">소희의실2</li>
						<li value="04">소희의실3</li>
						<li value="05">소희의실4</li>
					</ul>
				</div>
				<div id="mgt_room_2">
					<ul>
						<li value="01">회의실</li>
					</ul>
				</div>
				<div id="mgt_room_5">
					<ul>
						<li value="01">총무팀회의실</li>
						<li value="02">인사팀회의실</li>
					</ul>
				</div>
				<div id="mgt_room_6">
					<ul>
						<li value="01">기술본부회의실</li>
					</ul>
				</div>
				<div id="mgt_room_7">
					<ul>
						<li value="01">사업지원회의실</li>
						<li value="02">영업사업회의실</li>
					</ul>
				</div>		
				<div id="mgt_room_8">
					<ul>
						<li value="01">컨텐츠회의실</li>
						<li value="02">경영기획회의실</li>
					</ul>
				</div>
				<div id="mgt_room_9">
					<ul>
						<li value="01">연구본부회의실</li>
					</ul>
				</div>
		</div> -->

					<!-- <div style="padding: 0.2px; border: 2px solid #c4c4c4;">
						<p>
							<strong>회의를 원하는 날짜에 드래그하여 예약하세요.</strong>
						</p>

						<div draggable="true"
							class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
							<div class='fc-event-main' style="text-align: center;">일회성
								회의</div>
						</div>
						<div draggable="true"
							class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
							<div class='fc-event-main' style="text-align: center;">정기회의-일간</div>
						</div>
						<div draggable="true"
							class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
							<div class='fc-event-main' style="text-align: center;">정기회의-주간</div>
						</div>
						<div draggable="true"
							class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
							<div class='fc-event-main' style="text-align: center;">정기회의-월간</div>
						</div>
						<div draggable="true"
							class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
							<div class='fc-event-main' style="text-align: center;">특정기간
								전체사용</div>
						</div>
					</div> -->
				

				<div style="float: left; width: 100%; margin-bottom: 110px; background-color: #fff">
					<div style="text-align: center; height: 30px; font-size: 35px; font-weight: bold; margin-bottom: 30px;">회의실 예약 달력표</div>
					<div id='calendar'></div>
					<!-- fullcalendar 달력 div -->
				</div>
			</div>

		</div>
		
		<div id='external-events'>
			<div id="mgt_list">
				<div id="mgt_floor_list">
					<!-- script로 회의실 리스트 추가 -->
					<h3 style="text-align:center;margin-top:10px;margin-bottom:20px;">층 선택</h3>
					<ul id="mgt_floor_list_ul" style="text-align: center;">
					</ul>
				</div>
				<div class="mgt_room_list">
					<ul id="mgt_floor_list_ul" style="text-align: center;">
					</ul>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>