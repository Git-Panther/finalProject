/**
 * 
 */

function festivalDetail(contentid, eventstartdate, eventenddate, component){
	//console.log(contentid);
	var form = $("<form>");
	form.attr("id", "festivalDetail");
	form.attr("method", "post");
	form.attr("action", "/planner/festival.do");
	
	$("<input type='hidden'>").attr("name", "contentid").val(contentid).appendTo(form);
	$("<input type='hidden'>").attr("name", "eventstartdate").val(eventstartdate).appendTo(form);
	$("<input type='hidden'>").attr("name", "eventenddate").val(eventenddate).appendTo(form);
	
	// 참고로 날짜에 따른 기상청 조회는 detail 페이지에서 직접 처리할 것이다.
	form.appendTo($(component));
	//console.log(form);
	form.submit(); // 이렇게 해야 url 노출을 막을 수 있다.
}