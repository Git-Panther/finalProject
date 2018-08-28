/**
 * 
 */

function areaCodeList(){
	$.ajax({        
        url: 'areaCodeList.do',
        type: 'post',
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	printAreaList(data.response.body.items.item);
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });
}
function sigunguCodeList(areaCode){
	$.ajax({        
        url: 'areaCodeList.do',
        type: 'post',
        data: { areaCode : areaCode },
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	//console.log(data.response);
        	printSigunguList(areaCode, data.response.body.items.item);
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });
}

function selectFestivalList(params){
	$.ajax({        
        url: 'selectFestivalList.do',
        type: 'post',
        data: params,
        dataType: 'json',
        success: function(data){
        	console.log(data)
            printFestivalList(data);
    		printFestivalPageList(data);
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });
}

function festivalDetailCommon(contentid){
	$.ajax({        
        url: 'festivalDetailCommon.do',
        type: 'post',
        data: { contentid : contentid },
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	checkFavorite(data.response.body.items.item); // 찜 여부 체크
        	printFestivalCommon(data.response.body.items.item);
        	festivalDetailIntro(contentid); // 상세 정보 표시
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}

function festivalDetailIntro(contentid){
	$.ajax({        
        url: 'festivalDetailIntro.do',
        type: 'post',
        data: { contentid : contentid },
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	printFestivalDetail(data.response.body.items.item);
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}

function festivalDetailInfo(contentid){
	$.ajax({        
        url: 'festivalDetailInfo.do',
        type: 'post',
        data: { contentid : contentid },
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	printFestivalInfo(data.response.body.items.item);
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}

function locationBasedList(mapx, mapy, contenttypeid){
	$.ajax({        
        url: 'locationBasedList.do',
        type: 'post',
        data: { mapx : mapx, mapy : mapy, contenttypeid : contenttypeid},
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	printNearInfo(data.response.body.items.item, contenttypeid); // 공통 정보만 뽑았다.
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}

function forecast(mapx, mapy){
	$.ajax({        
        url: 'forecast.do',
        type: 'post',
        data: { mapx : mapy, mapy : mapx }, // 발표일은 controller에서 처리. 둘이 자리 바뀐 이유는 mapx 쪽이 세자리 나옴(...)
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	printForecast(data.response.body);
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}

function checkFavorite(item){ // 로그인 상태인데 찜을 해놓고 있냐 아니냐
	var $favorite = $("#favorite");
	var p = $("<p>").text("찜하기 ");
	//console.log(userNo, item.contentid, item.contenttypeid);
	if(isUser){
		// ajax로 item의 contenttype과 contenttypeid, 그리고 user.userNo 대조하여 되어있는지 검사
		$.ajax({        
	        url: 'checkFavorite.do',
	        type: 'post',
	        data: { userno : userNo, contenttypeid : item.contenttypeid, contentid : item.contentid},
	        success: function(data){
	        	//console.log(data);
	        	if(data){ // 있다면 검은별
	        		p.append("★");
	        		$favorite.click(function(){
	        			deleteFavorite(item);
	        		});
	        	}else{ // 없으면 하얀별
	        		p.append("☆");
	        		$favorite.click(function(){
	        			insertFavorite(item);
	        		});
	        	}
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}else{
		// 좋아요 버튼 이벤트 추가 : 로그인 후에 찜할 수 있습니다.
		p.append("☆");
		$("#favorite").click(function(){
			alert("로그인 후에 찜할 수 있습니다.");
		});
	}
	p.appendTo($favorite);
}

function insertFavorite(item){ // 찜 등록
	// ajax로 수신
	var $favorite = $("#favorite");
	//var p = $("<p>").text("찜하기 ");
	$.ajax({        
        url: 'insertFavorite.do',
        type: 'post',
        data: { userno : userNo, 
        		contenttypeid : item.contenttypeid,
        		contentid : item.contentid,
        		eventstartdate : eventstartdate,
        		eventenddate : eventenddate
        },
        success: function(data){
        	//console.log(data);
        	if(data){ // 성공
        		$favorite.children("p").text("찜하기 ★");
        		$favorite.off();
        		$favorite.click(function(){
        			deleteFavorite(item);
        		});
        	}else{ // 실패
        		alert("에러");
        	}
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });		
}

function deleteFavorite(item){ // 찜 삭제
	// ajax로 수신
	var $favorite = $("#favorite");
	
	$.ajax({        
        url: 'deleteFavorite.do',
        type: 'post',
        data: { userno : userNo, contenttypeid : item.contenttypeid, contentid : item.contentid}, // 
        success: function(data){
        	//console.log(data);
        	if(data){ // 성공
        		$favorite.children("p").text("찜하기 ☆");
        		$favorite.off();
        		$favorite.click(function(){
        			insertFavorite(item);
        		});
        	}else{ // 실패
        		alert("에러");
        	}
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}