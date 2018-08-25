<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
td {
	width:150px;
	height:40px;
	padding-left:5px;
}
th{
	width:120px;
	height: 40px;
	padding-left: 5px;
	font-weight: bold;
	font-size: 14px;
	color: #595959;
}
table{
	align:center;
	margin-left:auto;
	margin-right:auto;
}
span{
	line-height:200%;
}
#passwordChangeDiv{
	display: block;
	width: 530px;
	height: auto;
	margin-left: auto;
	margin-right: auto;
	border: 3px solid #aaaaaa;
	margin-top:5px;
	margin-bottom:5px;
}
.infoInput{
	width:290px;
	height:30px;
	border: 1px solid #aaaaaa;
}
#changePwdConfirmBtn{
	width: 208px;
	height: 50px;
	display: inline-block;
	text-align: center;
	background-color: black;
	color: white;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	margin-top:2px;
	margin-bottom:3px;
}
#changePwdCancelBtn{
	width: 208px;
	height: 50px;
	display: inline-block;
	text-align: center;
	background-color: #aaaaaa;
	color: white;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	margin-top:2px;
	margin-bottom:3px;
	margin-left:4px;
} 
#changePwdConfirmBtn:before, #changePwdCancelBtn:before {
  content: "";
  display: inline-block;
  vertical-align: middle;
  height: 100%;
}
#changePwdBtnDiv{
	width: 440px;
	height: auto;
	display: inline-block;
	align: center;
	margin-left: auto;
	margin-right: auto;
}
#checkDiv2, #checkPwdDiv{
	color: red;
}
#pwdChangeDivTitle{
	color: grey !important;
	font-size: 20px !important;
	font-weight: bold !important;
	line-height: 250%;
}
</style>
<title>Insert title here</title>
<script>
$(function(){
	var idChk= /^[A-Za-z0-9]{4,20}$/;

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
function memberInfoPage(){
	location.href="memberInfo.do";
}
function changePassword(){
	console.log("help")
	$("#passwordChangeForm").submit();
}
</script>
</head>
<body>
	<div id="passwordChangeDiv" align="center">
		<h2 id="pwdChangeDivTitle">비밀번호 변경</h2>
		<form id="passwordChangeForm" method="post" action="changePwd.do">
			<table>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="oldPassword" id="oldPassword" class="infoInput"/></td>
				</tr>
				<tr>
					<th>새로운 비밀번호</th>
					<td><input type="password" name="password" id="password" class="infoInput"/>
						<span id="checkDiv2"></span>
					</td>
					</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="password2" id="password" class="infoInput"/>
						<span id="checkPwdDiv"></span>
					</td>
				</tr>
			</table>
			<div id="changePwdBtnDiv" align="center">
				<div id="changePwdConfirmBtn" onclick="changePassword();">확인</div>
				<div id="changePwdCancelBtn" onclick="memberInfoPage();">취소</div>
			</div>
		</form>
	</div>
</body>
<c:import url="../common/footer.jsp" />
</html>