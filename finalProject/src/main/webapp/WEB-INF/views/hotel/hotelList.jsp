<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<c:import url="/header.do" />
<!DOCTYPE html>
<html>
<head>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDA_nL375kZbKh_UyHyB8EFsXdhJll3w0E&callback=initMap"
								  type="text/javascript"></script>
<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
<link href="resources/css/hotelList.css" rel="stylesheet">

<style>
       /* Set the size of the div element that contains the map */
      #map {
        height: 400px;  /* The height is 400 pixels */
        width: 100%;  /* The width is the width of the web page */
       }
</style>

<script>
var areaCode = 1;
var sigunguCode = 1;
var arrange = "B";
var pageNo = 1;
var total = 0;
var curPage = 1;
var arrPos = new Array();
var centerMap = null;

function moveHotelList(pageNo) {
	curPage = pageNo;
	pageNo = pageNo;
	getHotelList(areaCode, sigunguCode, arrange, pageNo);
}

$(function() {
	getHotelList(areaCode, sigunguCode, arrange, pageNo);
});

$(function() {
	$("#selectSort").change(function() {
		console.log($("#selectSort").val());
		if($("#selectSort").val() == "count") {
			arrange = "B";
			getHotelList(areaCode, sigunguCode, arrange, pageNo);
		} else if($("#selectSort").val() == "name") {
			arrange = "A";
			getHotelList(areaCode, sigunguCode, arrange, pageNo);
		}
	});
});

function getHotelList(areaCode, sigunguCode, arrange, pageNo) {
	$(function() {
		  $.ajax({
			url : 'hotelList.do',
			type : 'get',
			data : {
				areaCode : areaCode,
				sigunguCode : sigunguCode,
				arrange : arrange,
				pageNo : pageNo
			}, //contentid, contentTypeid 서버로 전송
			dataType : 'json',
			success : function(data) {
				console.log(data.response.body.totalCount);
				console.log(data.response.body.items.item);
				var item = data.response.body.items.item; //이 경로 내부에 데이터가 들어있음
				total = data.response.body.totalCount;
				var output = '';
				
				$(".list_cnt").html("총 " + total + "개의 호텔");

				for (var i = 0; i < item.length; i++) {
					arrPos[i] = {lat : item[i].mapx,
							lng : item[i].mapy};
					console.log("arrPos : " + arrPos);
					console.log("mapx : " + item[i].mapx);
					console.log("arrPos[i].lat : " + arrPos[i].lat);
					if(item[i].firstimage2 == undefined) {
						item[i].firstimage2 = "/planner/resources/images/common/no_img/hotel55.png";
					}
					output += '<div class="box" id="' + item[i].contentid + '">';
					output += '<img ';
					output += 'src="' + item[i].firstimage2 + '"';
					output += 'alt="" class="ht_img"';
					output += 'onclick="go_link(' + item[i].contentid + ",'localhost:8081/planner/hotelDetail.do?contentid=" + item[i].contentid + ');"' + '"';
					output += 'onerror="this.src=' + "'/planner/resources/images/common/no_img/hotel.png';" + '"';
					output += 'data-srl="' + item[i].contentid + '">';
					output += '<div class="box_right">';
					output += '<div class="btn_clip" data-yn="n" data-srl="' + item[i].contentid + '"'; 
					output += 'onclick="set_clip(' + item[i].contentid + ",'0','btn_clip','2');" + '">';
					output += '<img src="/planner/resources/images/city/spot_list/clip_ico.png" alt="">';
					output += '</div>';
					output += '<div class="btn_addplan"'; 
					output += 'onclick="et_modal(' + "'365px','380px','1','0','/ko/member','2','1')" + '">';
					output += '<img src="/planner/resources/images/city/spot_list/addplan_ico.png" alt="">';
					output += '</div>';
					output += '<a ';
					output += 'href="javascript:go_link(' + item[i].contentid + ",'localhost:8081/planner/hotelDetail.do?contentId=" + item[i].contentId + "');" + '"';
					output += 'class="ht_title">' + item[i].title + '</a>';
					output += '<div class="ht_info">';
					output += '<img src="/planner/resources/images/common/web/hotel_star_' + 4.5 + '.png" alt=""';
					output += 'class="ht_rate_img">';
					output += '<div class="ht_line"></div>';
					output += '<div class="ht_rate">';
					output += '<span>' + "[평점]" + '</span>' + "[평점]";
					output += '</div>';
					output += '<a class="ht_review"';
					output += 'href="javascript:go_link(' + item[i].contentId + ",'" + "[리뷰보기]" + "');" + '">이용후기';
					output += '보기</a>';
					output += '<div class="clear"></div>';
					output += '</div>';
					output += '<div class="ht_addr">';
					output += item[i].addr1 + " " +  item[i].addr2 + '<a class="map_link"';
					output += 'href="javascript:et_modal(' + "'1144px','816px','1','0','/ko/modal/spot_map?srl=" + item[i].contentId + "&amp;type=2','2','1');" + '">지도보기</a>';
					output += '</div>';
					output += '<div class="ht_count	">';
					output += '조회수 : ' + item[i].readcount + '건';
					output += '</div>';	
					output += '<div class="ht_bottom">';
					output += '<a class="ht_view"';
					output += 'href="javascript:go_link(' + item[i].contentid + ",localhost:8081/planner/hotelDetail.do?contentid=" + item[i].contentid + 
							');">자세히보기</a>';
							output += '</div>';
							output += '</div>';
							output += '<div class="clear"></div>';
							output += '</div>';
				}

				$(".list").html(output);
				makePaging(total, curPage);
				
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("Status: " + textStatus);
				alert("Error: " + errorThrown);
			}
		});  
		  
	}); 
	
	
}

