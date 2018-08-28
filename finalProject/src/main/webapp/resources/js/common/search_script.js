function getSearchList(keyword, curPage) {
	
	$.ajax({
		type : 'post',
		url: "searchList.do",
		dataType : "json",
		data: {
			keyword : keyword,
			curPage : curPage
		},
		success: function(data) {
	
	console.log("data: ", data);
	total = data.response.body.totalCount;
	console.log("total: ", total);
	var object = data.response.body.items.item; // 이 경로 내부에 데이터가 들어있음
	console.log("object: ", object);

	var output = '';

	$(".list_cnt").html("총 " + total + "개");
	if (total < 2) {
		$(".list_cnt").html("총 " + "0" + "개");
		output += "조회 결과가 없습니다."
	} else {
		$.each(object,
						function(index, item) {
							if (object[index].firstimage == undefined) {
								object[index].firstimage = "/planner/resources/images/common/no_img/hotel55.png";
							}
							output += '<div class="box" id="'
									+ object[index].contentid + '">';
							output += '<img ';
							output += 'src="' + object[index].firstimage + '"';
							output += 'alt="" class="ht_img"';
							output += 'onclick="javascript:moveContent('
									+ object[index].contenttypeid + ", "
									+ object[index].contentid + ",'"
									+ object[index].title + "') " + '" ';
							output += 'data-srl="' + object[index].contentid
									+ '">';
							output += '<div class="box_right">';
							output += '<div class="btn_clip" data-yn="n" data-srl="'
									+ object[index].contentid + '"';
							output += 'onclick="set_clip('
									+ object[index].contentid
									+ ",'0','btn_clip','2');" + '">';
							output += '<img src="/planner/resources/images/city/spot_list/clip_ico.png" alt="">';
							output += '</div>';
							output += '<div class="btn_addplan"';
							output += 'onclick="et_modal('
									+ "'365px','380px','1','0','/ko/member','2','1')"
									+ '">';
							output += '<img src="/planner/resources/images/city/spot_list/addplan_ico.png" alt="">';
							output += '</div>';
							output += '<a ';
							output += 'href="javascript:moveContent('
									+ object[index].contenttypeid + ", "
									+ object[index].contentid + ",'"
									+ object[index].title + "') " + '"';
							output += 'class="ht_title">' + object[index].title
									+ '</a>';
							output += '<div class="ht_info">';
							output += '&nbsp;' + '<span>0개의 리뷰가 있습니다.</span>';
							output += '<div class="clear"></div>';
							output += '</div>';
							output += '<div class="ht_addr">';
							output += object[index].addr1 + " "
									+ object[index].addr2
									+ '<a class="map_link"';
							output += 'href="javascript:et_modal('
									+ "'1144px','816px','1','0','/ko/modal/spot_map?srl="
									+ object[index].contentId
									+ "&amp;type=2','2','1');" + '">지도보기</a>';
							output += '</div>';
							output += '<div class="ht_count	">';
							output += '조회수 : ' + object[index].readcount + '건';
							output += '</div>';
							output += '<div class="ht_bottom">';
							output += '<a class="ht_view"';
							output += 'href="javascript:moveContent('
									+ object[index].contenttypeid + ", "
									+ object[index].contentid + ",'"
									+ object[index].title + "') " + '"'
									+ '>자세히보기</a>';
							output += '</div>';
							output += '</div>';
							output += '<div class="clear"></div>';
							output += '</div>';
						});
		$(".list").html(output);
		makePaging(total, curPage);
			}
		}
	});
}

function moveListPage(pageNo) {
	curPage = pageNo;
	pageNo = pageNo;
	getSearchList(keyword, curPage);
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


