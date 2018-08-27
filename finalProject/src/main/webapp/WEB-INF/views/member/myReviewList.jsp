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
	function contentDetailPage(contentid, contenttypeid){
		location.href="contentDetail.do?contentid=" + contentid + "&contenttypeid=" + contenttypeid;
	}

</script>

</head>
<body>

<div class="container">
<div class="jumbotron text-center">
  <h1>Review page</h1> 
  <p>Review</p> 
</div>
	<table class="table table-bordered">
		<tr>
		    <th>No</th>
			<th>내용</th>
			<th>작성일</th>
			<th>등급</th>
		</tr>
		<c:forEach items="${list }" var="review" varStatus="status">
			<tr onclick="contentDetailPage(${review.contentid}, ${review.contenttypeid});">
				<td>${status.count }</td>
				<td>${review.content }</td>
				<td>
					${review.reg_date }
				</td>
				<td>
	               <c:choose>
                       <c:when test="${review.grade eq 1 }">
                         	 별로에요!
                       </c:when>
                       <c:when test="${review.grade eq 3 }">
                      		 괜찮아요!
                       </c:when>
                       <c:otherwise>
                         	 좋아요!
                       </c:otherwise>
                    </c:choose>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
<c:import url="/footer.do"/>	
</body>
</html>