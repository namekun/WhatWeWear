<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap start -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="<c:url value="/resources/css/bootstrap.min.css" /> " rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-3.3.1.js" /> "></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" /> "></script> 
<!--bootstrap end -->

<!-- chatbot.css link -->
<link href="<c:url value="/resources/css/chatbot.css" /> " rel="stylesheet">

<!-- font awesome -->
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">

<!-- w3schools & font-awesome -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<body>
<jsp:include page="/WEB-INF/views/randomImage.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/ishot.jsp"></jsp:include>

<header id="header" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	<i class="fa fa-comments-o" id="comments"></i>
	오늘 뭐 입지?
</header>

<!-- <div id="wrapper" > -->
	<div id="said">
	</div>
<!-- </div> -->

<footer id="footer">
	<!-- <button type="button" id="btn_restart" class="btn btn-primary">대화 재시작</button> -->

	<input type="text" 
			   id="txt_isay" 
			   class="col-lg-10 col-md-10 col-sm-10 col-xs-10"
			   placeholder="메시지를 입력하세요"/>

	<span>
	<button type="button" 
			id="btn_isay" 
			class="col-lg-2 col-md-2 col-sm-2 col-xs-2 btn btn-default">
		<i class="fa fa-send"></i>
	</button>
	</span>
</footer>

</body>
</html>