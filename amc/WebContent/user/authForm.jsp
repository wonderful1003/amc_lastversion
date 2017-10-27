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
 	var check = false;
		function fncCheckUser() {
			// Form 유효성 검증
			var id=$('#email').val();
			if(id == null || id.length <1){
				alert("아이디는 반드시 입력하셔야 합니다.");
				return;
			}
			if(!check){
				alert("이미 존재하는 아이디 입니다.");
				return;
			}
			fncSendMail();
		}
	
		//============= "인증메일발송"  Event 연결 =============
 		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.join" ).on("click" , function() {
				fncCheckUser();
			});
		});	
		
		function fncSendMail() {
			 var email=$("input[name='email']").val();			    
			 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) 
				 || email == ""){
		    	alert("이메일 형식이 아닙니다.");
		    	return;
		     }
			alert("메일을 성공적으로 보냈습니다.");
			$("form").attr("method" , "POST").attr("action" , "/user/auth").submit();
		}
 		
		//==>""이메일" 유효성Check / ID중복확인" Event 처리 및 연결
		$(function(){					
			$('#email').bind('keyup', function(){
				var userId = $(this).val().trim();
				var tempId = userId.split(".");
	        	console.log("email :: " + email);
	         	console.log("tempId :: " + tempId);
					$.ajax({
						url : 'json/checkDuplication/'+tempId,
						method : 'get',
						dataType : 'json', 
						 headers : {
							'Accept' : 'application/json',
							'Content-Type' : 'application/json'
						}, 
						success : function(JSONData , status){
							/* alert("JSONData" + JSONData); */
							if(JSONData){
								$('span.help-block').html('사용가능한 아이디 입니다.').css('color','blue');
								check = true;
							}else{
								$('span.help-block').html('이미 존재하는 아이디 입니다.').css('color','red');
								check = false;
							}
						}
					});
				
					if(userId == ''){
						$('span.help-block').html('');
					}
			      
			});
		});		
		
		
		//============= 카카오 로그인 =============
		function loginWithKakao() {
			Kakao.init('fc5658887af25f840e94144f6722b228');
			// 로그인 창을 띄웁니다.
			Kakao.Auth.login({
		 		success: function(authObj) {
		   			var accessToken = Kakao.Auth.getAccessToken();
		    		Kakao.Auth.setAccessToken(accessToken);
		    
		    		Kakao.API.request({
		    			url: '/v1/user/me',
		       			success: function(res) {
			        		console.log("response 확인 :: " + res);
			           		var userId = res.kaccount_email;       
			           		/* var tempId = userId.replace(".", ","); */
			           		console.log("userId :: " + userId);
			           		/* console.log("tempId :: " + tempId); */
			           		$.ajax(
			            		{
			                   		/* url : "/user/json/loginUser/"+tempId, */
			                   		url : "/user/json/kakaoLogin", 
			                      	method : "POST",
			                      	/* dataType : "json", */
			                      	headers : {
			                       		"Accept" : "application/json",
			                       		"Content-Type" : "application/json"
			                      	},
									data : JSON.stringify({
										userId : userId
										/* password : pw */
									}),
			                      	success : function(JSONData, status) {
			                      		alert("성공");
			                       		if(JSONData.user == null ) {
			                       			alert("계정이 없습니다. 회원가입을 해주시기 바랍니다..");
			                       			$(self.location).attr("href","/user/addUser?email="+userId);                 
			                         	}else if(JSONData.user != ''){
			                         		alert("반갑습니다.");  
			                       			$(self.location).attr("href","/user/loginUser");
			
			                       	  		location.reload();
			                         	}else{
			                       	  		location.reload();
			                         	}
			                      	}
			                });
		          		}                  
		      		});
			  	},
			   	fail: function(err) {
			   		alert(JSON.stringify(err));
			   	}
		  	});
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
		        <legend class="screen_in">이메일 인증 방법</legend>
		 	<div class="row">
		        <div class="box email">
		            <label for="email">이메일</label>
		            <input value="" type="text" id="email" name="email" autofocus autocomplete="off" required />		            
		        </div>
		        <span id="helpBlock" class="help-block col-sm-6"></span>
		        </div>
	
		 
		        <div class="box btn">
		            <button type="button" class="btn join">
		                <i class="fa fa-envelope"></i>
		               	 인증코드발송
		            </button>
		        </div>        
	
		    </fieldset>
		
		
		 <br/><br/><br/>
 		    
 		    <fieldset>
		        <legend class="screen_out">이메일 인증 방법</legend>
		    
			<div>		
				<span class="col-md-4">
					<!-- <img src="../images/user/kakao_account.png" id = "kakao" class="img-rounded" width="70%" /> -->
					<!-- <a href="/user/json/kakaoGetCode" ><img src="../images/user/kakao_account.png" class="img-rounded" width="70%"> </a> -->
					<a id="custom-login-btn" href="javascript:loginWithKakao()">
					<img src="../images/user/kakao_account.png" class="img-rounded" width="70%"></a>
			<br/><br/>
					<!-- <img src="../images/user/naver.account.PNG" id = "naver" class="img-rounded" width="70%" /> -->
					<a href="/user/json/start" ><img src="../images/user/naver.account.PNG" class="img-rounded" width="70%"> </a>
			<br/><br/>
					<!-- <img src="../images/user/google_account.png" id = "google" class="img-rounded" width="70%" /> -->
					<a href="/user/kakaoGetCode" ><img src="../images/user/google_account.png" class="img-rounded" width="70%"> </a>
				</span>
		    
		    </div>
		    
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