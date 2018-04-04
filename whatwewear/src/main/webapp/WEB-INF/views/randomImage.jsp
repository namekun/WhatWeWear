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
      var images = new Array();
      var saveNum = null;

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
                  watsonsay += randomImage27up();
               } else if (temp >= 24 && temp < 27) {
                  watsonsay += randomImage24to27();
               } else if (temp >= 20 && temp < 24) {
                  watsonsay += randomImage20to23();
               } else if (temp >= 16 && temp < 20) {
                  watsonsay += randomImage16to19()
               } else if (temp >= 10 && temp < 16) {
                  watsonsay += randomImage10to15();
               } else if (temp >= 6 && temp < 10) {
                  watsonsay += randomImage6to9();
               } else if (temp < 5) {
                  watsonsay += randomImage5under();
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

      function randomImage27up() {
         images[0] = 'resources/img/up27/up27tshirt.jpg';
         images[1] = 'resources/img/up27/up27tshirt2.jpg';

         var text = [
            '오늘은 덥습니다. 반팔에 반바지밖에 선택지가 없는 것 같군요..',
            '오늘은 덥습니다. 반팔에 반바지밖에 선택지가 없는 것 같군요..',
         ];
         let watsonrecommend = null;
         var ranNum = -1;

         do {
            ranNum = parseInt(Math.random() * images.length);
         } while (saveNum == ranNum);
         watsonrecommend = '<span class="wbubble">' +
            '<img src="' + root + images[ranNum] + '" class="img-rounded" style="width: 200px;"/></span>' +
            '<br/><span style="width: 200px; padding: 5px; display: inline-block;">' + text[ranNum] +
            '</span><br/></p>';
         saveNum = ranNum;
         return watsonrecommend;
      }

      function randomImage24to27() {
         images[0] = 'resources/img/24to27/24-27longpants.jpg';
         images[1] = 'resources/img/24to27/24-27longpants2.jpg';
         images[2] = 'resources/img/24to27/24-27longpants3.jpg';

         var text = [
            '더운 날씨입니다.간단히 티셔츠 한장이면 시원하게 하루를 보낼 수 있을겁니다.',
            '더운 날씨입니다.간단히 티셔츠 한장이면 시원하게 하루를 보낼 수 있을겁니다.',
            '더운 날씨입니다.간단히 티셔츠 한장이면 시원하게 하루를 보낼 수 있을겁니다.'
         ];
         let watsonrecommend = null;
         var ranNum = -1;

         do {
            ranNum = parseInt(Math.random() * images.length);
         } while (saveNum == ranNum);
         watsonrecommend = '<span class="wbubble">' +
            '<img src="' + root + images[ranNum] + '" class="img-rounded" style="width: 200px;"/></span>' +
            '<br/><span style="width: 200px; padding: 5px; display: inline-block;">' + text[ranNum] +
            '</span><br/></p>';
         saveNum = ranNum;
         return watsonrecommend;
      }

      function randomImage20to23() {
         images[0] = 'resources/img/20to23/20-23cardigan.jpg';
         images[1] = 'resources/img/20to23/20-23hoodie.jpg';
         images[2] = 'resources/img/20to23/20-23shirt.jpg';
         images[3] = 'resources/img/20to23/20-23shirt2.jpg';

         var text = [
            '오늘 같은 환절기에는 가볍게 걸칠 수 있고,따듯한 가디건 하나를 챙겨가시는 것이 어떠실까요?',
            '진정한 멋쟁이는 환절기에 멋을 부립니다.후드티에 반바지면 적당할 것 같습니다.',
            '환절기에는 기온에 따라서 입고 벗을 것이 중요합니다.셔츠 한 장 가지고 나가시는 게 어떠신가요?',
            '환절기에는 기온에 따라서 입고 벗을 것이 중요합니다.셔츠 한 장 가지고 나가시는 게 어떠신가요?'
         ];
         let watsonrecommend = null;
         var ranNum = -1;

         do {
            ranNum = parseInt(Math.random() * images.length);
         } while (saveNum == ranNum);
         watsonrecommend = '<span class="wbubble">' +
            '<img src="' + root + images[ranNum] + '" class="img-rounded" style="width: 200px;"/></span>' +
            '<br/><span style="width: 200px; padding: 5px; display: inline-block;">' + text[ranNum] +
            '</span><br/></p>';
         saveNum = ranNum;
         return watsonrecommend;
      }

      function randomImage16to19() {
         images[0] = 'resources/img/16to19/16-19cardigan.jpg';
         images[1] = 'resources/img/16to19/16-19jacket.jpg';
         images[2] = 'resources/img/16to19/16-19jacket2.jpg';
         images[3] = 'resources/img/16to19/16-19jacket3.jpg';
         images[4] = 'resources/img/16to19/16-19jacket4.jpg';
         images[5] = 'resources/img/16to19/16-19jacket5.jpg';
         images[6] = 'resources/img/16to19/16-19m65.jpg';
         images[7] = 'resources/img/16to19/16-19m652.jpg';
         images[8] = 'resources/img/16to19/16-19shirt.jpg';
         images[9] = 'resources/img/16to19/16-19sweat.jpg';
         images[10] = 'resources/img/16to19/16-19sweat2.jpg';
         images[11] = 'resources/img/16to19/16-19sweat3.jpg';

         var text = [
            '오늘은 가볍고 따듯한 가디건이 어떠신가요?',
            '자켓은 간단하며 격식있는 멋을 부릴수 있는 아이템입니다.오늘은 자켓을 걸쳐보시는게 어떠신가요?',
            '자켓은 간단하며 격식있는 멋을 부릴수 있는 아이템입니다.오늘은 자켓을 걸쳐보시는게 어떠신가요?',
            '자켓은 간단하며 격식있는 멋을 부릴수 있는 아이템입니다.오늘은 자켓을 걸쳐보시는게 어떠신가요?',
            '자켓은 간단하며 격식있는 멋을 부릴수 있는 아이템입니다.오늘은 자켓을 걸쳐보시는게 어떠신가요?',
            '자켓은 간단하며 격식있는 멋을 부릴수 있는 아이템입니다.오늘은 자켓을 걸쳐보시는게 어떠신가요?',
            'm65는 남성미와 멋을 동시에 살릴 수 있는 옷입니다.오늘 어떠신가요?',
            'm65는 남성미와 멋을 동시에 살릴 수 있는 옷입니다.오늘 어떠신가요?',
            '오늘 날씨에는 가볍게 셔츠차림으로 나서는 것도 나쁘지 않을 것 같습니다.',
            '스웨트는 편하며 쉽게 멋을 낼 수 있는 아이템입니다.날씨엔 딱인거 같은데요?',
            '스웨트는 편하며 쉽게 멋을 낼 수 있는 아이템입니다.날씨엔 딱인거 같은데요?',
            '스웨트는 편하며 쉽게 멋을 낼 수 있는 아이템입니다.날씨엔 딱인거 같은데요?'
         ];
         let watsonrecommend = null;
         var ranNum = -1;

         do {
            ranNum = parseInt(Math.random() * images.length);

         } while (saveNum == ranNum);
         watsonrecommend = '<span class="wbubble">' +
            '<img src="' + root + images[ranNum] + '" class="img-rounded" style="width: 200px;"/></span>' +
            '<br/><span style="width: 200px; padding: 5px; display: inline-block;">' + text[ranNum] +
            '</span><br/></p>';
         saveNum = ranNum;
         return watsonrecommend;
      }

      function randomImage10to15() {
         images[0] = 'resources/img/10to15/10-15jacket.jpg';
         images[1] = 'resources/img/10to15/10-15knit.jpg';
         images[2] = 'resources/img/10to15/10-15knit2.jpg';
         images[3] = 'resources/img/10to15/10-15trench.jpg';
         images[4] = 'resources/img/10to15/10-15trench2.jpg';
         images[5] = 'resources/img/10to15/10-15trench3.jpg';
         images[6] = 'resources/img/10to15/10-15trenchcoat2.jpg';

         var text = [
            '오늘은 조금 쌀쌀합니다. 안에도 따듯하게 입으시고, 자켓도 하나 입으시는게 좋으실 거 같습니다.',
            '니트의 계절입니다! 포근함과 따듯함 모두를 잡을 수 있는 니트. 오늘 어떠세요?',
            '니트의 계절입니다! 포근함과 따듯함 모두를 잡을 수 있는 니트. 오늘 어떠세요?',
            '알베르 까뮈도,알랭 들롱도,주윤발도 즐겼던 트렌치 코트는 남자의 멋을 나타내기 좋은 아이템입니다.',
            '알베르 까뮈도,알랭 들롱도,주윤발도 즐겼던 트렌치 코트는 남자의 멋을 나타내기 좋은 아이템입니다.',
            '알베르 까뮈도,알랭 들롱도,주윤발도 즐겼던 트렌치 코트는 남자의 멋을 나타내기 좋은 아이템입니다.',
            '알베르 까뮈도,알랭 들롱도,주윤발도 즐겼던 트렌치 코트는 남자의 멋을 나타내기 좋은 아이템입니다.'
         ];
         let watsonrecommend = null;
         var ranNum = -1;

         do {
            ranNum = parseInt(Math.random() * images.length);

         } while (saveNum == ranNum);
         watsonrecommend = '<span class="wbubble">' +
            '<img src="' + root + images[ranNum] + '" class="img-rounded" style="width: 200px;"/></span>' +
            '<br/><span style="width: 200px; padding: 5px; display: inline-block;">' + text[ranNum] +
            '</span><br/></p>';
         saveNum = ranNum;
         return watsonrecommend;
      }

      function randomImage6to9() {
         images[0] = 'resources/img/6to9/6-9coat.jpg';
         images[1] = 'resources/img/6to9/6-9coat2.jpg';
         images[2] = 'resources/img/6to9/6-9coat3.jpg';
         images[3] = 'resources/img/6to9/6-9coat4.jpg';
         images[4] = 'resources/img/6to9/6-9coat5.jpg';
         images[5] = 'resources/img/6to9/6-9coat6.jpg';
         images[6] = 'resources/img/6to9/6-9ma1.jpg';
         images[7] = 'resources/img/6to9/6-9ma12.jpg';
         images[8] = 'resources/img/6to9/6-9padding.jpg';
         images[9] = 'resources/img/6to9/6-9rider.jpg';
         images[10] = 'resources/img/6to9/6-9sherpa.jpg';
         images[11] = 'resources/img/6to9/6-9sherpa2.jpg';

         var text = [
            '코트는 고급스런 룩의 마무리를 짓는 화룡점정이라고 할 수 있습니다. 오늘 룩에 점을 한번 찍어보시는 것은 어떨까요?',
            '코트는 고급스런 룩의 마무리를 짓는 화룡점정이라고 할 수 있습니다. 오늘 룩에 점을 한번 찍어보시는 것은 어떨까요?',
            '코트는 고급스런 룩의 마무리를 짓는 화룡점정이라고 할 수 있습니다. 오늘 룩에 점을 한번 찍어보시는 것은 어떨까요?',
            '코트는 고급스런 룩의 마무리를 짓는 화룡점정이라고 할 수 있습니다. 오늘 룩에 점을 한번 찍어보시는 것은 어떨까요?',
            '코트는 고급스런 룩의 마무리를 짓는 화룡점정이라고 할 수 있습니다. 오늘 룩에 점을 한번 찍어보시는 것은 어떨까요?',
            '코트는 고급스런 룩의 마무리를 짓는 화룡점정이라고 할 수 있습니다. 오늘 룩에 점을 한번 찍어보시는 것은 어떨까요?',
            '밀리터리웨어의 클래식 중 하나인 MA-1은 이제 우리 곁에서 편하며, 따듯하게 입을 수 있는 옷으로 다가왔습니다. 오늘은 밀리터리웨어를 입어보시는 것이 어떠신가요?',
            '밀리터리웨어의 클래식 중 하나인 MA-1은 이제 우리 곁에서 편하며, 따듯하게 입을 수 있는 옷으로 다가왔습니다. 오늘은 밀리터리웨어를 입어보시는 것이 어떠신가요?',
            '경량패딩은 가벼움과 따듯함을 모두 잡은 아이템입니다. 또한 단정한 룩에 매우 잘 어울리죠. 오늘 같은 날씨에 단정히 옷을 입어야한다면 딱이라고 할 수 있습니다.',
            '라이더 자켓은 요즘 기온에만 입을 수 있는 특권이라고 할 수 있습니다. 거기에 스카프 한 장으로 포인트를 주시는 것은 어떨까요?',
            '겨울에도 청자켓을 입을 수 있다면 어떠신가요? 양털로 따듯함까지 갖고 있는 셰르파 자켓은 그 상상을 현실로 이루어 드립니다.',
            '겨울에도 청자켓을 입을 수 있다면 어떠신가요? 양털로 따듯함까지 갖고 있는 셰르파 자켓은 그 상상을 현실로 이루어 드립니다.'
         ];
         let watsonrecommend = null;
         var ranNum = -1;

         do {
            ranNum = parseInt(Math.random() * images.length);

         } while (saveNum == ranNum);
         watsonrecommend = '<span class="wbubble">' +
            '<img src="' + root + images[ranNum] + '" class="img-rounded" style="width: 200px;"/></span>' +
            '<br/><span style="width: 200px; padding: 5px; display: inline-block;">' + text[ranNum] +
            '</span><br/></p>';
         saveNum = ranNum;
         return watsonrecommend;
      }

      function randomImage5under() {
         images[0] = 'resources/img/under5/under5coat.jpg';
         images[1] = 'resources/img/under5/under5layer.jpg';
         images[2] = 'resources/img/under5/under5mustang.jpg';
         images[3] = 'resources/img/under5/under5mustang2.jpg';
         images[4] = 'resources/img/under5/under5mustang3.jpg';
         images[5] = 'resources/img/under5/under5padding.jpg';
         images[6] = 'resources/img/under5/under5padding2.jpg';
         images[7] = 'resources/img/under5/under5padding3.jpg';
         images[8] = 'resources/img/under5/under5padding4.jpg';

         var text = [
            '추운 날입니다. 코트를 입을 땐 안에 경량패딩도 같이 입어주세요. 훨씬 따듯하실겁니다.',
            '추운 날에는 여러겹 레이어 해서 입는 것도 좋습니다. 다만 이 사진만큼은 말구요.',
            '동물들이 어떻게 겨울을 나는지 궁금하시다면, 무스탕을 입어보시면 알 수 있으실 겁니다.',
            '동물들이 어떻게 겨울을 나는지 궁금하시다면, 무스탕을 입어보시면 알 수 있으실 겁니다.',
            '동물들이 어떻게 겨울을 나는지 궁금하시다면, 무스탕을 입어보시면 알 수 있으실 겁니다.',
            '솔직히 추운 날에는 패딩이외에는 별다른 선택지가 없습니다. 무채색 겨울에 패딩으로 형형색색 멋을 내보시는 것은 어떠실까요?',
            '솔직히 추운 날에는 패딩이외에는 별다른 선택지가 없습니다. 무채색 겨울에 패딩으로 형형색색 멋을 내보시는 것은 어떠실까요?',
            '솔직히 추운 날에는 패딩이외에는 별다른 선택지가 없습니다. 무채색 겨울에 패딩으로 형형색색 멋을 내보시는 것은 어떠실까요?',
            '솔직히 추운 날에는 패딩이외에는 별다른 선택지가 없습니다. 무채색 겨울에 패딩으로 형형색색 멋을 내보시는 것은 어떠실까요?'

         ];
         let watsonrecommend = null;
         var ranNum = -1;

         do {
            ranNum = parseInt(Math.random() * images.length);

         } while (saveNum == ranNum);
         watsonrecommend = '<span class="wbubble">' +
            '<img src="' + root + images[ranNum] + '" class="img-rounded" style="width: 200px;"/></span>' +
            '<br/><span style="width: 200px; padding: 5px; display: inline-block;">' + text[ranNum] +
            '</span><br/></p>';
         saveNum = ranNum;
         return watsonrecommend;
      }

   });
</script>

</head>
<body>
</body>
</html>