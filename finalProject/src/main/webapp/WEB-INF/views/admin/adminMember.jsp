<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>이름</th>
			<th>성별</th>
			<th>이메일</th>
			<th>생일</th>
			<th>별로에요</th>
			<th>괜찮아요</th>
			<th>좋아요</th>
			<th>탈퇴</th>
		</tr>
		<c:forEach items="${mlist }" var="member">
			<tr>
				<td>${member.userName }</td>
				<td>
					<c:if test="${member.gender eq 'M'}">
						남
					</c:if>
					<c:if test="${member.gender ne 'M'}">
						녀
					</c:if>
				</td>
				<td>${member.email }</td>
				<td>${member.birthday }</td>
				<td>${member.cnt1 }</td>
				<td>${member.cnt3 }</td>
				<td>${member.cnt5 }</td>
				<td><button onclick="deleteMember(${member.userNo});">탈퇴</button></td>
				
			</tr>
			
		</c:forEach>
		
	</table>
	
	
	
</body>
</html>