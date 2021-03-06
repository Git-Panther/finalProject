<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="resources/css/city/spot_info.css" rel="stylesheet">
<link href="resources/css/review.css" rel="stylesheet">
<link href="resources/css/content/contentDetail.css" rel="stylesheet">
<meta charset="UTF-8">
<title>상세정보</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=339906b6f4278bdec7e4ff5ae52df3cc&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="resources/js/common/common_ajax.js"></script>
<script type="text/javascript" src="resources/js/common/common_print.js"></script>
<script type="text/javascript" src="resources/js/common/common_map.js"></script>
<script type="text/javascript" src="resources/js/content/contentImage.js"></script>
<script type="text/javascript" src="resources/js/content/contentEvent.js"></script>
<script type="text/javascript" src="resources/js/content/contentIntro.js"></script>
<script type="text/javascript" src="resources/js/common/forecast.js"></script>
<script>
	var contentid = <c:out value="${contentid}"/>;
	var contenttypeid = <c:out value="${contenttypeid}"/>;
	var isUser = false; // 로그인 중인가?
	var userNo = undefined;
	//var sidoCode, sigunguCode;
	
	<c:if test="${!empty sessionScope.user}">
		isUser = true;
		userNo = <c:out value="${sessionScope.user.userNo}"/>;
	</c:if>	
