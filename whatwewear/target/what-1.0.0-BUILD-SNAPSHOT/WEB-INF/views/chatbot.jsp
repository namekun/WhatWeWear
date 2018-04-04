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

<!-- bubbles css 사용하기 위한 link -->
<link href="<c:url value="/resources/css/bubbles.css" /> " rel="stylesheet">

<!-- jQuery Script-->
<script type="text/javascript">

<!-- weather -->
$(document).ready(function(){
$.ajax({
    url : "http://api.wunderground.com/api/419e7318e430beec/geolookup/conditions/q/KR/Seoul.json",
    dataType : "jsonp",
    success : function(parsed_json){
        var location = "위치 : " +parsed_json['current_observation']['display_location']['full'];
        var weather = "날씨 : " + parsed_json['current_observation']['weather'];
        var temperature = "기온 : " + parsed_json['current_observation']['temp_c']+"℃";
       
        if(parsed_json['current_observation']['weather']=="")
        { weather +="날씨정보가 없습니다";}
      
       
        $("#locationinfo").append(location);
        $("#weatherinfo").append(weather);
        $("#tempinfo").append(temperature);
       
    }
    });
});


$(document).ready(function() { //html을 열어놓고 준비
   
   $('#btn_restart').click(function() {   //대화 재시작 버튼 누르면
      let re = confirm('기존 대화가 모두 사라집니다.\n대화를 재시작 할까요?');
      if(re) {
         $('#said').html('');   //대화영역인 said를 모두 비운다.
         ajax_process('');
      }
   });
   
   $('#txt_isay').keypress(function(e) {   //txt_isay 영역에서 눌린 키에 대한 이벤트 e를 받는다.
      if(e.which === 13) {      // e가 뭐냐 (13 = Enter 키의 ASCII 코드)
         conversation();      //엔터 치면 conversation 수행
      }
   });
   
   $('#btn_isay').click(function() {
      conversation();      //버튼을 눌려도 conversation 수행
   });
   ajax_process('');   //맨 처음 한번에는 공백을 넘겨준다. 왓슨의 인사를 먼저 받기 위해
});

function conversation() {
   let _isay = $.trim($('#txt_isay').val());   // 공백을 제거
   if(_isay === '') {   //_isay에 공백만 입력됐다면
      alert('내용을 입력하세요');
      return;
   }
   let isay = '<p class="triangle-border right">' + _isay + '</p>';   //내가 입력한 부분은 오른쪽으로 정렬
   $('#said').append(isay);
   $('#txt_isay').val('');      //내가 입력한 내용을 지워준다.
   ajax_process(_isay);
}

function ajax_process(_isay) { 
   $.ajax({                  //ajax식으로 xhr.open("GET",url, true)
      type : 'POST',
      url  : 'watsonsay',
      data : {'isay': _isay},   //txt_isay를 통해 입력받은 내용을 isay 파라미터로 Controller에 넘긴다.
//      async : false,   //async true = 비동기화
      success : function(data) {   // 서버에서 messageresponse로 넘겨준 게 성공했을 때 동작
         let watsonsay =
            '<p class="triangle-border left">' + data.output.text;   //watson이 말하는 부분은 왼쪽으로 정렬
            if(_isay === '') {   //맨 처음 isay가 공백일 때 왓슨이 말하는 부분 뒤에 사진 붙여줌
               watsonsay += '<img src="<c:url value="/resources/img/emoji.png" />" width="40px" />';
             } //else if(_isay == '오늘 날씨 어때?'){
//                watsonsay +=  $("#weatherinfo").append(weather);
//             }
            watsonsay += '</p>';
            $('#said').append(watsonsay);//왓슨이 말하는 것을 붙여준다.
            $('html, body').animate({scrollTop:$(document).height()}, 500)   //스크롤의 제일 위쪽 높이를 계산해서 현재문서로 맞춰준다.(500=0.5초)
      }
   });
}
</script>
</head>
<body>
<div id="said"></div>
<button type="button" id="btn_restart" class="btn btn-primary">대화 재시작</button>
<input type="text" id="txt_isay" class="triangle-border center" />
<button type="button" id="btn_isay" class="btn btn-default">say</button>

</body>
</html>