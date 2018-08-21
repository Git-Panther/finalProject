/**
 * 
 */
function printMark(position, title, contenttypeid){ // 마커 생성
	/*
	 * 만일 중심정보이면 마커를 표시
	 * 중심정보가 아니면 커스텀 오버레이 표시
	 */
	//console.log(position);
		
	// div 만들기
	var markerContent = $("<div>").addClass("markerContent");
	/* 원래는 16줄마다 자르려고 했는데 이상하게 출력돼서 안함
	var cols = 16;
	var rows = Math.ceil(title.length / cols);
	
	var titleArr = [];
	
	for(var i = 0; i < rows; i++){
		titleArr[i] = title.substr(i * cols, cols);
	}
	
	titleArr.forEach(function(v, i){
		markerContent.append(v);
		if(i < titleArr.length - 1) markerContent.append("<br/>");
	});
	*/
	
	markerContent.append(title);
	
	var customOverlay = new daum.maps.CustomOverlay({
		//map: map,
	    position: position,
	    content: markerContent.get(0),
	    xAnchor: 0,
	    yAnchor: 3.5
	});

	var imageSrc;
	var imageSize = new daum.maps.Size(36, 64); // 크기
	var imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정.
	var markerImage;
	
	var marker = new daum.maps.Marker({
        position: position
    }); // 생성할 마커
	
	if(15 === contenttypeid){
		imageSrc = "/planner/resources/images/festival/festival_marker.png";
		map.panTo(position); // 지도 중심 잡기
		marker.setMap(map);
		festivalMarkers.push(marker);
	}else{
		if(32 === contenttypeid){
			imageSrc = "/planner/resources/images/festival/hotel_marker.png";
			hotelMarkers.push(marker);
		}else{
			imageSrc = "/planner/resources/images/festival/restaurant_marker.png";
			restaurantMarkers.push(marker);
		}
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
	/*
	if(isNear){ // 올렸을 때에만 표시
		//customOverlay.setVisible(false); // 우선은 숨기고 마우스 커서 올렸을 때만 보여준다 ㅇㅇ
		// 마커에 마우스오버 이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'mouseover', function() {
			// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
			//customOverlay.setVisible(true);
			customOverlay.setMap(map);
		});
		// 마커에 마우스아웃 이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'mouseout', function() {
		    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
			//customOverlay.setVisible(false);
			customOverlay.setMap(null);
		});
	}else{
		var event = function() {
		    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
			//customOverlay.setVisible(false);
			//customOverlay.setMap(null);
			customOverlay.setMap(map);
		};
		
		map.panTo(position); // 지도 중심 잡기
		customOverlay.setMap(map);
		//daum.maps.event.addListener(marker, 'click', event);
		
		//console.log(marker, $(marker));
		//$(marker).click();
		
		//daum.maps.event.trigger(marker, 'click', ''); // 이벤트 강제 발생
		//daum.maps.event.removeListener(marker, 'click', event); // 이벤트 제거
	}
	*/
}

function markerCategoryEvent(){
	var $markerMenu = $(".markerMenu");
	$markerMenu.each(function(){
		//console.log($(this));
		$(this).click(function(){
			changeMarker($(this).attr("id"));
		});
	});
	$markerMenu.children(".ico_festival").attr("src", "/planner/resources/images/festival/festival_marker.png");
	$markerMenu.children(".ico_hotels").attr("src", "/planner/resources/images/festival/hotel_marker.png");
	$markerMenu.children(".ico_restaurants").attr("src", "/planner/resources/images/festival/restaurant_marker.png");
	//console.log($markerMenu);
}

function changeMarker(type){ 
    //var $festivalMarkers = $("#festivalMarkers");
    //var $hotelMarkers = $("#hotelMarkers");
    //var $restaurantMarkers = $("#restaurantMarkers");
    var $markerMenu = $(".markerMenu");
    //console.log(type);
    $markerMenu.removeClass("menu_selected"); // 공통 부분이므로 먼저 실행
    
    var $markers = $("#"+type);
    $markers.addClass("menu_selected");
    //console.log($markers);
    
    switch(type){
    case "festivalMarkers":
    	//$festivalMarkers.addClass("menu_selected");
    	showMarkers("축제/행사", map);
    	showMarkers("숙박", null);
    	showMarkers("식당", null);
    	break;
    case "hotelMarkers":
    	//$hotelMarkers.addClass("menu_selected");
    	showMarkers("축제/행사", null);
    	showMarkers("숙박", map);
    	showMarkers("식당", null);
    	break;
    case "restaurantMarkers":
    	//$restaurantMarkers.addClass("menu_selected");
    	showMarkers("축제/행사", null);
    	showMarkers("숙박", null);
    	showMarkers("식당", map);
    	break;
    default:
    	alert("error");
    	break;
    }
}

function showMarkers(type, map){ // 마커들 표시
	switch(type){
	case "축제/행사":
		//console.log(festivalMarkers);
		festivalMarkers.forEach(function(v){
			v.setMap(map);
		});
		break;
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
	default:
		alert("error");
		break;
	}
}