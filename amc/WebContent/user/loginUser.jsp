

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="utf-8"/>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	
	<!-- 카카오 로그인 -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- 카카오 로그인 -->
	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		//============= "로그인"  Event 연결 =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#login").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				
				
				
		/* $("form").attr("method","POST").attr("action","/user/loginUser").attr("target","_parent").submit(); */
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				$.ajax( 
						{	
							url : "/user/json/loginUser",
							method : "POST" ,
							async : "false",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify({
								userId : id,
								password : pw
							}),
							dataType : "text",
							success : function(JSONData , status) {

								//Debug...
								//alert(status);
								//alert("JSONData : \n"+JSONData);
								//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
								//alert("JSONData : "+ JSONData );
								//alert("status : "+ status );
								
								var JSONData = $.parseJSON(JSONData);
								var displayValue = "유저타입 : "+JSONData.role;
								
								//alert( JSONData.role );
								//console.log(JSONData);
								
									if( JSONData.role != 'not' && JSONData !=''){
									//[방법1]
									
									$(window.parent.document.location).attr("href","/index.jsp");
									
								}else if(JSONData.role = 'not'){
									alert("탈퇴했으면서 어딜들어오려고!");
								}else{
									alert("아이디 , 패스워드를 확인하시고 다시 로그인1...");
								}
							},
							error:function(request,status,error){
								alert(error);
								alert("아이디 , 패스워드를 확인하시고 다시 로그인2...");
						    }
					}); 
			});
		});	
		
		//============= 회원원가입화면이동 =============
		$( function() {
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/authForm.jsp"
			});
		});
		
		//============= ID/PW 찾기 =============
		$( function() {
			$("#findUser").on("click" , function() {
				self.location = "/user/findUser.jsp"
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
			                      	dataType : "json",
			                      	headers : {
			                       		"Accept" : "application/json",
			                       		"Content-Type" : "application/json"
			                      	},
									data : JSON.stringify({
										userId : userId
										/* password : pw */
									}),

			                      	success : function(JSONData, status) {     
			                       		if(JSONData.user == null ) {
			                       			alert("반갑습네다.");
			                       			self.location="/user/addUser";                 
			                         	}else if(JSONData.user == ''){
			                         		alert("계정이 없습니다. 회원가입을 해주시기 바랍니다.");  
			                       			$(self.location).attr("href","/user/addUser");
			
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

<body>

	
	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div> 
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">		
			<div class="col-md-6">
				<img src="../images/uploadFiles/1.jpg" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">	 	 	
		 	 	<br/><br/>			
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">아 이 디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					 
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" id="login" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>					      					    
					  
					<!-- <a href="/user/kakaoGetCode" ><img src="../images/user/kakaobtn.png" class="img-rounded" width="20%"> </a> &nbsp; -->
				
					<a id="custom-login-btn" href="javascript:loginWithKakao()">
					<img src="../images/user/kakaobtn.png" class="img-rounded" width="20%">  &nbsp;
					</a>
					
					<a href="/user/kakaoGetCode" ><img src="../images/user/naverbtn.PNG" class="img-rounded" width="20%"> </a> &nbsp;
		
					
					<a href="/user/kakaoGetCode" ><img src="../images/user/googlebtn.png" class="img-rounded" width="25%"> </a>
  
					    </div>
					</form>
			   	</div>
				
				
							<div>		
				<span class="col-md-4">
					<!-- <img src="../images/user/kakao_account.png" id = "kakao" class="img-rounded" width="70%" /> -->
<!-- 					<a href="/user/kakaoGetCode" ><img src="../images/user/kakaobtn.png" class="img-rounded" width="30%"> </a>
		
					<img src="../images/user/naver.account.PNG" id = "naver" class="img-rounded" width="70%" />
					<a href="/user/kakaoGetCode" ><img src="../images/user/nnaverbtn.PNG" class="img-rounded" width="30%"> </a>
		
					<img src="../images/user/google_account.png" id = "google" class="img-rounded" width="70%" />
					<a href="/user/kakaoGetCode" ><img src="../images/user/googlebtn.png" class="img-rounded" width="30%"> </a>
 -->				
		    </div>
				
				
				
				
				<div class="col-sm-offset-4 col-sm-6 text-center">
					<button id="findUser" class="btn btn-primary"  >ID &nbsp;/ &nbsp;PW &nbsp;찾기</button>					      					      					   
				</div>
				
			</div>
		</div>	
  	 </div>
  	 	<!--  row Start /////////////////////////////////////-->
  	
 	<!--  화면구성 div end /////////////////////////////////////-->

</body>
</html>