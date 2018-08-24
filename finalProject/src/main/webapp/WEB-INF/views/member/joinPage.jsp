<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script>
	function memberJoin() {
		$("#joinForm").submit();
	}
	function mainPage() {
		location.href = "index.do";
	}
	$(function(){
	      var idChk= /^[A-Za-z]{1}[A-Za-z0-9]{3,19}$/;

	       $("#userId").on('keyup', function() {
	          var id = $(this).val();
	          var chk = idChk.test(id);
	               if(chk) {
	                  $("#checkDiv").html("");
	               } else {
	                  $("#checkDiv").html("4~20자의 영문 소문자 및 숫자만 가능합니다");
	                  return;
	               }
	               
	             $.ajax({
	               url:"userIdCheck.do",
	               type:"post",
	               data:{id:$("#userId").val()},
	               success:function(result){
	            	  console.log(result);
	            	  if(result=="available"){
	                  	$("#checkDiv").html("사용 가능한 아이디입니다");
	            	  }else{
		                $("#checkDiv").html("이미 사용중인 아이디입니다");
	            	  }
	               },error:function(e){
						console.log(e);
	               }
	             });  
	               
	          });
	       
	       $("#password").on('keyup', function() {
	          var id = $(this).val();
	          var chk = idChk.test(id);
	               if(chk) {
	                  $("#checkDiv2").html("");
	               } else {
	                  $("#checkDiv2").html("4~20자의 영문 소문자 및 숫자만 가능합니다");
	               }
	            });    
			$("#password2").on('keyup', function() {
	               if($("#password").val() == $("#password2").val()) {
	                  $("#checkPwdDiv").html("");
	               } else {
	                  $("#checkPwdDiv").html("비밀번호가 일치하지 않습니다");
	               }
	            });    
	   });
	
</script>
<title>회원가입</title>
<style>
#joinBtn, #joinMainBtn {
	width: 300px;
	height: 30px;
	display: block;
	text-align: center;
	background-color: black;
	color: white;
	cursor: pointer;
	margin-bottom: 3px;
	margin-left: 3px;
	font-weight: bold;
	font-size: 16px;
}

#checkIdBtn {
	width: 100px;
	height: 50px;
	display: block;
	background: white;
	color: grey;
	text-align: center;
	cursor: pointer;
	border: 1px solid grey;
}

#checkIdBtn:before, #joinBtn:before, #joinMainBtn:before {
	content: "";
	display: inline-block;
	vertical-align: middle;
	height: 100%;
}

td {
	width: 150px;
	height: 40px;
	padding-left: 5px;
}

span {
	line-height: 200%;
}

.infoInput {
	width: 290px;
	height: 30px;
}

#outer {
	margin-left: auto;
	margin-right: auto;
}
#checkDiv, #checkDiv2, #checkPwdDiv {
	color: red;
}
</style>
</head>
<body>
	<div id="outer">
		<form id="joinForm" method="post" action="join.do" enctype="multipart/form-data">
			<table>
				<tr>
					<td colspan="2"><input type="text" name="userId" id="userId" placeholder="아이디 " class="infoInput" />
					<div id="checkDiv"></div></td>
				</tr>
				<tr>
					<td colspan="2"><input type="password" name="password" id="password" placeholder="비밀번호" class="infoInput" />
					<div id="checkDiv2"></div></td>
				</tr>
				<tr>
					<td colspan="2"><input type="password" name="password2" id="password2" placeholder="비밀번호 확인" class="infoInput" />
					<div id="checkPwdDiv"></div></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="userName"
						placeholder="성명" class="infoInput" /></td>
				</tr>
				<tr>
					<td><input type="radio" name="gender" value="F" checked />여 <input
						type="radio" name="gender" value="M" />남</td>
				</tr>
				<tr>
					<td colspan="2"><input type="email" name="email"
						placeholder="이메일 주소" class="infoInput" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="birthday"
						placeholder="생일 YYYY/MM/DD 예)1982/02/17" class="infoInput" /></td>
				</tr>
				<tr>
					<td><span>프로필 사진</span> <input type="file" accept="image/*"
						name="profilePic1" /></td>
				</tr>
			</table>
			<div id="btns">
				<div id="joinBtn" onclick="memberJoin();">회원가입</div>
				<div id="joinMainBtn" onclick="mainPage();">취소</div>
			</div>
		</form>
	</div>
</body>
</html>