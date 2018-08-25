<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function updateReviewYn(userno, reviewyn){
		location.href="updateReviewYn.do?userNo=" + userno + "&reviewyn=" + reviewyn;
	}
	function deleteMember(userId){
		if(!confirm("회원 탈퇴 진행하시겠습니까?")){
			return;
		}
		location.href="deleteMember.do?userId=" + userId;
	}
</script>
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
			<th>댓글 작성<br>가능 여부</th>
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
				<td>
					<c:if test="${member.reviewyn eq 'Y'}">
						<input type="button" onclick="updateReviewYn(${member.userNo}, 'N');" value="가능"/>
					</c:if>
					<c:if test="${member.reviewyn ne 'Y'}">
						<input type="button" onclick="updateReviewYn(${member.userNo}, 'Y');" value="불가능"/>
					</c:if>
				</td>
				<td>
					<input type="button" onclick="deleteMember('${member.userId}');" value="탈퇴"/>
				</td>
				
			</tr>
			
		</c:forEach>
		
	</table>
	
	
	
</body>
</html>