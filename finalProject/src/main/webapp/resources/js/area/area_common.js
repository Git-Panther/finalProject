$(document).ready(	function() {

	$(document).on('click', '.pospot_tab', function() {
		var _this_cate = $(this).attr('data-cate');
		
		if($(this).attr('class') == 'pospot_tab on') {
			console.log("class가 on이므로 데이터를 받아오지 않음");	
		} else {
			console.log("class가 off이므로 데이터를 받아옴");
			$('.pospot_tab').removeClass('on');
			$(this).addClass('on');
			popList(sidoCode, sigunguCode, _this_cate);
		}
	});
});

function popList(sidoCode, sigunguCode, contenttypeid) {
	console.log("popList::sidoCode: ", sidoCode);
	console.log("popList::sigunguCode: ", sigunguCode);
	console.log("popList::contenttypeid: ", contenttypeid);
	$.ajax({
				type : 'post',
				url : 'popList.do',
				dataType : 'json',
				data : {
					sidoCode: sidoCode,
					sigunguCode: sigunguCode, 
					contenttypeid: contenttypeid
				},
				success : function(data) {
					var items = data.response.body.items;
					var object = data.response.body.items.item;
					_html = "";
					if (data.response.body.totalCount == 1) {
						object = items;
					} else if (data.response.body.totalCount == 0) {
						_html = "<h2>조회 결과가 없습니다.</h2>";
					} else {
						$
								.each(
										object,
										function(index, item) {
											_html += '<a class="pospot"';
											if (15 === object[index].contenttypeid) {// 링크는 축제 한정으로 옮긴다..
												_html += 'href="javascript:festivalDetail('
														+ object[index].contentid
														+ ', '
														+ object[index].eventstartdate
														+ ', '
														+ object[index].eventenddate
														+ ', '
														+ "'.wrap'"
														+ ');"';
											} else {
												_html += 'href="javascript:moveContent('
														+ object[index].contenttypeid
														+ ", "
														+ object[index].contentid
														+ ", '"
														+ object[index].title
														+ "')" + '"';
											}
											if (index == 3 || index == 7) {
												_html += 'target="_blank" style="margin-right:0px;"><div class="po_img_box">';
											} else {
												_html += 'target="_blank"><div class="po_img_box">';
											}
											_html += '<img ';
											if (object[index].firstimage == undefined) {
												_html += 'src="/planner/resources/images/common/no_img/sight55.png"';
											} else {
												_html += 'src="'
														+ object[index].firstimage
														+ '"';
											}
											_html += 'alt="" class="po_img">';
											_html += '</div>';
											_html += '<div class="po_name">'
													+ object[index].title
													+ '</div>';
											_html += '<div class="po_bottom">';
											_html += '<img src="/planner/resources/images/city/clip_icon.png" alt="" class="po_clip">';
											_html += '<div class="po_cnt">'
													+ object[index].readcount
													+ '</div>';
											_html += '<div class="po_tag">유명한거리/지역</div>';
											_html += '</div></a>';

										});
					}
					$(".pospot_content").html(_html);
					$(".pospot_content")
							.append('<div class="clear"></div>');
				}
			});
};


