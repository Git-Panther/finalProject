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
<script type="text/javascript" src="resources/js/area/area_main.js"></script>
<link href="resources/css/area/area_main.css" rel="stylesheet" />
<link href="resources/css/city/main.css" rel="stylesheet" />
<link href="resources/css/city/header_v2.css" rel="stylesheet" />
<link rel="stylesheet"
	href="resources/js/owl_carousel/owl.carousel2.css">
<script type="text/javascript"
	src="resources/js/owl_carousel/owl.carousel2.js"></script>
<script type="text/javascript" src="resources/js/web/jui/jquery-ui.js"></script>
<script>
var sidoCode = ${sidoCode};
var sidoName = '${sidoName}';
var sigunguCode = ${sigunguCode};
var sigunguName = '${sigunguName}';
	
$(document).ready(function() {
	popList(15);
});
/*
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
			var items = data.response.body.items;
			var object = data.response.body.items.item;
			console.log(object);
			_html = "";
			if(data.response.body.totalCount == 1){
				object = items;
			} else if(data.response.body.totalCount == 0) {
				_html = "<h2>조회 결과가 없습니다.</h2>";
			}
			$.each(object, function(index, item) {
				_html += '<a class="pospot"';
				_html += 'href="javascript:moveContent(' +	"'" 
				+ sidoName + "'," + sidoCode + ", '" 
				+ sigunguName + "', " + sigunguCode + ", '" 
				+ object[index].contenttypeid + "', " + object[index].contentid + ", '" + object[index].title;		
				if(15 === object[index].contenttypeid){// 축제이면 날짜도 같이 보내버린다.
					_html += ', ' + object[index].eventstartdate 
							+ ', ' + object[index].eventenddate;
				}
				
				_html += "')" + '"';
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
*/
/*
function moveContent(sidoName, sidoCode, sigunguName, sigunguCode, contenttypeid, contentid, title){ //area
	<c:url var="contents" value="/contentDetail.do"></c:url>
	var form = $("<form>");
	var contenttypename = '-1';
	
	switch(contenttypeid) {
	case 15 :
		contenttypename = '축제/행사';
		break;
	case 12 :
		contenttypename = '관광지';
		break;
	case 14 :
		contenttypename = '문화시설';
		break;
	case 32 :
		contenttypename = '숙박';
		break;
	case 38 :
		contenttypename = '쇼핑';
		break;
	case 39 :
		contenttypename = '음식';
	}
	
	form.attr("id", "contentDetail");
	form.attr("method", "post");
	form.attr("action", "${contents}");
	
	$("<input type='hidden'>").attr("name", "sidoName").val(sidoName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sidoCode").val(sidoCode).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguName").val(sigunguName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguCode").val(sigunguCode).appendTo(form);
	$("<input type='hidden'>").attr("name", "contenttypeid").val(contenttypeid).appendTo(form);
	$("<input type='hidden'>").attr("name", "contenttypename").val(contenttypename).appendTo(form);
	$("<input type='hidden'>").attr("name", "contentid").val(contentid).appendTo(form);
	$("<input type='hidden'>").attr("name", "title").val(title).appendTo(form);
	
	form.appendTo($("#header"));
	form.submit();
}
*/
</script>
<meta charset="UTF-8">
<title>페스티벌 플래너</title>
</head>
<body>
	<div class="area_bg top silver">

		<div class="wrap">

			<div class="area_nav">
				<a href="area.do" class="nav_btn">여행지</a>
				<c:choose>
					<c:when test="${sidoName ne '-1'}"> &gt; 
					<a href="javascript:moveAreaMain('<c:out value="${sidoName }" />', '<c:out value="${sidoCode }" />')" class="nav_btn">${sidoName }</a>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${sigunguName ne '-1'}"> &gt; 
					<a href="javascript:moveAreaMain('${sidoName}', ${sidoCode}, '${sigunguName }', ${sigunguCode })" class="nav_btn">${sigunguName}</a>
					</c:when>
				</c:choose>
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