</script>
</head>
<body>
	<div class="spot_header">
		<div class="wrap">
			<div class="nav_box">
				<a href="/area.do">여행지</a> 
				<c:choose>
					<c:when test="${sidoName ne '-1'}"> &gt; 
						<a href="javascript:moveAreaMain('<c:out value="${sidoName }" />', '<c:out value="${sidoCode }" />')" class="nav_btn">${sidoName }</a>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${sigunguName ne '-1'}"> &gt; 
						<a href="javascript:moveAreaMain('<c:out value="${sidoName }" />', '<c:out value="${sidoCode }" />')" class="nav_btn">${sigunguName }</a>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${contenttypename ne '-1'}"> &gt; 
						<c:out value="${contenttypename}"/>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${title ne '-1'}"> &gt; 
						<c:out value="${title}"/>
					</c:when>
				</c:choose>
			</div>

			<div class="header_left">
				<div class="spot_name">
					<c:choose>
						<c:when test="${title ne '-1'}">
							<span class="glyphicon glyphicon-sunglasses" aria-hidden="true"></span>
							<c:out value="${title}"/>
						</c:when>
						<c:otherwise>
							UNKNOWN
						</c:otherwise>
					</c:choose>
				</div>
				<div class="spot_addr">
					<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
				</div>
				<div class="spot_homepage">
					<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
				</div>
				<div class="spot_tel">
					<span class="glyphicon glyphicon-bell" aria-hidden="true"></span>
				</div>
				<!--  
				<div class="clip_cnt">477</div>
				<div class="cnt_line">&nbsp;</div>
				<div class="rate">
					<span class="rate_val">7.6</span>/10&nbsp;<span class="rate_cnt">6개의
						평가</span>
				</div>
				<div class="add_img" onclick="$('#img1').click();">사진추가</div>
				-->
			</div>
			<div class="header_right">
				<div class="header_btn btn_review" onclick="go_review();">
					<div class="header_btn_icon" >
						<img
							src="/planner/resources/images/city/spot_info/spot_review_btn.png"
							alt="">
					</div>
					<div class="header_btn_txt">리뷰쓰기</div>
				</div>
				<div class="header_btn btn_clip" id="favoriteBtn">
					<div class="header_btn_icon">
						<img
							src="/planner/resources/images/city/spot_info/spot_clip_btn.png"
							alt="">
					</div>
					<div class="header_btn_txt" id="favoriteTxt"></div>
				</div>
				<div class="header_btn on">
					<div class="header_btn_icon add_plan"
						onclick="et_modal('590px','400px','1','0','/ko/modal/add_plan_inspot?ci_srl=310&amp;pl_srl=6638','2','1');">
						<img
							src="/planner/resources/images/city/spot_info/spot_padd_btn.png"
							alt="">
					</div>
					<div class="header_btn_txt">일정에 넣기</div>
				</div>

				<div class="clip_bubble">
					<img
						src="/planner/resources/images/city/spot_info/spot_bubble_x.gif"
						alt="" class="bubble_close" onclick="del_bubble();">
					<div class="bubble_txt">
						관심장소를 클립해두면 편리하게<br>일정을 계획할 수 있습니다.
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>

	<div class="wrap">
		<div class="content_left">
			<div class="container imgContents">
			  <div id="myCarousel" class="carousel slide" data-ride="carousel">
			    <!-- Indicators -->
			    <div class="carousel-index"></div>
			    <ol class="carousel-indicators"></ol>
			    <!-- Wrapper for slides -->
			    <div class="carousel-inner"></div>	
			    <!-- Left and right controls -->
			    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
			      <span class="glyphicon glyphicon-chevron-left"></span>
			      <span class="sr-only">Previous</span>
			    </a>
			    <a class="right carousel-control" href="#myCarousel" data-slide="next">
			      <span class="glyphicon glyphicon-chevron-right"></span>
			      <span class="sr-only">Next</span>
			    </a>
			  </div>
			</div>
			<div class="content-wrap">
				<div class="btn-group btn-group-lg btn-group-toggle" role="group" data-toggle="buttons" aria-label="contentDetail">
					<label class="btn btn-info" id="defaultBtn">
				    	<input type="radio" name="options" autocomplete="off" class="contentBtn">상세 정보
					</label>
					<label class="btn btn-info" id="forecastBtn">
				    	<input type="radio" name="options" autocomplete="off" class="contentBtn">일기예보
				  	</label>
				  	<label class="btn btn-info" id="mapBtn">
				    	<input type="radio" name="options" autocomplete="off" class="contentBtn">지도
				  	</label>
				  	<!-- 
				  	<button type="button" class="btn btn-info" id="defaultBtn">정보</button>
				  	<button type="button" class="btn btn-info" id="forecastBtn">일기예보</button>
				  	<button type="button" class="btn btn-info" id="mapBtn">지도</button>
				  	 -->
				</div>
				<div class="spot_info_box">
					<div class="spot_info content" id="default_info">
						<table class="spot_info_table" id="spot_info_default">
							<colgroup>
								<col width="135">
								<col width="251">
								<col width="135">
								<col width="251">
							</colgroup>
							<tbody>
								<tr>
									<th>분류</th> <!-- 카테고리는 공통? 위와 중복이라 뺄수도 -->
									<td colspan="3" id="category"><c:out value="${contenttypename}"></c:out></td>
								</tr>
								<!-- 이 아래부터는 각각의 정보가 들어갈 것이다. -->
							</tbody>
						</table>
					</div>
					<div class="spot_info content" id="forecast_info">
					<!-- 
						<div class="h4 text-primary spot_info_date">DATE</div>
						<table class="spot_info_table">
							<colgroup>
								<col width="135">
								<col width="251">
								<col width="135">
								<col width="251">
							</colgroup>
							<tbody></tbody>
						</table>
					 -->
					</div>
					<div class="spot_info content" id="map_info">
						<table class="spot_info_table" id="spot_info_map">
							<colgroup>
								<col width="135">
								<col width="251">
								<col width="135">
								<col width="251">
							</colgroup>
							<tbody></tbody>
							<tr>
								<td colspan="4" id="festivalMap">
									<div class="mapWrapper">
										<div id="map"></div>
										<div class="markerCategory">
										 	<div id="allMarkers" class="markerMenu">
										 		<img class="ico_comm ico_all"></img>
												전체
										 	</div>
										 	<div id="hotelMarkers" class="markerMenu">
										 		<img class="ico_comm ico_hotels"></img>
												숙박
										 	</div>
										 	<div id="restaurantMarkers" class="markerMenu">
										 		<img class="ico_comm ico_restaurants"></img>
												식당
										 	</div>
										 	<div id="attractionMarkers" class="markerMenu">
										 		<img class="ico_comm ico_attractions"></img>
												관광지
										 	</div>
								    	</div>
								    </div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- 덧글 -->
				<div class="spot_info_box community" >
					<div class="community_tab on line" data-id="review">리뷰</div>
					<div class="community_tab" data-id="qa"></div>
					<div class="clear"></div>
					<div class="cmmt_tab_content review">
						<c:forEach items="${rlist }" var="review">
							<div class="cmmt_content_box">
			                  			<a class="cmmt_c_user" href="내정보보기 호출 url" style= "width: 750px;">
			                	<img
			                  		<c:if test="${empty user.profilePic}">
			                   			src="/planner/resources/images/common/profile/img_profile.png"
			                  		</c:if>
			                     	<c:if test="${!empty user.profilePic}">
			                   			src="/planner/resources/images/common/profile/${review.profilePic}"
			                		</c:if>
			                    class="cmmt_content_uimg"
			                    onerror="this.src='/planner/resources/images/common/profile/img_profile.png';"/>
			                    </a>
			              		<div class="review_opbtn" 
				                     <c:if test="${review.writer ne user.userNo }">
				                     	style="display:none"
				                     </c:if>
			                     >
			                     	<div class="rv_op_btn rop_delete" data-srl="5353" onclick="reviewDelete(${review.cno})">삭제</div>
			                     	<div class="rv_op_btn line rop_edit" onclick="reviewModify(${review.cno}, this, '${review.content}', ${review.grade});">수정</div>
			                     	<div class="rv_op_btn line rop_cancel" onclick="cancelReview();">취소</div>
			                   	</div>
			           			<div class="cmmt_c_user_txt">
			                        <div class="cmmt_c_user_name">
			                           ${review.writerNm }<span>&nbsp;&nbsp;${review.reg_date}</span>
			                           <div class="clear"></div>
			                        </div>
			                        <div class="cmmt_c_user_level">
			                           <a href="myReviewList.do?writer=${review.writer}"><div class="rv_cnt" style="margin-left: 1px;">${review.reviewCnt}개의 평가</div></a>
			                           <div class="clear"></div>
			                        </div>
			                    </div>
			                    <div class="clear"></div>
			                  	<div class="clear"></div>
			                  	<div class="cmmt_content" style="padding-left :13px;">
			                    <div class="cmmt_content_info">
			                    	<span>
			                    		<c:choose>
			                              <c:when test="${review.grade eq 1 }">
			                                 	별로에요!
			                              </c:when>
			                              <c:when test="${review.grade eq 3 }">
			                                 	괜찮아요!
			                              </c:when>
			                              <c:otherwise>
			                                 	좋아요!
			                              </c:otherwise>
			                           </c:choose>
			                        </span>
			                     </div>
			                     <span id="content${review.cno }">
			                        ${review.content}
			                     </span>
			                  </div>
			               </div>
						</c:forEach>
					</div>			
					<div id="no_result_box"
						<c:if test="${rlist.size() eq 0 }">
							style="display: block;"
			            </c:if>
			            <c:if test="${rlist.size() ne 0 }">
							style="display: none;"
			            </c:if>
			        >
						<img src="/planner/resources/images/common/no_result_icon.png">
						<div class="no_result_text">아직 리뷰가 없습니다.</div>
						<br> <br> <br> <br> <br>
					</div>
					<div class="cmmt_tab_content qa">
						<div id="no_result_box" style="display: block;">
							<img src="/planner/resources/images/common/no_result_icon.png">
							<div class="no_result_text">아직 질문이 없습니다.</div>
						</div>
						<br> <br> <br> <br> <br>
					</div>
					<div class="page review" style="display: none;"></div>
					<div class="page qa" id="paging"></div>
						<div class="write_area">
							<div class="write_review">
								<div class="write_title r">
									<span></span> 리뷰 남기기
								</div>
								<div class="review_box">
									<!-- <div class="write_left">
				   				    <img src="/planner/resources/images/common/mobile/img_profile.png" onerror="this.src='/planner/resources/images/common/mobile/img_profile.png';" class="cmmt_content_uimg">
									<div class="clear"></div>
									</div> -->
									<div class="write_center">
										<div class="rate_box">
											<div class="rate_btn bad" data-val="1" data="1">별로에요!</div>
											<div class="rate_btn normal" data-val="3" data="3">괜찮아요!</div>
											<div class="rate_btn good on" data-val="5" data="5">좋아요!</div>
											<div class="clear"></div>
										</div>
										<textarea class="review_area" id="content" placeholder="장소에 대한 리뷰를 입력하세요."></textarea>
									</div>
									<div class="write_right">
										<div class="btn_review_write" id="si_review_form_submit" style="margin-top: 155px;" data="new" onclick="writeComment();">등록</div>
									</div>
									<div class="clear"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="content_right">
				<div class="right_inner" id="nearHotel">
					<div class="r_inner_title">
						1km 이내 호텔
						<!-- 
							<img src="" alt="" class="ri_img" onerror="this.src='/res/img/common/no_img/hotel55.jpg';">
						 	<div class="ri_right">
						 		<div class="ri_title">그랜드 모텔</div>
						 		<div class="ri_price">￦74,708</div>
						 		<div class="ri_bottom">
						 			<div class="ri_distance">거리 25.86km</div>
						 			<div class="ri_rate">강력추천 <span>9.9</span></div>
						 			<div class="clear"></div>
						 		</div>
						 	</div>
						 	<div class="clear"></div>
						 -->
						<!--  
						 <a
							href="/ko/city/seoul_310/hotel?from_lat=37.57736200&amp;from_lng=126.97668500&amp;ht_name=경복궁"
							class="ri_more ht"> 더보기 &gt; </a>
						<div class="clear"></div>
						-->
					</div>
					<div class="near_ht"></div>
				</div>
				<div class="right_inner" id="nearRestaurant">
					<div class="r_inner_title">
						1km 이내 음식점 <!-- <a class="ri_more food"
							href="/ko/city/seoul_310/restaurant"> 더보기 &gt; </a>-->
					</div>
					<div class="near_food"></div>
				</div>
				<div class="right_inner" id="nearAttraction">
					<div class="r_inner_title">
						1km 이내 관광지<!--   <a class="ri_more attr"
							href="/ko/city/seoul_310/attraction"> 더보기 &gt; </a>-->
					</div>
					<div class="near_attr"></div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
 /*댓글  */
