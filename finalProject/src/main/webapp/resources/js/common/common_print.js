/**
 * 디테일한 정보를 출력할 때, 여기서 한 번 필터링을 거친 다음에 출력한다.
 */

function printCommon(item){ // 공통정보 출력	
	console.log("printCommon called");
	
	$(".spot_addr").append(item.addr1);	
	if(15 === item.contenttypeid) { // 축제 한정
		$(".spot_addr").append("$");  
	}
	
	if(undefined != item.zipcode) $(".spot_addr").append(" (" + item.zipcode + ")");
	
	if(undefined === item.homepage) {
		console.log("homepage removed");
		$(".spot_homepage").remove();	
	} else {
		console.log("homepage added");
		$(".spot_homepage").append(item.homepage);
	}
	
	if(undefined === item.tel) {
		console.log("tel removed");
		$(".spot_tel").remove();
	} else {
		console.log("tel added");
		$(".spot_tel").append(item.tel);
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
	if(undefined === item){ // 없으면 빈 이미지 하나만 만든다.
		imageCount = 0;
		printIndicators(0);
		$(".carousel-index").hide();
		$(".left.carousel-control").hide();
		$(".right.carousel-control").hide();
	}else{ // 있으면 출력
		if(undefined === item.length) item = [item];
		imageCount = item.length;
		printIndicators(item.length);
		$(".carousel-index").html("1 / " + item.length);
	}
	printInner(item);
}

function printNearInfo(body, type){ // 각 정보별로 표시
	var $near;
	var $marker;
	var $nearContents;
	
	switch(type){
	case 12:
		$near = $("#nearAttraction");
		$marker = $("#attractionMarkers");
		$nearContents = $(".near_attr");
		break;
	case 32:
		$near = $("#nearHotel");
		$marker = $("#hotelMarkers");
		$nearContents = $(".near_ht");
		break;
	case 39:
		$near = $("#nearRestaurant");
		$marker = $("#restaurantMarkers");
		$nearContents = $(".near_food");
		break;
	}
	
	if(body.totalCount == 0){ // 결과가 하나도 없으면
		$near.hide();
		$marker.hide();
	}else{ // 하나라도 있으면
		var item = body.items.item;
		if(undefined === item.length) item = [item]; // 배열이 아니면 배열로 만듬(결과가 1개이면)
		
		var img = $('<img class="ri_img">');
		var ri_right = $('<div class="ri_right">');
		var ri_bottom = $('<div class="ri_bottom">');
		
		var div = $("<div>");
		
		item.forEach(function(v, i){
			img = $('<img class="ri_img">');
			ri_right = $('<div class="ri_right">');
			ri_bottom = $('<div class="ri_bottom">');
			
			if(undefined != v.firstimage && "" != v.firstimage){
				img.attr("src", v.firstimage);
			}else{
				img.attr("src", "/planner/resources/images/festival/no_image.png");
			}
			$nearContents.append(img);
			
			div = $("<div>");	
			div.addClass("ri_title").html(v.title);
			ri_right.append(div);
			
			div = $("<div>");	
			div.addClass("ri_price").html(v.addr1);
			if(undefined != v.addr2 && "" != v.addr2) div.append(v.addr2);
			ri_right.append(div).appendTo($nearContents);
			
			div = $("<div>");	
			div.addClass("ri_distance").html(v.dist + "m");
			ri_bottom.append(div);
			
			div = $("<div>");	
			div.addClass("ri_rate").html("조회수 : " + v.readcount);
			ri_bottom.append(div);
			
			div = $("<div>");	
			div.addClass("clear");
			ri_bottom.append(div).appendTo($nearContents);
			
			printMark(new daum.maps.LatLng(v.mapy, v.mapx), v.title, type);
		});
	}
}