/**
 * 디테일한 정보를 출력할 때, 여기서 한 번 필터링을 거친 다음에 출력한다.
 */
function printCommon(item){ // 공통정보 출력
	console.log("printCommon called");
	$(".spot_addr").html(item.addr1);
	if(15 === item.contenttypeid) $(".spot_addr").append("$");  
	$(".spot_addr").append(" (" + item.zipcode + ")");
	if(undefined != item.hompage) $(".spot_homepage").html(item.hompage);
	else $(".spot_homepage").remove();
	$(".spot_tel").html(item.telname + " : " + item.tel);
}

function printIntro(item){ // 상세정보 출력
	switch(item.contenttypeid){
	case 12:
		printAttractionIntro(item);
		break;
	case 14:
		printCultureIntro(item);
		break;
	case 15:
		//checkFavorite(item); // 찜 여부 체크
		printFestivalIntro(item);
		break;
	case 32:
		printHotelIntro(item);
		break;
	case 38:
		printShoppingIntro(item);
		break;
	case 39:
		printRestaurantIntro(item);
		break;
	}
}

function printInfo(item){ // 반복정보 출력. 반복 정보는 다 다르지만 배열화하여 각각의 개별 정보가 나오니까 통일 가능할지도?
	console.log("printInfo called.");
	
	if(undefined === item.length) item = [item];
	/*
	switch(item[0].contenttypeid){
	case 15:
		printFestivalInfo(item);
		break;
	case 32:
		break;
	case 39:
		break;
	}*/
	var $tbody = $("#spot_info_default").children("tbody");
	//console.log($tbody);
	
	var tr = $("<tr>"); // 한 줄
	var th = $("<th>"); // 설명의 제목
	var td = $("<td colspan='3'>"); // 자세한 설명 또는 공백 채우기용?
	
	if(undefined === item.length) item = [item];
	
	item.forEach(function(v, i){
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
		
		th.html(v.infoname).appendTo(tr);
		td.html(v.infotext).appendTo(tr);
		tr.appendTo($tbody);
	});
}

function printImage(item){ // 이미지 정보 출력 : 이것은 공통이다
	console.log("printImage called");
	var categoryText = $(".nav_box").text();
	$("#category").html(categoryText.split(">")[0] + ">" + categoryText.split(">")[1] + ">" + categoryText.split(">")[2]);
}

// 여기서부터 각 관광별로 표시가 다름

function printFestivalCommon(item){
	console.log("printFestivalCommon called");
	$(".spot_addr").html(item.addr1 + "$" + " (" + item.zipcode + ")");
	if(undefined != item.hompage) $(".spot_homepage").html(item.hompage);
	else $(".spot_homepage").remove();
	$(".spot_tel").html(item.telname + " : " + item.tel);
}

function printAttractionIntro(item){
	
}

function printCultureIntro(item){
	
}

function print

function printFestivalIntro(item){
	console.log("printFestivalIntro called");
	var addr = $(".spot_addr").html();
	$(".spot_addr").html(addr.split("$")[0] + " " + item.eventplace + " " + addr.split("$")[1]); // 주소 재구성
	
	var $tbody = $("#spot_info_default").children("tbody");
	//console.log($tbody);
	
	var tr = $("<tr>"); // 한 줄
	var th = $("<th>"); // 설명의 제목
	var td = $("<td colspan='3'>"); // 자세한 설명 또는 공백 채우기용?
	
	if(undefined != item.placeinfo && "" != item.placeinfo){
		th.html("추천 경로").appendTo(tr);
		td.html(item.placeinfo).appendTo(tr);
		tr.appendTo($tbody);
		
		// 초기화
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	
	if(undefined != item.playtime && "" != item.playtime){
		th.html("기간").appendTo(tr);
		td.html(item.playtime).appendTo(tr);
		tr.appendTo($tbody);
		
		// 초기화
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}

	if(undefined != item.agelimit && "" != item.agelimit){
		th.html("연령 제한").appendTo(tr);
		td.html(item.agelimit).appendTo(tr);
		tr.appendTo($tbody);
		
		// 초기화
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	
	
	if(undefined != item.spendtimefestival && "" != item.spendtimefestival){
		th.html("이용 시간").appendTo(tr);
		td.html(item.spendtimefestival).appendTo(tr);
		tr.appendTo($tbody);
		
		// 초기화
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	
	if(undefined != item.usetimefestival && "" != item.usetimefestival){
		th.html("비용").appendTo(tr);
		td.html(item.usetimefestival).appendTo(tr);
		tr.appendTo($tbody);
		
		// 초기화
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	
	if(undefined != item.program && "" != item.program){
		th.html("프로그램").appendTo(tr);
		td.html(item.program).appendTo(tr);
		tr.appendTo($tbody);
		
		// 초기화
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	
	if(undefined != item.subevent && "" != item.subevent){
		th.html("이벤트").appendTo(tr);
		td.html(item.subevent).appendTo(tr);
		tr.appendTo($tbody);
		
		// 초기화
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	
	if(undefined != item.sponsor1 && "" != item.sponsor1){
		th.html("문의전화").appendTo(tr);
		td.html(item.sponsor1 + " : " + item.sponsor1tel);
		if(undefined != item.sponsor2 && "" != item.sponsor2){
			td.append("<br>" + item.sponsor2 + " : " + item.sponsor2tel);
		}
		td.appendTo(tr);
		tr.appendTo($tbody);
		
		// 초기화
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
}