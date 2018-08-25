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
#memberInfoDiv{
	background-color:white;
	align: center;
	margin-top:5px;
	margin-bottom:5px;
	margin-left: auto;
	margin-right: auto;
	padding-bottom:5px;
	width: 530px;
	height: auto;
	border: 3px solid #aaaaaa;
}
.infoInput{
	width:290px;
	height:30px;
	border: 1px solid #aaaaaa;
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
#updateBtn:before , #deleteBtn:before , #changePwdBtn:before {
  content: "";
  display: inline-block;
  vertical-align: middle;
  height: 100%;
}
#btnsDiv{
	width: 440px;
	height: auto;
	display: inline-block;
	align: center;
	margin-top:5px;
	margin-left: auto;
	margin-right: auto;
}
#updateBtn{
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
#deleteBtn{
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
#currentProfile{
	width: 288px;
	height: auto;
	border: 1px solid #aaaaaa;
}
#memberInfoDivTitle{
	color: grey !important;
	font-size: 20px !important;
	font-weight: bold !important;
	line-height: 250%;
}
</style>
<title>Insert title here</title>
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script>
function updateMemberInfo(){
	$("#memberInfoForm").submit();
}
function deleteMember(){
	var really = confirm("정말로 탈퇴하시겠습니까?");
	if(really == true){
		$("#memberInfoForm").attr("action","memberDelete.do");
		$("#memberInfoForm").submit();
	}
}
function changePwdPage(){
	location.href="changePwdPage.do";
}
</script>
</head>
<body>
	<div id="memberInfoDiv" align="center">
		<h2 id="memberInfoDivTitle">내 정보 수정</h2>
		<form id="memberInfoForm" method="post" action="updateMember.do" enctype="multipart/form-data">
			<table>
				<tr>
					<th>아이디</th>
					<td><span name="userId"><c:out value="${user.userId}"></c:out></span></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><div id="changePwdBtn" onclick="changePwdPage();">비밀번호 변경</div></td>
				</tr>
				<tr>
					<th>성명</th>
					<td><span name="username"><c:out value="${user.userName}" ></c:out></span></td>
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
					<td><span><img src="resources/upload/${user.profilePic}" id="currentProfile"/></span><br/>
					<span><b>현재 프로필 </b><c:out value="${user.profilePic }"></c:out></span>
					<input type="file" accept="image/*" name="newProfilePic"/></td>
				</tr>
			</table>
			<div id="btnsDiv" align="center">
				<div id="btns" align="center">
					<div id="updateBtn" onclick="updateMemberInfo();">내 정보 수정</div>
					<div id="deleteBtn" onclick="deleteMember();">회원 탈퇴</div>
				</div>
			</div>
		</form>
	</div>
</body>
<c:import url="../common/footer.jsp" />
</html>