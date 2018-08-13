<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="/header.do"/>
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
	        type: 'get',
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
        
        $("#resultAmount").text("");
        $("#resultAmount").append($("<p>").text("결과  : " + list.response.body.totalCount + "건"));
        
        $festivals.html("");
        for(var i = 0; i < myItem.length; i++){
        	//console.log(myItem[i]);
        	maintd = $("<td>");
        	subTable = $("<table class='festivalInfo'>");
        	tr = $("<tr>");
        	//th = $("<th>");
        	td = $("<td colspan='2'>");
    
        	img = $("<img>").css({"width":"300px", "height":"300px"});
        	if(myItem[i].firstimage != undefined) img.attr("src", myItem[i].firstimage);
        	else img.attr("src", "/planner/resources/images/festival/no_image.png");
        	td.append(img).appendTo(td);
        	tr.append(td).appendTo(subTable);
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text((i+1)+ "번째").appendTo(th);       	
        	$("<p>").text(myItem[i].title).addClass("link").attr("onclick", "festivalDetail('"+myItem[i].contentid+"')").appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);   	
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("행사 장소").appendTo(th);       	
        	$("<p>").html(myItem[i].addr1).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("문의전화").appendTo(th);       	
        	$("<p>").html(myItem[i].tel).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("기간").appendTo(th);       	
        	$("<p>").text(myItem[i].eventstartdate + '~' + myItem[i].eventenddate).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("좌표").appendTo(th);       	
        	$("<p>").text(myItem[i].mapx + ', ' + myItem[i].mapy).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	
        	maintd.append(subTable).appendTo(maintr);
        	if( i % 3 == 2 || i == myItem.length - 1){
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
    
    function movePage(pageNo){
    	var loc = "/planner/festivalList.do?pageNo="+pageNo;
    	if("${arrange}" != "") loc += "&arrange="+"${arrange}";
    	if("${areaCode}" != "") loc += "&areaCode="+"${areaCode}";
    	if("${sigunguCode}" != "") loc += "&sigunguCode="+"${sigunguCode}";
    	if("${eventStartDate}" != "") loc += "&eventStartDate="+"${eventStartDate}";
    	if("${eventEndDate}" != "") loc += "&eventEndDate="+"${eventEndDate}";
    	location.href=loc;
    }
    
    function festivalDetail(contentid){
    	//console.log(contentid, 15);
    	location.href="/planner/festival.do?contentid="+contentid;
    }
</script>
</head>
<body>
<div class="outer">
	<hr>
	<div class="area" id="festivals"></div>
	<br>
	<div class="pageList" id="pageList"></div>
</div>
</body>
<c:import url="/footer.do"/>
</html>