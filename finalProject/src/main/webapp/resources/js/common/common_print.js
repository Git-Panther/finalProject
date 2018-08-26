/**
 * 디테일한 정보를 출력할 때, 여기서 한 번 필터링을 거친 다음에 출력한다.
 */
function printCommon(item){ // 공통정보 출력	
	console.log("printCommon called");
	
	$(".spot_addr").html(item.addr1);	
	if(15 === item.contenttypeid) {
		$(".spot_addr").append("$");  
	}
	
	if(undefined != item.zipcode) $(".spot_addr").append(" (" + item.zipcode + ")");
	
	if(undefined === item.homepage) {
		console.log("homepage removed");
		$(".spot_homepage").remove();	
	} else {
		console.log("homepage added");
		$(".spot_homepage").html(item.homepage);
	}
	
	if(undefined === item.tel) {
		console.log("tel removed");
		$(".spot_tel").remove();
	} else {
		console.log("tel added");
		$(".spot_tel").html(item.tel);
	}
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
		//checkFavorite(item); // 찜 여부 체크
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
	if(undefined != item){ // 있으면 한다.
		if(undefined === item.length) item = [item]; // 반복정보 있으나 1개이면
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
}

function printImage(item){ // 이미지 정보 출력 : 이것은 공통이다
	console.log("printImage called");
	var categoryText = $(".nav_box").text();
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
	console.log("printAttractionIntro called");
	var $tbody = $("#spot_info_default").children("tbody");
	//console.log($tbody);
	
	var tr = $("<tr>"); // 한 줄
	var th = $("<th>"); // 설명의 제목
	var td = $("<td colspan='3'>"); // 자세한 설명 또는 공백 채우기용?
	
	if(undefined != item.opendate && "" != item.opendate){
		th.html("개장일").appendTo(tr);
		td.html(item.opendate).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.restdate && "" != item.restdate){
		th.html("휴일").appendTo(tr);
		td.html(item.restdate).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.useseason && "" != item.useseason){
		th.html("이용시기").appendTo(tr);
		td.html(item.useseason).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.usetime && "" != item.usetime){
		th.html("이용시간").appendTo(tr);
		td.html(item.usetime).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.accomcount && "" != item.accomcount){
		th.html("수용인원").appendTo(tr);
		td.html(item.accomcount).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.expagerange && "" != item.expagerange){
		th.html("체험가능 연령").appendTo(tr);
		td.html(item.expagerange).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.parking && "" != item.parking){
		th.html("주차시설").appendTo(tr);
		td.html(item.parking).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkcreditcard && "" != item.chkcreditcard){
		th.html("신용카드").appendTo(tr);
		td.html(item.chkcreditcard).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkpet && "" != item.chkpet){
		th.html("반려동물 입장").appendTo(tr);
		td.html(item.chkpet).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkbabycarriage && "" != item.chkbabycarriage){
		th.html("유모차 대여").appendTo(tr);
		td.html(item.chkbabycarriage).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.expguide && "" != item.expguide){
		th.html("체험안내").appendTo(tr);
		td.html(item.expguide).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.infocenter && "" != item.infocenter){
		th.html("문의").appendTo(tr);
		td.html(item.infocenter).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
}

function printCultureIntro(item){
	console.log("printCultureIntro called");
	var $tbody = $("#spot_info_default").children("tbody");
	//console.log($tbody);
	
	var tr = $("<tr>"); // 한 줄
	var th = $("<th>"); // 설명의 제목
	var td = $("<td colspan='3'>"); // 자세한 설명 또는 공백 채우기용?
	
	if(undefined != item.restdateculture && "" != item.restdateculture){
		th.html("휴일").appendTo(tr);
		td.html(item.restdateculture).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.scale && "" != item.scale){
		th.html("규모").appendTo(tr);
		td.html(item.scale).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.usetimeculture && "" != item.usetimeculture){
		th.html("이용시간").appendTo(tr);
		td.html(item.usetimeculture).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.spendtime && "" != item.spendtime){
		th.html("소요시간").appendTo(tr);
		td.html(item.spendtime).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.accomcountculture && "" != item.accomcountculture){
		th.html("수용인원").appendTo(tr);
		td.html(item.accomcountculture).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.usefee && "" != item.usefee){
		th.html("이용요금").appendTo(tr);
		td.html(item.usefee).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.discountinfo && "" != item.discountinfo){
		th.html("할인정보").appendTo(tr);
		td.html(item.discountinfo).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.parkingculture && "" != item.parkingculture){
		th.html("주차시설").appendTo(tr);
		td.html(item.parkingculture).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.parkingfee && "" != item.parkingfee){
		th.html("주차요금").appendTo(tr);
		td.html(item.parkingfee).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkcreditcardculture && "" != item.chkcreditcardculture){
		th.html("신용카드").appendTo(tr);
		td.html(item.chkcreditcardculture).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkpetculture && "" != item.chkpetculture){
		th.html("반려동물 입장").appendTo(tr);
		td.html(item.chkpetculture).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkbabycarriageculture && "" != item.chkbabycarriageculture){
		th.html("유모차 대여").appendTo(tr);
		td.html(item.chkbabycarriageculture).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.infocenterculture && "" != item.infocenterculture){
		th.html("문의").appendTo(tr);
		td.html(item.infocenterculture).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
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
	
	if(undefined != item.festivalgrade && "" != item.festivalgrade){
		th.html("축제 등급 ").appendTo(tr);
		td.html(item.festivalgrade).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}	
	if(undefined != item.placeinfo && "" != item.placeinfo){
		th.html("추천 경로").appendTo(tr);
		td.html(item.placeinfo).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.playtime && "" != item.playtime){
		th.html("기간").appendTo(tr);
		td.html(item.playtime).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.agelimit && "" != item.agelimit){
		th.html("연령 제한").appendTo(tr);
		td.html(item.agelimit).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.bookingplace && "" != item.bookingplace){
		th.html("예매처").appendTo(tr);
		td.html(item.bookingplace).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.spendtimefestival && "" != item.spendtimefestival){
		th.html("이용 시간").appendTo(tr);
		td.html(item.spendtimefestival).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.usetimefestival && "" != item.usetimefestival){
		th.html("비용").appendTo(tr);
		td.html(item.usetimefestival).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.discountinfofestival && "" != item.discountinfofestival){
		th.html("할인 정보").appendTo(tr);
		td.html(item.discountinfofestival).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.program && "" != item.program){
		th.html("프로그램").appendTo(tr);
		td.html(item.program).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.subevent && "" != item.subevent){
		th.html("이벤트").appendTo(tr);
		td.html(item.subevent).appendTo(tr);
		tr.appendTo($tbody);
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
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
}

function printHotelIntro(item){
	console.log("printHotelIntro called");
	var $tbody = $("#spot_info_default").children("tbody");
	//console.log($tbody);
	
	var tr = $("<tr>"); // 한 줄
	var th = $("<th>"); // 설명의 제목
	var td = $("<td colspan='3'>"); // 자세한 설명 또는 공백 채우기용?
	
	if(undefined != item.reservationlodging && "" != item.reservationlodging){
		th.html("예약안내").appendTo(tr);
		td.html(item.reservationlodging);
		if(undefined != item.reservationurl && "" != item.reservationurl){
			td.append(" " + item.reservationurl);
		}	
		td.appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}	
	if(undefined != item.roomcount && "" != item.roomcount){
		th.html("객실 수").appendTo(tr);
		td.html(item.roomcount).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}	
	if(undefined != item.roomtype && "" != item.roomtype){
		th.html("유형").appendTo(tr);
		td.html(item.roomtype).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}	
	if(undefined != item.scalelodging && "" != item.scalelodging){
		th.html("규모").appendTo(tr);
		td.html(item.scalelodging).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}	
	if(undefined != item.accomcountlodging && "" != item.accomcountlodging){
		th.html("수용 인원").appendTo(tr);
		td.html(item.accomcountlodging).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.checkintime && "" != item.checkintime){
		th.html("입실").appendTo(tr);
		td.html(item.checkintime).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.checkouttime && "" != item.checkouttime){
		th.html("퇴실").appendTo(tr);
		td.html(item.checkouttime).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkcooking && "" != item.chkcooking){
		th.html("객실 내 취사").appendTo(tr);
		td.html(item.chkcooking).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.pickup && "" != item.pickup){
		th.html("픽업 서비스").appendTo(tr);
		td.html(item.pickup).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.parkinglodging && "" != item.parkinglodging){
		th.html("주차시설").appendTo(tr);
		td.html(item.parkinglodging).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.infocenterlodging && "" != item.infocenterlodging){
		th.html("문의").appendTo(tr);
		td.html(item.infocenterlodging).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
}

function printShoppingIntro(item){
	console.log("printShoppingIntro called");
	var $tbody = $("#spot_info_default").children("tbody");
	//console.log($tbody);
	
	var tr = $("<tr>"); // 한 줄
	var th = $("<th>"); // 설명의 제목
	var td = $("<td colspan='3'>"); // 자세한 설명 또는 공백 채우기용?
	
	if(undefined != item.opendateshopping && "" != item.opendateshopping){
		th.html("개장일").appendTo(tr);
		td.html(item.opendateshopping).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.restdateshopping && "" != item.restdateshopping){
		th.html("휴일").appendTo(tr);
		td.html(item.restdateshopping).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.opentime && "" != item.opentime){
		th.html("영업시간").appendTo(tr);
		td.html(item.opentime).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.fairday && "" != item.fairday){
		th.html("장서는 날").appendTo(tr);
		td.html(item.fairday).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.parkingshopping && "" != item.parkingshopping){
		th.html("주차시설").appendTo(tr);
		td.html(item.parkingshopping).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.culturecenter && "" != item.culturecenter){
		th.html("문화센터").appendTo(tr);
		td.html(item.culturecenter).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.scaleshopping && "" != item.scaleshopping){
		th.html("규모").appendTo(tr);
		td.html(item.scaleshopping).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.restroom && "" != item.restroom){
		th.html("화장실").appendTo(tr);
		td.html(item.restroom).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkcreditcardshopping && "" != item.chkcreditcardshopping){
		th.html("신용카드").appendTo(tr);
		td.html(item.chkcreditcardshopping).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkpetshopping && "" != item.chkpetshopping){
		th.html("반려동물 입장").appendTo(tr);
		td.html(item.chkpetshopping).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkbabycarriageshopping && "" != item.chkbabycarriageshopping){
		th.html("유모차 대여").appendTo(tr);
		td.html(item.chkbabycarriageshopping).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.shopguide && "" != item.shopguide){
		th.html("매장안내").appendTo(tr);
		td.html(item.shopguide).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.saleitem && "" != item.saleitem){
		th.html("판매 품목").appendTo(tr);
		td.html(item.saleitem).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.saleitemcost && "" != item.saleitemcost){
		th.html("품목별 가격").appendTo(tr);
		td.html(item.saleitemcost).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.infocentershopping && "" != item.infocentershopping){
		th.html("문의").appendTo(tr);
		td.html(item.infocentershopping).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
}

function printRestaurantIntro(item){
	console.log("printRestaurantIntro called");
	var $tbody = $("#spot_info_default").children("tbody");
	//console.log($tbody);
	
	var tr = $("<tr>"); // 한 줄
	var th = $("<th>"); // 설명의 제목
	var td = $("<td colspan='3'>"); // 자세한 설명 또는 공백 채우기용?
	
	if(undefined != item.opendatefood && "" != item.opendatefood){
		th.html("개업일").appendTo(tr);
		td.html(item.opendatefood).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.opentimefood && "" != item.opentimefood){
		th.html("영업 시간").appendTo(tr);
		td.html(item.opentimefood).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.restdatefood && "" != item.restdatefood){
		th.html("휴일").appendTo(tr);
		td.html(item.restdatefood).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.treatmenu && "" != item.treatmenu){
		th.html("취급 메뉴").appendTo(tr);
		td.html(item.treatmenu).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.firstmenu && "" != item.firstmenu){
		th.html("대표 메뉴").appendTo(tr);
		td.html(item.firstmenu).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.scalefood && "" != item.scalefood){
		th.html("규모").appendTo(tr);
		td.html(item.scalefood).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.seat && "" != item.seat){
		th.html("좌석수").appendTo(tr);
		td.html(item.seat).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.packing && "" != item.packing){
		th.html("포장").appendTo(tr);
		td.html(item.packing).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.reservationfood && "" != item.reservationfood){
		th.html("예약").appendTo(tr);
		td.html(item.reservationfood).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.parkingfood && "" != item.parkingfood){
		th.html("주차").appendTo(tr);
		td.html(item.parkingfood).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.discountinfofood && "" != item.discountinfofood){
		th.html("할인").appendTo(tr);
		td.html(item.discountinfofood).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.chkcreditcardfood && "" != item.chkcreditcardfood){
		th.html("신용카드").appendTo(tr);
		td.html(item.chkcreditcardfood).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.smoking && "" != item.smoking){
		th.html("금연/흡연 여부").appendTo(tr);
		td.html(item.smoking).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.kidsfacility && "" != item.kidsfacility){
		th.html("어린이 놀이방").appendTo(tr);
		td.html(item.kidsfacility).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
	if(undefined != item.infocenterfood && "" != item.infocenterfood){
		th.html("문의").appendTo(tr);
		td.html(item.infocenterfood).appendTo(tr);
		tr.appendTo($tbody);
		tr = $("<tr>");
		th = $("<th>");
		td = $("<td colspan='3'>");
	}
}

function parseYN(message){
	console.log(message);
	return ("Y" == message) ? "가능" : "불가";
}