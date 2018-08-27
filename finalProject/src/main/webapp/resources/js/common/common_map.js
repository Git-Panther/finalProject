/**
 * 지도 표시 알고리즘
 */
function printMark(position, title, contenttypeid){ // 마커 생성
	/*
	 * 만일 중심정보이면 마커를 표시
	 * 중심정보가 아니면 커스텀 오버레이 표시
	 */
	var markerContent = $("<div>").addClass("markerContent");
	
	markerContent.append(title);
	
	var customOverlay = new daum.maps.CustomOverlay({
		//map: map,
	    position: position,
	    content: markerContent.get(0),
	    xAnchor: 0.55,
	    yAnchor: 2.75
	});

	var imageSrc;
	var imageSize = new daum.maps.Size(36, 64); // 크기
	var imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정.
	var markerImage;
	
	var marker = new daum.maps.Marker({
        position: position
    }); // 생성할 마커
	
	switch(contenttypeid){
	case 12:
		imageSrc = "/planner/resources/images/map/attraction_marker.png";
		attractionMarkers.push(marker);
		break;
	case 32:
		imageSrc = "/planner/resources/images/map/hotel_marker.png";
		hotelMarkers.push(marker);
		break;
	case 39:
		imageSrc = "/planner/resources/images/map/restaurant_marker.png";
		restaurantMarkers.push(marker);
		break;
	case 0: // 0이면 메인 마커
		imageSrc = "/planner/resources/images/map/main_marker.png";
		map.panTo(position); // 지도 중심 잡기
		marker.setMap(map);
		break;
	default:
		alert("error");
		break;
	}
	
	markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
	marker.setImage(markerImage);
	
	daum.maps.event.addListener(marker, 'mouseover', function() {
		// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
		customOverlay.setMap(map);
	});
	
	daum.maps.event.addListener(marker, 'mouseout', function() {
	    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
		customOverlay.setMap(null);
	});
	// marker.setMap(map); // 맵에다가 붙임. 이제는 분류를 클릭해야 표시
	
	//console.log(marker);
}

function markerCategoryEvent(){
	var $markerMenu = $(".markerMenu");
	$markerMenu.each(function(){
		//console.log($(this));
		$(this).click(function(){
			changeMarker($(this).attr("id"));
		});
	});
	$markerMenu.children(".ico_all").attr("src", "/planner/resources/images/map/main_marker.png");
	$markerMenu.children(".ico_hotels").attr("src", "/planner/resources/images/map/hotel_marker.png");
	$markerMenu.children(".ico_restaurants").attr("src", "/planner/resources/images/map/restaurant_marker.png");
	$markerMenu.children(".ico_attractions").attr("src", "/planner/resources/images/map/attraction_marker.png");
	//console.log($markerMenu);
}

function changeMarker(type){ 
    var $markerMenu = $(".markerMenu");
    //console.log(type);
    $markerMenu.removeClass("menu_selected"); // 공통 부분이므로 먼저 실행
    
    var $markers = $("#"+type);
    $markers.addClass("menu_selected");
    //console.log($markers);
    
    switch(type){
    case "attractionMarkers":
    	showMarkers("관광지", map);
    	showMarkers("숙박", null);
    	showMarkers("식당", null);
    	break;
    case "hotelMarkers":
    	showMarkers("숙박", map);
    	showMarkers("식당", null);
    	showMarkers("관광지", null);
    	break;
    case "restaurantMarkers":
    	showMarkers("숙박", null);
    	showMarkers("식당", map);
    	showMarkers("관광지", null);
    	break;
    case "allMarkers":
		showMarkers("숙박", map);
		showMarkers("식당", map);
		showMarkers("관광지", map);
    	break;
    default:
    	alert("error");
    	break;
    }
}

function showMarkers(type, map){ // 마커들 표시
	switch(type){
	case "숙박":
		//console.log(hotelMarkers);
		hotelMarkers.forEach(function(v){
			v.setMap(map);
		});
		break;
	case "식당":
		restaurantMarkers.forEach(function(v){
			v.setMap(map);
		});
		break;
	case "관광지":
		attractionMarkers.forEach(function(v){
			v.setMap(map);
		});
		break;
	default:
		alert("error");
		break;
	}
}