$(function(){
   //$(".write_area").hide();   
   //$(".rv_op_btn.rop_cancel").hide();
   $(".rop_cancel").hide();
   <c:if test="${empty sessionScope.user or user.reviewyn eq N}">
      $(".review_opbtn").hide();
      $(".write_area").hide();   
   </c:if>
   
  $(".rate_btn").click(function(){
     var clickBtn = $(this).data("val");
     
     setGradeBtn(clickBtn);
//      $(".rate_btn").each(function(index){
//         var forBtn = $(this).data("val");
//         if(clickBtn  == forBtn){
//            $(this).addClass("on");
//         }else{
//            $(this).removeClass("on");
//         }
        
//      });
  });
});

function writeComment(){
   var writer = 0;
   <c:if test="${!empty sessionScope.user}">
      writer = <c:out value="${sessionScope.user.userNo}"/>;
   </c:if>
   if(0 != writer){
	   console.log({ contenttypeid : ${contenttypeid}, contentid : ${contentid}, content : $("#content").val(), writer:writer, grade:$(".rate_btn.on").data("val") });
   
      $.ajax({        
           url: 'writeReview.do',
           type: 'post',
           data: { contenttypeid : ${contenttypeid}, contentid : ${contentid}, content : $("#content").val(), writer:writer, grade:$(".rate_btn.on").data("val") },
           success: function(data){
              console.log(data);
              //1. 댓글 작성 성공 여부 화면 출력
              if(data.result == 1){
//                 alert("댓글 작성 성공 하였습니다.");
                 swal({
                	 text: "댓글 작성 성공 하였습나다.",
                	 icon: "success",
                	 button: "확인"
                 })
              }else{
                 /* alert("댓글 작성 실패 하였습니다."); */
                 swal({
                	 text: "댓글 작성 실패 하였습니다..",
                	 icon: "error",
                	 button: "확인"
                 })
              }
              //2. 댓글 리스트 화면에 출력
              setReviewList(data.list);
           }, error: function(XMLHttpRequest, textStatus, errorThrown) { 
              alert("Status: " + textStatus); alert("Error: " + errorThrown); 
          } 
       });   
   }else{
	   swal({
      	 text: "로그인 후 이용하세요!",
      	 icon: "error",
      	 button: "확인"
       })
   }
}
function slideDownComment(){
  $(".rv_op_btn.rop_cancel").show();
  $(".write_area").slideDown(500);
}

