<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
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
				
		//$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
	
			
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				$.ajax( 
						{	
							url : "/user/json/loginUser",
							method : "POST" ,
							dataType : "json" ,
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
								//alert( JSONData != null );
								
								if( JSONData != null ){
									//[���1]
									$(window.parent.document.location).attr("href","/index.jsp");
									
									//[���2]
									//window.parent.document.location.reload();
									
									//[���3]
									//$(window.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
									//$(window.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
									//$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
									
									//==> ��� 1 , 2 , 3 ��� ����
								}else{
									alert("���̵� , �н����带 Ȯ���Ͻð� �ٽ� �α���...");
								}
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
					    </div>
					</form>
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