// 페이징 생성
function makePaging(total, curPage){
	console.log(total+'/'+curPage)
	$('html, body').scrollTop(0);
	
	// 페이지당 리스트출력수
	var viewPage = 10;
	var movePage = viewPage-1;
	var perPage = 2;
	// 전체 페이지
	var totalPage =  Math.ceil(total/perPage);
	var startPage = (Math.floor((curPage-1)/viewPage))*viewPage+1;
	var endpage = (startPage+movePage < totalPage)? startPage+movePage: totalPage;


	// 페이징 생성
	var paging ='<span class="nv">';
	if(curPage > 1){
		paging += '<button type="button" class="pgn-pv1" onclick="moveHotelList'+'(1)">처음으로</button>';
	}
	if(startPage > viewPage && curPage > 1){
		paging += '<button type="button" class="pgn-pv2" onclick="moveHotelList'+'('(startPage-viewPage)+')">이전</button>';
	}

	paging += '</span>';
	for(var i=startPage ; i<= endpage; i++){
		if(curPage == i){
		  paging += '<button type="button" class="on" onclick="moveHotelList'+'(' + i+')">'+i+'</button>';
		}else{
		  paging += '<button type="button" onclick="moveHotelList(' + i +')">'+ i +'</button>';
		}
	}

	paging += '<span class="nv">';
	if((startPage+movePage) < totalPage && curPage < totalPage){
		paging += '<button type="button" class="pgn-nx2" onclick="moveHotelList'+'(' + (startPage+viewPage)+')">다음</button>';
	}

	if(curPage < totalPage){
		paging += '<button type="button" class="pgn-nx1" onclick="moveHotelList'+'(' + totalPage+')">맨뒤로</button>';
	}

	paging += '</span>';
		$('#paging').html(paging);
}

	
	
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="clear"></div>
	<div class="area_bg top silver">

		<div class="wrap">

			<div class="area_nav">
				<a href="/ko/area" class="nav_btn">여행지</a> &gt; <a
					href="/ko/area/republic-of-korea" class="nav_btn cu">대한민국</a> &gt;
				<a href="/ko/city/seoul_310" class="nav_btn"> 서울 </a> &gt; 호텔
			</div>


			<div class="area_title">
				<b>서울</b> <span>Seoul</span>
			</div>


			<div class="common_menu">
				<a href="/ko/city/seoul_310"> 홈 </a> <a
					href="/ko/city/seoul_310/hotel#1" class="on"> 호텔 </a> <a
					href="/ko/city/seoul_310/attraction#1"> 관광명소 </a> <a
					href="/ko/city/seoul_310/restaurant#1"> 음식점 </a> <a
					href="/ko/city/seoul_310/shopping#1"> 쇼핑 </a> <a
					href="/ko/plan?ci=310" target="_blank"> 여행일정 </a> <a
					href="/ko/city/seoul_310/map"> 지도보기 </a>
				<div class="clear"></div>
			</div>


			<!-- <script type="text/javascript"
				src="/res/js/mobile/noui_slider/jquery.nouislider.all.min.js"></script>
			<link rel="stylesheet"
				href="/res/js/mobile/noui_slider/jquery.nouislider.css">
			<link rel="stylesheet" href="/res/css/web/date_picker.css">
			<script type="text/javascript" src="/res/js/web/jui/jquery-ui.js"></script>
			<script type="text/javascript"
				src="/jslang?lang=ko&amp;lang_file=city"></script>

			<script type="text/javascript"
				src="http://earthtory.com/res/js/jquery.tipsy.js"></script>

			<script type="text/javascript" src="/res/js/web/common_w.js"></script>
			<link rel="stylesheet" href="/res/css/city/spot_list.css">
			<link rel="stylesheet" href="/res/css/city/hotel_list.css">
			<script
				src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;key=AIzaSyCl637FhRA2W2lb2sQ776t96OML_-LOVdw"></script>
			<script type="text/javascript"
				src="/res/js/web/dhistory/dhtmlHistory.js"></script>
			<form id="historyStorageForm" method="GET"
				style="position: absolute; top: -1000px; left: -1000px;">
				<textarea id="historyStorageField"
					style="position: absolute; top: -1000px; left: -1000px;" left:=""
					-1000px;'="" name="historyStorageField"></textarea>
			</form>

			<link rel="stylesheet" href="/res/css/web/date_picker.css">
			<script type="text/javascript" src="/res/js/web/jui/jquery-ui.js"></script>-->
			<style type="text/css"> 
