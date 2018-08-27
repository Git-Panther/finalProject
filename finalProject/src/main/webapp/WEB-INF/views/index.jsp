<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do"/>
<!DOCTYPE html>
<html>
<head>
<script>
var contenttypename = '15';
</script>
<link href="resources/css/master.css" rel="stylesheet" />
<link href="resources/css/city/main.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>페스티벌 플래너</title>
<script>
	var sidoName, sidoCode, sigunguName, sigunguCode;
</script>
</head>
<body>
	<div class="clear"></div>
	<div class="main_top"
		style="background: url('/planner/resources/images/key_bg_1.jpg') no-repeat; background-size: cover;">
		<div class="wrap">
			<div class="main_top_title">나만의 행사 플래너!</div>
			<div class="main_top_desc">쉽고 빠르게 축제를 찾아보세요.</div>
			<div class="search_area">
				<input class="search_input" id="city_search"
					placeholder="축제명, 도시명으로 검색">
				<div id="city_autocomplete"></div>
				<div class="latest_search">
					추천축제 : <a href="" class="latest_a">축제명</a>
					<!-- API 조회수를 조회해서 가장 높은 조회수를 가진 행사를 배치, 행사 상세정보로 이동-->
				</div>
				<!-- <a class="go_map" href="javascript:void(0)"
					onclick="et_full_modal('/ko/modal/world_map')">지도에서 검색 &gt;</a> -->
				<!-- 나중에 찾으면 활용 -->
				<div class="clear"></div>
			</div>
		</div>
	</div>
	<div class="page white">
		<div class="wrap">
			<div class="page_title">플래너에서 축제를 찾아보세요!</div>
			<div class="clear"></div>
			<div class="intro_list">
				<div class="intro_box" onclick="location.href='area.do';">
					<img src="/planner/resources/images/main/intro/intro_1.jpg" alt="">
					<div class="intro_title">여행정보</div>
					<div class="intro_desc">전국의 축제/행사, 관광명소, 호텔, 음식점 정보를 확인하세요.</div>
				</div>
				<div class="intro_box" onclick="location.href='festivalList.do';">
					<img src="/planner/resources/images/main/intro/intro_2.jpg" alt="">
					<div class="intro_title">축제일정</div>
					<div class="intro_desc">지금 하고있는 축제들을 확인하고 나만의 일정을 계획해 보세요.</div>
				</div>
				<div class="intro_box">
					<img src="/planner/resources/images/main/intro/intro_3.jpg" alt="">
					<div class="intro_title">커뮤니티</div>
					<div class="intro_desc">사람들과 정보를 공유하고, 궁금한 것은 언제든 물어보세요.</div>
				</div>
				<div class="clear"></div>
			</div>
			<a href="use.do" class="intro_link"> 사용방법이 궁금하신가요? </a>
		</div>
	</div>
	<div class="page silver" style="padding-top: 30px;">

	 	<div class="wrap">
			<div class="page_title">인기 축제 일정</div>
			<div class="page_desc">현재 진행 중인 인기있는 축제를 만나보세요!</div>
			<div class="pospot_content"></div>
		</div>
	</div>
	<c:import url="/footer.do"/>
</body>
</html>