function slideUpComment(){
  $(".rv_op_btn.rop_cancel").hide();
  $(".write_area").slideUp(500);
}

function setReviewList(list){
	var writer = 0;
    <c:if test="${!empty sessionScope.user}">
      writer = <c:out value="${sessionScope.user.userNo}"/>;
    </c:if>
	
  function pad(num) {
          num = num + '';
          return num.length < 2 ? '0' + num : num;
  }
   
  var reviewDiv = $(".cmmt_tab_content.review");
  reviewDiv.empty();
  
  var reviewHtml = "";
  for(var i in list){
     var writeDate = new Date(list[i].reg_date);
     reviewHtml += '<div class="cmmt_content_box">';
     reviewHtml +=    '<a class="cmmt_c_user" href="내정보보기 호출 url" style= "width: 750px;">';
     reviewHtml +=       '<img ';
     if(list[i].profilePic == ''){
        reviewHtml +=    'src="/planner/resources/images/common/profile/img_profile.png"';
     }else{
        reviewHtml +=    'src="/planner/resources/images/common/profile/' + list[i].profilePic + '" ';
     }
     reviewHtml +=       'class="cmmt_content_uimg" onerror="this.src=\'/planner/resources/images/common/profile/img_profile.png\';">';
     reviewHtml +=    '</a>';
     reviewHtml +=   '<div class="review_opbtn" ';
     if(list[i].writer != writer){
	     reviewHtml +=   'style="display:none;" ';
     }
     reviewHtml +=   '>';
     reviewHtml +=   '<div class="rv_op_btn rop_delete" data-srl="5353" onclick="reviewDelete(' + list[i].cno+ ')">삭제</div>';
     reviewHtml +=   '<div class="rv_op_btn line rop_edit" onclick="reviewModify('+list[i].cno+', this, \''+list[i].content+'\', ' + list[i].grade + ');">수정</div>';
     reviewHtml +=   '<div class="rv_op_btn line rop_cancel" onclick="cancelReview();">취소</div></div>';
     reviewHtml +=   '<div class="cmmt_c_user_txt">';
     reviewHtml +=      '<div class="cmmt_c_user_name">';
     reviewHtml +=      list[i].writerNm + '<span>&nbsp;&nbsp;' + writeDate.getFullYear() + "-" + pad(writeDate.getMonth() + 1) + "-" + pad(writeDate.getDate()) + '</span>';
     reviewHtml +=      '<div class="clear"></div>';
     reviewHtml +=      '</div>';
     reviewHtml +=      '<div class="cmmt_c_user_level">';
     reviewHtml +=         '<a href="myReviewList.do?writer=' + list[i].writer + '">';
     reviewHtml +=         '<div class="rv_cnt" style="margin-left: 1px;">' + list[i].reviewCnt + '개의 평가</div></a>';
     reviewHtml +=         '<div class="clear"></div>';
     reviewHtml +=      '</div>';
     reviewHtml +=   '</div>';
     reviewHtml +=   '<div class="clear"></div><div class="clear"></div>';
     reviewHtml +=   '<div class="cmmt_content" style="padding-left :13px;">';
     reviewHtml +=      '<div class="cmmt_content_info">';
     console.log(list[i].grade);
     if(list[i].grade == 1){
        reviewHtml +=      '<span>별로에요!</span>';
     }else if(list[i].grade == 3){
        reviewHtml +=      '<span>괜찮아요!</span>';              
     }else{
        reviewHtml +=      '<span>좋아요!</span>';
     }
     reviewHtml +=    '</div><span id="content' + list[i].cno + '">';
     reviewHtml +=   list[i].content;
     reviewHtml +='</span></div></div>';
     //var dateTd = $("<td>").text(writeDate.getFullYear() + "-" + pad(writeDate.getMonth() + 1) + "-" + pad(writeDate.getDate()));            
  }
  reviewDiv.html(reviewHtml);
  
  if(list.length == 0){
     $("#no_result_box").show();
  }else{
     $("#no_result_box").hide();
  }
  
  $("#content").val("");
  $("#si_review_form_submit").text("등록");
  $("#si_review_form_submit").attr("onclick", "writeComment();");
  $(".rop_cancel").hide();
  setGradeBtn(5);
}

