<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html lang="en">
<c:import url="/header.do"/>
<head>
  <title>Company Page</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://cdn.emailjs.com/sdk/2.2.4/email.min.js"></script>
  <style>
  .jumbotron {
      background-color: #538ce8;
      color: #fff;
      padding: 100px 25px;
  }
  .container-fluid {
      padding: 60px 50px;
  }
  .bg-grey {
      background-color: #f6f6f6;
  }
  .logo-small {
      color: #538ce8;
      font-size: 50px;
  }
  .logo {
  	
      color: #538ce8;
      font-size: 200px;
  }
 img{
    float: left;
    margin-top: -20px;
  }
  @media screen and (max-width: 768px) {
    .col-sm-4 {
      text-align: center;
      margin: 25px 0;
    }
  }
    .use {
    display: block;
    text-align: center;
    margin-top: 20px;
    font-weight: bold;
    font-size: 13px;
    color: #ff9320;
    text-decoration: underline;
  </style>
  <script type="text/javascript">
  var emailC = {
			
	    	email_to : 'onewonchoi2603@gmail.com',
	        from_name : '안녕하세요 입니다. 임시 비밀번호를 드립니다.',
	        message_html: 'ㅎㅇ'
	     	}
  
  function sendMail(){
       emailjs.init("user_H3yutwk4dSFJmaa6dUMMh"); // 바꿀 필요 없습니다. Account 에 User ID 랑 똑같습니다.
       emailjs.send("one2","template_0oasa6Mg",emailC)
      .then(function(response) {
          console.log("SUCCESS. status=%d, text=%s", response.status, response.text);
      }, function(err) {
          console.log("FAILED. error=", err);
      });

      /*
      YOUR SERVICE ID : Email Service 에서 등록한  Service ID
      YOUR TEMPLATE ID : Email Template 에 들어가면 이미 하나 만들어져 있습니다. 거기 있는 Template ID 등록    
      then 부터 콜백처리입니다. 성공하면 reponse 실패하면 error
      */
  };
  </script>
</head>
<body>

<div class="jumbotron text-center">
  <h1>Admin page</h1> 
  <p>Member Management, Review Management</p> 
</div>
<!-- Container (Services Section) -->
<div class="container-fluid text-center">
  <h2>SERVICES</h2>
  <h4>What we offer</h4>
  <br>
  <div class="row">
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-off logo-small"></span>
      <!-- <h4>POWER</h4> -->
      <a class="use"; href="adminreview.do">회원</a>
      <!-- <p>Lorem ipsum dolor sit amet..</p> -->
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-heart logo-small"></span>
      <!-- <h4>LOVE</h4> -->
      <a class="use"; href="adminmember.do">리뷰</a>
      <!-- <p>Lorem ipsum dolor sit amet..</p> -->
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-lock logo-small"></span>
      <a class="use" href="javascript:sendMail()">JOB DONE</a>
    </div>
  </div>
  <br><br>
  <div class="row">
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-leaf logo-small"></span>
      <h4>GREEN</h4>
      <p>Lorem ipsum dolor sit amet..</p>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-certificate logo-small"></span>
      <h4>CERTIFIED</h4>
      <p>Lorem ipsum dolor sit amet..</p>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-wrench logo-small"></span>
      <h4 style="color:#303030;">HARD WORK</h4>
      <p>Lorem ipsum dolor sit amet..</p>
    </div>
  </div>
</div>
</body>
<c:import url="/footer.do"/>
</html>
