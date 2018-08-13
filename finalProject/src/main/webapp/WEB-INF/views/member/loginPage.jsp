<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do" />
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<style>
.btns{
width:150px;
height:50px;
display:table-cell;
align:center;
background:black;
color:white;
text-align:center;
vertical-align:middle;
cursor:pointer;
}
</style>
<title>Header</title>
<script>
function login(){
	$("#loginForm").submit();
}
function mainPage(){
	location.href="index.do";
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
				<td width="200px"><span class="import">*</span>아이디</td>
				<td><input type="text" name="userId" id="userId" required /></td>
			</tr>
			<tr>
				<td width="200px"><span class="import">*</span>비밀번호</td>
				<td><input type="password" name="password" id="password"
					required /></td>
			</tr>
		</table>
	</form>
</div>
<div class="btns">
	<div id="loginBtn" onclick="login();">로그인</div>
	<div id="loginMainBtn" onclick="mainPage();">취소</div>
</div>
<c:import url="/footer.do" />
</html>