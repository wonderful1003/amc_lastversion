<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   <!-- Bootstrap Paver -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/prism/0.0.1/prism.min.js"></script>
	<script type="text/javascript" src="../dist/js/jquery.paver.min.js"></script>
	<script type="text/javascript" src="../demo/dist/js/functions.min.js"></script>

	
	<link type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/3.0.0/normalize.min.css" media="all" rel="stylesheet" />
	<link href="https://fonts.googleapis.com/css?family=PT+Serif:400italic" rel="stylesheet" type="text/css">
	<link type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/prism/0.0.1/prism.min.css" media="all" rel="stylesheet" />
	
	<script type="text/javascript">
		$(function () {
    		$('div[data-paver]').paver();
		});
	</script>
	
	<script>
		(function(i,s,o,g,r,a,m){i["GoogleAnalyticsObject"]=r;i[r]=i[r]||function(){
			(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,"script","https://www.google-analytics.com/analytics.js","ga");
		ga("create", "UA-46830269-1", "terrymun.github.io");
		ga("send", "pageview");
	</script>

	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
    <title>이미지 마커와 커스텀 오버레이</title>
    <style>
.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>
</head>
<body>

	<div class="container">
	<!-- Carousel
    ================================================== -->
	    <div id="myCarousel" class="carousel slide" data-ride="carousel">
	      <!-- Indicators -->
	      <ol class="carousel-indicators">
	        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	        <li data-target="#myCarousel" data-slide-to="1"></li>
	        <li data-target="#myCarousel" data-slide-to="2"></li>
	        <li data-target="#myCarousel" data-slide-to="3"></li>
	        <li data-target="#myCarousel" data-slide-to="4"></li>
	      </ol>
	      <div class="carousel-inner" role="listbox">
	        <div class="item active">
	          <img class="img-responsive center-block" src="../image/theater/theaterEnter1.jpg" alt="First slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <h1></h1>
	              <p><code></code></p>
	            </div>
	          </div>
	        </div>
	        <div class="item">
	          <img class="img-responsive center-block" src="../image/theater/theaterEnter2.jpg" alt="Second slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <h1></h1>
	              <br/>
	              <br/>
	              <p></p>
	            </div>
	          </div>
	        </div>
	        <div class="item">
	          <img class="img-responsive center-block" src="../image/theater/theaterElevator.jpg" alt="third slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <p></p>
	              <p></p>
	            </div>
	          </div>
	        </div>
	         <div class="item">
	          <img class="img-responsive center-block" src="../image/theater/screenTheaterEnter.jpg" alt="four slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <p></p>
	              <p></p>
	            </div>
	          </div>
	        </div>
	         <div class="item">
	          <img class="img-responsive center-block" src="../image/theater/screenTheaterLobby.jpg" alt="five slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <p></p>
	              <p></p>
	            </div>
	          </div>
	        </div>
	      </div>
	      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
	        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	        <span class="sr-only">Previous</span>
	      </a>
	      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
	        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	        <span class="sr-only">Next</span>
	      </a>
	    </div><!-- /.carousel -->
    </div>
    
   <figure>
    <div data-paver>
        <img src="../image/theater/1.jpg" title="Sunset in the heart of Aarhus" alt="A panorama taken from the roof of my penthouse unit in the center of Aarhus." />
    </div>
    <figcaption>Sunset in the heart of Aarhus&mdash;A panorama taken from the roof of my penthouse unit in the center of Aarhus.</figcaption>
	</figure>
    
    
    
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=602c37cc6b68ef5c22dd85c18e6663a5"></script>
<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
  mapOption = { 
        center: new daum.maps.LatLng(37.4946444, 127.02759279999998), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new daum.maps.Map(mapContainer, mapOption);

var markerPosition = new daum.maps.LatLng(37.4946444, 127.02759279999998); // 마커가 표시될 위치입니다


// 마커를 생성합니다
var marker = new daum.maps.Marker({
  position: markerPosition,
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);  

// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
var content = '<div class="customoverlay">' +
    '  <a href="http://map.daum.net/link/map/24048361" target="_blank">' +
    '    <span class="title">AmericodeCinema</span>' +
    '  </a>' +
    '</div>';

// 커스텀 오버레이가 표시될 위치입니다 
var position = new daum.maps.LatLng(37.4946444, 127.02759279999998);  

// 커스텀 오버레이를 생성합니다
var customOverlay = new daum.maps.CustomOverlay({
    map: map,
    position: position,
    content: content 
});

//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();

// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

//지도에 교통정보를 표시하도록 지도타입을 추가합니다
//map.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);    

</script>
</body>
</html>