#SearchBox {
	position: fixed;
	left: 0px;
	top: 0px;
	z-index: -1;
	display: none;
	width: 1px;
	height: 1px;
}
</style>
			<div id="SearchBox">
				<!-- <iframe src="/ko/modal/hotel_hidden" frameborder="0"
					class="ht_search_box_frame"></iframe> -->
			</div>



			<div class="wrap">
				<div class="filter_box">
					<div class="filter_top">
						<div class="cicu_names">대한민국, 서울</div>

						<div class="search_area">
							<input type="text" placeholder="지역을 검색하세요." class="hotel_search">


							<div class="ht_search">검색</div>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
					</div>

				</div>
			</div>
		</div>
		<div class="list_bg">
			<div class="wrap">
				<div class="list_left">

					<div class="list_top" style="display: block;">
						<div class="list_cnt">
							총 0개의 호텔 <a href="javascript:reset_filter();"
								style="display: none;">필터 초기화</a>
						</div>
						<div class="list_sort">
							<select name="" id="selectSort" class="sort" data-height="25">
								<option value="count">인기순</option>
								<option value="name">이름순</option>
							</select>
						</div>
					</div>
					<div class="list"></div>
					<div id="paging"></div>
				</div>
				<div class="list_right">
					<div class="scroll_area" style="">
						<div class="right_box">
							<div class="right_title">지도에서 호텔보기</div>
							<div id="map"></div>
							
							<script>
							// Initialize and add the map
							function initMap() {
					// 시, 도의 가운데
					   var uluru = {
							lat : -25.344,
							lng : 131.036
							};   

					// The map, centered at Uluru
					var map = new google.maps.Map(document
							.getElementById('map'), {
						zoom : 4,
						center : uluru
					});
					console.log(arrPos.length);
					// The marker, positioned at Uluru
					for(var idx = 0; idx < arrPos.length; idx++) {
					var marker = new google.maps.Marker({
						position : arrPos[idx],
						map : map
					});
					}
				}
							</script>
								<!-- <div class="map_box">
						<div class="map-canvas" id="map-canvas" style="position: relative; overflow: hidden;"><div style="height: 100%; width: 100%; position: absolute; top: 0px; left: 0px; background-color: rgb(229, 227, 223);"><div class="gm-style" style="position: absolute; z-index: 0; left: 0px; top: 0px; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px;"><div tabindex="0" style="position: absolute; z-index: 0; left: 0px; top: 0px; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; cursor: url(&quot;https://maps.gstatic.com/mapfiles/openhand_8_8.cur&quot;), default; touch-action: pan-x pan-y;"><div style="z-index: 1; position: absolute; left: 50%; top: 50%; transform: translate(0px, 0px);"><div style="position: absolute; left: 0px; top: 0px; z-index: 100; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div style="position: absolute; z-index: 1; transform: matrix(1, 0, 0, 1, -81, -48);"><div style="position: absolute; left: 0px; top: 0px; width: 256px; height: 256px;"><div style="width: 256px; height: 256px;"></div></div><div style="position: absolute; left: -256px; top: 0px; width: 256px; height: 256px;"><div style="width: 256px; height: 256px;"></div></div><div style="position: absolute; left: -256px; top: -256px; width: 256px; height: 256px;"><div style="width: 256px; height: 256px;"></div></div><div style="position: absolute; left: 0px; top: -256px; width: 256px; height: 256px;"><div style="width: 256px; height: 256px;"></div></div></div></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 101; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 102; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 103; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: -1;"><div style="position: absolute; z-index: 1; transform: matrix(1, 0, 0, 1, -81, -48);"><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 0px; top: 0px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: -256px; top: 0px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: -256px; top: -256px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 0px; top: -256px;"></div></div></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -124px; top: 30px; z-index: 0;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -84px; top: -50px; z-index: 1;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -80px; top: -41px; z-index: 2;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: 35px; top: -91px; z-index: 3;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -68px; top: -33px; z-index: 4;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -89px; top: -30px; z-index: 5;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: 102px; top: 38px; z-index: 6;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -71px; top: -54px; z-index: 7;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: 12px; top: -33px; z-index: 8;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -90px; top: -16px; z-index: 9;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: 68px; top: 30px; z-index: 10;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -73px; top: -28px; z-index: 11;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -84px; top: -33px; z-index: 12;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: 11px; top: -63px; z-index: 13;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -78px; top: -40px; z-index: 14;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: 59px; top: 42px; z-index: 15;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -92px; top: -25px; z-index: 16;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: -94px; top: -13px; z-index: 17;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: 18px; top: -61px; z-index: 18;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div><div style="width: 21px; height: 24px; overflow: hidden; position: absolute; left: 23px; top: 14px; z-index: 19;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1; width: 21px; height: 24px;"></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div style="position: absolute; z-index: 1; transform: matrix(1, 0, 0, 1, -81, -48);"><div style="position: absolute; left: 0px; top: 0px; width: 256px; height: 256px;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i11!2i1746!3i793!4i256!2m3!1e0!2sm!3i430134852!3m9!2sko-KR!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!4e0!23i1301875&amp;key=AIzaSyCl637FhRA2W2lb2sQ776t96OML_-LOVdw&amp;token=78716" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: -256px; top: -256px; width: 256px; height: 256px;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i11!2i1745!3i792!4i256!2m3!1e0!2sm!3i430134852!3m9!2sko-KR!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!4e0!23i1301875&amp;key=AIzaSyCl637FhRA2W2lb2sQ776t96OML_-LOVdw&amp;token=104627" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: 0px; top: -256px; width: 256px; height: 256px;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i11!2i1746!3i792!4i256!2m3!1e0!2sm!3i430134852!3m9!2sko-KR!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!4e0!23i1301875&amp;key=AIzaSyCl637FhRA2W2lb2sQ776t96OML_-LOVdw&amp;token=56492" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: -256px; top: 0px; width: 256px; height: 256px;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i11!2i1745!3i793!4i256!2m3!1e0!2sm!3i430134852!3m9!2sko-KR!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!4e0!23i1301875&amp;key=AIzaSyCl637FhRA2W2lb2sQ776t96OML_-LOVdw&amp;token=126851" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div></div></div></div><div class="gm-style-pbc" style="z-index: 2; position: absolute; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; left: 0px; top: 0px; opacity: 0; transition-duration: 0.8s;"><p class="gm-style-pbt">지도를 확대/축소하려면 Ctrl을 누른 채 스크롤하세요.</p></div><div style="z-index: 3; position: absolute; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; left: 0px; top: 0px; touch-action: pan-x pan-y;"><div style="z-index: 4; position: absolute; left: 50%; top: 50%; transform: translate(0px, 0px);"><div style="position: absolute; left: 0px; top: 0px; z-index: 104; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 105; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 106; width: 100%;"><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -124px; top: 30px; z-index: 0;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap0" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap0" id="gmimap0"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="투어인 하루미 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -84px; top: -50px; z-index: 1;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap1" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap1" id="gmimap1"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="예포 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -80px; top: -41px; z-index: 2;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap2" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap2" id="gmimap2"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="올라 서울 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: 35px; top: -91px; z-index: 3;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap3" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap3" id="gmimap3"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="화이트 래빗 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -68px; top: -33px; z-index: 4;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap4" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap4" id="gmimap4"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="주하우스 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -89px; top: -30px; z-index: 5;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap5" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap5" id="gmimap5"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="홍대 올리브 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: 102px; top: 38px; z-index: 6;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap6" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap6" id="gmimap6"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="케이 걸 게스트하우스 여성전용" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -71px; top: -54px; z-index: 7;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap7" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap7" id="gmimap7"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="연희 하우스 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: 12px; top: -33px; z-index: 8;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap8" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap8" id="gmimap8"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="준 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -90px; top: -16px; z-index: 9;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap9" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap9" id="gmimap9"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="하우스 버닝하트" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: 68px; top: 30px; z-index: 10;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap10" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap10" id="gmimap10"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="제나 스위트 강남 가로수길" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -73px; top: -28px; z-index: 11;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap11" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap11" id="gmimap11"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="어반우드 게스트하우스 홍대" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -84px; top: -33px; z-index: 12;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap12" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap12" id="gmimap12"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="서울 스위트 스타일 홍대" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: 11px; top: -63px; z-index: 13;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap13" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap13" id="gmimap13"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="예하도예 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -78px; top: -40px; z-index: 14;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap14" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap14" id="gmimap14"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="트릭 아트 게스트하우스 홍대" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: 59px; top: 42px; z-index: 15;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap15" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap15" id="gmimap15"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="신사 레지던스 앤 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -92px; top: -25px; z-index: 16;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap16" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap16" id="gmimap16"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="홍대 레이지 폭스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: -94px; top: -13px; z-index: 17;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap17" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap17" id="gmimap17"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="홍대쉐프 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: 18px; top: -61px; z-index: 18;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap18" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap18" id="gmimap18"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="비빔밥 한옥 게스트하우스 인사동" style="cursor: pointer; touch-action: none;"></map></div><div class="gmnoprint" style="width: 21px; height: 24px; overflow: hidden; position: absolute; opacity: 0.01; left: 23px; top: 14px; z-index: 19;"><img alt="" src="/res/img/city/marker_m.png" draggable="false" usemap="#gmimap19" style="position: absolute; left: 0px; top: 0px; width: 21px; height: 24px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; opacity: 1;"><map name="gmimap19" id="gmimap19"><area log="miw" coords="1,1,1,20,18,20,18,1" shape="poly" title="트래블 홀릭 게스트하우스" style="cursor: pointer; touch-action: none;"></map></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 107; width: 100%;"></div></div></div></div><iframe frameborder="0" style="z-index: -1; position: absolute; width: 100%; height: 100%; top: 0px; left: 0px; border: none;" src="about:blank"></iframe><div style="margin-left: 5px; margin-right: 5px; z-index: 1000000; position: absolute; left: 0px; bottom: 0px;"><a target="_blank" rel="noopener" href="https://maps.google.com/maps?ll=37.553516,126.969567&amp;z=11&amp;t=m&amp;hl=ko-KR&amp;gl=US&amp;mapclient=apiv3" title="Google 지도에서 이 지역을 보려면 클릭하세요." style="position: static; overflow: visible; float: none; display: inline;"><div style="width: 66px; height: 26px; cursor: pointer;"><img alt="" src="https://maps.gstatic.com/mapfiles/api-3/images/google4.png" draggable="false" style="position: absolute; left: 0px; top: 0px; width: 66px; height: 26px; user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></a></div><div style="background-color: white; padding: 15px 21px; border: 1px solid rgb(171, 171, 171); font-family: Roboto, Arial, sans-serif; color: rgb(34, 34, 34); box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 16px; z-index: 10000002; display: none; width: 192px; height: 146px; position: absolute; left: 5px; top: 5px;"><div style="padding: 0px 0px 10px; font-size: 16px;">지도 데이터</div><div style="font-size: 13px;">지도 데이터 ©2018 SK telecom</div><div style="width: 13px; height: 13px; overflow: hidden; position: absolute; opacity: 0.7; right: 12px; top: 12px; z-index: 10000; cursor: pointer;"><img alt="" src="https://maps.gstatic.com/mapfiles/api-3/images/mapcnt6.png" draggable="false" style="position: absolute; left: -2px; top: -336px; width: 59px; height: 492px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div></div><div class="gmnoprint" style="z-index: 1000001; position: absolute; right: 52px; bottom: 0px; width: 150px;"><div draggable="false" class="gm-style-cc" style="user-select: none; height: 14px; line-height: 14px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a style="text-decoration: none; cursor: pointer; display: none;">지도 데이터</a><span>지도 데이터 ©2018 SK telecom</span></div></div></div><div class="gmnoscreen" style="position: absolute; right: 0px; bottom: 0px;"><div style="font-family: Roboto, Arial, sans-serif; font-size: 11px; color: rgb(68, 68, 68); direction: ltr; text-align: right; background-color: rgb(245, 245, 245);">지도 데이터 ©2018 SK telecom</div></div><div class="gmnoprint gm-style-cc" draggable="false" style="z-index: 1000001; user-select: none; height: 14px; line-height: 14px; position: absolute; right: 0px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a href="https://www.google.com/intl/ko-KR_US/help/terms_maps.html" target="_blank" rel="noopener" style="text-decoration: none; cursor: pointer; color: rgb(68, 68, 68);">이용약관</a></div></div><button draggable="false" title="전체 화면보기로 전환" aria-label="전체 화면보기로 전환" type="button" style="background: none rgb(255, 255, 255); border: 0px; margin: 10px 14px; padding: 0px; position: absolute; cursor: pointer; user-select: none; width: 25px; height: 25px; overflow: hidden; top: 0px; right: 0px;"><img alt="" src="https://maps.gstatic.com/mapfiles/api-3/images/sv9.png" draggable="false" class="gm-fullscreen-control" style="position: absolute; left: -52px; top: -86px; width: 164px; height: 175px; user-select: none; border: 0px; padding: 0px; margin: 0px;"></button><div draggable="false" class="gm-style-cc" style="user-select: none; height: 14px; line-height: 14px; display: none; position: absolute; right: 0px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a target="_blank" rel="noopener" title="Google에 도로 지도 또는 이미지 오류 신고" href="https://www.google.com/maps/@37.5535158,126.969567,11z/data=!10m1!1e1!12b1?source=apiv3&amp;rapsrc=apiv3" style="font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); text-decoration: none; position: relative;">지도 오류 신고</a></div></div><div class="gmnoprint gm-bundled-control gm-bundled-control-on-bottom" draggable="false" controlwidth="0" controlheight="0" style="margin: 10px; user-select: none; position: absolute; display: none; bottom: 14px; right: 0px;"><div class="gmnoprint" style="display: none; position: absolute;"><div draggable="false" style="user-select: none; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; cursor: pointer; background-color: rgb(255, 255, 255);"><button draggable="false" title="확대" aria-label="확대" type="button" style="background: none; display: block; border: 0px; margin: 0px; padding: 0px; position: relative; cursor: pointer; user-select: none;"><div style="overflow: hidden; position: absolute;"><img alt="" src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 120px; height: 54px;"></div></button><div style="position: relative; overflow: hidden; width: 67%; height: 1px; left: 16%; background-color: rgb(230, 230, 230);"></div><button draggable="false" title="축소" aria-label="축소" type="button" style="background: none; display: block; border: 0px; margin: 0px; padding: 0px; position: relative; cursor: pointer; user-select: none;"><div style="overflow: hidden; position: absolute;"><img alt="" src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 120px; height: 54px;"></div></button></div></div><div class="gm-svpc" controlwidth="28" controlheight="28" style="background-color: rgb(255, 255, 255); box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; width: 28px; height: 28px; cursor: url(&quot;https://maps.gstatic.com/mapfiles/openhand_8_8.cur&quot;), default; touch-action: none; display: none; position: absolute;"><div style="position: absolute; left: 1px; top: 1px;"></div></div><div class="gmnoprint" controlwidth="28" controlheight="0" style="display: none; position: absolute;"><div title="지도 90도 회전" style="width: 28px; height: 28px; overflow: hidden; position: absolute; background-color: rgb(255, 255, 255); box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; cursor: pointer; display: none;"><img alt="" src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl4.png" draggable="false" style="position: absolute; left: -141px; top: 6px; width: 170px; height: 54px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div class="gm-tilt" style="width: 0px; height: 0px; overflow: hidden; position: absolute; background-color: rgb(255, 255, 255); box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; top: 0px; cursor: pointer;"><img alt="" src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl4.png" draggable="false" style="position: absolute; left: 0px; top: 0px; width: 170px; height: 54px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div></div></div><div class="gmnoprint" style="margin: 10px; z-index: 0; position: absolute; cursor: pointer; display: none; left: 0px; top: 0px;"><div class="gm-style-mtc" style="float: left; position: relative;"><div role="button" tabindex="0" title="거리 지도 보기" aria-label="거리 지도 보기" aria-pressed="true" draggable="false" style="direction: ltr; overflow: hidden; text-align: center; position: relative; color: rgb(0, 0, 0); font-family: Roboto, Arial, sans-serif; user-select: none; font-size: 11px; background-color: rgb(255, 255, 255); padding: 8px; border-bottom-left-radius: 2px; border-top-left-radius: 2px; background-clip: padding-box; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; min-width: 22px; font-weight: 500;">지도</div><div style="background-color: white; z-index: -1; padding: 2px; border-bottom-left-radius: 2px; border-bottom-right-radius: 2px; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; position: absolute; left: 0px; top: 0px; text-align: left; display: none;"><div draggable="false" title="지형과 거리 지도 보기" style="color: rgb(0, 0, 0); font-family: Roboto, Arial, sans-serif; user-select: none; font-size: 11px; background-color: rgb(255, 255, 255); padding: 6px 8px 6px 6px; direction: ltr; text-align: left; white-space: nowrap;"><span role="checkbox" style="box-sizing: border-box; position: relative; line-height: 0; font-size: 0px; margin: 0px 5px 0px 0px; display: inline-block; background-color: rgb(255, 255, 255); border: 1px solid rgb(198, 198, 198); border-radius: 1px; width: 13px; height: 13px; vertical-align: middle;"><div style="position: absolute; left: 1px; top: -2px; width: 13px; height: 11px; overflow: hidden; display: none;"><img alt="" src="https://maps.gstatic.com/mapfiles/mv/imgs8.png" draggable="false" style="position: absolute; left: -52px; top: -44px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 68px; height: 67px;"></div></span><label style="vertical-align: middle; cursor: pointer;">지형</label></div></div></div><div class="gm-style-mtc" style="float: left; position: relative;"><div role="button" tabindex="0" title="위성 이미지 보기" aria-label="위성 이미지 보기" aria-pressed="false" draggable="false" style="direction: ltr; overflow: hidden; text-align: center; position: relative; color: rgb(86, 86, 86); font-family: Roboto, Arial, sans-serif; user-select: none; font-size: 11px; background-color: rgb(255, 255, 255); padding: 8px; border-bottom-right-radius: 2px; border-top-right-radius: 2px; background-clip: padding-box; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; min-width: 22px; border-left: 0px;">위성</div><div style="background-color: white; z-index: -1; padding: 2px; border-bottom-left-radius: 2px; border-bottom-right-radius: 2px; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; position: absolute; right: 0px; top: 0px; text-align: left; display: none;"><div draggable="false" title="거리 이름과 이미지 함께 보기" style="color: rgb(0, 0, 0); font-family: Roboto, Arial, sans-serif; user-select: none; font-size: 11px; background-color: rgb(255, 255, 255); padding: 6px 8px 6px 6px; direction: ltr; text-align: left; white-space: nowrap;"><span role="checkbox" style="box-sizing: border-box; position: relative; line-height: 0; font-size: 0px; margin: 0px 5px 0px 0px; display: inline-block; background-color: rgb(255, 255, 255); border: 1px solid rgb(198, 198, 198); border-radius: 1px; width: 13px; height: 13px; vertical-align: middle;"><div style="position: absolute; left: 1px; top: -2px; width: 13px; height: 11px; overflow: hidden;"><img alt="" src="https://maps.gstatic.com/mapfiles/mv/imgs8.png" draggable="false" style="position: absolute; left: -52px; top: -44px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 68px; height: 67px;"></div></span><label style="vertical-align: middle; cursor: pointer;">라벨</label></div></div></div></div></div></div></div>
						<img src="/res/img/city/map_view_btn.png" alt="" class="map_full" onclick="location.href='/ko/city/seoul_310/map/hotel';">
					</div> -->
						</div>

					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>

	</div>
	<c:import url="/footer.do" />
</body>
</html>