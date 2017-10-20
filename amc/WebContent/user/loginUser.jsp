<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<!-- īī�� �α��� -->
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

		//============= "�α���"  Event ���� =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#login").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID �� �Է����� �����̽��ϴ�.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('�н����带 �Է����� �����̽��ϴ�.');
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
									alert("����ִ�");
								}
								 */
								/* if( JSONData != null || JSONData !=''){ */
									if( JSONData !=''){
									//[���1]
									alert("login ajax success");
									$(window.parent.document.location).attr("href","/index.jsp");
									
									//[���2]
									//window.parent.document.location.reload();
									
									//[���3]
									//$(window.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
									//$(window.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
									//$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
									
									//==> ��� 1 , 2 , 3 ��� ����
								}else{
									alert("���̵� , �н����带 Ȯ���Ͻð� �ٽ� �α���1...");
								}
							},
							error:function(request,status,error){
								alert(error);
								alert("���̵� , �н����带 Ȯ���Ͻð� �ٽ� �α���2...");
						       }
					}); 
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			});
		});	
		
		
		//============= ȸ��������ȭ���̵� =============
		$( function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				/* self.location = "/user/addUser" */
				self.location = "/user/authForm.jsp"
			});
		});
		
		//============= ID/PW ã�� =============
		$( function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#findUser").on("click" , function() {
				/* self.location = "/user/addUser" */
				self.location = "/user/findUser.jsp"
			});
		});
		
		//============= īī�� �α��� =============
		
			
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
			                       			alert("������ �����ϴ�. ȸ�������� ���ֽñ� �ٶ��ϴ�.");
			                       			self.location="/user/addUser.jsp?userId="+userId;                 
			                         	}else if(JSONData.user.role == 4){
			                       			alert("Ż���� �����Դϴ�.");  
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
				var loginBtn = $("<a/>",{"class":"kakao-login-btn","text":"�α���"});
				loginBtn.click(function(){
					Kakao.Auth.login({
						persistAccessToken: true,
						persistRefreshToken: true,
						success: function(authObj) {
							//���� �߰�
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
				var logoutBtn = $("<a/>",{"class":"kakao-logout-btn","text":"�α׾ƿ�"});
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">		
			<div class="col-md-6">
				<img src="../images/uploadFiles/1.jpg" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">	 	 	
		 	 	<br/><br/>			
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">�� &nbsp;&nbsp;�� &nbsp;&nbsp;��</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">�� �� ��</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="���̵�" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">�� �� �� ��</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="�н�����" >
					    </div>
					  </div>
					 
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" id="login" class="btn btn-primary"  >�� &nbsp;�� &nbsp;��</button>
					      <a class="btn btn-primary btn" href="#" role="button">ȸ &nbsp;�� &nbsp;�� &nbsp;��</a>					      					    
					  
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
					<button id="findUser" class="btn btn-primary"  >ID &nbsp;/ &nbsp;PW &nbsp;ã��</button>					      					      					   
				</div>
				
			</div>
		</div>	
  	 </div>
  	 	<!--  row Start /////////////////////////////////////-->
  	
 	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>
</html>