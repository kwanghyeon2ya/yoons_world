<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
<head>
	<link href='/fullcalendar/main.css' rel='stylesheet' />
	<script src='/fullcalendar/main.js'></script>
	<script src='/fullcalendar/locales/ko.js'></script>
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
		  transition: all 0.5s;
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
		      droppable: true, // this allows things to be dropped onto the calendar
		      drop: function(info) {
		        // is the "remove after drop" checkbox checked?
		        if (checkbox.checked) {
		          // if so, remove the element from the "Draggable Events" list
		          info.draggedEl.parentNode.removeChild(info.draggedEl);
		        }
		      }
		    });
		    calendar.render();
		    var item = document.querySelectorAll(".fc-event");
		    item.addEventListener('drop', handleDrop);
		  });
	  
	  
	  
	  function handleDrop(e){//회의 주제를 날짜에 놓았을 때 발생
		  e.stopPropagation();//브라우저 리다이렉트 방지
		  this.addClass("show");
	  }
  </script>
  
</head>

<body>


	<div class="background">
		<div class="window">
			<div class="popup">
				<table style="margin:0 auto;border-collapse: separate;border-spacing: 0 10px;margin-bottom: 100px;">
					<tbody>
						<tr style="margin-bottom:50px;">
							<th><span style="font-size:1.5rem;">회의 주제 : </span></th>
							<td>
								<select id="room_subject">
									<option>일간회의</option>
									<option>주간회의</option>
									<option>공부</option>
									<option>기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><span style="font-size:1.5rem;">회의 내용 : </span></th>
							<td><textArea id="room_content"></textArea></td>
						</tr>
						<tr>
							<th><span style="font-size:1.5rem;">시작 시간 : </span></th>
							<td>
								<select id="start_dt">
									<option>9:00</option>
									<option>9:30</option>
									<option>10:00</option>
									<option>10:30</option>
									<option>11:00</option>
									<option>11:30</option>
									<option>12:00</option>
									<option>12:30</option>
									<option>13:00</option>
									<option>13:30</option>
									<option>14:00</option>
									<option>14:30</option>
									<option>15:00</option>
									<option>15:30</option>
									<option>16:00</option>
									<option>16:30</option>
									<option>17:00</option>
								</select>
							</td>
							<th><span style="font-size:1.5rem;">종료 시간 : </span></th>
							<td>
								<select id="end_dt">
									<option>9:30</option>
									<option>10:00</option>
									<option>10:30</option>
									<option>11:00</option>
									<option>11:30</option>
									<option>12:00</option>
									<option>12:30</option>
									<option>13:00</option>
									<option>13:30</option>
									<option>14:00</option>
									<option>14:30</option>
									<option>15:00</option>
									<option>15:30</option>
									<option>16:00</option>
									<option>16:30</option>
									<option>17:00</option>
									<option>17:30</option>
								</select>
							</td>
						</tr>					
					</tbody>
				</table>
			</div>		
		</div>
	</div>

  <div id='external-events' style="float:left;width:10%;padding-right:30px;padding-left:20px;margin-top:110px;">
  
	<p>
		<strong>회의를 원하는 날짜에 드래그하여 예약하세요.</strong>
	</p>

    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
      <div class='fc-event-main'>일간 회의</div>
    </div>
    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
      <div class='fc-event-main'>주간 회의</div>
    </div>
    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
      <div class='fc-event-main'>공부</div>
    </div>
    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
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