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
	width:100px;
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
#memberInfoDiv{
	align: center;
	margin-left: auto;
	margin-right: auto;
	width: 600px;
	height: auto;
	border: 1px solid grey;
}
.infoInput{
	width:290px;
	height:30px;
}
#changePwdBtn{
	width:290px;
	height:30px;
	cursor:pointer;
	background-color:black;
	font-size: 14px;
	font-weight: bold;
	color:white;
	text-align:center;
}
#btns{
	align: center;
	margin-left: auto;
	margin-right: auto;
}
#updateBtn:before , #deleteBtn:before , #changePwdBtn:before {
  content: "";
  display: inline-block;
  vertical-align: middle;
  height: 100%;
}
#updateBtn{
	width: 200px;
	height: 50px;
	display: inline-block;
	text-align: center;
	background-color: black;
	color: white;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	margin-bottom:3px;
	margin-left:5px;
}
#deleteBtn{
	width: 200px;
	height: 50px;
	display: inline-block;
	text-align: center;
	background-color: #aaaaaa;
	color: white;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	margin-bottom:3px;
} 
#currentProfile{
	width: 290px;
	height:auto;
}
</style>
<title>Insert title here</title>
<script>
function updateMemberInfo(){
	
}
function deleteMember(){
	
}
</script>
</head>
<body>
	<div id="memberInfoDiv">
		<form id="memberInfoForm" method="post" action="updateMember.do" >
			<table>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="userId" value="${user.userId}" class="infoInput" readonly/></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><div id="changePwdBtn" onclick="changePwd();">비밀번호 변경</div></td>
				</tr>
				<tr>
					<th>성명</th>
					<td><input type="text" name="username" value="${user.userName}" class="infoInput" readonly/></td>
				</tr>
				<tr>
					<th>성별</th>
					<c:if test="${user.gender eq 'F'}">
					<td><input type="radio" name="gender" value="F" checked disabled/>여
					<input type="radio" name="gender" value="M" disabled/>남</td>
					</c:if>
					<c:if test="${user.gender eq 'M'}">
					<td><input type="radio" name="gender" value="F" disabled/>여
					<input type="radio" name="gender" value="M" checked disabled/>남</td>
					</c:if>
				</tr>
				<tr>
					<th>이메일 주소</th>
					<td><input type="email" name="email" value="${user.email}" class="infoInput"/></td>
				</tr>
				<tr>
					<th>생일</th>
					<td><input type="text" name="birthday" value="${user.birthday }" class="infoInput"/></td>
				</tr>
				<tr>
					<th>프로필 사진</th>
					<td><span><img src="resources/upload/${user.profilePic}" id="currentProfile"/></span>
					<input type="file" accept="image/*" name="profilePic"/></td>
				</tr>
			</table>
			<div id="btns">
				<div id="updateBtn" onclick="updateMemberInfo();">내 정보 수정</div>
				<div id="deleteBtn" onclick="deleteMember();">회원 탈퇴</div>
			</div>
		</form>
	</div>
</body>
<c:import url="../common/footer.jsp" />
</html>