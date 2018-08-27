/**
 * 
 */
var eventstartdate = undefined, eventenddate = undefined;

function setCarouselEvent(){
	$('#myCarousel').on('slid.bs.carousel', function (e) {
		// do something…
		var $li = $("#myCarousel .carousel-indicators li");
		//console.log($li);
		$li.each(function(i){
			//console.log(i);
			if($(this).is(".active")) {
				//console.log("!");
				printImagePage(i + 1);
			}
		});
	});
}

function setFavoriteEvent(){
	checkFavorite(); // 먼저 검사한다.
	$("#favoriteBtn").click(function(){
		if(isUser){
			//console.log($("#favoriteBtn > .header_btn_icon"));
			var isFavorite = $("#favoriteBtn > .header_btn_icon").is(".favorite");
			//console.log(isFavorite);
			if(isFavorite){
				deleteFavorite();
			}else{
				insertFavorite();
			}
		}else{
			swal({
				title: "찜하기 실패!",
				text: "로그인 후 이용하세요.",
				icon: "error"
			});
		}
		//console.log(eventstartdate, eventenddate, contenttypeid, contentid);
	});
}
	