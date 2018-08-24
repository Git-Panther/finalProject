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
        	console.log(data);
        	printCommon(data.response.body.items.item);
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
        	console.log(data);
        	printIntro(data.response.body.items.item);
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
        	console.log(data);
        	printInfo(data.response.body.items.item);
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
        	console.log(data);
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
        	//printNearInfo(data.response.body.items.item, contenttypeid); // 공통 정보만 뽑았다.
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
        	console.log(data);
        	//printForecast(data.response.body);
        }
        , error: function(XMLHttpRequest, textStatus, errorThrown) { 
        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
    	} 
    });	
}