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
<script type="text/javascript" src="resources/js/area/area_common.js"></script>
<script type="text/javascript"
	src="resources/js/area/area_main.js?ber=1"></script>

<link href="resources/css/area/area_main.css" rel="stylesheet" />
<link href="resources/css/city/main.css" rel="stylesheet" />
<link href="resources/css/city/header_v2.css" rel="stylesheet" />
<link rel="stylesheet"
	href="resources/js/owl_carousel/owl.carousel2.css">
<script type="text/javascript"
	src="resources/js/owl_carousel/owl.carousel2.js"></script>
<script type="text/javascript" src="resources/js/web/jui/jquery-ui.js"></script>
<script>
var sidoCode = '${sidoCode}';
var sigunguCode = '${sigunguCode}';
var contenttypeid = '${contenttypeid}';
var arrange = "B";
var pageNo = 1;
var total = 0;
var curPage = 1;
	$(document).ready(function() {
		popList(15);
	});
</script>
<meta charset="UTF-8">
<title>페스티벌 플래너</title>
</head>
<body>
	<div class="area_bg top silver">

		<div class="wrap">
		<c:import url="/area_header.do" />

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
			<div class="area_title_center city_po">
				<c:out value="${name }" />
				인기장소
			</div>

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