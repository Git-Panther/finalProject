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
				+ sigunguName + "', " + sigunguCode + ", " 
				+ object[index].contenttypeid + ", " + object[index].contentid + ", '" + object[index].title + "'";		
				if(15 === object[index].contenttypeid){// 축제이면 날짜도 같이 보내버린다.
					_html += ', ' + object[index].eventstartdate 
							+ ', ' + object[index].eventenddate;
				}
				
				_html += ")" + '"';
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

