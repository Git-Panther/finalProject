/**
 * 
 */
function printMark(position, title, isNear){ // 마커 생성
	var marker = new daum.maps.Marker({
        position: position
    }); // 생성할 마커 
	marker.setMap(map); // 맵에다가 붙임
	
	var markerText = $("<div>").addClass("markerText").append($("<p>").html(title));
	//console.log(markerText.get(0));
	
	var infowindow = new daum.maps.InfoWindow({
		position : position
		, content : markerText.get(0)
	});
	
	// $("#map img").addClass("marker");
	
	if(isNear){
		// 마커에 마우스오버 이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'mouseover', function() {
		  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
		    infowindow.open(map, marker);
		});
		// 마커에 마우스아웃 이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'mouseout', function() {
		    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
		    infowindow.close();
		});
		/*
		marker.md.onmouseenter = function(){
			infowindow.open(map, marker)
		};
		*/
	}else{
		infowindow.open(map, marker);
	}
	
	//console.log(marker);
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

/*
function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}
*/