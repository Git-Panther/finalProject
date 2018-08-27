/* 
 */

function printForecast(body){
	console.log("printForecast called");
	var $forecast_info = $("#forecast_info");
	//console.log(eventstartdate, eventenddate);
	// 출력 대상 : 강수확률, 강수형태, 6시간 강수량, 습도, 하늘상태, 6시간 신적설(겨울 한정), 3시간 기온, 풍향, 풍속
	if(body.totalCount > 0){ // 결과가 하나라도 있으면
		var item = body.items.item;
		if(undefined === item.length) item = [item]; // 배열이 아니면 배열로 만듬(결과가 1개이면)
		var baseDate = item[0].baseDate; // 어차피 baseDate는 다 같다.
		var startdate, enddate; // 조회 기간 정하기
		if(15 === contenttypeid){ // 전역변수이므로 가능
			startdate = eventstartdate;
			enddate = eventenddate;
		}else{
			startdate = getDay(0);
			enddate = getDay(3);
		}
		
		var forecast = item.filter(function(v){ // 1차 필터링 : 이것들만 표시
			var dateRange = v.fcstDate >= startdate && v.fcstDate <= enddate;
			var isPOP = v.category === "POP";
			var isPTY = v.category === "PTY";
			var isR06 = v.category === "R06";
			var isREH = v.category === "REH";
			var month = new Date().getMonth();
			var isWinter = (month >= 0 && month <= 2) || (month >= 10 && month <= 11);
			var isS06 = (v.category === "S06") && (isWinter);
			var isSKY = v.category === "SKY";
			var isT3H = v.category === "T3H";
			var isVEC = v.category === "VEC";
			var isWSD = v.category === "WSD";
			var presentation = (isPOP || isPTY || isR06 || isREH || isS06 || isSKY || isT3H || isVEC || isWSD);
			return dateRange && presentation;
		});
		// baseDate + 0 ~ 3 기반으로 날짜별 분류
		var forecastList = [];
		var dayCount = 0;
		for(var i = 0; i <= 3; i++){
			dayCount = i;
			forecastList.push(forecast.filter(function(v){ // 2차 필터링 : 해당 날짜 기준으로 3일 후까지 조회
				return v.fcstDate === baseDate + dayCount;
			}));
		}
		
		console.log(forecastList);
		//console.log(forecast);
		if(forecast.length === 0)
			$("<div class='h4 text-primary spot_info_date'>").text("조회된 결과가 없습니다.").appendTo($forecast_info);
		else {
			forecastList.forEach(function(v){
				if(v.length > 0){
					printEachForecast(v);
				}
			});
		}
	}else{
		$("<div class='h4 text-primary spot_info_date'>").text("조회된 결과가 없습니다.").appendTo($forecast_info);
	}
}

function printEachForecast(list){ // 각각의 날짜에 해당하는 것을 출력
	var $forecast_info = $("#forecast_info");
	var dateInfo = $("<div class='h4 text-primary spot_info_date'>");	
	var table = $('<table class="spot_info_table">');
	var colgroup = $("<colgroup>");
	colgroup.append('<col width="135">').append('<col width="251">').append('<col width="135">').append('<col width="251">');
	table.append(colgroup);
	
	var tr = $("<tr>"); // 한 줄
	var th = $("<th>"); // 타이틀
	var td = $("<td>"); // 내용
	var fcstObj; // 반환하는 객체 저장용
	
	var timeList = ["0000", "0300", "0600", "0900", 1200, 1500, 1800, 2100];
	var forecastEachTime = [];
	timeList.forEach(function(v){
		var fcstTime = v; // 시간 묶음
		forecastEachTime.push(list.filter(function(v){
			return v.fcstTime === fcstTime;
		}));
	});
	
	//console.log(forecastEachTime);
	
	dateInfo.html(parseFcstDate(list[0].fcstDate));
	forecastEachTime.forEach(function(v, i){
		if(v.length > 0){
			tr = $("<tr>");
	    	th = $("<th colspan='4'>");
	    	td = $("<td>");
	    	
	    	th.html(parseFcstTime(v[0].fcstTime)).appendTo(tr);
	    	tr.appendTo(table);
	    	
	    	v.forEach(function(v){
	    		tr = $("<tr>");
	    		th = $("<th>");
	    		td = $("<td>");
	    		fcstObj = parseForecast(v.category, v.fcstValue);
	    		th.html(fcstObj.category).appendTo(tr);
	    		td.html(fcstObj.value).appendTo(tr);
	    		tr.appendTo(table);
	    	});
		}
	});
	$forecast_info.append(dateInfo).append(table);
}

function parseFcstDate(fcstDate){
	var dateString = "" + fcstDate;
	var result = dateString.substr(0, 4) + "/" + dateString.substr(4, 2) + "/" + dateString.substr(6, 2);
	return result;
}

function parseFcstTime(fcstTime){
	var timeString = "" + fcstTime;
	var result = "";
	var startIndex = 0;
	if(timeString.charAt(0) === "0") startIndex = 1;
	else startIndex = 0;
	
	result = timeString.substr(startIndex, 2 - startIndex) + ":" + timeString.substr(2, 2);
	return result;
}

