<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Area</title>
<link href="resources/css/festival.css" rel="stylesheet">
<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<div class="outer">
	<form id="searchArea" method="post">
		<!-- <div id="typeList"></div><br> -->
		<!-- <div id="serviceList"></div><br> -->
		<div class="searchRow">
			<div id="areaList"></div>
			<div id="sigunguList"></div>
		</div>
		<br>
		<div class="searchRow">
			<div id="resultAmount"></div>
			<div id="arrangeList">
				<select id="arrange" name="arrange">
					<option value="D">작성일</option>
					<option value="C">수정일</option>
					<option value="B">조회수</option>
				</select>
			</div>
		</div>
	</form>		
</div>
</body>
</html>