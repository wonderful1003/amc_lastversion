<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="utf-8"/>
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	
	<!-- īī�� �α��� -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- īī�� �α��� -->
	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #000000;
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
				var id=$("#userId").val();
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
				
				$.ajax( 
						{	
							url : "/user/json/loginUser",
							method : "POST" ,
							async : false,
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
								//alert("JSONData : "+ JSONData );
								//alert("status : "+ status );
									//alert(JSONData.role);
									console.log(JSONData.userId);
									
									//alert("�α�������");
									
									if( JSONData.role == 'not' ){
										alert("Ż����ȸ��...");
									}else if( JSONData !='' ){
									//$(window.parent.document.location).attr("href","/index.jsp");
									$(self.location).attr("href","/index.jsp");
									
									}else{
										alert("���̵� , �н����带 Ȯ���Ͻð� �ٽ� �α���1...");
									}
								},
							error:function(request,status,error){
								//alert(error);
								//alert("���̵� , �н����带 Ȯ���Ͻð� �ٽ� �α���2...");
						    }
					}); 
				
			});
		});	
		
		//============= ȸ��������ȭ���̵� =============
		$( function() {
			/* $("a[href='#' ]").on("click" , function() {
				self.location = "/user/authForm.jsp"
			}); */
			$("#addUser").on("click" , function() {
				self.location = "/user/authForm.jsp"
			});
		});
		
		//============= ID/PW ã�� =============
		$( function() {
			$("#findUser").on("click" , function() {
				self.location = "/user/findUser.jsp"
			});
		});
		
		//============= īī�� �α��� =============
		function loginWithKakao() {
			Kakao.init('fc5658887af25f840e94144f6722b228');
			// �α��� â�� ���ϴ�.
			Kakao.Auth.login({
		 		success: function(authObj) {
		   			var accessToken = Kakao.Auth.getAccessToken();
		    		Kakao.Auth.setAccessToken(accessToken);
		    
		    		Kakao.API.request({
		    			url: '/v1/user/me',
		       			success: function(res) {
			        		console.log("response Ȯ�� :: " + res);
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
			                       			alert("�ݰ����״�.");
			                       			self.location="/user/addUser";                 
			                         	}else if(JSONData.user == ''){
			                         		alert("������ �����ϴ�. ȸ�������� ���ֽñ� �ٶ��ϴ�.");  
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
 	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">AMC</a>
   		</div>
   	</div> 
	
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">		
			<div class="col-md-6">
				<img src="http://192.168.0.32:8080/images/common/LOGO.png" class="img-rounded" width="100%" />
				 <!-- <img src="http://192.168.0.32:8080/images/common/LOGO.png" class="img-rounded" width="100%" /> --> 
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
					      <button type="button" id="login" class="btn btn-primary">�� &nbsp;�� &nbsp;��</button>
					      <button type="button" id="addUser" class="btn btn-primary">ȸ������</button><br/><br/>
					      <button type="button" id="findUser" class="btn btn-primary">ID/PWã��</button>
					 	</div>
					  </div><br/><br/><br/><br/><br/>  
					    </form>   
					      
					     <!--  <a class="btn btn-primary btn" href="#" role="button">ȸ &nbsp;�� &nbsp;�� &nbsp;��</a>
					      <a class="btn btn-primary btn" href="#" role="button">ȸ &nbsp;�� &nbsp;�� &nbsp;��</a>		 -->			      					    
						
				<!-- 		<div class="col-sm-offset-4 col-sm-6 text-center">
					<button id="findUser" class="btn btn-primary"  >ID &nbsp;/ &nbsp;PW &nbsp;ã��</button>					      					      					   
				</div>
				 -->
				<div>
					<a id="custom-login-btn" href="javascript:loginWithKakao()">
					<img src="http://127.0.0.1:8080/images/user/kakaobtn.png" class="img-rounded" width="10%"></a>&nbsp;
					<a href="/user/kakaoGetCode" ><img src="http://127.0.0.1:8080/images/user/naverbtn.PNG" class="img-rounded" width="10%"> </a> &nbsp;
					<a href="/user/Naver" ><img src="http://127.0.0.1:8080/images/user/googlebtn.png" class="img-rounded" width="10%"> </a>
				</div>
					
			   	</div>
				
				
				
			</div>
		</div>	
  	 </div>
  	 	<!--  row Start /////////////////////////////////////-->
  	
 	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>
</html>