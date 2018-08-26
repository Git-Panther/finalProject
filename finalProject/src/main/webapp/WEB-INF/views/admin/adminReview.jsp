<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<c:import url="/header.do"/>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script>
	function updateReviewYn(userno, reviewyn){
		location.href="updateReviewYn.do?userNo=" + userno + "&reviewyn=" + reviewyn;
	}
</script>
<style>
th, td {
	text-align: center;
	/* color: black; */
}
  .jumbotron {
      background-color: #538ce8;
      color: #fff;
      padding: 100px 25px;
  }
 img{
    float: left;
    margin-top: -20px;
  }
  
</style>
<script>
function moveReviewList(userNo) {
	location.href="/planner/adminReviewList.do?userNo=" + userNo;
		
}
</script>
</head>
<body>

<div class="container">
<div class="jumbotron text-center">
  <h1>Review page</h1> 
  <p>Review Management</p> 
</div>
<!-- <h2>관리자 페이지</h2>
  <p>회원 관리</p>   -->          
	<table class="table table-bordered">
		<tr>
		    <th>No</th>
			<th>이름</th>
			<th>성별</th>
			<th>이메일</th>
			<th>생일</th>
		</tr>
		<c:forEach items="${mlist }" var="member" varStatus="status">
			<tr onclick="javascript:moveReviewList(${member.userNo})">
				<td>${status.count }</td>
				<td>${member.userName }</td>
				<td>
					<c:if test="${member.gender eq 'M'}">
						남
					</c:if>
					<c:if test="${member.gender ne 'M'}">
						여
					</c:if>
				</td>

				<td>${member.email }</td>
				<td>${member.birthday }</td>
				
			</tr>
		</c:forEach>
	</table>
</div>
<c:import url="/footer.do"/>	
</body>
</html>