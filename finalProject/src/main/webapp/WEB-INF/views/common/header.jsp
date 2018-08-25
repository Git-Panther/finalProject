<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/common/common_festival.js"></script>
<link href="resources/css/header.css" rel="stylesheet" />
<meta charset="UTF-8">
<style>
.gnb_mn_drop a{
	line-height:300%;
	text-decoration:none;
	color:grey;
	padding-left:15px;
}
.header_profile{
	height:37px;
	width:37px;
	border-radius:50%;
}

.header_profile img{
	max-height:37px;
	max-width:37px;
	height:37px;
	width:auto;
	align:center;
	vertical-align:middle;
	margin-top:12px;
	margin-left:10px;
	border-radius:50%;
	cursor:pointer;
}
.gnb_mn_drop{
	width:138px;
	height:auto;
	background:white;
	color:grey;
	font-size:13px;
	border:1px grey solid;
}
</style>
<title>Header</title>
<script>

function joinPage(){
	location.href="joinPage.do";
}
function loginPage(){
	location.href="loginPage.do";
}
function logout(){
	location.href="logout.do";
}
$(function(){
	$(".header_profile").hover(function(){
	    $(".gnb_mn_drop").css("display", "block");
	}, function(){
	$(".gnb_mn_drop").css("display", "none");
	});
})
</script>
</head>
<body>
	<div id="header">
		<div class="wrap">
			<h1 class="logo fl" alt="행사의 시작! 플래너">
				<a href="/planner/index.do"><img
					src="/planner/resources/images/common/gnb/logo.jpg" alt="행사의 시작! 플래너" style="width: 200px;"></a>
			</h1>
			<ul class="gnb fl">
				<c:url var="festivalList" value="/festivalList.do"></c:url>
				<a href="${festivalList}" class="fl"><li>축제/행사</li></a>
				<c:url var="area" value="/area.do"></c:url>
				<a href="${area}" class="fl"><li>여행지</li></a>
				<a href="/planner/plan.do" value="" class="fl"><li>일정만들기</li></a>
				<a href="/hotel.do" class="fl"><li>호텔</li></a>
				<a href="use.do" class="fl"><li>이용방법</li></a>
<!-- 				<a href="/adminMain.do" class="fl"><li>a</li></a> -->
			</ul>

			<div class="fr gnb_box">
				<div class="fl gnb_search_box">
					<input type="text" id="gnb_search" placeholder="축제/도시를 찾아보세요.">
					<div class="gnb_search_btn" style="display: none;"></div>
				</div>
				<div id="gnb_search_autocomplete"></div>
				<c:if test="${empty sessionScope.user}">
					<a href="javascript:void(0)" class="fr" onclick="joinPage();">
						<div class="fl gnb_join_btn">회원가입</div></a>
					<a href="javascript:void(0)" class="fr" onclick="loginPage();">
						<div class="fl gnb_login_btn">로그인</div></a>
					<a href="javascript:void(0);" class="fr" style="display: none;"> </a>
					<div class="clear"></div>
				</c:if>
				<c:if test="${!empty sessionScope.user}">
					<div class="header_profile fr"><img src="resources/upload/${user.getProfilePic()}"/>
						<div class="gnb_mn_drop" style="display:none;">
							<a href="" class="item">찜 목록</a><br/>
							<a href="" class="item">내 일정</a><br/>
							<a href="" class="item">리뷰</a><br/>
							<c:if test="${user.userNo eq 1}">
								<a href="adminMain.do" class="item">관리자 페이지</a><br/>
							</c:if>
							<a href="/planner/memberInfo.do" class="item">내 정보</a><br/>
							<a href="/planner/logout.do" class="item">로그아웃</a>
						</div>
					</div>
					<div class="clear"></div>
				</c:if>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="clear"></div>
</body>
</html>