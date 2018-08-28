/**
 * 
 */
function detailCommon(contenttypeid, contentid){ // 해당 정보의 공통정보
	$.ajax({        
        url: 'detailCommon.do',
        type: 'post',
        data: { contenttypeid : contenttypeid, contentid : contentid },
        dataType: 'json',
        success: function(data){
        	var item = data.response.body.items.item;
        	console.log(data);
        	printCommon(item); // 공통정보 출력
        	detailIntro(contenttypeid, contentid); // 공통정보 출력이 끝나면 상세정보를 조회
        	// 지도 조회
        	forecast(item.mapx, item.mapy); // 기상청 조회
        	locationBasedList(item.mapx, item.mapy, 32);
        	locationBasedList(item.mapx, item.mapy, 39);
        	locationBasedList(item.mapx, item.mapy, 12);
        	printMark(new daum.maps.LatLng(item.mapy, item.mapx), item.title, 0); // 자기 자신 마커 출력
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}

function detailIntro(contenttypeid, contentid){ // 해당 정보의 상세정보
	$.ajax({        
        url: 'detailIntro.do',
        type: 'post',
        data: { contenttypeid : contenttypeid, contentid : contentid },
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	printIntro(data.response.body.items.item); // 상세정보 출력
        	detailInfo(contenttypeid, contentid); // 상세정보 출력이 끝나면 반복 정보를 조회
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}

function detailInfo(contenttypeid, contentid){ // 해당 정보의 반복정보
	$.ajax({        
        url: 'detailInfo.do',
        type: 'post',
        data: { contenttypeid : contenttypeid, contentid : contentid },
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	printInfo(data.response.body.items.item); // 반복정보 출력
        	detailImage(contentid); // 반복정보 출력이 끝나면 이미지 정보를 조회
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}

function detailImage(contentid){ // 해당 정보의 반복정보
	$.ajax({        
        url: 'detailImage.do',
        type: 'post',
        data: { contentid : contentid },
        dataType: 'json',
        success: function(data){
        	//console.log(data);
        	printImage(data.response.body.items.item);
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}
function locationBasedList(mapx, mapy, contenttypeid){ // 축제 한정으로만 쓰임
	$.ajax({        
        url: 'locationBasedList.do',
        type: 'post',
        data: { mapx : mapx, mapy : mapy, contenttypeid : contenttypeid},
        dataType: 'json',
        success: function(data){
        	console.log(data);
        	printNearInfo(data.response.body, contenttypeid); // 공통 정보만 뽑았다.
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}
function forecast(mapx, mapy){ // 축제가 아니어도 기상청 정보는 쓴다.
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

function checkFavorite(){ // 로그인 상태인데 찜을 해놓고 있냐 아니냐
	if(isUser){
		$.ajax({        
	        url: 'checkFavorite.do',
	        type: 'post',
	        // 이미 전역 변수로 userNo, contenttypeid, contentid가 있다. 거기다 el로 값을 정해준다.
	        data: { userno : userNo, contenttypeid : contenttypeid, contentid : contentid},
	        success: function(data){
	        	//console.log(data);
	        	if(data){ // 있다면 찜하기 등록한 상태로 변경
	        		$("#favoriteBtn > .header_btn_icon").addClass("favorite");
	        		$("#favoriteTxt").html("찜 해제");
	        	}else{
	        		$("#favoriteTxt").html("찜하기");
	        	}
	        }
	        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	    });	
	}
}

function insertFavorite(){ // 찜 등록 : 다섯 개 전부 전역 변수이므로 무관
	$.ajax({        
        url: 'insertFavorite.do',
        type: 'post',
        data: { userno : userNo, 
        		contenttypeid : contenttypeid,
        		contentid : contentid,
        		eventstartdate : eventstartdate, // contentEvent.js 전역변수
        		eventenddate : eventenddate // contentEvent.js 전역변수
        },
        success: function(data){
        	//console.log(data);
        	if(data){ // 성공
        		$("#favoriteBtn > .header_btn_icon").addClass("favorite");
        		$("#favoriteTxt").html("찜 해제");
        		swal({
    				title: "찜 등록 완료!",
    				text: "찜 목록에 추가했습니다.",
    				icon: "success"
    			});
        	}else{ // 실패
        		swal({
    				title: "찜하기 실패!",
    				text: "예기치 않은 오류가 발생했습니다.",
    				icon: "error"
    			});
        	}
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) {
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });		
}

function deleteFavorite(){ // 찜 삭제
	$.ajax({        
        url: 'deleteFavorite.do',
        type: 'post',
        data: { userno : userNo, contenttypeid : contenttypeid, contentid : contentid}, 
        success: function(data){
        	//console.log(data);
        	if(data){ // 성공
        		$("#favoriteBtn > .header_btn_icon").removeClass("favorite");
        		$("#favoriteTxt").html("찜하기");
        		swal({
    				title: "찜 해제 완료!",
    				text: "찜 목록에서 없앴습니다.",
    				icon: "success"
    			});
        	}else{ // 실패
        		swal({
    				title: "찜 해제 실패!",
    				text: "예기치 않은 오류가 발생했습니다.",
    				icon: "error"
    			});
        	}
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}