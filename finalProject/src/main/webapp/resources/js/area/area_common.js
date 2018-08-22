$(document).ready(	function() {
			var festival = 15;
			var attraction = 12;
			var culture = 14;
			var hotel = 32;
			var shopping = 38;
			var restaurant = 39;

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

function moveAreaMain(sidoName, sidoCode){ //함수 오버로딩
	var form = $("<form>");
	form.attr("id", "areaMain");
	form.attr("method", "post");
	form.attr("action", "/planner/areaMain.do");
	
	$("<input type='hidden'>").attr("name", "sidoName").val(sidoName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sidoCode").val(sidoCode).appendTo(form);
	form.appendTo($("#header"));
	form.submit();
}

function moveAreaMain(sidoName, sidoCode, sigunguName, sigunguCode){ //함수 오버로딩
	var form = $("<form>");
	form.attr("id", "areaMain");
	form.attr("method", "post");
	form.attr("action", "/planner/areaMain.do");
	
	$("<input type='hidden'>").attr("name", "sidoName").val(sidoName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sidoCode").val(sidoCode).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguName").val(sigunguName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguCode").val(sigunguCode).appendTo(form);
	form.appendTo($("#header"));
	form.submit();
}




