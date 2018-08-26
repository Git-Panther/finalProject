var areaCenter = new daum.maps.LatLng(33.450701000000, 126.570667000000);
var areaAddr = '서울특별시';
var markers = [];
var x = 0;
var y = 0;
function getLatLng(mapy, mapx) {
	areaCenter = new daum.maps.LatLng(mapy, mapx);
}

function initMarker() {
	markers = new Array();
	x = 0;
	y = 0;
}

function addMarker(title, mapy, mapx) {
	markers.push({
		title : title,
		latlng : new daum.maps.LatLng(mapy, mapx)
	});
	x += Number(mapx);
	y += Number(mapy);
	console.log("addMarker::currentMarkers: ", markers);
}


function setMarkers(markers) {
	areaCenter = new daum.maps.LatLng(y/markers.length, x/markers.length);
	console.log(y/markers.length);
	console.log(x/markers.length);

	for (var i = 0; i < markers.length; i++) {
		var marker = new daum.maps.Marker({
			map : map,
			position : markers[i].latlng,
			title : markers[i].title
		});

		console.log("setMarkers::markers[" + i + "]", markers[i].title + ", " + markers[i].latlng);
	}
	if(x > 0) {
		map.setCenter(areaCenter);
		
	} else {
		map.setCenter(new daum.maps.LatLng(33.450701000000, 126.570667000000));
	}

}

function getAreaAddr(name) {
	console.log("getAreaAddr::name: ", name);
	areaAddr = name;

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(areaAddr, function(result, status) {

		// 정상적으로 검색이 완료됐으면
		if (status === daum.maps.services.Status.OK) {

			var coords = new daum.maps.LatLng(result[0].y, result[0].x);

			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(areaCenter);
		}
	});
}

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = {
	center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	level : 8
// 지도의 확대 레벨
};

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();

// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

// 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();
