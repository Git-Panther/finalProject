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
        	//console.log(data)
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
        	checkUserFavorite(data.response.body.items.item); // 찜 여부 체크
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