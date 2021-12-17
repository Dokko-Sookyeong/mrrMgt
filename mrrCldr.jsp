<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="CacheCommboUtil" uri="/WEB-INF/tlds/CacheCommboUtil.tld"%>
<%@ include file="/WEB-INF/jsp/egovframework/mordern/config/common.jsp" %>
<script type="text/javascript" src="/common/ckeditor/ckeditor.js" charset="UTF-8" ></script>
<script type="text/javascript" src="/common/ckeditor/adapters/jquery.js" charset="UTF-8" ></script>
<link href='/common/fullcalendar-5.10.1/lib/main.css' rel='stylesheet' />
<script src='/common/fullcalendar-5.10.1/lib/main.js'></script>
<style>
	/*month/week/day*/
	.fc-button-active{
		border-color: #ffc107 		!important;
		background-color: #ffc107 	!important;
		color: #000 				!important;
		font-weight: bold 			!important;
	}
	/*노란버튼*/
	.btn-warning{
		font-weight: bold;
	}
	/*달력 요일,날짜 색 변경 시 필요*/
	.fc-col-header-cell-cushion, .fc-daygrid-day-number {
		color: inherit !important;
	}
	/*일정 내용 색상*/
	.fc-daygrid-event{
		color: #000000 !important;
	}
	/*요일별 색상*/
	.fc-day-sun {
		color: red !important;
	}
	.fc-day-mon {
		color: black !important;
	}
	.fc-day-tue {
		color: black !important;
	}
	.fc-day-wed {
		color: black !important;
	}
	.fc-day-thu {
		color: black !important;
	}
	.fc-day-fri {
		color: black !important;
	}
	.fc-day-sat {
		color: blue !important;
	}
</style>
<script type="text/javascript">
var mrrCldr = [];
document.addEventListener('DOMContentLoaded', function() {
	selectListMrrCldr();
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },

      	timeZone: 'UTC',
      	events: mrrCldr,
      	eventClick: function(info) {
      	    fnDetail(info.event._def.publicId);
      	}


    });

    calendar.render();
  });

// 회의 리스트 받아오기 Ajax(동기)
  function selectListMrrCldr() {
	  $.ajax({
	         url : "/admin/mrr/selectListMrrCldrAjax.do",
	         type : 'POST',
	         dataType : 'json',
	         async: false,
	         success : function(response) {
	        		mrrCldr = response.resultStats.resultMsg.mrrCldr;
	            }
	      });
  }

//캘린더 상세
  function fnDetail(mrrSeq) {
     $("[name=mrr_seq]").val(mrrSeq);
     $("#aform").attr({
        action : "/admin/mrr/"+fnSysMappingCode()+"selectMrrMgt.do",
        method : 'post'
     }).submit();
  }
</script>
<div class="content">
   <div class="container-fluid">
      <div class="row">
         <div class="col-lg-12">
             <form role="form" id="aform" method="post" action="/admin/mrr/selectPageListMrrMgt.do">
                   <input type="hidden" name="mrr_seq" />
                 <div class="card card-info card-outline">
                     <div class="card-body">
                        <div id='calendar'></div>
                    </div>
                 </div>
             </form>
         </div>
      </div>
   </div>
</div>