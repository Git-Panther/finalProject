<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../common/header.jsp" />
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<style>
#loginFormDiv{
	width: 400px;
	height: auto;
	margin-left: auto;
	margin-right: auto;
	border: 3px solid grey;
	padding: 5px 5px 5px 5px;
}
#loginBtn, #loginMainBtn {
	width: 290px;
	height: 40px;
	display: block;
	background: black;
	color: white;
	text-align: center;
	font-weight:bold;
	font-size:16px;
	cursor: pointer;
	margin-bottom:3px;	
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
}
.infoInput{
	width:290px;
	height:30px;
}
#loginFormDiv{
	background-color:white;
	margin-top:5px;
	margin-bottom:5px;
	margin-left:auto;
	margin-right:auto;
	border: 3px solid #aaaaaa;
}
#loginFormDivTitle{
	color: grey !important;
	font-size: 20px !important;
	font-weight: bold !important;
	line-height: 250%;
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
</script>
<head>
<body>
</body>
</head>
<div id="loginFormDiv" align="center">
	<h2 id="loginFormDivTitle">로그인</h2>
	<form id="loginForm" method="post" action="login.do">
		<table>
			<tr>
				<td><input type="text" name="userId" placeholder="아이디" class="infoInput" required/></td>
			</tr>
			<tr>
				<td><input type="password" name="password" placeholder="비밀번호" class="infoInput" required/></td>
			</tr>
		</table>
	</form>
	<div class="btns">
		<div id="loginBtn" onclick="login();">로그인</div><div id="loginMainBtn" onclick="mainPage();">취소</div>
	</div>
</div>
<c:import url="../common/footer.jsp" />
</html>