function parseForecast(category, value){
	var result = { category : "", value : "" };
	
	switch(category){
	case "POP":
		result.category = "강수확률"; // ! 비 올 확률(%)
		result.value = value + "%";
		break;
	case "PTY":
		result.category = "강수형태"; // ! 단위 따르기
		result.value = paresPTY(value);
		break; 
	case "R06":
		result.category = "6시간 강수량"; // ! 단위 따르기
		result.value = parseR06(value);
		break;
	case "REH":
		result.category = "습도"; // ! %
		result.value = value + "%";
		break;
	case "S06":
		result.category = "6시간 신적설"; // ! 겨울
		result.value = parseS06(value);
		break;
	case "SKY":
		result.category = "하늘상태"; // !
		result.value = parseSKY(value);
		break;
	case "T3H":
		result.category = "3시간 기온"; // ! 도
		result.value = value + "°C";
		break;
	case "TMN":
		result.category = "아침 최저기온"; // ! 도
		result.value = value + "°C";
		break;
	case "TMX":
		result.category = "낮 최고기온"; // ! 도
		result.value = value + "°C";
		break;
	case "UUU":
		result.category = "풍속(동서성분)"; // m/s
		result.value = parseUUU(value);
		break;
	case "VVV":
		result.category = "풍속(남북성분)"; // m/s -> 강도
		result.value = parseVVV(value);
		break;
	case "WAV":
		result.category = "파고"; // 파도 높이라 함(안씀)
		result.value = value + "m";
		break;
	case "VEC":
		result.category = "풍향"; // ??
		result.value = parseVEC(value);
		break;
	case "WSD":
		result.category = "풍속"; // ???
		result.value = parseWSD(value);
		break;
	}
	
	return result;
}

function parseSKY(sky){ // 하늘상태
	var result = "";
	switch(sky){
	case 1:
		result = "맑음";
		break;
	case 2:
		result = "구름조금";
		break;
	case 3:
		result = "구름많음";
		break;
	case 4:
		result = "흐림";
		break;
	default:
		result = undefined;
	}

	return result;
}

function paresPTY(pty){ // 강수형태
	var result = "";	
	switch(pty){
	case 0:
		result = "없음";
		break;
	case 1:	
		result = "비";
		break;
	case 2:
		result = "비/눈";
		break;
	case 3:
		result = "눈";
		break;
	default:
		result = undefined;
	}	
	
	return result;
}

function parseR06(r06){ // 6시간 강수량
	var result = "";	
	
	switch(r06){
	case 0:
		result = "0.1mm 미만";
		break;
	case 1:
		result = "0.1mm 이상 1mm 미만";
		break;
	case 5:
		result = "1mm 이상 5mm 미만";
		break;
	case 10:
		result = "5mm 이상 10mm 미만";
		break;
	case 20:
		result = "10mm 이상 20mm 미만";
		break;
	case 40:
		result = "20mm 이상 40mm 미만";
		break;
	case 70:
		result = "40mm 이상 70mm 미만";
		break;
	case 100:
		result = "70mm 이상";
		break; 
	default:
		result = r06 + "mm";
	}

	return result;
}

function parseS06(s06){ // 6시간 적설량 : 겨울에만 사용?
	var result = "";	
	
	switch(s06){
	case 0:
		result = "0.1mm 미만";
		break;
	case 1:
		result = "0.1mm 이상 1mm 미만";
		break;
	case 5:
		result = "1mm 이상 5mm 미만";
		break;
	case 10:
		result = "5mm 이상 10mm 미만";
		break;
	case 20:
		result = "10mm 이상 20mm 미만";
		break;
	case 100:
		result = "20mm 이상";
		break; 
	default:
		result = undefined;
	}

	return result;
}

function parseUUU(uuu){ // 동서바람성분 : 바람은 양에 따라 강약을 따짐
	var result = "";
	if(uuu >= 0) result = "동쪽 방향으로 " + uuu;
	else result = "서쪽 방향으로 " + (-uuu);
	
	result += "m/s";
	
	return result;
}

function parseVVV(vvv){ // 남북바람성분
	var result = "";	
	
	if(vvv >= 0) result = "븍쪽 방향으로 " + vvv;
	else result = "남쪽 방향으로 " + (-vvv);
	
	result += "m/s";

	return result;
}

function parseVEC(vec){ // 풍향
	var result = "";
	if((vec >= 0 && vec < 45) || vec == 360) result = "N-NE";
	else if(vec >= 45 && vec < 90) result = "NE-E";
	else if(vec >= 90 && vec < 135) result = "E-SE";
	else if(vec >= 135 && vec < 180) result = "SE-S";
	else if(vec >= 180 && vec < 225) result = "S-SW";
	else if(vec >= 225 && vec < 270) result = "SW-W";
	else if(vec >= 270 && vec < 315) result = "W-NW";
	else if(vec >= 315 && vec < 360) result = "NW-N";
	else result = undefined;		
	return result;
}

function parseWSD(wsd){ // 풍속
	var result = "";
	if(wsd < 4) result = "약함";
	else if(4 <= wsd && 9 > wsd) result = "약간 강함";
	else if(9 <= wsd && 14 > wsd) result = "강함";
	else result = "매우 강함";
	return result;
}