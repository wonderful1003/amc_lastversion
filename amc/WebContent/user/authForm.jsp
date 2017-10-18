<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">	
	<!-- 참조 : http://getbootstrap.com/css/    -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- 카카오 API -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<title>Login Demo - Kakao JavaScript SDK</title>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- 카카오 API -->
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 다음 주소 CDN -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body{
			padding-top : 70px;
		}
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		//============= "인증메일발송"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.join" ).on("click" , function() {
				fncSendMail();
			});
		});	
		
		
		function fncSendMail() {
			
			 var email=$("input[name='email']").val();			    
			 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) 
				 || email == ""){
		    	alert("이메일 형식이 아닙니다.");
		    	return;
		     }
			
			$("form").attr("method" , "POST").attr("action" , "/user/auth").submit();
		}
		
	</script>		
    
</head>

<body bgcolor="#ffffff" text="#000000">

	<jsp:include page="../layout/topToolbar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<!-- <form action="/sendMail/auth" id="findForm" method="post"> -->
		<form id="findForm">
		    <fieldset>
		        <legend class="screen_out">인증코드</legend>
		 
		        <div class="box email">
		            <label for="email">이메일</label>
		            <input type="text" id="email" name="email" autofocus autocomplete="off" required />
		        </div>
	
		 
		        <div class="box btn">
		            <button type="button" class="btn join">
		                <i class="fa fa-envelope"></i>
		               	 인증코드발송
		            </button>
		        </div>        
	
		    </fieldset>
		</form> 
	</div>	    
	
	<!-- Modal 화면 tool bar로 부터 받아오기	 --> 
	<div id="modal-testNew" class="modal fade" tabindex="-1" role="dialog" 
									aria-labelledby="테스트정보 등록" aria-describedby="테스트 모달">
	    <div class="modal-dialog" style="width:1200px;height:700px">
	        <div class="modal-content">
	        </div>
	    </div>
	</div> 


</body>

</html>