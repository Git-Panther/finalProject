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
	$("#favoriteBtn").click(function(){
		console.log(eventstartdate, eventenddate, contenttypeid, contentid);
	});
}
	