function reviewModify(cno, btn, replyContent, grade){
        
  $(".rv_op_btn").hide();
  $(btn).next().removeClass("line").show();
  
  setGradeBtn(grade);
  
  //var id = ;
  $("#content").val($("#content" + cno).text().trim());
  $("#content").focus();
  $("#si_review_form_submit").text("수정");
  $("#si_review_form_submit").attr("onclick", "updateReview("+cno+");");
  
  
//   $(".rate_btn").each(function(){
//      if($(this).data("val") == grade){
//         $(this).addClass("on");
//      }else{
//         $(this).removeClass("on");
//      }
//   })
  
  
}

function setGradeBtn(grade){
  $(".rate_btn").each(function(){
     if($(this).data("val") == grade){
        $(this).addClass("on");
     }else{
        $(this).removeClass("on");
     }
  })
}


function reviewDelete(cno){
  if(!confirm("댓글을 삭제 하시겠습니까?")){
     return;
  }
  
  $.ajax({        
       url: 'deleteReview.do',
       type: 'post',
       data: { contentid : ${contentid}, cno : cno },
       success: function(data){
          console.log(data);
          //1. 댓글 작성 성공 여부 화면 출력
          if(data.result == 1){
        	  swal({
              	 text: "댓글 삭제 성공 하였습니다.",
              	 icon: "success",
              	 button: "확인"
               })
          }else{
        	  swal({
             	 text: "댓글 삭제 실패 하였습니다.",
             	 icon: "error",
             	 button: "확인"
              })
          }
          //2. 댓글 리스트 화면에 출력
          setReviewList(data.list);
       }, error: function(XMLHttpRequest, textStatus, errorThrown) { 
          alert("Status: " + textStatus); alert("Error: " + errorThrown); 
      } 
   });
}

