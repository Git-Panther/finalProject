function moveHotelList(pageNo) {
	curPage = pageNo;
	pageNo = pageNo;
	getHotelList(sidoCode, sigunguCode, arrange, pageNo, curPage);
}

function getHotelList(sidoCode, sigunguCode, arrange, pageNo, curPage) {
	$(function() {
		  $.ajax({
			url : 'hotelList.do',
			type : 'get',
			data : {
				sidoCode : sidoCode,
				sigunguCode : sigunguCode,
				arrange : arrange,
				pageNo : pageNo
			}, //contentid, contentTypeid 서버로 전송
			dataType : 'json',
			success : function(data) {
				console.log(data);
				console.log(data.response.body.totalCount);
				console.log(data.response.body.items.item);
				var item = data.response.body.items.item; //이 경로 내부에 데이터가 들어있음
				total = data.response.body.totalCount;
				var output = '';
				
				$(".list_cnt").html("총 " + total + "개의 호텔");

				for (var i = 0; i < item.length; i++) {
					/*arrPos[i] = {lat : item[i].mapx,
							lng : item[i].mapy};
					console.log("arrPos : " + arrPos);
					console.log("mapx : " + item[i].mapx);
					console.log("arrPos[i].lat : " + arrPos[i].lat);*/
					if(item[i].firstimage2 == undefined) {
						item[i].firstimage2 = "/planner/resources/images/common/no_img/hotel55.png";
					}
					output += '<div class="box" id="' + item[i].contentid + '">';
					output += '<img ';
					output += 'src="' + item[i].firstimage2 + '"';
					output += 'alt="" class="ht_img"';
					output += 'onclick="go_link(' + item[i].contentid + ",'localhost:8081/planner/hotelDetail.do?contentid=" + item[i].contentid + ');"' + '"';
					output += 'onerror="this.src=' + "'/planner/resources/images/common/no_img/hotel.png';" + '"';
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
					output += 'href="javascript:go_link(' + item[i].contentid + ",'localhost:8081/planner/hotelDetail.do?contentId=" + item[i].contentId + "');" + '"';
					output += 'class="ht_title">' + item[i].title + '</a>';
					output += '<div class="ht_info">';
					output += '<img src="/planner/resources/images/common/web/hotel_star_' + 4.5 + '.png" alt=""';
					output += 'class="ht_rate_img">';
					output += '<div class="ht_line"></div>';
					output += '<div class="ht_rate">';
					output += '<span>' + "[평점]" + '</span>' + "[평점]";
					output += '</div>';
					output += '<a class="ht_review"';
					output += 'href="javascript:go_link(' + item[i].contentId + ",'" + "[리뷰보기]" + "');" + '">이용후기';
					output += '보기</a>';
					output += '<div class="clear"></div>';
					output += '</div>';
					output += '<div class="ht_addr">';
					output += item[i].addr1 + " " +  item[i].addr2 + '<a class="map_link"';
					output += 'href="javascript:et_modal(' + "'1144px','816px','1','0','/ko/modal/spot_map?srl=" + item[i].contentId + "&amp;type=2','2','1');" + '">지도보기</a>';
					output += '</div>';
					output += '<div class="ht_count	">';
					output += '조회수 : ' + item[i].readcount + '건';
					output += '</div>';	
					output += '<div class="ht_bottom">';
					output += '<a class="ht_view"';
					output += 'href="javascript:go_link(' + item[i].contentid + ",localhost:8081/planner/hotelDetail.do?contentid=" + item[i].contentid + 
							');">자세히보기</a>';
							output += '</div>';
							output += '</div>';
							output += '<div class="clear"></div>';
							output += '</div>';
				}

				$(".list").html(output);
				makePaging(total, curPage);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("Status: " + textStatus);
				alert("Error: " + errorThrown);
			}
		});  
	}); 
}

// 페이징 생성
function makePaging(total, curPage){
	console.log(total+'/'+curPage)
	$('html, body').scrollTop(0);
	
	// 페이지당 리스트출력수
	var viewPage = 10;
	var movePage = viewPage-1;
	var perPage = 2;
	// 전체 페이지
	var totalPage =  Math.ceil(total/perPage);
	var startPage = (Math.floor((curPage-1)/viewPage))*viewPage+1;
	var endpage = (startPage+movePage < totalPage)? startPage+movePage: totalPage;


	// 페이징 생성
	var paging ='<span class="nv">';
	if(curPage > 1){
		paging += '<button type="button" class="pgn-pv1" onclick="moveHotelList'+'(1)">처음으로</button>';
	}
	if(startPage > viewPage && curPage > 1){
		paging += '<button type="button" class="pgn-pv2" onclick="moveHotelList'+'('(startPage-viewPage)+')">이전</button>';
	}

	paging += '</span>';
	for(var i=startPage ; i<= endpage; i++){
		if(curPage == i){
		  paging += '<button type="button" class="on" onclick="moveHotelList'+'(' + i+')">'+i+'</button>';
		}else{
		  paging += '<button type="button" onclick="moveHotelList(' + i +')">'+ i +'</button>';
		}
	}

	paging += '<span class="nv">';
	if((startPage+movePage) < totalPage && curPage < totalPage){
		paging += '<button type="button" class="pgn-nx2" onclick="moveHotelList'+'(' + (startPage+viewPage)+')">다음</button>';
	}

	if(curPage < totalPage){
		paging += '<button type="button" class="pgn-nx1" onclick="moveHotelList'+'(' + totalPage+')">맨뒤로</button>';
	}

	paging += '</span>';
		$('#paging').html(paging);
}
