<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do" />
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="resources/js/common/search_script.js"></script>
<link href="resources/css/master.css" rel="stylesheet" />
<link href="resources/css/city/main.css" rel="stylesheet" />
<link href="resources/css/city/header_v2.css" rel="stylesheet" />
<link href="resources/css/area/area_home.css" rel="stylesheet" />
<style>
.search_area {
    float: none;
}
</style>
<meta charset="UTF-8">
<title>페스티벌 플래너</title>
<script>
var sidoName, sidoCode, sigunguName, sigunguCode;
var pageNo = 1;
var total = 0;
var curPage = 1;
var keyword = '${keyword}';
$(document).ready(function() {
	getSearchList(keyword, curPage);
});
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
					placeholder="축제명으로 검색"
					onkeypress="if( event.keyCode == 13 ){searchContent();}" />
				<script>
					function searchContent() {
						var keyword = $("#city_search").val();
						var form = $("<form>");
						form.attr("id", "searchContent");
						form.attr("method", "get");
						form.attr("action", "/planner/searchContent.do?"
								+ keyword);
						$("<input type='hidden'>").attr("name", "keyword").val(
								keyword).appendTo(form);
						form.appendTo($("#header"));
						form.submit();
					}
				</script>
				<div id="city_autocomplete"></div>
				<div class="latest_search">
					추천축제 : <a href="" class="latest_a">축제명</a>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>
	<div class="page white">
		<div class="list_bg">
			<div class="wrap">
				<div class="list_left">
					<div class="list_top" style="display: block;">
						<div class="list_cnt">총 0개</div>
					</div>
					<div class="list"></div>
					<div id="paging"></div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>
	<div class="page silver" style="padding-top: 30px;"></div>
	<c:import url="/footer.do" />
</body>
</html>