function updateReview(cno){
  var writer = 0;
   <c:if test="${!empty sessionScope.user}">
      writer = <c:out value="${sessionScope.user.userNo}"/>;
   </c:if>
  $.ajax({        
       url: 'updateReview.do',
       type: 'post',
       data: { contenttypeid : ${contenttypeid}, contentid : ${contentid}, cno: cno, content : $("#content").val(), writer:writer, grade:$(".rate_btn.on").data("val") },
       success: function(data){
          console.log(data);
          //1. 댓글 작성 성공 여부 화면 출력
          if(data.result == 1){
        	  swal({
               	 text: "댓글을 수정 하였습니다.",
               	 icon: "success",
               	 button: "확인"
                })
          }else{
             swal({
             	 text: "댓글 수정 실패 하였습니다.",
             	 icon: "error",
             	 button: "확인"
              })
          }
          //2. 댓글 리스트 화면에 출력
          setReviewList(data.list);
       }, error: function(XMLHttpRequest, textStatus, errorThrown) { 
          alert("Status: " + textStatus); alert("Error: " + errorThrown); 
      } 
   });
}

function cancelReview(){
  $.ajax({        
       url: 'selectReview.do',
       type: 'post',
       data: { contentid : ${contentid}},
       success: function(data){
          setReviewList(data.list);
       }, error: function(XMLHttpRequest, textStatus, errorThrown) { 
          alert("Status: " + textStatus); alert("Error: " + errorThrown); 
      } 
   });
}

function go_review(){
	$("#content").focus();
}
</script>
<script> // Map
	var attractionMarkers = [], hotelMarkers = [], restaurantMarkers = []; // 메인 컨텐츠는 항상 표시, 인근 것들은.??
	
	var container = document.getElementById('map');			
	var options = {
		center: new daum.maps.LatLng(33.450701, 126.570667),
		level: 4
		// ,marker: markers // 이미지 지도에 표시할 마커 
	};			
	var map = new daum.maps.Map(container, options);

	var zoomControl = new daum.maps.ZoomControl();
	
	$(function(){
		//console.log(contentid, contenttypeid);
		setTapEvent();
		detailCommon(contenttypeid, contentid); // 기본 정보 조회. 이후 순서대로 조회될 것이다.
		markerCategoryEvent(); // 마커 표시 이벤트 추가
		setCarouselEvent();
		setFavoriteEvent();
		map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
		map.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);
		changeMarker("allMarkers"); // 전체 먼저 누르기
	});
</script>
</body>
<c:import url="/footer.do"></c:import>
</html>