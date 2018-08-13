<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="resources/js/gnb.js"></script>
<link href="resources/css/footer.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Footer</title>
</head>
<body>
<div id="footer">
	<div class="wrap">
		<div class="footer_col fl">
			<div class="footer_title">어스토리</div>
			<a href="/ko/area">여행지</a>
			<a href="/ko/plan">일정만들기</a>
			<a href="/ko/hotel">호텔</a>
						<a href="/ko/community/qa">Q&amp;A</a>
			<a href="/ko/community/tips">여행TIP</a>
						<a href="/ko/mobile">모바일</a><!--모바일-->
		</div>

		<div class="footer_col fl">
			<div class="footer_title">회사이야기</div>
			<a href="/ko/helpdesk/about">회사소개</a>
			<a href="/ko/helpdesk/intro">이용방법</a>
			<a href="/ko/helpdesk/contact">광고 및 제휴</a>
		</div>

		<div class="footer_col fl">
			<div class="footer_title">고객센터</div>
			<a href="/ko/helpdesk/faq">FAQ</a>
			<a href="/ko/helpdesk">문의하기</a>
			<a href="/ko/helpdesk/policy">이용약관</a>
			<a href="/ko/helpdesk/personal_info">개인정보 처리방침</a>
		</div>
		
				<div class="footer_col fl" style="margin-right:0px;">
			<div class="footer_title" style="border-bottom:0px;margin-bottom:0px;">&nbsp;</div>
			<script type="text/javascript">
				$(document).ready(function(){
					$('#lang_chage_item_box .lang_change_item').click(function(){
						var lang_n = $(this).attr('data');
						console.log(lang_n);
						$.ajax({
							type:'post',
							url:'/api/member/set_session',
							data:{'lang':lang_n},
							success:function(){
								if(lang_n == 'ko'){
									location.href = '/ko/';
								}else if(lang_n == 'ja'){
									location.href = '/ja/';
								}else{
									location.href = '/';
								}
							}
						});
					});
				});

				$('#footer').on('click','#footer_lang_sel_box',function(){
					is_open = $(this).attr('data-is_open');
					//console.log(is_open);
					if(is_open == '1'){
						$('#lang_chage_item_box').slideUp(300);
						$(this).attr('data-is_open','0');
					}else{
						$('#lang_chage_item_box').slideDown(200);
						$(this).attr('data-is_open','1');
					}
				});
			</script>

			<!-- 번역 기능 알아보는 중 -->
			<div class="fl footer_lang_box" id="footer_lang_sel_box" data-is_open="0" data-h="ko/ko">
									한국어
							</div>
			<div id="lang_chage_item_box">
				<a href="/ko/" class="prevent_href lang_change_item" data="ko">한국어</a>
				<a href="/ja/" class="prevent_href lang_change_item" data="ja">日本語</a>
				<a href="/" class="prevent_href lang_change_item" data="en">English</a>
			</div>
			<div class="clear" style="padding-bottom:20px"></div>

			<!-- 소셜 기능 -->
			<!-- <div class="fl footer_sns_icon"><a href="https://www.facebook.com/Earthtory" target="_blank"><img src="/res/img/common/footer/ft_fb_icon.png" alt="어스토리 페이스북"></a></div>
			<div class="fl footer_sns_icon"><a href="http://blog.earthtory.com/" target="_blank"><img src="/res/img/common/footer/ft_blog_icon.png" alt="어스토리 트위터"></a></div> -->
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
	</div>

	<div class="footer_bottom">
		<div class="wrap">
			Copyright ⓒ 2018 Earthtory.com, All Rights Reserved.
						<div style="float:right;">문의사항: @ | </div><div class="clear"></div>
		</div>
	</div>
</div>
</body>
</html>