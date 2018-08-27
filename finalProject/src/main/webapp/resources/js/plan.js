$(document).ready(function() {
    selectFavoriteList(15);
    selectFavoriteHotel(32);
});

function selectFavoriteList(contentTypeId) {
    $.ajax({
        url: "selectFavoriteList.do",
        type: "post",
        data: {
            userNo: 1,
            contentTypeId: contentTypeId
        },
        dataType: 'json',
        success: function(data){
            console.log(data);
            printFavorite(data.list);
            addevent();
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("Status: " + textStatus); alert("Error: " + errorThrown);
        }
    });
}

function printFavorite(list) {
    console.log(list);
    list.forEach(function (v, i) {
        var div = $("<div>").addClass("fc-event");
        div.text(v.CONTENTID);
        div.data('event', {
            title: div.text(), // use the element's text as the event title
            stick: true, // maintain when user navigates (see docs on the renderEvent method)
            contenttypeid : v.CONTENTTYPEID,
            startdate : v.EVENTSTARTDATE,
            enddate : v.EVENTENDDATE
        });
        div.appendTo("#favoriteFestivals");
        div.on("mouseenter", function(){
        	doTooltip(event,i);
        });
        div.on("mouseleave", function(){
        	hideTip();
        });

        messages.push(["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJu7L6VPKSLfcTtCOp1QdcJuxM0z5rU2-jykh2XgGjUHMEX5Au4Q",
        	v.CONTENTID + "<br>" + v.EVENTSTARTDATE + " ~ " + v.EVENTENDDATE,
            "#FFFFFF"]);
    });
}

function addevent() {
    $('#external-events .fc-event').each(function() {
        // store data so the calendar knows to render an event upon drop
        //console.log($.trim($(this).text()));
        /*
        $(this).data('event', {
            title: $.trim($(this).text()), // use the element's text as the event title
            stick: true, // maintain when user navigates (see docs on the renderEvent method)
            startdate : "2018-08-25",
            enddate : "2018-08-26"
        });
        */

        // make the event draggable using jQuery UI
        $(this).draggable({
            zIndex: 999,
            revert: true,      // will cause the event to go back to its
            revertDuration: 0  //  original position after the drag
        });
    });

    //console.log($('#external-events .fc-event'));
    /* initialize the calendar
    -----------------------------------------------------------------*/

    // $('#favoriteFestivals').draggable({
    //     revert: true,      // immediately snap back to original position
    //     revertDuration: 0  //
    // });
    drawCalendar();
//    $('#calendar').fullCalendar({
//        header: {
//            left: 'prev,next today',
//            center: 'title',
//            right: 'month,agendaWeek,agendaDay'
//        },
//        lang: 'ko',
//        //businessHours: true, //토, 일 색 회색으로 변경
//        googleCalendarApiKey :"AIzaSyCGWuSmpJq73sOY_B8MY4tXQBMgRwmeaes",
//        editable: true,
//        draggable: true,
//        droppable: true, // this allows things to be dropped onto the calendar
//
//        events: [ //이벤트 등록
//            {
//                title : "festival",
//                start : '2018-09-22',
//                end : '2018-09-24'
//            }
//        ],
//        eventSources : [
//            // 대한민국의 공휴일
//            {
//                googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
//                , className : "koHolidays"
//                , color : "#ffffff"
//                , textColor : "#FF0033"
//                , editable: false
//            }],
//        eventDrop: function(event, delta, revertFunc) { //캘리더에서 캘린더로 드래그시 위치변경 알림
//            // console.log(event, delta, revertFunc); // 이벤트에 시작일, 종료일 담기 가능?
//            // alert("날짜를 변경 할 축제이름 : " + event.title + "  변경할 날짜 : " + event.start.format());
//                swal({
//                    title: event.title,
//                    text: "변경된 날짜는 : " + event.start.format() + "입니다.",
//                    icon: "success",
//                    button: "일정 변경하기"
//                });
//        },
//        drop: function(date, event) {  //찜 목록에서 캘린더로 드래그시 이벤트
//            //'2018-08-20' -> 실제 축제기간 넣기(switch-case?, ajax?)
//            console.log(event.target);
//            var $target = $(event.target);
//            console.log($target.data());
//            console.log(123123, $target.data().event.startdate);
//
//            var startdate = $target.data().event.startdate;
//            var endddate = $target.data().event.enddate;
//
//            if (date.format() >= startdate && date.format() <= endddate) {
//                // alert("입력할 날짜 : " + date.format());// && confirm("축제 기간입니다. 일정을 추가 하시겠습니까?")
//                swal({
////                    text: "입력된 날짜는 : " + startdate ~ endddate + " 입니다.",
//                    text: "입력된 날짜는 : " + startdate + "~" + endddate + " 입니다.",
//                    icon: "success",
//                    button: "일정 추가"
//                });
//                
//                console.log($('#calendar').fullCalendar('clientEvents'));
//            }else {
//                // alert("축제 기간이 아닙니다. 축제 기간은 : " + startdate + " ~ " + endddate + " 입니다.");
//                swal({
//                    text: "축제 기간이 아닙니다." +"\n"+ "축제 기간은 : " + startdate + " ~ " + endddate + " 입니다.",
//                    icon: "error",
//                    button: "축제 기간에 넣어주세요"
//                })
//            }
//
//            //체크박스 -> 체크후 드래그시 목록 사라짐
//            // is the "remove after drop" checkbox checked?
//            if ($('#drop-remove').is(':checked')) {
//                // if so, remove the element from the "Draggable Events" list
//                $(this).remove();
//            }
//        },
//        eventDragStop: function (event, jsEvent, ui, view) {
//            console.log(event, jsEvent, ui, view);
//        },
//        eventResize: function(event, delta, revertFunc) {
//
//            // alert(event.title + " 이 축제의 기간이 " + event.start.format() + " 에서 " +
//            // event.end.format() + "까지로 변경됩니다.");
//            swal({
//                text: event.title + "이 축제의 기간이 " + "\n" + event.start.format() + " 에서 " +
//                "\n" + event.end.format() + " 으로 변경됩니다.",
//                icon: "success",
//                button: "변경하기"
//            });
//
//            // if (!confirm("변경 하시겠습니까??")) {
//            //     revertFunc();
//            // }
//
//        }
//
//        // },
//        // eventLimit: false,
//        // events: [
//        //     {
//        //         title: 'Festival', //ajax
//        //         start: '2018-08-20',
//        //         end: '2018-08-23'
//        //     }]
//    });

}

function selectFavoriteHotel(contentTypeId) {
    $.ajax({
        url: "selectFavoriteHotel.do",
        type: "post",
        data: {
            userNo: 1,
            contentTypeId: contentTypeId
        },
        dataType: 'json',
        success: function(data){
            console.log(data);
            printFavoriteHotel(data.list);
            addevent();
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("Status: " + textStatus); alert("Error: " + errorThrown);
        }
    });
}

function printFavoriteHotel(list) {
    console.log(list);
    list.forEach(function (v, i) {
        var div = $("<div>").addClass("fc-event");
        div.text(v.CONTENTID).appendTo("#favoriteHotels");
    });
}