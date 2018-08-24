/**
 *  축제 정보를 commonDetail.do에 맞게. 다른 애들도 그에 맞는 Detail.js를 가질 것
 */

function printFestivalCommon(item){
	console.log("printFestivalCommon called");
	$(".spot_addr").html(item.addr1 + "$" + " (" + item.zipcode + ")");
	if(undefined != item.hompage) $(".spot_homepage").html(item.hompage);
	else $(".spot_homepage").remove();
	$(".spot_tel").html(item.telname + " : " + item.tel);
}

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

function printFestivalInfo(item){
	console.log("printFestivalInfo called");
	
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