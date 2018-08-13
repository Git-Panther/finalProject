<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="ht_top">
	<div class="wrap">
		<div class="ht_title">
			전국 (api조회)개 이상의 다양한 호텔		</div>
		<div class="ht_desc">
			최고급 호텔부터 아파트, 게스트 하우스까지 다양한 숙박시설을 검색해 보세요!		</div>
		<div class="ht_search_box">
			<input type="text" placeholder="도시명으로 검색" class="ht_search">
			<!-- <input type="text" class="start_date hasDatepicker" value="2018-08-09" id="dp1533143953757">
			<input type="text" class="end_date hasDatepicker" value="2018-08-10" id="dp1533143953758"> -->
			<input type="button" class="ht_submit" value="검색">
			<div class="clear"></div>
		</div>
	</div>
</div>
<div class="ht_center">
	<div class="wrap">
		<div class="cbox">
			<img src="/res/img/main/hotel/cimg1.gif" alt="" class="cimg">
			<div class="cleft">
				<div class="ctitle">
					저렴한 요금				</div>
				<div class="cdesc">
					별도의 예약수수료가 없으며,<br>제휴사와 동일한 가격을 보장합니다.				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div class="cbox">
			<img src="/res/img/main/hotel/cimg2.gif" alt="" class="cimg">
			<div class="cleft">
				<div class="ctitle">
					무료취소				</div>
				<div class="cdesc">
					정해진 기간내에<br>취소 및 변경이 가능합니다.				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div class="cbox">
			<img src="/res/img/main/hotel/cimg3.gif" alt="" class="cimg">
			<div class="cleft">
				<div class="ctitle">
					검증된 이용후기				</div>
				<div class="cdesc">
					5000만개의 검증된 이용 후기를<br>보고 최적의 호텔을 선택하세요.				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
	</div>
</div>
<div class="ht_footer">
	<div class="wrap">
		<div class="htf_title">
			인기도시		</div>
				<a href="/ko/city/jeju_312/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				제주도			</div>
			<img src="http://img.earthtory.com/img/city_images/312/jeju_1425527554.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/bangkok_86/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				방콕			</div>
			<img src="http://img.earthtory.com/img/city_images/86/bangkok_1425369498.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/singapore_243/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				싱가포르			</div>
			<img src="http://img.earthtory.com/img/city_images/243/singapore_1425521353.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/taipei_92/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				타이베이			</div>
			<img src="http://img.earthtory.com/img/city_images/92/taipei_1425530181.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/hong-kong_245/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				홍콩			</div>
			<img src="http://img.earthtory.com/img/city_images/245/hong-kong_1425535264.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/fukuoka_286/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				후쿠오카			</div>
			<img src="http://img.earthtory.com/img/city_images/286/fukuoka_1425865076.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/rome_185/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				로마			</div>
			<img src="http://img.earthtory.com/img/city_images/185/rome_1426825405.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/london_309/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				런던			</div>
			<img src="http://img.earthtory.com/img/city_images/309/london_1427340547.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/barcelona_10005/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				바르셀로나			</div>
			<img src="http://img.earthtory.com/img/city_images/10005/barcelona_1426832359.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/paris_307/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				파리			</div>
			<img src="http://img.earthtory.com/img/city_images/307/paris_1426774110.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/sydney_313/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				시드니			</div>
			<img src="http://img.earthtory.com/img/city_images/313/sydney_1426838423.jpg" alt="" class="ht_city_img">
		</a>
				<a href="/ko/city/san-francisco_10020/hotel#1" class="ht_city_box">
			<img src="/res/img/main/hotel/htview.png" alt="" class="htview">
			<div class="ht_city_name">
				샌프란시스코			</div>
			<img src="http://img.earthtory.com/img/city_images/10020/san-francisco_1426836440.jpg" alt="" class="ht_city_img">
		</a>
				<div class="clear"></div>
	</div>
</div>
</body>
</html>