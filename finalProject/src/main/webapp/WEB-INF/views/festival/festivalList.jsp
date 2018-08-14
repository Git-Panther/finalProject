<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="searchArea.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Festival List</title>
<script>
	$(function(){
		var params = {
			pageNo : "${pageNo}".length != 0 ? "${pageNo}" : undefined,
			arrange : "${arrange}".length != 0 ? "${arrange}" : undefined,
			areaCode : "${areaCode}".length != 0 ? "${areaCode}" : undefined,
			sigunguCode : "${sigunguCode}".length != 0 ? "${sigunguCode}" : undefined,
			eventStartDate : "${eventStartDate}".length != 0 ? "${eventStartDate}" : undefined,
			eventEndDate : "${eventEndDate}".length != 0 ? "${eventEndDate}" : undefined
		};
		selectFestivalList(params);
	});
	
	function selectFestivalList(params){
		$.ajax({        
	        url: 'selectFestivalList.do',
	        type: 'post',
	        data: params,
	        dataType: 'json',
	        success: function(data){
	        	//console.log(data)
	            printFestivalList(data);
	    		printFestivalPageList(data);
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });
	}
	
	function printFestivalList(list){
		//console.log(list);
        //console.log(list.response);        
        var myItem = list.response.body.items.item;
        var $festivals = $("#festivals");
        var img;
        var tableList = $("<table class='festivalList' border='1'>");
        var maintr = $("<tr>");
        var maintd = $("<td>");
        var subTable = $("<table border='1' align='center'>");
        var tr = $("<tr>");
        var th = $("<th>");
        var td = $("<td>");
        var size; // 결과 개수
        var dateString; // 행사 기간
        var cols = 4; // 한 행에 n열
        
        $("#resultAmount").text("");
        $("#resultAmount").append($("<p>").text("결과  : " + list.response.body.totalCount + "건"));
        
        $festivals.html("");
        //console.log(myItem);
        if(undefined == myItem) {
        	size = 0; // 결과가 없으므로 0
        	$("<p>").text("검색 결과가 없습니다.").appendTo($festivals);
        } else if(undefined == myItem.length) { // 결과가 1개이면 배열이 아닌 객체로만 옴
        	size = 1;
        	myItem = [myItem]; // 배열화시켜서 for문 처리 통일함
        }
        else size = myItem.length; // 결과가 2개 이상 있으므로 2 이상
        
        for(var i = 0; i < size; i++){
        	//console.log(myItem[i]);
        	maintd = $("<td>");
        	subTable = $("<table class='festivalInfo link'>").attr("onclick", "festivalDetail('"+myItem[i].contentid+"')");
        	tr = $("<tr>");
        	//th = $("<th>");
        	td = $("<td colspan='2'>");
    
        	img = $("<img>").addClass("img");
        	if(undefined == myItem[i].firstimage) img.attr("src", "/planner/resources/images/festival/no_image.png");
        	else img.attr("src", myItem[i].firstimage);
        	td.append(img).appendTo(td);
        	tr.append(td).appendTo(subTable);
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("축제명 : ").appendTo(th);       	
        	$("<p>").text(myItem[i].title).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);   	
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("장소 : ").appendTo(th);       	
        	$("<p>").html(myItem[i].addr1).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	/* 전화
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("문의전화").appendTo(th);       	
        	$("<p>").html(myItem[i].tel).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	*/
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("기간 : ").appendTo(th);
        	dateString = dateFormat(myItem[i].eventstartdate);
        	if(myItem[i].eventstartdate != myItem[i].eventenddate) dateString += ' ~ ' + dateFormat(myItem[i].eventenddate);
        	$("<p>").text(dateString).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	/* 좌표
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("좌표").appendTo(th);       	
        	$("<p>").text(myItem[i].mapx + ', ' + myItem[i].mapy).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	*/
        	maintd.append(subTable).appendTo(maintr);
        	if( i % cols == cols - 1 || i == myItem.length - 1){
        		maintr.appendTo(tableList);
        		maintr = $("<tr>");
        	}    
        } 
        $festivals.append(tableList);
	}
        
    function printFestivalPageList(list){
    	//console.log(list);
    	var currentPage = list.response.body.pageNo; // 현재 페이지
    	var minPage = 1; // 최소 페이지
    	var totalCount = list.response.body.totalCount; // 총 개수
    	var numOfRows = list.response.body.numOfRows; // 한 페이지당 개수
    	var pageLimit = 10; // 한 번에 표시되는 페이지 리스트 개수
    	var maxPage = Math.ceil(totalCount/numOfRows); // 최대 페이지
    	var pageGroup = Math.ceil(currentPage/pageLimit); // 페이지 그룹
    	
    	//var maxShow = pageGroup * pageLimit; // 현재 표시되는 최대 페이지 번호
    	//if(maxShow > maxPage) maxShow = maxPage; 
    	
    	var maxShow; // 현재 표시되는 최대 페이지 번호
    	var minShow; // 현재 표시되는 최소 페이지 번호
    	
    	if(0 < totalCount){ // 결과가 1개 이상이면 페이지 표시
    		if(currentPage > 5){
        		if(maxPage < currentPage + 5){
        			maxShow = maxPage;
        			minShow = maxPage - 9;
        		}else{
        			minShow = currentPage - 4;
            		maxShow = minShow + 9;
        		}
        	}else{
        		minShow = 1;
        		maxShow = minShow + 9;
        	}
        	
        	if(maxShow > maxPage) maxShow = maxPage; // 최대치 넘으면 안되므로
        	if(minShow < 1) minShow = minPage; // 1페이지보다 작아질 순 없다
        	// var minShow = maxShow - (pageLimit - 1); // 현재 표시되는 최소 페이지 번호
        	
        	//console.log(currentPage, minPage, totalCount, numOfRows, pageLimit, maxPage, minShow, maxShow);
    		
    		var $pageList = $("#pageList");
        	var p = $("<p class='pageElement'>");
        	p.text("<<");
        	if(1 != currentPage){
        		p.attr("onclick", "movePage("+minPage+")");
        		p.addClass("link");
        	}else{
        		p.addClass("disactive");
        	}
        	p.appendTo($pageList);
        	
        	p = $("<p class='pageElement'>");
        	p.text("<");
        	if(1 != currentPage){
        		p.attr("onclick", "movePage("+(currentPage - 1)+")");
        		p.addClass("link");
        	}else{
        		p.addClass("disactive");
        	}
        	p.appendTo($pageList);
        	
        	for(var i = minShow; i <= maxShow; i++){
        		p = $("<p class='pageElement'>");
        		p.text(i);
        		if(i == currentPage){
        			p.addClass("selected");
        		}else{
        			p.attr("onclick", "movePage("+i+")");
        			p.addClass("link");
        		}
        		p.appendTo($pageList);
        	}
        	
        	p = $("<p class='pageElement'>");
        	p.text(">");
        	if(maxPage != currentPage){
        		p.attr("onclick", "movePage("+(currentPage + 1)+")");
        		p.addClass("link");
        	}else{
        		p.addClass("disactive");
        	}
        	p.appendTo($pageList);
        	
        	p = $("<p class='pageElement'>");
        	p.text(">>");
        	if(maxPage != currentPage){
        		p.attr("onclick", "movePage("+maxPage+")");
        		p.addClass("link");
        	}else{
        		p.addClass("disactive");
        	}
        	p.appendTo($pageList);
        	//console.log($pageList);
    	}
    }
    
    function movePage(pageNo){
    	<c:url var="movePage" value="/festivalList.do"></c:url>
    	var form = $("<form>");
    	form.attr("id", "movePage");
    	form.attr("method", "post");
    	form.attr("action", "${movePage}");
    	$("<input type='hidden'>").attr("name", "pageNo").val(pageNo).appendTo(form);
    	if("${arrange}" != "") $("<input type='hidden'>").attr("name", "arrange").val("${arrange}").appendTo(form);
    	if("${areaCode}" != "") $("<input type='hidden'>").attr("name", "areaCode").val("${areaCode}").appendTo(form);
    	if("${sigunguCode}" != "") $("<input type='hidden'>").attr("name", "sigunguCode").val("${sigunguCode}").appendTo(form);
    	if("${eventStartDate}" != "") $("<input type='hidden'>").attr("name", "eventStartDate").val("${eventStartDate}").appendTo(form);
    	if("${eventEndDate}" != "") $("<input type='hidden'>").attr("name", "eventEndDate").val("${eventEndDate}").appendTo(form);
		form.appendTo($("#pageList"));
    	//console.log(form);
		form.submit(); // 이렇게 해야 url 노출을 막을 수 있다.
    	
    	/*
    	var loc = "/planner/festivalList.do?pageNo="+pageNo;
    	if("${arrange}" != "") loc += "&arrange="+"${arrange}";
    	if("${areaCode}" != "") loc += "&areaCode="+"${areaCode}";
    	if("${sigunguCode}" != "") loc += "&sigunguCode="+"${sigunguCode}";
    	if("${eventStartDate}" != "") loc += "&eventStartDate="+"${eventStartDate}";
    	if("${eventEndDate}" != "") loc += "&eventEndDate="+"${eventEndDate}";
    	location.href = loc;
    	*/
    }
    
    function dateFormat(date){
    	var dateStr = date.toString();
    	return dateStr.substr(0, 4) + "년 " + dateStr.substr(4, 2) + "월 " + dateStr.substr(6, 2) + "일"
    }
    
    function festivalDetail(contentid){
    	//console.log(contentid, 15);
    	location.href="/planner/festival.do?contentid="+contentid;
    	// 정 보안을 원한다면 가려라. form 태그로
    }
</script>
</head>
<body>
<div class="outer">
	<div class="area" id="festivals"></div>
	<br>
	<div class="pageList" id="pageList"></div>
</div>
</body>
<c:import url="/footer.do"/>
</html>