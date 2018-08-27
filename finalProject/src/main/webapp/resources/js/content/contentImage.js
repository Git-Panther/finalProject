/*
 * 
 */

var imageCount = 1; // 총 이미지 개수
var imageIndex = 1; // 이미지 인덱스

function printIndicators(size){
	var $ol = $(".carousel-indicators");
	$ol.html(""); // 비운다.

	var li;
	for(var i = 0; i < size; i++){
		li = $('<li data-target="#myCarousel" data-slide-to="'+i+'">');
		li.appendTo($ol);
	}
	
	$ol.children("li").eq(0).addClass("active");
}

function printInner(item){
	var $imageList = $(".carousel-inner");
	var div;
	var img;
	
	$imageList.html("");
	
	if(undefined === item){
		div = $('<div class="item contentImage">');
		img = $("<img>");
		img.attr("src", "/planner/resources/images/festival/no_image.png");
		img.attr("alt", "no-image");
		img.addClass("no_image");
		div.append(img).appendTo($imageList);
	}else{
		item.forEach(function(v, i){
			div = $('<div class="item contentImage">');
			img = $("<img>");
			img.attr("src", v.originimgurl);
			img.attr("alt", v.serialnum);
			div.append(img).appendTo($imageList);
		});
	}
	
	$imageList.children(".item").eq(0).addClass("active");
}

function printImagePage(index){
	if(index > imageCount) imageIndex = 1;
	else if(index < 1) imageIndex = imageCount;
	else imageIndex = index;	
	var $index = $(".carousel-index");
	$index.html("");
	$index.html(imageIndex + " / " + imageCount);
}