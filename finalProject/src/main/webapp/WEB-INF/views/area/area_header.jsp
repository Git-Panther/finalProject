<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- common -->
<script type="text/javascript" src="resources/js/common/component.js"></script>
<script type="text/javascript"
	src="resources/js/common/common_script.js"></script>
<script type="text/javascript"
	src="resources/js/area/area_common.js"></script>
<script type="text/javascript"
	src="resources/js/owl_carousel/owl.carousel2.js"></script>
			<script type="text/javascript" src="resources/js/web/jui/jquery-ui.js"></script>
<!-- /common -->

<!-- css -->
<link href="resources/css/city/main.css" rel="stylesheet" />
<link href="resources/css/city/header_v2.css" rel="stylesheet" />
<link rel="stylesheet"
	href="resources/js/owl_carousel/owl.carousel2.css">
<link href="resources/css/hotelList.css" rel="stylesheet">
<!-- /css -->

<style>
#map {
	height: 400px; /* The height is 400 pixels */
	width: 100%; /* The width is the width of the web page */
}
</style>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=339906b6f4278bdec7e4ff5ae52df3cc&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="resources/js/area/area_map.js"></script>


<script>
	var sidoCode = ${sidoCode};
	var sidoName = '${sidoName}';
	var sigunguCode = ${sigunguCode};
	var sigunguName = '${sigunguName}';
</script>
<meta charset="UTF-8">
<title>페스티벌 플래너</title>
</head>
<body>
<div class="wrap">
	<div class="area_nav">
				<a href="area.do" class="nav_btn">여행지</a>
				<c:choose>
					<c:when test="${sidoName ne '-1'}"> &gt; 
					<a
							href="javascript:moveAreaMain('<c:out value="${sidoName }" />', '<c:out value="${sidoCode }" />')"
							class="nav_btn">${sidoName }</a>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${sigunguName ne '-1'}"> &gt; 
					<a
							href="javascript:moveAreaMain('${sidoName}', ${sidoCode}, '${sigunguName }', ${sigunguCode })"
							class="nav_btn">${sigunguName}</a>
					</c:when>
				</c:choose>
			</div>

			<div class="area_title">
			<c:choose>
					<c:when test="${sidoName ne '-1'}">
					<b><c:out value="${sidoName }" /></b>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${sigunguName ne '-1'}">
					<b><c:out value="${sigunguName }" /></b>
					</c:when>
				</c:choose>
				
			</div>

			<div class="common_menu">
				<a href="javascript:areaMenu('home')" id="home" class="on"> 홈 </a> <a
					href="javascript:areaMenu('attraction')" id="attraction"> 관광지 </a> <a
					href="javascript:areaMenu('culture')" id="culture"> 문화시설 </a> <a
					href="javascript:areaMenu('hotel')" id="hotel"> 숙박 </a> <a
					href="javascript:areaMenu('shopping')" id="shopping"> 쇼핑 </a> <a
					href="javascript:areaMenu('restaurant')" id="restaurant"> 음식점 </a> <a
					href="/#"> 지도보기 </a>
				<div class="clear"></div>
			</div>
		</div>
</body>
</html>