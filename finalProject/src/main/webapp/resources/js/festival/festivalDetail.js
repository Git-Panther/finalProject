/**
 *  축제 정보를 commonDetail.do에 맞게. 다른 애들도 그에 맞는 Detail.js를 가질 것
 */

function printFestivalCommon(item){
	console.log("printFestivalCommon called");
	$(".spot_addr").html(item.addr1);
}

function printFestivalIntro(item){
	console.log("printFestivalIntro called");
	$(".spot_addr").append(" " + item.eventplace);
}

function printFestivalInfo(item){
	console.log("printFestivalInfo called");
}