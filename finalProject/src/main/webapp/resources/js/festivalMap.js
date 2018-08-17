/**
 * 
 */
function printMark(position, title, isNear){ // 마커 생성
	/*
	 * 만일 중심정보이면 마커를 표시
	 * 중심정보가 아니면 커스텀 오버레이 표시
	 */
	var marker = new daum.maps.Marker({
        position: position
    }); // 생성할 마커 
	marker.setMap(map); // 맵에다가 붙임
	
	// div 만들기
	var markerContent = $("<div>").addClass("markerContent");
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
	
	var customOverlay = new daum.maps.CustomOverlay({
	    map: map,
	    position: position,
	    content: markerContent.get(0),
	    yAnchor: 1.5
	});
	
	if(isNear){ // 올렸을 때에만 표시
		customOverlay.setVisible(false); // 우선은 숨기고 마우스 커서 올렸을 때만 보여준다 ㅇㅇ
		// 마커에 마우스오버 이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'mouseover', function() {
			// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
			customOverlay.setVisible(true);
		});
		// 마커에 마우스아웃 이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'mouseout', function() {
		    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
			customOverlay.setVisible(false);
		});
	}else{
		customOverlay.setVisible(false);
		customOverlay.setVisible(true);
	}
}