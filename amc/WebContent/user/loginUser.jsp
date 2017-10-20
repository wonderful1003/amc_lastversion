<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<!-- 카카오 로그인 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	
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
							/* method : "POST" , */
							method : "POST" ,
							async : "false",
							/* dataType : "json" , */
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify({
								userId : id,
								password : pw
							}),
							success : function(JSONData , status) {

								//Debug...
								//alert(status);
								//alert("JSONData : \n"+JSONData);
								//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
								alert("JSONData : "+ JSONData );
								alert("status : "+ status );
								
							/* 	if(JSONData == ''){
									alert("비어있다");
								}
								 */
								/* if( JSONData != null || JSONData !=''){ */
									if( JSONData !=''){
									//[방법1]
									alert("login ajax success");
									$(window.parent.document.location).attr("href","/index.jsp");
									
									//[방법2]
									//window.parent.document.location.reload();
									
									//[방법3]
									//$(window.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
									//$(window.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
									//$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
									
									//==> 방법 1 , 2 , 3 결과 학인
								}else{
									alert("아이디 , 패스워드를 확인하시고 다시 로그인1...");
								}
							},
							error:function(request,status,error){
								alert(error);
								alert("아이디 , 패스워드를 확인하시고 다시 로그인2...");
						       }
					}); 
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			});
		});	
		
		
		//============= 회원원가입화면이동 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				/* self.location = "/user/addUser" */
				self.location = "/user/authForm.jsp"
			});
		});
		
		//============= ID/PW 찾기 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#findUser").on("click" , function() {
				/* self.location = "/user/addUser" */
				self.location = "/user/findUser.jsp"
			});
		});
		
		//============= 카카오 로그인 =============
		
			
		$("#kakao").on("click" , function(){
			$(document).ready(function(){
			Kakao.init("cb07b923496fc037b5450da00da1428a");
			
			
			function getKakaoUserProfile(){
				Kakao.API.request({
					url: '/v1/user/me',
					success: function(res) {
						console.log("ressssss :: " + res);
						var userId = res.kaccount_email;       
		           		var tempId = userId.replace(".", ",");
		           		console.log("userId :: " + userId);
		           		console.log("tempId :: " + tempId);
		           		$.ajax({
		           					/* url : "/user/checkUserId/"+tempId, */
		           					url : "/user/checkUserId",
			                      	method : "POST",
			                      	dataType : "json",
			                      	headers : {
			                       		"Accept" : "application/json",
			                       		"Content-Type" : "application/json"
			                      	},
			                      	success : function(JSONData, status) {     
			                       		if(JSONData.user ==null ) {
			                       			alert("계정이 없습니다. 회원가입을 해주시기 바랍니다.");
			                       			self.location="/user/addUser.jsp?userId="+userId;                 
			                         	}else if(JSONData.user.role == 4){
			                       			alert("탈퇴한 계정입니다.");  
			                       			$(self.location).attr("href","/user/logout");
			
			                       			self.location="/user/login"
			                         	}else{
			                       	  		self.location="/user/login"
			                         	}
			                      	}//sucess
			           });//ajax
			           					
						$("#kakao-profile").append(res.properties.nickname);
						$("#kakao-profile").append(res.kaccount_email);
		          	},//sucess                  
					
					fail: function(error) {
						console.log(error);
					}
				});
			}
		});
			
			function createKakaotalkLogin(){
				$("#kakao-logged-group .kakao-logout-btn,#kakao-logged-group .kakao-login-btn").remove();
				var loginBtn = $("<a/>",{"class":"kakao-login-btn","text":"로그인"});
				loginBtn.click(function(){
					Kakao.Auth.login({
						persistAccessToken: true,
						persistRefreshToken: true,
						success: function(authObj) {
							//논스톱 추가
							var accessToken = Kakao.Auth.getAccessToken();
		    				Kakao.Auth.setAccessToken(accessToken);						
							///////////////////////////
							getKakaoUserProfile();
							createKakaotalkLogout();
						},
						fail: function(err) {
							console.log(err);
						}
					});
				});
				$("#kakao-logged-group").prepend(loginBtn)
			}
			
			
			function createKakaotalkLogout(){
				$("#kakao-logged-group .kakao-logout-btn,#kakao-logged-group .kakao-login-btn").remove();
				var logoutBtn = $("<a/>",{"class":"kakao-logout-btn","text":"로그아웃"});
				logoutBtn.click(function(){
					Kakao.Auth.logout();
					createKakaotalkLogin();
					$("#kakao-profile").text("");
				});
				$("#kakao-logged-group").prepend(logoutBtn);
			}
			if(Kakao.Auth.getRefreshToken()!=undefined&&Kakao.Auth.getRefreshToken().replace(/ /gi,"")!=""){
				createKakaotalkLogout();
				getKakaotalkUserProfile();
			}else{
				createKakaotalkLogin();
			}
		});
		
		
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
					<img id = "kakao" src="../images/user/kakaobtn.png" class="img-rounded" width="20%">  &nbsp;
		
					
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