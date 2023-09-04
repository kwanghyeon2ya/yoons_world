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
		.fc-event{
			margin-top:2px;
			cursor:pointer;
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
		    width: 600px;
		    height: 440px;
			
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
		#history_div{
			display: none;
		    white-space: break-spaces;
	    	width: 100%;
	    	margin-bottom: 100px;
		}
		.fc-daygrid-event-harness-abs .fc-daygrid-event-dot{fc-daygrid-event-dot
			display: none;
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
					var mgt_nm = document.querySelector("#mgt_nm");
					
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
				  var mgt_cn = "";
				  for (var i = 0; i < all_events.length; i++) {
					  if(all_events[i].id== info.event.id){//db에서 가져온 id와 캘린더에 가공해서 넣은 id값이 일치할 때
						  mgt_cn = all_events[i].mgtCn;//db에서 가져온 회의 내용을 변수 대입
					  }
					  console.log(all_events[i]);
					} 
				  console.log(all_events);
				  tippy(info.el, {
				      content: mgt_cn//회의 내용을 툴팁으로 넣음.
				      });
				  },
		      drop: function(info) {//태그를 날짜에 drop하는 순간 작동
		    	  console.log(info.view);
		    	console.log(info);
		        console.log("drop됨");
		    	var background = document.querySelector(".background");
				background.classList.add("show");
				var infoInnerText = info.draggedEl.innerText; 
				var mgt_nm = document.querySelector("#mgt_nm");
				
				console.log(mgt_nm.options);
				console.log(infoInnerText);
				console.log(mgt_nm.options[0].value);
				
				document.getElementById("use_bgng_ymd").value = info.dateStr;//시작 날짜 클릭 해당 날짜 초기 세팅
		   		document.getElementById("use_end_ymd").value = info.dateStr;//종료 날짜 클릭 해당 날짜 초기 세팅
		    	
				for(var i = 0;i<mgt_nm.options.length;i++){//드래그한 회의 주제를 popup창에서 selected되도록
					
					if(mgt_nm.options[i].value == infoInnerText){
						mgt_nm.options[i].selected = true;
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
		    	console.log(event.allDay);
		    	console.log("gdgd?");
		    	console.log(event.id);
		    	console.log(event.location);
		    })
		    dayevents.forEach(function(dayevent){
		    	console.log(dayevent);
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
	    
	    function loadingEvents(){//db에서 데이터 가져오기
	    	console.log("loadingEvents 진입확인");
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
				    
	    	var background = document.querySelector(".background");
	    	background.classList.add("show");
	    	
	    	console.log("readReservation  :  "+node);
	    	
	    	var close_btn = document.querySelector("#close_btn");
	    	console.log(close_btn);
	    	close_btn.value = 1;//팝업이 닫힌상태인지 구별용  0닫힘/1열림
	    	var reserv_btn = document.getElementById("reserv_btn");
	    	reserv_btn.style.display = "none";
	    	
	    	var nodePrt1 = node.split("-")[0];
	    	var nodePrt2 = node.split("-")[1];
	    	var nodePrt3 = node.split("-")[2];
	    	var nodes = [String(nodePrt1),nodePrt2,nodePrt3];
	    	
	    	var node12 = nodes[1]+"-"+nodes[2]
	    	
	    	var noStr = "211f";
	    	var noNum = 32;
	    	
	    	const updatebutton = document.createElement('span');
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
		    			
		    		document.getElementById("history_div").style.display = "block";//과거 내역 block
		    		
		    		var use_bgng_ymd = document.querySelector("#use_bgng_ymd");// 시간일자 2023-08-24
		    		var use_bgng_tm = document.querySelector("#use_bgng_ymd");// 종료일자 2023-08-27
		    		var use_bgng_tm = document.querySelector("#use_bgng_tm");//시작 시각 값 예시) 090000
			    	var use_end_tm = document.querySelector("#use_end_tm");//종료시각 값 예시) 100000
	
			    	var use_se_code = document.querySelector("#use_se_code");//연속예약 여부확인 체크박스
			    	
			    	use_bgng_ymd.value = data.useBgngYmd;//시작일자 date타입에 값 입력
			    	use_end_ymd.value = data.useEndYmd;//종료일자 date타입에 값 입력
			    	
			    	for(var i=0;i<use_bgng_tm.length;i++){//팝업창 열었을 때 DB에서 가져온 날짜,시간 selected
			    		if(use_bgng_tm.options[i].value == data.useBgngTm){//시작값과 일치한다면 selected
			    			use_bgng_tm.options[i].selected = true;
			    		}
			    		if(use_end_tm.options[i].value == data.useEndTm){//종료값과 일치한다면 selected
			    			use_end_tm.options[i].selected = true;
			    		}
			    	} 
			    	
			    	var mgt_cn = document.querySelector("#mgt_cn");
			    	var mgt_nm = document.querySelector("#mgt_nm");
			    	console.log(mgt_cn);
			    	for(var i = 0;mgt_nm.length>i;i++){
			    		if(mgt_nm.options[i].value == data.mgtNm){
			    			mgt_nm.options[i].selected = true;
			    		}	
			    	}
			    	if(data.rgtrDepName != data.mdfrDepName){//만약 부서가 같지 않다면
						document.getElementById("update_btn").remove();//수정하기 버튼은 보이지 않음
						document.getElementById("cancel_btn").remove();//예약취소 버튼은 보이지 않음
			    	}
			    	
			    	console.log(data.useSeCode);
			    	
			    	if(data.mgtRoomUseSeCode == "02"){
			    		use_se_code.checked = true;		    		
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
			    	mgt_cn.value = data.mgtCn;//회의내용 넣기
			    	
	    			console.log(data.regDt);//등록날짜 
	    			console.log(data.mdfcnDt);//수정 날짜
		    	}
	    	});
	    }
	    
	    function cancelReservation(node){//회의실 예약 취소
	    	
	    	console.log("node : "+node);
	    	var mgt_nm = document.querySelector("#mgt_nm");//회의주제 select box node
	    	var mgt_cn = document.querySelector("#mgt_cn");//회의 내용 node
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
	    
	   	function isContinueChk(){//회의실 반복사용,연속사용 여부
	   		
	   		
	   		
	   		var use_se_code = document.getElementById("use_se_code");//반복,연속사용 여부 체크 박스
	   	
	   		if(typeof document.getElementById("use_bgng_ymd").value == "undefined"||typeof document.getElementById("use_end_ymd").value == "undefined"){
	   			alert("날짜를 선택해주시기 바랍니다.");
				use_se_code.checked = false;	   			
	   		}
	   		
	   		if(document.getElementById("use_bgng_ymd").value == document.getElementById("use_end_ymd").value){
	   			alert("동일한 날짜에 연속예약을 할 수 없습니다.");
				use_se_code.checked = false;	   			
	   		}
	   		
	   		var use_code_is_checked = use_se_code.checked;//체크 박스 체크 여부
	   		var use_bgng_ymd_val = document.getElementById("use_bgng_ymd").value;
	   		var use_end_ymd_val = document.getElementById("use_end_ymd").value;
	   		
	   		if(use_code_is_checked){//체크박스에 체크했다면
	   			if(confirm("회의실을 이어서 사용하시겠습니까?")){
	   				 alert(use_bgng_ymd_val+"부터 "+use_end_ymd_val+"까지 이어서 회의실을 사용합니다.");
	   			}else{
	   				alert(use_bgng_ymd_val+"부터 "+use_end_ymd_val+"까지 매일 같은 시간에 회의실을 사용합니다.");
	   				use_se_code.checked = false;
	   			}
	   		}
	   	}
	    
	    function updateReservation(node){//회의실 예약 내용 업데이트 // node - 회의실 고유 번호
	    	console.log("updateReservation");
	    	var mgt_nm = document.querySelector("#mgt_nm");//회의주제 select box node
	    	var mgt_cn = document.querySelector("#mgt_cn");//회의 내용 node
	    	
	    	var use_bgng_ymd_val = document.querySelector("#use_bgng_ymd").value;//예약 시작 일자 node
	    	console.log("use_bgng_ymd_val : "+use_bgng_ymd_val);
	    	var use_end_ymd_val = document.querySelector("#use_end_ymd").value;//예약 종료 일자 node
	    	console.log("use_end_ymd_val : "+use_end_ymd_val);
	    	
	    	var use_bgng_tm = document.querySelector("#use_bgng_tm");//시작 시간 값
	    	var use_bgng_tm_val = use_bgng_tm.options[use_bgng_tm.selectedIndex].value;
	    	var use_end_tm = document.querySelector("#use_end_tm");
	    	var use_end_tm_val = use_end_tm.options[use_end_tm.selectedIndex].value;//종료시간 값
	    	
	    	var use_se_code_chk = document.querySelector("#use_se_code").checked;//반복사용여부 체크 boolean type return
	    	var use_se_code_val = "";
	    	
	    	if(use_se_code_chk){
	    		var use_se_code_val = document.querySelector("#use_se_code").value;
	    	}
	    	
	    	use_bgng_ymd_val = use_bgng_ymd_val.split("-")[0]+use_bgng_ymd_val.split("-")[1]+use_bgng_ymd_val.split("-")[2];  
	    	use_end_ymd_val = use_end_ymd_val.split("-")[0]+use_end_ymd_val.split("-")[1]+use_end_ymd_val.split("-")[2];
	    	
	    	console.log("업데이트 시작시간 : "+use_bgng_tm_val);
	    	console.log("업데이트 종료시간 : "+use_end_tm_val);
	    	
	    	
	    	if(mgt_cn.value.trim().length == 0){//띄어쓰기만으로 작성할 수 없음
	    		alert("회의 내용을 입력해주세요");
	    		mgt_cn.value = "";
	    		mgt_cn.focus();
	    		return false;
	    	}
	    	console.log("use_bgng_tm_val : "+use_bgng_tm_val);
	    	if(mgt_cn.value.length>2000){//회의 내용은 2000자를 넘길 수 없음
	    		alert("회의 내용은 2000자를 초과할 수 없습니다.");
	    		return false;
	    	}
	    	
	    	if(use_bgng_tm_val == use_end_tm_val){
	    		alert("시작시간과 종료시간은 같을 수 없습니다.");
	    		return false;
	    	}
	    	
	    	if(use_bgng_tm_val >= use_end_tm_val){//시작 시간과 종료시간이 같거나 종료시간이 큰 경우
	    		if(use_bgng_tm_val > use_end_tm_val||start_minuet > end_minuet){
	    			alert("시작시간보다 종료시간이 이전일 수 없습니다.");
		    		return false;	
	    		}
	    	}
	    	
	    	//content_cnt 콘텐츠 글자 수
	    	var param = {mgtNm : mgt_nm.value,
	    				 mgtCn : mgt_cn.value,
	    				 useBgngYmd : use_bgng_ymd_val,
		   				 useBgngTm : use_bgng_tm_val,
		   				 useEndYmd : use_end_ymd_val,
		   				 useEndTm : use_end_tm_val,
		   				 mgtRoomUseSeCode : use_se_code_val,
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
	    
	    
		function reservationChk(){//예약하기 버튼을 눌렀을 때 - Insert
	    	
	    	var mgt_nm_val = document.querySelector("#mgt_nm").value;//회의주제 select box value
	    	var mgt_cn_val = document.querySelector("#mgt_cn").value;//회의 내용 node
	    	
	    	var use_bgng_ymd_val = document.querySelector("#use_bgng_ymd").value;//예약 시작 일자 node
	    	var use_end_ymd_val = document.querySelector("#use_end_ymd").value;//예약 종료 일자 node
	    	
	    	var use_bgng_tm = document.querySelector("#use_bgng_tm");//예약 시작 시각 node
	    	var use_bgng_tm_val = use_bgng_tm.options[use_bgng_tm.selectedIndex].value;//시작 시각 selected 값
	    	var use_end_tm = document.querySelector("#use_end_tm");//종료 시각 node
	    	var use_end_tm_val = use_end_tm.options[use_end_tm.selectedIndex].value;//종료시각 selected 값
	    	
	    	use_bgng_ymd_val = use_bgng_ymd_val.split("-")[0]+use_bgng_ymd_val.split("-")[1]+use_bgng_ymd_val.split("-")[2];  
	    	use_end_ymd_val = use_end_ymd_val.split("-")[0]+use_end_ymd_val.split("-")[1]+use_end_ymd_val.split("-")[2];
	    	
	    	var use_se_code_chk = document.querySelector("#use_se_code").checked;//반복사용여부 체크 boolean type return
	    	var use_se_code_val = "";
	    	
	    	if(use_se_code_chk){
	    		var use_se_code_val = document.querySelector("#use_se_code").value;
	    	}
	    	
	    	console.log("업데이트 시작시간 : "+use_bgng_tm_val);
	    	console.log("업데이트 종료시간 : "+use_end_tm_val);

	    	if(mgt_cn_val.trim().length == 0){//띄어쓰기만으로 작성할 수 없음
	    		alert("회의 내용을 입력해주세요");
	    		mgt_cn.value = "";
	    		mgt_cn.focus();
	    		return false;
	    	}
	    	
	    	if(mgt_cn_val.length > 1000){//회의 내용은 1000자를 넘길 수 없음
	    		alert("회의 내용은 2000자를 초과할 수 없습니다.");
	    		return false;
	    	}
	    	
	    	if(use_bgng_ymd_val > use_end_ymd_val){//종료일자가 시작일자보다 과거일 때
	    		alert("종료일자가 시작일자보다 과거일 수 없습니다.");
	    		return false;
	    	}
	    	
	    	if(!use_se_code_chk){//연속사용 체크박스에 체크가 되어있지 않다면
	    		
	    		if(use_bgng_tm_val == use_end_tm_val){//시작시각과 종료시각이 같은 경우
		    		alert("시작시각과 종료시각은 같을 수 없습니다.");
		    		return false;
		    	}
	    	
	    		if(use_bgng_tm_val > use_end_tm_val){//종료시각이 시작시각보다 큰 경우
		    		if(use_bgng_tm_val > use_end_tm_val){
		    			alert("시작시간보다 종료시간이 이전일 수 없습니다.");
			    		return false;	
		    		}
		    	}
	    		
	    	}
	    	
	    	//content_cnt 콘텐츠 글자 수
	    	var param = {mgtNm : mgt_nm_val,
	    				 mgtCn : mgt_cn_val,
	    				 useBgngYmd : use_bgng_ymd_val,
	    				 useBgngTm : use_bgng_tm_val,
	    				 useEndYmd : use_end_ymd_val,
	    				 useEndTm : use_end_tm_val,
	    				 mgtRoomUseSeCode : use_se_code_val
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
	    			alert("원하시는 시간에 이미 예약이 존재합니다.");
	    			break;
	    		case 9999:
	    			alert("예상치 못 한 오류가 발생했습니다. 로그인 페이지로 이동합니다.");
	    			location.href="/login/logout";
	    		}
	    		
	    	}
	    	});
	    	
		}
		
		function modal_close(){//취소 버튼을 눌렀을 때  -- 아직 보류중
			
			var use_bgng_tm = document.querySelector("#use_bgng_tm");//시작 시간 값
	    	var use_end_tm = document.querySelector("#use_end_tm");//종료시간 값
	    	/* for(var i=0;i<use_bgng_tm.length;i++){//날짜+시작or종료 시간 삭제 (예시)2023-07-11 17:30:00 >>17:30:00 
	    		use_bgng_tm.options[i].value = use_bgng_tm.options[i].value.split(" ")[1];
	    		use_end_tm.options[i].value = use_end_tm.options[i].value.split(" ")[1];	
	    	} */
			
			var background = document.querySelector(".background");//팝업창 배경(팝업이 뜨는지 유무를 background에서 처리)
			var mgt_cn = document.querySelector("#mgt_cn");//회의 내용 node
			var frame = document.querySelector(".fc-event-title-frame");//예약되어있는 목록들 node
			var reserv_btn = document.getElementById("reserv_btn");//예약 버튼 element
			var close_btn = document.querySelector("#close_btn");//모달 팝업 닫기 버튼 node
			
			var btn_div = document.getElementById("btn_div");//버튼div element선택
			
			background.classList.remove("show");//모달팝업 안보이게			
			mgt_cn.value="";//글내용 초기화
			use_bgng_tm.options[0].selected = true;//시작시간 초기화
	    	use_end_tm.options[0].selected = true;//종료시간 초기화
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
			document.getElementById("mdfr_name").innerHTML = "";
			document.getElementById("mdfcn_dt").innerHTML = "";
			document.getElementById("use_se_code").checked = false;
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
								<select id="mgt_nm">
									<option value="일간 회의">일간 회의</option>
									<option value="주간 회의">주간 회의</option>
									<option value="공부">공부</option>
									<option value="기타">기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><span style="font-size:1.5rem;">회의 내용 : </span></th>
							<td><textArea id="mgt_cn" placeholder="회의 내용을 적어주세요"></textArea></td>
							<td><span id="content_cnt" style="font-size:0.5rem;"></span></td>
						</tr>
						<tr>
							<th><label for="use_bgng_ymd"><span style="font-size:1.5rem;">시작일자 : </span></label></th>
							<td><input id="use_bgng_ymd" type="date"/></td>
							<th><label for="use_end_ymd" ><span style="font-size:1.5rem;">종료일자 : </span></label></th>
							<td><input id="use_end_ymd" type="date"/></td>
							<th><label style="font-size:0.9rem;padding-left:3px;margin-left:5px;"><a title="연속사용이란? &#10;시작일시부터 종료일시까지 해당 회의실을 계속 사용하는 것을 의미합니다." style="cursor: help;">연속사용*</a></label></th>
							<td style="vertical-align: middle;">
								<input type="checkbox" id="use_se_code" style="display:block;" onchange="isContinueChk()" value="02"/>
							</td>
						</tr>
						<tr>
							<th><span style="font-size:1.5rem;">시작 시간 : </span></th>
							<td>
								<select id="use_bgng_tm">
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
								</select>
							</td>
							<th><span style="font-size:1.5rem;">종료 시간 : </span></th>
							<td>
								<select id="use_end_tm">
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
				<div id="history_div">
					<p class="historyNode" id="rgtr_name"></p>
					<p class="historyNode" id="reg_dt"></p>
					<p class="historyNode" id="mdfr_name"></p>
					<p class="historyNode" id="mdfcn_dt"></p>
				</div>
			</div>		
		</div>
	</div>

<div id="page-wrapper">
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false" />

		<div id="container">
			<div class="content">




  <div id='external-events' style="float:left;width:20%;padding-right:30px;padding-left:20px;padding-top:11%">
  
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

	<div style="float:left;width:80%;margin-bottom:110px;">
		<div style="text-align:center;height:30px;font-size:35px;font-weight:bold;margin-bottom:30px;">회의실 예약 달력표</div>
		<div id='calendar' ></div>
	</div>
	
	</div>
	</div>
	</div>
</body>
</html>