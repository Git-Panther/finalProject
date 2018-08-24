<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do" />
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/city/spot_info.css" rel="stylesheet">
<meta charset="UTF-8">
<title>상세정보</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=339906b6f4278bdec7e4ff5ae52df3cc&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="resources/js/common/common_ajax.js"></script>
<script type="text/javascript" src="resources/js/common/common_detail.js"></script>
<script type="text/javascript" src="resources/js/common/common_map.js"></script>
<script type="text/javascript" src="resources/js/common/forecast.js"></script>
<script type="text/javascript" src="resources/js/festival/festivalDetail.js"></script>
<script>
/*
$(document).ready(	function() {
	$.ajax({
		
		
		
		
	});
	console.log('${contenttypename}', '${contentid}', '${title}'); // 넘어오는 값들
	
});
*/
	var contentid = ${contentid};
	var contenttypeid = ${contenttypeid};
	<c:if test="15 eq ${contenttypeid}"> // 이걸 하는 이유가, 축제는 좋아요 기능을 넣어햐 하기 때문
		var eventstartdate = ${eventstartdate}, eventenddate = ${eventenddate};
		console.log(eventstartdate, eventenddate);
	</c:if>
	
	$(function(){
		//console.log(contentid, contenttypeid);
		detailCommon(contenttypeid, contentid); // 기본 정보
		detailIntro(contenttypeid, contentid); // 상세 정보
		detailInfo(contenttypeid, contentid); // 반복 정보
		detailImage(contentid); // 이미지 정보
	});
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
					${contenttypename }
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${title ne '-1'}"> &gt; 
					${title }
					</c:when>
				</c:choose>
			</div>

			<div class="header_left">
				<div class="spot_name">
					<c:choose>
						<c:when test="${title ne '-1'}"> &gt; 
							<c:out value="${title}"/>
						</c:when>
						<c:otherwise>
							UNKNOWN
						</c:otherwise>
					</c:choose>
				</div>
				<div class="spot_addr"></div>
				<div class="clip_cnt">477</div>
				<div class="cnt_line">&nbsp;</div>
				<div class="rate">
					<span class="rate_val">7.6</span>/10&nbsp;<span class="rate_cnt">6개의
						평가</span>
				</div>
				<div class="add_img" onclick="$('#img1').click();">사진추가</div>
			</div>
			<div class="header_right">
				<div class="header_btn btn_review" onclick="go_review();">
					<div class="header_btn_icon">
						<img
							src="/planner/resources/images/city/spot_info/spot_review_btn.png"
							alt="">
					</div>
					<div class="header_btn_txt">리뷰쓰기</div>
				</div>
				<div class="header_btn btn_clip" data-yn="n" data-srl="6638"
					onclick="set_clip('6638','1364392','btn_clip');">
					<div class="header_btn_icon">
						<img
							src="/planner/resources/images/city/spot_info/spot_clip_btn.png"
							alt="">
					</div>
					<div class="header_btn_txt">클립</div>
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
			<div class="spot_img_box">
				<div class="spot_img" onclick="img_slide('0');">
					<img
						src="http://img.earthtory.com/img/place_img_user/820668/6645/6645_1415673028.JPG">
				</div>
				<div class="spot_img" onclick="img_slide('1');">
					<img
						src="http://img.earthtory.com/img/place_img_user/820668/6645/6645_1415673008.JPG">
				</div>
				<div class="spot_img last" onclick="img_slide('2');">
					<div class="img_cnt">+0</div>
					<img src="http://img.earthtory.com/img/place_img/310/6645_0_et.jpg">
				</div>
				<div class="clear"></div>
			</div>

			<div class="spot_tip">
				<img class="spot_info_ico"
					src="/planner/resources/images/city/spot_info/info_icon.gif">컨텐츠
				내용
				<div class="clear"></div>
			</div>

			<div class="spot_info_box">
				<div class="spot_info">
					<table class="spot_info_table" id="spot_info_default" width="100%">
						<colgroup>
							<col width="135">
							<col width="251">
							<col width="135">
							<col width="251">
						</colgroup>
						<tbody>
							<tr>
								<th></th>
								<td></td>
								<th></th>
								<td></td>
							</tr>
							<tr>
								<th>카테고리</th>
								<td>명소 &gt; 랜드마크, 성/궁궐</td>
								<th>웹사이트</th>
								<td><a href="http://www.royalpalace.go.kr" target="_blank">www.royalpalace.go.kr</a></td>
							</tr>
							<tr>
								<th>가는방법</th>
								<td colspan="3">[Line 3]Gyeongbokgung(경복궁)역 5번 출구. 도보 5분.</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>02-3700-3900</td>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<th>영업시간</th>
								<td>1월-2월 09:00~17:00 3월-5월 09:00~18:00 6월-8월 09:00~18:30
									9월-10월 09:00~18:00 11월-12월 09:00~17:00 매주 화요일 휴궁</td>
								<td colspan="2"></td>
							</tr>
						</tbody>
					</table>

					<table class="spot_info_table" id="vk_detail_info" width="100%"
						style="display: none;">
						<colgroup>
							<col width="135">
							<col width="251">
							<col width="135">
							<col width="251">
						</colgroup>
						<tbody></tbody>
						<!--
					<tr>
						<th>
							관광코스안내
						</th>
						<td>
							* 1일차 - 천국의 계단 세트장 → 하나개해수욕장 → 환상의 길<br> * 2일차 - 호룡곡산 → 실미도(바닷길 체험)
						</td>
						<th>
							촬영장소
						</th>
						<td>
							영화 '실미도' 촬영지<br> 드라마 '천국의 계단' 촬영지
						</td>
					</tr>
					-->
					</table>

					<table class="spot_info_table" id="fq_attr_info" width="100%"
						style="display: none;">
						<colgroup>
							<col width="135">
							<col width="251">
							<col width="135">
							<col width="251">
						</colgroup>
						<tbody></tbody>
					</table>

					<table class="spot_info_table" id="fq_open_info" width="100%"
						style="display: none;">
						<colgroup>
							<col width="135">
							<col width="251">
							<col width="135">
							<col width="251">
						</colgroup>
						<tbody></tbody>
					</table>

					<br> <br>
					<table class="spot_info_table" width="100%">
						<tbody>
							<tr>
								<td colspan="4">
									<div class="btn_spot_edit" onclick="spot_update(6638,'경복궁');">
										정보수정 업데이트</div>
									<div class="source_txt" id="source_fq" style="display: none;">
										Powered by Foursquare</div>
									<div class="source_txt" id="source_vk" style="display: none;">
										Powered by 한국관광공사</div>
									<div class="clear"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<div class="spot_info_box community">
				<div class="community_tab on line" data-id="review">리뷰</div>
				<div class="community_tab" data-id="qa">Q&amp;A</div>
				<div class="clear"></div>

				<div class="cmmt_tab_content review"></div>
				<div id="no_result_box" style="display: block;">
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
					<div class="write_qa">
						<div class="write_title">
							<span>경복궁</span>에 궁금한점이 있나요? 질문을 남겨보세요!
						</div>

						<div class="btn_inquiry"
							onclick="et_modal('550px','500px','1','0','/modal/inquiry?ci_srl=310&amp;pl_srl=6638','2','1');">
							질문하기</div>
					</div>

					<div class="write_review">
						<div class="write_title r">
							<span>경복궁</span> 리뷰 남기기
						</div>

						<div class="review_box">
							<!-- <div class="write_left">
																						  <img src="/planner/resources/images/common/mobile/img_profile.png" onerror="this.src='/planner/resources/images/common/mobile/img_profile.png';" class="cmmt_content_uimg">
														<div class="clear"></div>
						</div> -->
							<div class="write_center">
								<div class="rate_box">
									<div class="rate_btn bad" data-val="1" data="1">별로에요!</div>
									<div class="rate_btn normal" data-val="3" data="3">괜찮아요!
									</div>
									<div class="rate_btn good" data-val="5" data="5">좋아요!</div>
									<div class="clear"></div>
								</div>
								<textarea class="review_area" placeholder="장소에 대한 리뷰를 입력하세요."></textarea>
							</div>
							<div class="write_right">
								<div class="btn_review_write" id="si_review_form_submit"
									data="new">등록</div>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
			</div>





		</div>
		<div class="content_right">


			<div class="right_inner">


				<div class="r_inner_title near">
					인근의 클립장소
					<!--<a href="#" class="all_near">
					모두보기
				</a>-->
					<div class="clear"></div>
				</div>
				<div class="near_list">
					<a
						href="/ko/city/seoul_310/attraction/incheon-international-airport_7136"
						class="near" target="_blank">인천국제공항
						<div class="near_distance">48.41km</div>
					</a>
				</div>
			</div>



			<div class="right_inner"></div>


			<div class="right_inner tips">
				<div class="r_inner_title">이 장소의 여행TIP&gt;</div>

			</div>

			<div class="right_inner hotel">
				<div class="r_inner_title">
					인근의 호텔 <a
						href="/ko/city/seoul_310/hotel?from_lat=37.57736200&amp;from_lng=126.97668500&amp;ht_name=경복궁"
						class="ri_more ht"> 더보기 &gt; </a>
					<div class="clear"></div>
				</div>
				<div class="near_ht"></div>
			</div>

			<div class="right_inner">
				<div class="r_inner_title">
					인근의 음식점 <a class="ri_more food"
						href="/ko/city/seoul_310/restaurant"> 더보기 &gt; </a>
				</div>
				<div class="near_food"></div>
			</div>

			<div class="right_inner">
				<div class="r_inner_title">
					인근의 관광명소 <a class="ri_more attr"
						href="/ko/city/seoul_310/attraction"> 더보기 &gt; </a>
				</div>
				<div class="near_attr"></div>
			</div>

		</div>
		<div class="clear"></div>
	</div>


</body>
<c:import url="/footer.do"></c:import>
</html>