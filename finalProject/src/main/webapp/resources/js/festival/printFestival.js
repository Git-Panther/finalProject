/**
 * 
 */

function printFestivalCommon(common){
	//console.log(common);
	$("#festivalTitle p").text(common.title); // 행사명
	
	var src;
	if(undefined != common.firstimage) src = common.firstimage;
	else src = "/planner/resources/images/festival/no_image.png";
	
	$("#festivalPicture").attr("src", src);// 이미지
	
	var $festivalCommonInfo = $("#festivalCommonInfo"); // 기본 정보(개요)
	
	var table = $("<table class='infoTable'>");
	var tr = $("<tr>");
	var th = $("<th>");
	var td = $("<td>");
	
	if(common.addr1 != undefined && common.addr1 != ""){
		var address = common.addr1;
		if(common.addr2 != undefined) address += common.addr2;
		th.text("주소").appendTo(tr);
		td.text(address).appendTo(tr);
		tr.appendTo(table);
	}	
	
	// 초기화
	if(common.hompage != undefined && common.hompage != ""){
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td>");	
		th.text("홈페이지").appendTo(tr);
		td.html(common.homepage).appendTo(tr);
		tr.appendTo(table);
	}
	
	if(common.tel != undefined && common.tel != ""){
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td>");	
		th.text("전화").appendTo(tr);
		td.html(common.telname + "<br>" + common.tel).appendTo(tr);
		tr.appendTo(table);
	}

	table.appendTo($festivalCommonInfo);
	
	var festivalx = common.mapx;
	var festivaly = common.mapy;
	
	locationBasedList(festivalx, festivaly, 32); // 숙박
	locationBasedList(festivalx, festivaly, 39); // 음식점
	forecast(festivalx, festivaly); // 날씨 정보 불러오기 ajax
	
	// 지도 표시를 해준다 ㅇㅇ.
	var center = new daum.maps.LatLng(festivaly, festivalx);
	printMark(center, common.title, contenttypeid);
}

function printFestivalDetail(detail){
	//console.log(detail);		
	var $commonTable = $("#festivalCommonInfo table");
	var tr = $("<tr>");
	var th = $("<th>");
	var td = $("<td>");
	
	if(detail.agelimit != undefined && detail.agelimit != ""){
		th.text("연령대").appendTo(tr); // 연령대 추가
		td.html(detail.agelimit).appendTo(tr);
		tr.appendTo($commonTable);
	}
	
	$("#festivalCommonInfo table td").eq(0).append(" " + detail.eventplace); // 장소 추가
	
	if(detail.playtime != undefined && detail.playtime != ""){
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td>");	
		th.text("기간").appendTo(tr); // 기간 추가
		td.html(detail.playtime).appendTo(tr);
		tr.appendTo($commonTable);
	}

	if(detail.program != undefined && detail.program != ""){
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td>");	
		th.text("프로그램").appendTo(tr); // 행사내용 추가
		td.html(detail.program).appendTo(tr);
		tr.appendTo($commonTable);	
	}
	
	if(detail.spendtimefestival != undefined && detail.spendtimefestival != ""){
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td>");	
		th.text("입장 권한").appendTo(tr); // 입장권한 추가
		td.html(detail.spendtimefestival).appendTo(tr);
		tr.appendTo($commonTable);
	}
	
	if(detail.sponsor1 != undefined && detail.sponsor1 != ""){
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td>");	
		th.text("후원").appendTo(tr); // 후원 추가
		var sponser = detail.sponsor1 + " : " + detail.sponsor1tel;
		if(detail.sponser2 != undefined && detail.sponser2 != ""){
			sponser += "<br>" + detail.sponsor2 + " : " + detail.sponsor2tel
		}
		td.html(sponser).appendTo(tr);
		tr.appendTo($commonTable);
	}
	
	if(detail.usetimefestival != undefined && detail.usetimefestival != ""){
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td>");	
		th.text("참가비").appendTo(tr); // 비용 추가
		td.html(detail.usetimefestival).appendTo(tr);
		tr.appendTo($commonTable);
	}
	
	if(detail.subevent != undefined && detail.subevent != ""){
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td>");	
		th.text("추가 이벤트").appendTo(tr); // 추가 이벤트 추가
		td.html(detail.subevent).appendTo(tr);
		tr.appendTo($commonTable);
	}	
}

function printFestivalInfo(info){ // 반복 정보 추가(안내)
	//console.log(detail);
	var $festivalDetailInfo = $("#festivalDetailInfo"); // 기본 정보(개요)
	var table = $("<table class='infoTable'>");
	var tr = $("<tr>");
	var th = $("<th>");
	var td = $("<td>");
	
	if(info.length != undefined){ // 배열 형태이면
		info.forEach(function(v) {
			//console.log(v);
			tr = $("<tr>");
			th = $("<th>");
			td = $("<td>");
			th.html(v.infoname).appendTo(tr);
			td.html(v.infotext).appendTo(tr);
			tr.appendTo(table);
		})
	}else{ // 단일 값만 넘어왔다면
		th.html(info.infoname).appendTo(tr);
		td.html(info.infotext).appendTo(tr);
		tr.appendTo(table);
	}

	table.appendTo($festivalDetailInfo);
}

