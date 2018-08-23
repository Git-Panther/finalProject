<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../common/header.jsp" />
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<style>
#loginBtn, #loginMainBtn {
	width: 300px;
	height: 30px;
	display: block;
	background: black;
	color: white;
	text-align: center;
	font-weight:bold;
	font-size:16px;
	cursor: pointer;
	margin-bottom:3px;	
	margin-left:3px;
}
#loginBtn:before, #loginMainBtn:before {
  content: "";
  display: inline-block;
  vertical-align: middle;
  height: 100%;
}
td {
	width:150px;
	height:40px;
	padding-left:5px;
}
.infoInput{
	width:290px;
	height:30px;
}
</style>
<title>Header</title>
<script>
	function login() {
		$("#loginForm").submit();
	}
	function mainPage() {
		location.href = "index.do";
	}
	function passwordCheckMessage() {
	    alert(msg);
	}
</script>
<head>
<body>
</body>
</head>
<div class="outer">
	<form id="loginForm" method="post" action="login.do">
		<table>
			<tr>
				<td colspan="2"><input type="text" name="userId" placeholder="아이디" class="infoInput" required/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="password" placeholder="비밀번호" class="infoInput" required/></td>
			</tr>
		</table>
	</form>
</div>
<div class="btns">
	<div id="loginBtn" onclick="login();">로그인</div><div id="loginMainBtn" onclick="mainPage();">취소</div>
</div>
<c:import url="../common/footer.jsp" />
</html>