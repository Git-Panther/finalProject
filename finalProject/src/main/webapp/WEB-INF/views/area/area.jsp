<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do" />
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="resources/js/common/component.js"></script>
<script type="text/javascript" src="resources/js/common/common_script.js"></script>
<link href="resources/css/area/area.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>페스티벌 플래너</title>
<script>

$(document).ready(function(){
	get_reco_city();
	get_city();

	$(document).on('click','.travel_city',function(){
		var _this_show = $(this).attr('data-show');
		var _this_code = $(this).attr('code');
		$('.travel_city').each(function(){
			if($(this).attr('data-show') != _this_show){
				$(this).removeClass('on');
				$('.city_arrow',this).attr('src',$('.city_arrow').attr('src').replace('_on.gif','.gif'));				
				$(this).attr('data-on','off');
				$('.travel_hide[data-id='+$(this).attr('data-show')+']').slideUp('fast');
			}
		});

		if($(this).attr('data-on') == 'off'){
			$(this).addClass('on');
			$('.city_arrow',this).attr('src',$('.city_arrow').attr('src').replace('.gif','_on.gif'));
			$(this).attr('data-on','on');
			$('.travel_hide[data-id='+$(this).attr('data-show')+']').slideDown();
		}else{
			$('.travel_city').removeClass('on');
			$('.city_arrow',this).attr('src',$('.city_arrow').attr('src').replace('_on.gif','.gif'));
			$(this).attr('data-on','off');
			$('.travel_hide[data-id='+$(this).attr('data-show')+']').slideUp();
		}
	});

	$('.po_city_area').click(function(){
		console.log('aaaaaaaaaaaaaaaaa');
		$('.po_city_area').removeClass('on');
		$(this).addClass('on');
		get_reco_city();
	});
});


function get_city() {
	console.log("get_city");
	$.ajax({
		type:'get',
		url:'areaList.do',
		dataType : 'json',
		success:function(data) {
			var object = data.response.body.items.item;
			_html = '';

			$.each(object ,function(index,item){
				console.log("index : ", index);
				console.log("item : ", item);
				if(index != 7) {
					if(index < 10) {
					_html += '<div class="travel_city" data-on="off" data-show="00' + index + '" code="' + item.code + '">';
					} else {
					_html += '<div class="travel_city" data-on="off" data-show="0' + index + '" code="' + item.code + '">';
					}
				_html += '<div>';
				_html += '<span>' + item.name + '</span> <img src="/planner/resources/images/area/area_arrow.gif" alt=""';
				_html += 'class="city_arrow">';
				_html += '<div class="clear"></div>';
				_html += '</div>';
				_html += '</div>';
				get_sigungu(index, item.code);
				}
				if(index == 8) {
					_html += '<div class="clear"></div>';
					$('.pa10').html(_html);
					_html = "";
										} 
					if(index == 16){
					_html += '<div class="clear"></div>';
					$('.pa20').html(_html);
											}
																});
								}
			});
	}
	
	function get_sigungu(id, areaCode) {
		console.log("get_sugungu");
		$.ajax({
			type :'get',
			url :'sigunguCount.do',
			data: {
				areaCode : areaCode
			},
			dataType : 'json',
			success : function(data) {
				var count = data.response.body.totalCount;
				$.ajax({
					type :'get',
					url :'sigunguList.do',
					data: {
						areaCode : areaCode,
						numOfSigungu : count
					},
					dataType : 'json',
					success : function(data) {
						var object = data.response.body.items.item;
						_html = "";
						if(id < 10) {
							_html +=	'<div class="travel_hide" data-id="00' + id + '" style="">';
							} else {
							_html +=	'<div class="travel_hide" data-id="0' + id + '" style="">';
							}
						$.each(object, function(index, item) {
							_html += '<a href="areaMain.do?name=' + object[index].name + '&sido=' + areaCode + '&sigungu=' + index + '" class="travel_ar"> ' + object[index].name + ' </a>';
							/* _html += '<a href="areaMain.do?sido=' + areaCode + '_' + id + '_' + index + '" class="travel_ar"> ' + object[index].name + ' </a>'; */
						});
							_html += '</div>';
							if(id < 9) {
								$('.pa10').after(_html);
							} else {
								$('.pa20').after(_html);
							}
					}
				});
			}
		});
	}

	function get_reco_city() {
		console.log('aaaa');
		_ct_code = $('.po_city_area.on').attr('data');
		console.log(_ct_code);
		$.ajax({
					type : 'POST',
					url : '/api/city/get_reco_city',
					data : {
						'ct_code' : _ct_code
					},
					success : function(data) {
						console.log('nnnnnn');
						console.log(data);
						_html = '';

						$.each(data.response_data,
										function(key, val) {
											_html += '<a href="/ko/city/'+val.ci_name_url+'" class="po_city"><div class="po_city_name">'
													+ val.ci_name + '</div>';
											_html += '<img src="'
													+ val.ci_image
													+ '" alt="" <a href="/ko/city/</a>';
										});

						_html += '<div class="clear"></div>';

						$('.po_city_box').html(_html);
					}
				});
	}
