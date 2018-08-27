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
	$("#favoriteTxt").html("찜하기");
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

function setTapEvent(){
	$(".btn-info").each(function(){
		$(this).click(function(){
			showContentInfo($(this).attr("id"));
		});
	});
	$("#defaultBtn").click(); // 마지막으로 클릭을 해주어 기본 표시
}

function showContentInfo(id){
	//console.log(id);
	//console.log(id.split("Btn")[0]);
	var viewId = "#" + id.split("Btn")[0] + "_info";
	$(".content").hide();
	$(viewId).show();
}

function getDay(num){
	var today = new Date();
	today.setDate(today.getDate()+num);
	var dd = today.getDate();
	var mm = today.getMonth() + 1
	var yyyy = today.getFullYear();

	if(dd < 10) {
	    dd='0'+dd
	} 

	if(mm < 10) {
	    mm='0'+mm
	} 

	var result = Number("" + yyyy + mm + dd);
	return result;
}