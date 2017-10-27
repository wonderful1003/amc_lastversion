<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="euc-kr">	
	<!-- ���� : http://getbootstrap.com/css/    -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- īī�� API -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<title> ȸ �� Ż��  </title>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- īī�� API -->
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- ���� �ּ� CDN -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<!-- sweetalert -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.1/sweetalert2.all.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body{
			padding-top : 70px;
		}
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= "����"  Event ���� =============
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncDeleteUser();
			});
		});	
		
		function fncDeleteUser() {
			
			var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var name=$("input[name='userName']").val();
			
			
			if(id == null || id.length <1){
				alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(name == null || name.length <1){
				alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			/* alert("����� ajax");
				$.ajax({
					url : "/user/json/deleteCheck/" ,
					method : "POST" ,							
					async : "true",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						userId : id,
						password : pw,
						userName : name
					}),
					dataType : "text",
					success : function(JSONData , status) {
						alert(JSONData);
						
						
					}
				}); */
			
			
				swal({
					  title: 'Ż�� �����Ͻðڽ��ϱ�?',
					  text: "'��'�� �����ø� Ż�� �� ������������ �̵��մϴ�!",
					  type: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: '��, Ż���ϰڽ��ϴ�!'
					}).then(function () {
					  swal({	   
						  type: 'success',
						  title: '�׵��� �̿��� �ּż� �����մϴ�.',
						  showConfirmButton: false,
						  timer: 1500
						})
						delay()
					})
		}
 	
		function sleep(num){	//[1/1000��]
			 var now = new Date();
			   var stop = now.getTime() + num;
			   while(true){
				 now = new Date();
				 if(now.getTime() > stop)return;
			   }
		}
		
		function delay(){
			setTimeout(function move(){
				$("form").attr("method" , "POST").attr("action" , "/user/deleteUser").submit();
			},1500) 
		}
		
	</script>		
    
</head>

<body bgcolor="#ffffff" text="#000000">

	<jsp:include page="../layout/topToolbar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header col-sm-offset-2 col-sm-10">	
		<h1>ȸ �� Ż ��</h1>
		</div>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		  <div class="form-group">
		    <label for="userId" class="col-sm-3 control-label">�� �� ��</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="userId" name="userId" placeholder="�̸���ID�Է�" aria-describedby="helpBlock" >		       	      	
		    </div>	
		    <span id="helpBlock" class="help-block col-sm-6"></span>		    
		  </div>
		  
		  <div class="form-group">
		    <label for="password" class=" col-sm-3 control-label">��й�ȣ</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ">
		    </div>
		    <span id="helpBlock2" class="help-block2 col-sm-6"></span>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class=" col-sm-3 control-label">�̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="ȸ���̸�">
		    </div>
		    <span id="helpBlock3" class="help-block3 col-sm-6"></span>
		  </div>
		 
			<!-- <h1>���� : http://postcode.map.daum.net/guide</h1> -->
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >ȸ �� Ż �� </button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
	
</body>

</html>