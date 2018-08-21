<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="searchArea.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Festival Detail</title>
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
				<!-- <td>교통상황</td>  -->
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
						<div id="festivalMap" class="tapGroup1">
							<div id="map"></div>
							 <div class="markerCategory">
							 	<div id="festivalMarkers" class="markerMenu">
							 		<img class="ico_comm ico_festival"></img>
									축제/행사
							 	</div>
							 	<div id="hotelMarkers" class="markerMenu">
							 		<img class="ico_comm ico_hotels"></img>
									숙박
							 	</div>
							 	<div id="restaurantMarkers" class="markerMenu">
							 		<img class="ico_comm ico_restaurants"></img>
									식당
							 	</div>
						    </div>
						</div>
						<div id="festivalForecast" class="tapGroup1"></div>
						<!-- <div id="festivalTraffic" class="tapGroup1"></div> 교통정보는 지도에 표시하는걸로 -->
					</td>
				</tr>
			</table>
			<div id="favorite" class="link"></div>
		</div>
		<!-- <div id="festivalIntro"></div> -->
		<!-- <br> -->
		<div id="festivalDetailInfo" class="tapGroup2"></div>
		<div id="festivalHotels" class="tapGroup2"></div>
		<div id="festivalRestaurants" class="tapGroup2"></div>
		<br>
		<div id="festivalComment">코멘트 부분</div>
	</div>	
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=339906b6f4278bdec7e4ff5ae52df3cc&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="resources/js/forecast.js"></script>
<script type="text/javascript" src="resources/js/printFestival.js"></script>
<script type="text/javascript" src="resources/js/festivalMap.js"></script>
<script>
	var eventstartdate = <c:out value='${eventstartdate}'/>; // 전역 변수로 만들어 사용해야 외부 js 파일과 쓸 수 있다. 아마?
	var eventenddate = <c:out value='${eventenddate}'/>;
	//var festivalx, festivaly; // x, y축 저장용
	var contentid = ${contentid}, contenttypeid = 15; // 행사의 contentid, contenttypeid
	var userNo;
	var isUser = false;
	<c:if test="${!empty sessionScope.user}">
		isUser = true;
		userNo = <c:out value="${sessionScope.user.userNo}"/>;
	</c:if>
	
	var festivalMarkers = [];
	var hotelMarkers = [], restaurantMarkers = [];
	
	var container = document.getElementById('map');			
	var options = {
		center: new daum.maps.LatLng(33.450701, 126.570667),
		level: 5
		// ,marker: markers // 이미지 지도에 표시할 마커 
	};			
	var map = new daum.maps.Map(container, options);

	function setFestivalEvent(){
		festivalTapEvent(); // 탭 이벤트 추가	
		festivalDetailCommon(${contentid}); // 기본정보 표시	
		festivalDetailInfo(${contentid}); // 반복 정보 표시
		map.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC); // 지도에 교통체증 표시
		
		$("#festivalTap td").eq(1).click(); // 기본 정보부터 표시
		$("#festivalTap td").eq(0).click(); // 기본 정보부터 표시
		
		markerCategoryEvent(); // 마커 표시 이벤트 추가
		changeMarker("festivalMarkers"); // 행사 먼저 누르기
	}

    $(function(){
    	setFestivalEvent();
	});
</script>
</body>
<c:import url="/footer.do"/>
</html>