function printNearInfo(list, contenttypeid){ // 근처 정보
	//console.log(list, contenttypeid);
	var $nearInfo;
	var noSearch; // 검색 결과 없을 때
	if(32 == contenttypeid) {
		$nearInfo = $("#festivalHotels");
		noSearch = "숙박 시설";
	}
	else if(39 == contenttypeid) {
		$nearInfo = $("#festivalRestaurants");
		noSearch = "식당";
	}
	if("" == list || undefined == list){
		$nearInfo.html("반경 1km 이내에 "+ noSearch +"이 없습니다.");
	}else{ // 있다면
		var img;
        var tableList = $("<table class='nearList' border='1'>");
        var maintr = $("<tr>");
        var maintd = $("<td>");
        var subTable = $("<table border='1' align='center'>");
        var tr = $("<tr>");
        var th = $("<th>");
        var td = $("<td>");
        var addr; // 주소
        var cols = 3; // 한 행에 n열
		
		if(undefined == list.length){ // 결과값이 하나면 배열로 바꿔줌
			list = [list];
		}
        
		for(var i = 0; i < list.length; i++){
        	//console.log(myItem[i]);
        	maintd = $("<td>");
        	subTable = $("<table class='nearInfo'>").attr("onclick", "");
        	tr = $("<tr>");
        	//th = $("<th>");
        	td = $("<td colspan='2'>");
    
        	img = $("<img>").addClass("img");
        	if(undefined == list[i].firstimage) img.attr("src", "/planner/resources/images/festival/no_image.png");
        	else img.attr("src", list[i].firstimage);
        	td.append(img);
        	tr.append(td).appendTo(subTable);
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("이름").appendTo(th);       	
        	$("<p>").text(list[i].title).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);   	
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("주소").appendTo(th);
        	addr = list[i].addr1;
        	if(undefined != list[i].addr2/* || "" != list[i].addr2*/) addr += list[i].addr2;
        	$("<p>").html(addr).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("행사 장소로부터").appendTo(th);       	
        	$("<p>").html(list[i].dist + "m").appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        		
        	tr = $("<tr>");
        	th = $("<th>");
        	td = $("<td>");   	
        	$("<p>").text("전화").appendTo(th);       	
        	$("<p>").html(list[i].tel).appendTo(td);
        	tr.append(th).append(td).appendTo(subTable);
        	
        	maintd.append(subTable).appendTo(maintr);
        	
        	printMark(new daum.maps.LatLng(list[i].mapy, list[i].mapx), list[i].title, contenttypeid);
        	if( i % cols == cols - 1 || i == list.length - 1){
        		if(i == list.length - 1 && i < cols - 1){ // 2개 이하일 때에는 테이블 깨짐.
        			var extra = 0;
        			switch(i % cols){
        			case 0:
        				extra = 2;
        				break;
        			case 1:
        				extra = 1;
        				break;
        			case 2:
        				extra = 0;
        				break;
        			}
        			// 빈칸 채우기용
	        		for(var j = 0; j < extra; j++){
	        			maintd = $("<td>");
	        			subTable = $("<table class='opacity'>");
	        			tr = $("<tr>");
	    	        	//th = $("<th>");
	    	        	td = $("<td colspan='2'>");
	    	    
	    	        	img = $("<img>").addClass("img");
	    	        	if(undefined == list[i].firstimage) img.attr("src", "/planner/resources/images/festival/no_image.png");
	    	        	else img.attr("src", list[i].firstimage);
	    	        	td.append(img);
	    	        	tr.append(td).appendTo(subTable);
	    	        	
	    	        	tr = $("<tr>");
	    	        	th = $("<th>");
	    	        	td = $("<td>");   	
	    	        	$("<p>").text("이름").appendTo(th);       	
	    	        	$("<p>").text(list[i].title).appendTo(td);
	    	        	tr.append(th).append(td).appendTo(subTable);   	
	    	        	
	    	        	tr = $("<tr>");
	    	        	th = $("<th>");
	    	        	td = $("<td>");   	
	    	        	$("<p>").text("주소").appendTo(th);
	    	        	addr = list[i].addr1;
	    	        	if("" != list[i].addr2) addr += list[i].addr2;
	    	        	$("<p>").html(addr).appendTo(td);
	    	        	tr.append(th).append(td).appendTo(subTable);
	    	        	
	    	        	tr = $("<tr>");
	    	        	th = $("<th>");
	    	        	td = $("<td>");   	
	    	        	$("<p>").text("행사 장소로부터").appendTo(th);       	
	    	        	$("<p>").html(list[i].dist + "m").appendTo(td);
	    	        	tr.append(th).append(td).appendTo(subTable);
	    	        		
	    	        	tr = $("<tr>");
	    	        	th = $("<th>");
	    	        	td = $("<td>");   	
	    	        	$("<p>").text("전화").appendTo(th);       	
	    	        	$("<p>").html(list[i].tel).appendTo(td);
	    	        	tr.append(th).append(td).appendTo(subTable);
	    	        	
	    	        	maintd.append(subTable).appendTo(maintr);
	        		}
	        	}
        		maintr.appendTo(tableList);
        		maintr = $("<tr>");
        	}
        } 
	}           
	$nearInfo.append(tableList);
}

function festivalTapEvent(){
	$("#festivalTap td").each(function(){
		$(this).click(function(){
			//$("#festivalTap td").removeClass("showing");
			//$(this).addClass("showing");
			showInfo($(this).text());
		});
	});
}

function showInfo(content){
	//console.log(content);
	switch(content){
	case "개요":
		$(".tapGroup1").hide();
		$("#festivalCommonInfo").show();
		break;
	case "안내":
		$(".tapGroup2").hide();
		$("#festivalDetailInfo").show();
		break;
	case "지도":
		$(".tapGroup1").hide();
		$("#festivalMap").show();
		break;
	case "숙박":
		$(".tapGroup2").hide();
		$("#festivalHotels").show();
		break;
	case "식당":
		$(".tapGroup2").hide();
		$("#festivalRestaurants").show();
		break;
	case "일기예보":
		$(".tapGroup1").hide();
		$("#festivalForecast").show();
		break;
	case "교통상황":
		$(".tapGroup1").hide();
		$("#festivalTraffic").show();
		break;
	}
}