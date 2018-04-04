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
<title>page title</title>
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
   rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-3.3.1.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<!-- bootstrap end -->
<meta charset="utf-8">
<script
   src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>

<script>
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
                   
       				return weather   
                 
                }
                });
            });
       </script>
</head>
<body>
   <div>
      <div id="locationinfo"></div>
      <div id="weatherinfo"></div>
      <div id="tempinfo"></div>
   </div>
</body>
</html>