<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="searchArea.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Festival Detail</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=339906b6f4278bdec7e4ff5ae52df3cc&libraries=services,clusterer,drawing"></script>
<script>
	function festivalDetailCommon(){
		$.ajax({        
	        url: 'festivalDetailCommon.do',
	        type: 'post',
	        data: { contentid : ${contentid} },
	        dataType: 'json',
	        success: function(data){
	        	//console.log(data);
	        	checkUserFavorite(data.response.body.items.item); // 찜 여부 체크
	        	printFestivalCommon(data.response.body.items.item);
	        	festivalDetailIntro(); // 상세 정보 표시
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}
	
	function festivalDetailIntro(){
		$.ajax({        
	        url: 'festivalDetailIntro.do',
	        type: 'post',
	        data: { contentid : ${contentid} },
	        dataType: 'json',
	        success: function(data){
	        	//console.log(data);
	        	printFestivalDetail(data.response.body.items.item);
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}
	
	function festivalDetailInfo(){
		$.ajax({        
	        url: 'festivalDetailInfo.do',
	        type: 'post',
	        data: { contentid : ${contentid} },
	        dataType: 'json',
	        success: function(data){
	        	//console.log(data);
	        	printFestivalInfo(data.response.body.items.item);
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}
	
	function locationBasedList(mapx, mapy, contenttypeid){
		$.ajax({        
	        url: 'locationBasedList.do',
	        type: 'post',
	        data: { mapx : mapx, mapy : mapy, contenttypeid : contenttypeid},
	        dataType: 'json',
	        success: function(data){
	        	//console.log(data);
	        	printNearInfo(data.response.body.items.item, contenttypeid); // 공통 정보만 뽑았다.
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}
	
	function forecast(addr){
		$.ajax({        
	        url: 'forecast.do',
	        type: 'post',
	        data: { addr : addr }, // 날짜는 controller에서 처리. 좌표는 엑셀 파일 읽어서 처리해야한다. 주소 파싱할 것
	        dataType: 'json',
	        success: function(data){
	        	console.log(data);
	        	//printNearInfo(data.response.body.items.item, contenttypeid); // 공통 정보만 뽑았다.
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}
	
	function printFestivalCommon(common){
		console.log(common);
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
		
		// $("#festivalIntro").html(common.overview); // 상세한 설명
		
		var x = common.mapx;
		var y = common.mapy;
		
		locationBasedList(x, y, 32); // 숙박
		locationBasedList(x, y, 39); // 음식점
		forecast(common.addr1);
		
		// 지도 표시를 해준다 ㅇㅇ.
		printMark(new daum.maps.LatLng(y, x));
	}
	
	function printFestivalDetail(detail){
		console.log(detail);		
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
	
	function printNearInfo(list, contenttypeid){
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
	        var tableList = $("<table class='festivalList' border='1'>");
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
	        	subTable = $("<table>").attr("onclick", "");
	        	tr = $("<tr>");
	        	//th = $("<th>");
	        	td = $("<td colspan='2'>");
	    
	        	img = $("<img>").addClass("img");
	        	if(undefined == list[i].firstimage) img.attr("src", "/planner/resources/images/festival/no_image.png");
	        	else img.attr("src", list[i].firstimage);
	        	td.append(img).appendTo(td);
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
	        	if( i % cols == cols - 1 || i == list.length - 1){
	        		maintr.appendTo(tableList);
	        		maintr = $("<tr>");
	        	}    
	        } 
		}           
		$nearInfo.append(tableList);
	}
	
	function printForecast(forecast){
		
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
			$("#map").show();
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
	
	function checkUserFavorite(item){ // 로그인 상태인데 찜을 해놓고 있냐 아니냐
		//console.log("${sessionScope.user}");
		if("${sessionScope.user}" != ""){
			// ajax로 item의 contenttype과 contenttypeid, 그리고 user.userNo 대조하여 되어있는지 검사
		}else{
			// 좋아요 버튼 이벤트 추가 : 로그인 후에 찜할 수 있습니다.
			$("#favorite p").append("☆");
			$("#favorite").click(function(){
				alert("로그인 후에 찜할 수 있습니다.");
			});
		}
	}
	
	function insertFavorite(){ // 찜 등록
		// ajax로 수신
	}
	
	function deleteFavorite(){ // 찜 삭제
		// ajax로 수신
	}
</script>
</head>
<body>
<div class="outer">
	<div>
		<table id="festivalTap">
			<tr>
				<td>개요</td>
				<td>안내</td>
				<td>지도</td>
				<td>숙박</td>
				<td>식당</td>
				<td>일기예보</td>
				<td>교통상황</td>
			</tr>
		</table>
	</div>
	<div id="festivalDetail">
		<div id="festivalTitle"><p></p></div>
		<div>
			<table id="festivalInfo">
				<tr>
					<td>
						<div><img id="festivalPicture" /></div>
					</td>
					<td>
						<div id="festivalCommonInfo" class="tapGroup1"></div>
						<div id="map" class="tapGroup1"></div>
						<div id="festivalForecast" class="tapGroup1"></div>
						<div id="festivalTraffic" class="tapGroup1"></div>
					</td>
				</tr>
			</table>
			<div id="favorite" class="link"><p>찜하기 </p></div>
		</div>
		<!-- <div id="festivalIntro"></div> -->
		<!-- <br> -->
		<script type="text/javascript">		
			// 고정 지도로 바꿀 듯?
			var container = document.getElementById('map');
			var options = {
				center: new daum.maps.LatLng(33.450701, 126.570667),
				level: 3,
				// marker: markers // 이미지 지도에 표시할 마커 
			};
			
			var map = new daum.maps.Map(container, options);
	
			var marker = new daum.maps.Marker({
		        position: new daum.maps.LatLng(0, 0)
		    }); // 마커 
		    
			marker.setMap(map);
		   
		    var infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
		 	// 주소-좌표 변환 객체를 생성합니다
		    var geocoder = new daum.maps.services.Geocoder();
		    
		    function printMark(position){
				map.setCenter(position);
				marker.setPosition(position);
				/*
				searchDetailAddrFromCoords(position, function(result, status) {
			        if (status === daum.maps.services.Status.OK) {
			            var detailAddr = result[0].road_address != undefined ? '<p>도로명주소 <br>' + result[0].road_address.address_name + '</p>' : '';
			            detailAddr += '<p>지번 주소<br>' + result[0].address.address_name + '</p>';
			            
			            var content = '<div id="bAddr">' +
			                            //'<span id="addrTitle">법정동 주소정보</span>' + 
			                            detailAddr + 
			                        '</div>';
			
			            // 마커를 클릭한 위치에 표시합니다 
			            marker.setPosition(position);
			            // marker.setMap(map);
			
			            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			            infowindow.setContent(content);
			            infowindow.open(map, marker);
			        }   
			    });
				*/
			}
			
			function searchDetailAddrFromCoords(coords, callback) {
		        // 좌표로 법정동 상세 주소 정보를 요청합니다
		        geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		    }
		    
		    $(function(){
		    	festivalTapEvent(); // 탭 이벤트 추가	
		    	festivalDetailCommon(); // 기본정보 표시	
		    	festivalDetailInfo(); // 반복 정보 표시
		    	$("#festivalTap td").eq(1).click(); // 기본 정보부터 표시
		    	$("#festivalTap td").eq(0).click(); // 기본 정보부터 표시
			});
		</script>
		<div id="festivalDetailInfo" class="tapGroup2"></div>
		<div id="festivalHotels" class="tapGroup2"></div>
		<div id="festivalRestaurants" class="tapGroup2"></div>
		<br>
		<div id="festivalComment">코멘트 부분</div>
	</div>	
</div>
</body>
<c:import url="/footer.do"/>
</html>