/**
 * 디테일한 정보를 출력할 때, 여기서 한 번 필터링을 거친 다음에 출력한다.
 */
function printCommon(item){ // 공통정보 출력
	switch(item.contenttypeid){
	case 15:
		printFestivalCommon(item);
		break;
	case 32:
		break;
	case 39:
		break;
	}
}

function printIntro(item){ // 상세정보 출력
	switch(item.contenttypeid){
	case 15:
		//checkFavorite(item); // 찜 여부 체크
		printFestivalIntro(item);
		break;
	case 32:
		break;
	case 39:
		break;
	}
}

function printInfo(item){ // 반복정보 출력
	if(undefined === item.length) item = [item];
	
	switch(item[0].contenttypeid){
	case 15:
		printFestivalInfo(item);
		break;
	case 32:
		break;
	case 39:
		break;
	}
}

function printImage(item){ // 이미지 정보 출력 : 이것은 공통이다
	console.log("printImage called");
}