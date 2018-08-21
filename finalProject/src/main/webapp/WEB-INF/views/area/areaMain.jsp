<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do" />
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="resources/js/common/component.js"></script>
<script type="text/javascript"
	src="resources/js/common/common_script.js"></script>
<link href="resources/css/area/area_main.css" rel="stylesheet" />
<link href="resources/css/city/main.css" rel="stylesheet" />
<link href="resources/css/city/header_v2.css" rel="stylesheet" />
<link rel="stylesheet"
	href="resources/js/owl_carousel/owl.carousel2.css">
<script type="text/javascript"
	src="resources/js/owl_carousel/owl.carousel2.js"></script>
<script type="text/javascript" src="resources/js/web/jui/jquery-ui.js"></script>
<meta charset="UTF-8">
<title>페스티벌 플래너</title>
<script>
var festival = 15;
var attraction = 12;
var culture = 14;
var hotel = 32;
var shopping = 38;
var restaurant = 39;
	$(document).ready(	function() {
						sidoCode = document.location.href.split("?")[1]
								.split("&")[1].split("=")[1];
						sigunguCode = document.location.href.split("?")[1]
								.split("&")[2].split("=")[1];
						/* for(var i=0; i < document.location.href.split("?")[1].split("&").length; i++){
							  console.log("key", document.location.href.split("?")[1].split("&")[i].split("=")[0]);
							  console.log("value", document.location.href.split("?")[1].split("&")[i].split("=")[1]);
							  console.log("sidoCode: ", sidoCode);
							  console.log("sigunguCode: ", sigunguCode);
							} */
							popList(15);
							
							$(document).on('click', '.pospot_tab', function() {
								var _this_cate = $(this).attr('data-cate');
								
								if($(this).attr('class') == 'pospot_tab on') {
									console.log("class가 on이므로 데이터를 받아오지 않음");
								} else {
									console.log("class가 off이므로 데이터를 받아옴");
									$('.pospot_tab').removeClass('on');
									$(this).addClass('on');
									popList(_this_cate);
								}
							});
					});

	function popList(contentTypeId) {
		$.ajax({
			type:'GET',
			url:'popList.do',
			dataType : 'json',
			data:{
				sidoCode:sidoCode,
				sigunguCode:sigunguCode,
				contentTypeId:contentTypeId
			},
			success: function(data) {
				var object = data.response.body.items.item;
				_html = "";
				console.log(object);
				
				$.each(object, function(index, item) {
					_html += '<a class="pospot"';
					_html += 'href="/ko/city/seoul_310/attraction/bukchon-hanok-village_6725"';
					if(index == 3 || index == 7) {
					_html += 'target="_blank" style="margin-right:0px;"><div class="po_img_box">';
					} else {
					_html += 'target="_blank"><div class="po_img_box">';
					}
					_html += '<img ';
					 if(object[index].firstimage == undefined) {
					_html += 'src="/planner/resources/images/common/no_img/sight55.png"';
					} else {
					_html += 'src="' + object[index].firstimage + '"';
					} 
					_html += 'alt="" class="po_img">';
					_html += '</div>';
					_html += '<div class="po_name">' + object[index].title + '</div>';
					_html += '<div class="po_bottom">';
					_html += '<img src="/planner/resources/images/city/clip_icon.png" alt="" class="po_clip">';
					_html += '<div class="po_cnt">' + object[index].readcount + '</div>';
					_html += '<div class="po_tag">유명한거리/지역</div>';
					_html += '</div></a>'; 
					
				});
				$(".pospot_content").html(_html);
				$(".pospot_content").append('<div class="clear"></div>');
			}
			
		});
	};
	
</script>
</head>
<body>
	<div class="area_bg top silver">

		<div class="wrap">

			<div class="area_nav">
				<a href="area.do" class="nav_btn">여행지</a> &gt; <a
					href="areaMain.do?name=${name }&sido=${sido }&sigungu${name }"
					class="nav_btn"> <c:out value="${name }" />
				</a>
			</div>

			<div class="area_title">
				<b><c:out value="${name }" /></b>
			</div>

			<div class="common_menu">
				<a href="/ko/city/seoul_310" class="on"> 홈 </a> <a
					href="/ko/city/seoul_310/hotel#1"> 호텔 </a> <a
					href="/ko/city/seoul_310/attraction#1"> 관광명소 </a> <a
					href="/ko/city/seoul_310/restaurant#1"> 음식점 </a> <a
					href="/ko/city/seoul_310/shopping#1"> 쇼핑 </a> <a
					href="/ko/plan?ci=310" target="_blank"> 여행일정 </a> <a
					href="/ko/city/seoul_310/map"> 지도보기 </a>
				<div class="clear"></div>
			</div>

			<style type="text/css">
