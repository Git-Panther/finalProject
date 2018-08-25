<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do" />
<!DOCTYPE html>
<html>
<head>
<!-- javascript -->
<!-- <script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDA_nL375kZbKh_UyHyB8EFsXdhJll3w0E&callback=initMap"type="text/javascript">
	</script> -->
<script type="text/javascript" src="resources/js/common/component.js"></script>
<script type="text/javascript"
	src="resources/js/common/common_script.js"></script>
<script type="text/javascript"
	src="resources/js/area/area_common.js?a=1"></script>
<script type="text/javascript"
	src="resources/js/owl_carousel/owl.carousel2.js"></script>
<script type="text/javascript" src="resources/js/web/jui/jquery-ui.js"></script>
<script type="text/javascript" src="resources/js/area/area_hotel.js"></script>

<!-- /javascript -->

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
<script>
	var sidoCode = '${sidoCode}';
	var sigunguCode = '${sigunguCode}';
	var contenttypeid = '${contenttypeid}';
	var arrange = "B";
	var pageNo = 1;
	var total = 0;
	var curPage = 1;
$(document).ready(function() {
	headerClassOn('${menu}');
	getList(sidoCode, sigunguCode, contenttypeid, arrange, pageNo, curPage);
	
	$("#selectSort").change(function() {
		console.log($("#selectSort").val());
		if($("#selectSort").val() == "count") {
			arrange = "B";
			getList(sidoCode, sigunguCode, contenttypeid, arrange, pageNo, curPage);
		} else if($("#selectSort").val() == "name") {
			arrange = "A";
			getList(sidoCode, sigunguCode, contenttypeid, arrange, pageNo, curPage);
		}
	});
});

function headerClassOn(){
	console.log('headerClassOn::', ${menu});
	$(".common_menu a").removeClass("on");
	$(".common_menu a[id='${menu}']").addClass("on");
}

</script>
<meta charset="UTF-8">
<title>페스티벌 플래너</title>
</head>
<body>
	<div class="area_bg top silver">
		<c:import url="/area_header.do" />
		<br> <br>
		<div class="list_bg">
			<div class="wrap">
				<div class="list_left">
					<div class="list_top" style="display: block;">
						<div class="list_cnt">
							총 0개 <a href="javascript:reset_filter();" style="display: none;">필터
								초기화</a>
						</div>
						<div class="list_sort">
							<select name="" id="selectSort" class="sort" data-height="25">
								<option value="count">인기순</option>
								<option value="name">이름순</option>
							</select>
						</div>
					</div>
					<div class="list"></div>
					<div id="paging"></div>
				</div>
				<div class="list_right">
					<div class="scroll_area" style="">
						<div class="right_box">
							<div class="right_title">지도에서 보기</div>
							<div id="map"></div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>

	</div>

	<c:import url="/footer.do"></c:import>
</body>
</html>