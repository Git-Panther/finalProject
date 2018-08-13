<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="/header.do"/>
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
	        type: 'get',
	        data: { contentid : ${contentid} },
	        dataType: 'json',
	        success: function(data){
	        	//console.log(data);
	        	printFestivalCommon(data.response.body.items.item);
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}
	
	function festivalDetailIntro(){
		$.ajax({        
	        url: 'festivalDetailIntro.do',
	        type: 'get',
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
	        type: 'get',
	        data: { contentid : ${contentid} },
	        dataType: 'json',
	        success: function(data){
	        	console.log(data);
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}
	
	function locationBasedList(mapx, mapy, contenttypeid){
		$.ajax({        
	        url: 'locationBasedList.do',
	        type: 'get',
	        data: { mapx : mapx, mapy : mapy, contenttypeid : contenttypeid},
	        dataType: 'json',
	        success: function(data){
	        	console.log(data);
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}
	
	function printFestivalCommon(common){
		//console.log(common);
		var $festivalInfo = $("#festivalInfo");

		var img = $("<img>").css({"width":"300px", "height":"300px"});
		if(undefined != common.firstimage) img.attr("src", common.firstimage);
		else img.attr("src", "/planner/resources/images/festival/no_image.png");
		$festivalInfo.append(img);
		
		//img = $("<img>").attr("src", common.firstimage2).css({"width":"300px", "height":"300px"});
		//$festivalInfo.append(img);
		
		var info = $("<p>");
		info.html(common.addr1);
		if(common.addr2 != undefined) info.append(common.addr2);
		$festivalInfo.append(info);
		
		info = $("<p>");
		info.html(common.homepage);
		$festivalInfo.append(info);
		
		//info = $("<p>");
		//info.html(common.homepage);
		//$festivalInfo.append(info);
		
		//bookingplace
		
		info = $("<p>");
		info.html(common.overview);
		$festivalInfo.append(info);
		
		info = $("<p>");
		info.html(common.tel);
		$festivalInfo.append(info);
		
		info = $("<p>");
		info.html(common.telname);
		$festivalInfo.append(info);
		
		info = $("<p>");
		info.html(common.title);
		$festivalInfo.append(info);
		
		info = $("<p>");
		info.html(common.zipcode);
		$festivalInfo.append(info);
		
		locationBasedList(common.mapx, common.mapy, 32); // 숙박
		locationBasedList(common.mapx, common.mapy, 39); // 음식점
		
		// 지도 표시를 해준다 ㅇㅇ.
		printMark(new daum.maps.LatLng(common.mapy, common.mapx));
	}
	
	function printFestivalDetail(detail){
		//console.log(detail);
		var $festivalInfo = $("#festivalInfo");
		var info = $("<p>");
		info.html(detail.agelimit);
		$festivalInfo.append(info);
		
		info = $("<p>");
		info.html(detail.playtime);
		$festivalInfo.append(info);
		
		info = $("<p>");
		info.html(detail.eventplace);
		$festivalInfo.append(info);
		
		info = $("<p>");
		info.html(detail.usetimefestival);
		$festivalInfo.append(info);
	}
</script>
</head>
<body>
<div class="outer">
	<div id="festivalDetail">
		<div id="festivalInfo"></div>
		<br>
		<div id="map"></div>
		<script type="text/javascript">		
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
				searchDetailAddrFromCoords(position, function(result, status) {
			        if (status === daum.maps.services.Status.OK) {
			            var detailAddr = !!result[0].road_address ? '<div>도로명주소 <br>' + result[0].road_address.address_name + '</div><br>' : '';
			            detailAddr += '<div>지번 주소<br>' + result[0].address.address_name + '</div><br>';
			            
			            var content = '<div class="bAddr">' +
			                            //'<span class="title">법정동 주소정보</span>' + 
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
			}
			
			function searchDetailAddrFromCoords(coords, callback) {
		        // 좌표로 법정동 상세 주소 정보를 요청합니다
		        geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		    }
		    
		    $(function(){
		    	festivalDetailCommon();
		    	festivalDetailIntro();
		    	festivalDetailInfo();
			});
		</script>
	</div>
	<div id="festivalComment"></div>
</div>
</body>
<c:import url="/footer.do"/>
</html>