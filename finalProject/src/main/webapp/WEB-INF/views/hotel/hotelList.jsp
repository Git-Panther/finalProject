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


<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="area_bg top silver">

		<div class="wrap">

			<div id="SearchBox">
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
		

	</div>
	<c:import url="/footer.do" />
</body>
</html>