/**
 * 디테일한 정보를 출력할 때, 여기서 한 번 필터링을 거친 다음에 출력한다.
 */
function printCommon(item){ // 공통정보 출력
	switch(item.contenttypeid){
	case 15:
		printFestivalCommon(item);
		break;
	case 32:
		break;
	case 39:
		break;
	}
}

function printIntro(item){ // 상세정보 출력
	switch(item.contenttypeid){
	case 15:
		//checkFavorite(item); // 찜 여부 체크
		printFestivalIntro(item);
		break;
	case 32:
		break;
	case 39:
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