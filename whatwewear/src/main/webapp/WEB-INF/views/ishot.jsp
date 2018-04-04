<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap start -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="<c:url value="/resources/css/bootstrap.min.css" /> "
   rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-3.3.1.js" /> "></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" /> "></script>
<!--bootstrap end -->

<!-- chatbot.css link -->
<link href="<c:url value="/resources/css/chatbot.css" /> "
   rel="stylesheet">

<!-- jQuery Script-->
<script type="text/javascript">
   $(document).ready(function() {
      var root = '<c:url value="/"/>';


      $('#btn_restart').click(function() { //대화 재시작 버튼 누르면
         let re = confirm('기존 대화가 모두 사라집니다.\n대화를 재시작 할까요?');
         if (re) {
            $('#said').html(''); //대화영역인 said를 모두 비운다.
            ajax_process('');
         }
      });

      $('#txt_isay').keypress(function(e) { //txt_isay 영역에서 눌린 키에 대한 이벤트 e를 받는다.
         if (e.which === 13) { // e가 뭐냐 (13 = Enter 키의 ASCII 코드)
            conversation(); //엔터 치면 conversation 수행
         }
      });

      $('#btn_isay').click(function() {
         conversation(); //버튼을 눌려도 conversation 수행
      });
      ajax_process(''); //맨 처음 한번에는 공백을 넘겨준다. 왓슨의 인사를 먼저 받기 위해


      function conversation() {
         let _isay = $.trim($('#txt_isay').val()); // 공백을 제거
         if (_isay === '') { //_isay에 공백만 입력됐다면
            alert('내용을 입력하세요');
            return;
         }
         let isay = '<p style="text-align: right;"><span class="ibubble">' + _isay + '</span></p>'; //내가 입력한 부분은 오른쪽으로 정렬
         $('#said').append(isay);
         $('html, body').animate({
            scrollTop : $(document).height()
         }, 500);
         $('#txt_isay').val(''); //내가 입력한 내용을 지워준다.
         ajax_process(_isay);
      }

      function ajax_process(_isay) {
         $.ajax({
            type : 'POST',
            url : 'watsonsay',
            data : {
               'isay' : _isay
            }, //txt_isay를 통해 입력받은 내용을 isay 파라미터로 Controller에 넘긴다.
            //      async : false,   //async false = 비동기화
            success : function(data) { // 서버에서 messageresponse로 넘겨준 게 성공했을 때 동작
               let watsonsay = '<span><img src="' + root + 'resources/img/smile.png" id="icon"/>오늘뭐입지봇</span>' +
                  '<p><img src="' + root + 'resources/img/smile.png" id="hiddenicon"/>' + '<span class="wbubble">'; //watson이 말하는 부분은 왼쪽으로 정렬 
               let temp = parseInt(data.output.text);
               if (temp >= 27) {
                  watsonsay +=  temp27up();
               } else if (temp >= 20 && temp < 27) {
                  watsonsay += temp24to27();
               } else if (temp >= 6 && temp < 20) {
                  watsonsay += temp6to24();
               } else if (temp < 5) {
                  watsonsay += temp5under();
               } else {
                  watsonsay += data.output.text;
                  watsonsay += '</span></p>';
               }
               $('#said').append(watsonsay);
               $('html, body').animate({
                  scrollTop : $(document).height()
               }, 500); //스크롤의 제일 위쪽 높이를 계산해서 현재문서로 맞춰준다.(500=0.5초)
            }
         });
      }

      function temp27up() {
         watsonrecommend =
            '<br/><span style="width: 200px; padding: 5px; display: inline-block;">덥습니다. 매우.</span><br/></p>';
         return watsonrecommend;
      }

      function temp20to27() {
          watsonrecommend =
             '<br/><span style="width: 200px; padding: 5px; display: inline-block;">덥습니다.</span><br/></p>';
          return watsonrecommend;
       }

      function temptemp6to20{
          watsonrecommend =
             '<br/><span style="width: 200px; padding: 5px; display: inline-block;">덥지 않습니다.</span><br/></p>';
          return watsonrecommend;
       }

     
      function temp5under{
          watsonrecommend =
             '<br/><span style="width: 200px; padding: 5px; display: inline-block;">오히려 춥습니다.</span><br/></p>';
          return watsonrecommend;
       }
     

   });
</script>

</head>
<body>
</body>
</html>