#SearchBox {
	position: fixed;
	left: 0px;
	top: 0px;
	z-index: -1;
	display: none;
	width: 1px;
	height: 1px;
}
</style>

			<div class="inner_box">
				<div class="main_img_cnt">5/5</div>
				<div class="img_box">
					<div class="img_roll owl-carousel owl-theme owl-loaded">
						<div class="owl-stage-outer">
							<div class="owl-stage"
								style="transform: translate3d(-3744px, 0px, 0px); transition: all 0.25s ease 0s; width: 5616px;">
								<div class="owl-item cloned"
									style="width: 624px; margin-right: 0px;">
									<div class="m_img">
										<a href="/ko/mypage/Editor01" class="img_info" target="_blank"><b>i</b><span>JIEUN</span></a><img
											src="http://img.earthtory.com/img/city_images/310/seoul_1425372992.jpg"
											alt="">
									</div>
								</div>
								<div class="owl-item cloned"
									style="width: 624px; margin-right: 0px;">
									<div class="m_img">
										<a href="/ko/mypage/Editor01" class="img_info" target="_blank"><b>i</b><span>JIEUN</span></a><img
											src="http://img.earthtory.com/img/city_images/310/seoul_1425373106.jpg"
											alt="">
									</div>
								</div>
								<div class="owl-item" style="width: 624px; margin-right: 0px;">
									<div class="m_img">
										<a href="/ko/mypage/Editor01" class="img_info" target="_blank"
											style="width: 24px; overflow: hidden;"><b>i</b><span>JIEUN</span></a><img
											src="http://img.earthtory.com/img/city_images/310/seoul_1425372763.jpg"
											alt="">
									</div>
								</div>
								<div class="owl-item" style="width: 624px; margin-right: 0px;">
									<div class="m_img">
										<a href="/ko/mypage/Editor01" class="img_info" target="_blank"><b>i</b><span>JIEUN</span></a><img
											src="http://img.earthtory.com/img/city_images/310/seoul_1425372852.jpg"
											alt="">
									</div>
								</div>
								<div class="owl-item" style="width: 624px; margin-right: 0px;">
									<div class="m_img">
										<a href="/ko/mypage/Editor01" class="img_info" target="_blank"><b>i</b><span>JIEUN</span></a><img
											src="http://img.earthtory.com/img/city_images/310/seoul_1425372928.jpg"
											alt="">
									</div>
								</div>
								<div class="owl-item" style="width: 624px; margin-right: 0px;">
									<div class="m_img">
										<a href="/ko/mypage/Editor01" class="img_info" target="_blank"><b>i</b><span>JIEUN</span></a><img
											src="http://img.earthtory.com/img/city_images/310/seoul_1425372992.jpg"
											alt="">
									</div>
								</div>
								<div class="owl-item active"
									style="width: 624px; margin-right: 0px;">
									<div class="m_img">
										<a href="/ko/mypage/Editor01" class="img_info" target="_blank"><b>i</b><span>JIEUN</span></a><img
											src="http://img.earthtory.com/img/city_images/310/seoul_1425373106.jpg"
											alt="">
									</div>
								</div>
								<div class="owl-item cloned"
									style="width: 624px; margin-right: 0px;">
									<div class="m_img">
										<a href="/ko/mypage/Editor01" class="img_info" target="_blank"><b>i</b><span>JIEUN</span></a><img
											src="http://img.earthtory.com/img/city_images/310/seoul_1425372763.jpg"
											alt="">
									</div>
								</div>
								<div class="owl-item cloned"
									style="width: 624px; margin-right: 0px;">
									<div class="m_img">
										<a href="/ko/mypage/Editor01" class="img_info" target="_blank"><b>i</b><span>JIEUN</span></a><img
											src="http://img.earthtory.com/img/city_images/310/seoul_1425372852.jpg"
											alt="">
									</div>
								</div>
							</div>
						</div>
						<div class="owl-controls">
							<div class="owl-nav">
								<div class="owl-prev" style="">
									<img src="/planner/resources/images/area/ar_img_nav_prev.png">
								</div>
								<div class="owl-next" style="">
									<img src="/planner/resources/images/area/ar_img_nav_next.png">
								</div>
							</div>
							<div class="owl-dots" style="">
								<div class="owl-dot">
									<span></span>
								</div>
								<div class="owl-dot">
									<span></span>
								</div>
								<div class="owl-dot">
									<span></span>
								</div>
								<div class="owl-dot">
									<span></span>
								</div>
								<div class="owl-dot active">
									<span></span>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="clear"></div>
			</div>
		</div>
	</div>

	<div class="area_bg line spot_list silver">
		<div class="wrap">
			<div class="area_title_center city_po"><c:out value="${name }" /> 인기장소</div>

			<div class="pospot_tab_box">
				<div class="pospot_tab on" data-cate="15">축제/공연</div>
				<div class="pospot_tab" data-cate="12">관광지</div>
				<div class="pospot_tab" data-cate="14">문화시설</div>
				<div class="pospot_tab" data-cate="32">숙박</div>
				<div class="pospot_tab" data-cate="38">쇼핑</div>
				<div class="pospot_tab last" data-cate="39">음식</div>
				<div class="pospot_tab_blank">&nbsp;</div>
				<div class="clear"></div>
			</div>

			<div class="pospot_content"></div>

			<!-- <a class="list_more spot_list" href="/ko/city/seoul_310/attraction">298개
				관광명소 모두보기</a> -->
		</div>
	</div>

	<c:import url="/footer.do"></c:import>
</body>
</html>