</script>
</head>
<body>
	<div class="clear"></div>
	<div class="area_top">
		<div class="wrap">
			<div class="area_top_title">어디로 행사를 가시나요?</div>

			<div class="search_area">
				<input class="search_input" id="city_search" placeholder="지역명으로 검색">
				<div id="city_autocomplete"></div>
				<div class="latest_search">
					추천도시 : <a href="http://www.earthtory.com/city/jeju_312"
						class="latest_a">제주도</a>
				</div>
				<a class="go_map" href="javascript:void(0)"
					onclick="et_full_modal('/modal/world_map')">지도에서 검색 ></a>
				<div class="clear"></div>
			</div>
		</div>
	</div>

<div class="area_silver">
	<div class="wrap">
		<div class="area_title">
			국내 여행지		</div>
		<div class="travel_box">
			<!-- <div class="travel_section">
				<div class="travel_left">
					주요도시				</div>
				<div class="clear"></div>
			</div> -->
			<div class="travel_section pa10">
				<div class="clear"></div>
			</div>
			<div class="travel_section pa20">
				<div class="clear"></div>
			</div>
		</div>
	</div>
</div>
	<div class="area_white">
		<div class="wrap">
			<div class="area_title">국내 인기 여행지</div>
			<div class="po_city_tab">
				<div class="po_city_area on" data="all">추천</div>
				<div class="po_line">&nbsp;</div>
				<div class="po_city_area" data="as">서울</div>
				<div class="po_line">&nbsp;</div>
				<div class="po_city_area" data="eu">춘천</div>
				<div class="po_line">&nbsp;</div>
				<div class="po_city_area" data="oc">강릉</div>
				<div class="po_line">&nbsp;</div>
				<div class="po_city_area" data="na">대전</div>
				<div class="po_line">&nbsp;</div>
				<div class="po_city_area" data="sa">부산</div>
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
			<div class="po_city_box">
				<a href="/ko/city/prague_196" class="po_city"><div
						class="po_city_name">춘천</div> <img
					src="/planner/resources/images/city/춘천.jpg" alt=""
					class="po_city_img"></a> <a href="/ko/city/toronto_10488"
					class="po_city"><div class="po_city_name">단양</div> <img
					src="/planner/resources/images/city/단양.jpg" alt=""
					class="po_city_img"></a><a href="/ko/city/saipan_10025"
					class="po_city"><div class="po_city_name">정선</div> <img
					src="/planner/resources/images/city/정선.jpg" alt=""
					class="po_city_img"></a><a href="/ko/city/melbourne_10003"
					class="po_city"><div class="po_city_name">통영</div> <img
					src="/planner/resources/images/city/통영.jpg" alt=""
					class="po_city_img"></a><a href="/ko/city/hong-kong_245"
					class="po_city"><div class="po_city_name">여수</div> <img
					src="/planner/resources/images/city/여수.jpg" alt=""
					class="po_city_img"></a><a href="/ko/city/jeju_312"
					class="po_city"><div class="po_city_name">전주</div> <img
					src="/planner/resources/images/city/전주.jpg" alt=""
					class="po_city_img"></a><a href="/ko/city/vancouver_10484"
					class="po_city"><div class="po_city_name">정동진</div> <img
					src="/planner/resources/images/city/정동진.jpg" alt=""
					class="po_city_img"></a><a href="/ko/city/istanbul_202"
					class="po_city"><div class="po_city_name">담양</div> <img
					src="/planner/resources/images/city/담양.jpg" alt=""
					class="po_city_img"></a>
				<div class="clear"></div>
			</div>
		</div>
	</div>

	<c:import url="/footer.do"></c:import>
</body>
</html>