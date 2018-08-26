<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do" />
<!DOCTYPE html>
<html>
<head>
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
		<br>
		<br>
		<div class="list_bg">
			<div class="wrap">
				<div class="list_left">
					<div class="list_top" style="display: block;">
						<div class="list_cnt">
							총 0개의 호텔 <a href="javascript:reset_filter();"
								style="display: none;">필터 초기화</a>
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
							<div class="right_title">지도에서 호텔보기</div>
							<div id="map"></div>

							<!-- <script>
								// Initialize and add the map
								function initMap() {
									// 시, 도의 가운데
									var uluru = {
										lat : -25.344,
										lng : 131.036
									};

									// The map, centered at Uluru
									var map = new google.maps.Map(document
											.getElementById('map'), {
										zoom : 4,
										center : uluru
									});
									// The marker, positioned at Uluru
									var marker = new google.maps.Marker({
										position : uluru,
										map : map
									});
								}
							</script> -->
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