function moveAreaMain(sidoName, sidoCode){ // 함수 오버로딩
	var form = $("<form>");
	form.attr("id", "areaMain");
	form.attr("method", "post");
	form.attr("action", "/planner/areaMenu.do");
	
	$("<input type='hidden'>").attr("name", "sidoName").val(sidoName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sidoCode").val(sidoCode).appendTo(form);
	form.appendTo($("#header"));
	form.submit();
}

function moveAreaMain(sidoName, sidoCode, sigunguName, sigunguCode){ // 함수
																		// 오버로딩
	var form = $("<form>");
	form.attr("id", "areaMain");
	form.attr("method", "post");
	form.attr("action", "/planner/areaMenu.do");
	
	$("<input type='hidden'>").attr("name", "sidoName").val(sidoName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sidoCode").val(sidoCode).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguName").val(sigunguName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguCode").val(sigunguCode).appendTo(form);
	form.appendTo($("#header"));
	form.submit();
}

function moveContent(sidoName, sidoCode, 
		sigunguName, sigunguCode, 
		contenttypeid, contentid, title, eventstartdate, eventenddate){
	var form = $("<form>");
	var contenttypename = '-1';
	
	form.attr("id", "contentDetail");
	form.attr("method", "post");
	form.attr("action", "/planner/contentDetail.do");
	
	switch(contenttypeid) {
	case 15 :
		contenttypename = '축제/행사';
		$("<input type='hidden'>").attr("name", "eventstartdate").val(eventstartdate).appendTo(form);
		$("<input type='hidden'>").attr("name", "eventenddate").val(eventenddate).appendTo(form);
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

function areaMenu(menu) {
	var form = $("<form>");
	form.attr("id", "areaMenu");
	form.attr("method", "post");
	form.attr("action", "/planner/areaMenu.do");
	
	$("<input type='hidden'>").attr("name", "sidoName").val(sidoName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sidoCode").val(sidoCode).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguName").val(sigunguName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguCode").val(sigunguCode).appendTo(form);
	$("<input type='hidden'>").attr("name", "contenttypeid").val(contenttypeid).appendTo(form);
	$("<input type='hidden'>").attr("name", "menu").val(menu).appendTo(form);
	
	form.appendTo($("#header"));
	form.submit();
}


function getList(sidoCode, sigunguCode, contenttypeid, arrange, pageNo, curPage) {
	$(function() {
		  $.ajax({
			url : 'getList.do',
			type : 'get',
			data : {
				sidoCode : sidoCode,
				sigunguCode : sigunguCode,
				contenttypeid : contenttypeid,
				arrange : arrange,
				pageNo : pageNo
			}, //contentid, contentTypeid 서버로 전송
			dataType : 'json',
			success : function(data) {
				console.log("getList::contenttypeid: ", contenttypeid);
				console.log("getList::totalCount: ", data.response.body.totalCount);
				console.log("getList::item: ", data.response.body.items.item);
				total = data.response.body.totalCount;
				if(total != 1) {
					var item = data.response.body.items.item; //이 경로 내부에 데이터가 들어있음
				} else {
					var item = data.response.body.items;
				}
				var output = '';
				
				$(".list_cnt").html("총 " + total + "개");

				for (var i = 0; i < (item.length); i++) {
					if(item[i].firstimage == undefined) {
						item[i].firstimage = "/planner/resources/images/common/no_img/hotel55.png";
					}
					output += '<div class="box" id="' + item[i].contentid + '">';
					output += '<img ';
					output += 'src="' + item[i].firstimage + '"';
					output += 'alt="" class="ht_img"';
					output += 'onclick="javascript:moveContent(' + item[i].contenttypeid + ", " + item[i].contenttypeid + ",'" + item[i].title + "') " + '" ';
					output += 'data-srl="' + item[i].contentid + '">';
					output += '<div class="box_right">';
					output += '<div class="btn_clip" data-yn="n" data-srl="' + item[i].contentid + '"'; 
					output += 'onclick="set_clip(' + item[i].contentid + ",'0','btn_clip','2');" + '">';
					output += '<img src="/planner/resources/images/city/spot_list/clip_ico.png" alt="">';
					output += '</div>';
					output += '<div class="btn_addplan"'; 
					output += 'onclick="et_modal(' + "'365px','380px','1','0','/ko/member','2','1')" + '">';
					output += '<img src="/planner/resources/images/city/spot_list/addplan_ico.png" alt="">';
					output += '</div>';
					output += '<a ';
					output += 'href="javascript:moveContent(' + item[i].contenttypeid + ", " + item[i].contenttypeid + ",'" + item[i].title + "') " + '"';
					output += 'class="ht_title">' + item[i].title + '</a>';
					output += '<div class="ht_info">';
					output += '&nbsp;' + '<span>0개의 리뷰가 있습니다.</span>';
					output += '<div class="clear"></div>';
					output += '</div>';
					output += '<div class="ht_addr">';
					output += item[i].addr1 + " " + item[i].addr2 + '<a class="map_link"';
					output += 'href="javascript:et_modal(' + "'1144px','816px','1','0','/ko/modal/spot_map?srl=" + item[i].contentId + "&amp;type=2','2','1');" + '">지도보기</a>';
					output += '</div>';
					output += '<div class="ht_count	">';
					output += '조회수 : ' + item[i].readcount + '건';
					output += '</div>';	
					output += '<div class="ht_bottom">';
					output += '<a class="ht_view"';
					output += 'href="javascript:moveContent('
							+ item[i].contenttypeid + ", "
							+ item[i].contenttypeid + ",'"
							+ item[i].title + "') " + '"'
							+ '>자세히보기</a>';
							output += '</div>';
							output += '</div>';
							output += '<div class="clear"></div>';
							output += '</div>';
				}

				$(".list").html(output);
				makePaging(total, curPage);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("Error: " + "목록 불러오기를 실패했습니다.");
			}
		});  
	}); 
}

function moveListPage(pageNo) {
	curPage = pageNo;
	pageNo = pageNo;
	getList(sidoCode, sigunguCode, contenttypeid, arrange, pageNo, curPage);
}

// 페이징 생성
function makePaging(total, curPage){
	console.log(total+'/'+curPage)
	$('html, body').scrollTop(0);
	
	// 페이지당 리스트출력수
	var viewPage = 10;
	var movePage = viewPage-1;
	var perPage = 15;
	// 전체 페이지
	var totalPage =  Math.ceil(total/perPage);
	var startPage = (Math.floor((curPage-1)/viewPage))*viewPage+1;
	var endpage = (startPage+movePage < totalPage)? startPage+movePage: totalPage;


	// 페이징 생성
	var paging ='<span class="nv">';
	if(curPage > 1){
		paging += '<button type="button" class="pgn-pv1" onclick="moveListPage' + '(1)">처음으로</button>';
	}
	if(startPage > viewPage && curPage > 1){
		paging += '<button type="button" class="pgn-pv2" onclick="moveListPage' + '(' + (startPage-viewPage) + ')">이전</button>';
	}

	paging += '</span>';
	for(var i=startPage ; i<= endpage; i++){
		if(curPage == i){
		  paging += '<button type="button" class="on" onclick="moveListPage'+'(' + i+')">'+i+'</button>';
		}else{
		  paging += '<button type="button" onclick="moveListPage(' + i +')">'+ i +'</button>';
		}
	}

	paging += '<span class="nv">';
	if((startPage+movePage) < totalPage && curPage < totalPage){
		paging += '<button type="button" class="pgn-nx2" onclick="moveListPage'+'(' + (startPage+viewPage)+')">다음</button>';
	}

	if(curPage < totalPage){
		paging += '<button type="button" class="pgn-nx1" onclick="moveListPage'+'(' + totalPage+')">맨뒤로</button>';
	}

	paging += '</span>';
		$('#paging').html(paging);
}
