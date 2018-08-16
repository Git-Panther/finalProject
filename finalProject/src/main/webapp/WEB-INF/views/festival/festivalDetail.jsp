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
<script type="text/javascript" src="resources/js/forecast.js"></script>
<script type="text/javascript" src="resources/js/printFestival.js"></script>
<script>
	var eventstartdate = <c:out value='${eventstartdate}'/>; // 전역 변수로 만들어 사용해야 외부 js 파일과 쓸 수 있다. 아마?
	var eventenddate = <c:out value='${eventenddate}'/>;

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
		    	festivalDetailCommon(${contentid}); // 기본정보 표시	
		    	festivalDetailInfo(${contentid}); // 반복 정보 표시
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