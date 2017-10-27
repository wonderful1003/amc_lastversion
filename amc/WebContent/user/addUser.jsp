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
	<title>Login Demo - Kakao JavaScript SDK</title>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- īī�� API -->
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- ���� �ּ� CDN -->
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
		//============= "����"  Event ���� =============
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		
/* 		//============= "���"  Event ó�� ��  ���� =============
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	
	
 */		
		function fncAddUser() {
			
			var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
			var birth=$("input[name='birth']").val();
			var check=true
			
			if(id == null || id.length <1){
				alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
				/* return check=false; */
				return;
			}
			if(id != null && (id.indexOf('@') < 1 || id.indexOf('.') == -1) ){
				alert("�̸��������̾ƴմϴ�.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
				/* return check=false; */
				return; 
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
				/* return check=false; */
				return;
			}
			if(name == null || name.length <1){
				alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
				/* return check=false; */
				return;
			}
			if( pw != pw_confirm ) {				
				alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
				$("input:text[name='password2']").focus();
				/* return check=false; */
				return;
			}			
			if( birth == null || birth.length <1 ) {				
				alert("��������� �ݵ�� �Է��ؾ��մϴ�..");				
				/* return check=false; */
				return;
			}
			
				
			var value = "";	
			if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
				var value = $("option:selected").val() + "-" 
									+ $("input[name='phone2']").val() + "-" 
									+ $("input[name='phone3']").val();
			}

			/* $("input:hidden[name='phone']").val( value ); */
			
			if(check == true){
				alert('ȸ�������� �����մϴ�.');
				$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
			}
			
			/* $("form").attr("method" , "POST").attr("action" , "/user/addUser").submit(); */
		}
		
 
/*  		$(function(){
 			$('#email_select').change(function(){
 				if($('#email_select').val() == "1"){
 					$('#last_email').val(""); //�� �ʱ�ȭ
 					$('#last_email').prop("readonly",false); //Ȱ��ȭ
 				} else if($('#email_select').val()==""){
 					$('#last_email').val(""); //�� �ʱ�ȭ
 					$('#last_email').prop("readonly",true); //textBox ��Ȱ��ȭ
 				} else {
 					$('#last_email').val($('#email_select').val()); //���ð� �Է�
 					$('#last_email').prop("readonly",true); //��Ȱ��ȭ
 				}
 			});
 		});
 */ 	
 
 
		//==>""�̸���" ��ȿ��Check / ID�ߺ�Ȯ��" Event ó�� �� ����
		$(function(){					
			$('#userId').bind('keyup', function(){
				var userId = $(this).val().trim();
				var tempId = userId.split(".");
                console.log("userId :: " + userId);
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
								$('span.help-block').html('��밡���� ���̵� �Դϴ�.').css('color','blue');
								check = true;
							}else{
								$('span.help-block').html('�̹� �����ϴ� ���̵� �Դϴ�.').css('color','red');
								check = false;
							}
						}
					});
				
					if(userId == ''){
						$('span.help-block').html('');
					}
			      
			});
		});
			
		
		$(function(){
			$('#password2').bind('keyup',function(){
				if( $('#password').val() != $(this).val()){
					$('span.help-block2').text("��й�ȣ�� �ٸ��ϴ�.").css('color','red');
				}else{
					$('span.help-block2').text("Ȯ��").css('color','blue');
				}
			});
		});
		
		
		
		
		////���� �ּ� API////////////////////////////////////////////////////////////////////////////////////////////////
			function execDaumPostcode() {
				
		        new daum.Postcode({
		            oncomplete: function(data) {
		            	
		                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
		
		                // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
		                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
		                var fullAddr = ''; // ���� �ּ� ����
		                var extraAddr = ''; // ������ �ּ� ����
		
		                // ����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
		                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
		                    fullAddr = data.roadAddress;
		
		                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
		                    fullAddr = data.jibunAddress;
		                }
		
		                // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����Ѵ�.
		                if(data.userSelectedType === 'R'){
		                    //���������� ���� ��� �߰��Ѵ�.
		                    if(data.bname !== ''){
		                        extraAddr += data.bname;
		                    }
		                    // �ǹ����� ���� ��� �߰��Ѵ�.
		                    if(data.buildingName !== ''){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // �������ּ��� ������ ���� ���ʿ� ��ȣ�� �߰��Ͽ� ���� �ּҸ� �����.
		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                }
		
		                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
		                document.getElementById('postcode').value = data.zonecode; //5�ڸ� �������ȣ ���
		                document.getElementById('address').value = fullAddr;
		
		                // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
		                document.getElementById('address_detail').focus();
		            },
		        
		            theme: {
		    	 		bgColor: "#ECECEC", //���� ����
		    	 		searchBgColor: "#0B65C8", //�˻�â ����
		    	 		contentBgColor: "#FFFFFF", //���� ����(�˻����,��l������,ùȭ��,�˻�������Ʈ)
		    	 		pageBgColor: "#FAFAFA", //������ ����
		    	 		textColor: "#333333", //�⺻ ���ڻ�
		    	 		queryTextColor: "#FFFFFF", //�˻�â ���ڻ�
		    	 		postcodeTextColor: "#FA4256", //�����ȣ ���ڻ�
		    	 		emphTextColor: "#008BD3", //���� ���ڻ�
		    	 		outlineColor: "#E0E0E0" //�׵θ�
		    		}   
	            
		        }).open();
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
		<h1>ȸ �� �� ��</h1>
		</div>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
			
		  <div class="form-group">
		    <label for="userId" class="col-sm-3 control-label">�� �� ��</label>
		    <div class="col-sm-3">
		   	 <input type="text" class="form-control" value="${email}" id="userId" name="userId" placeholder="ID�Է�" aria-describedby="helpBlock" readonly/>
		    <!--  <input type="text" class="form-control" id="first_email" placeholder="ID�Է�" aria-describedby="helpBlock" />
		       @<input type="text" class="form-control" id="last_email" placeholder="�̸����Է�" aria-describedby="helpBlock" />
		    	<select id="email_select">
		    		<option value="" selected>::�����ϱ�::</option>
		    		<option value="naver.com">naver.com</option>
		    		<option value="nate.com">nate.com</option>
		    		<option value="daum.net">daum.net</option>
		    		<option value="gmail.com">gmail.com</option>
		    		<option value="1">::�����Է�::</option>
		    	</select> -->
		    </div>	
		    <span id="helpBlock" class="help-block col-sm-6"></span>		    
		  </div>
		  
		  <div class="form-group">
		    <label for="password" class=" col-sm-3 control-label">��й�ȣ</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class=" col-sm-3 control-label">��й�ȣ Ȯ��</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="��й�ȣ Ȯ��" aria-describedby="helpBlock2" >
		    </div>
		     <span id="helpBlock2" class="help-block2 col-sm-6"></span>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class=" col-sm-3 control-label">�̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="ȸ���̸�">
		    </div>
		  </div>
		 
		   <span>		  
		  
		  <div class="form-group">
			  <label for="birth" class="col-sm-3 control-label">�� �� �� ��</label>
			 	 <div class="col-sm-4">
			  		<input type="date" class="form-control" name="birth" id="birth" placeholder="�������" >
			  	</div>
			</div>
		  
		  <div class="form-group">
			  <label for="calendarType" class="col-sm-3 control-label">������� ����</label>
			 	 <div class="col-sm-4">			  		
			  	  	<input type='radio' name='calendarType' value='S' checked="checked">���
					<input type='radio' name='calendarType' value='L'>����
			  	</div>
		  </div>
		  
		  <div class="form-group">
			  <label for="gender" class="col-sm-3 control-label">������� ����</label>
			 	 <div class="col-sm-4">			  		
			  	  	<input type='radio' name='gender' value='M' checked="checked">����
					<input type='radio' name='gender' value='F'>����
			  	</div>
		  </div>
		  
		 
		  </span>
		  
		  <div class="form-group">
		    <label for="ssn" class=" col-sm-3 control-label">�����ȣ</label>
		    <div class="col-sm-4">		      
			    <input type="text" class="form-control" id="postcode" placeholder="�����ȣ" readonly>
			    	  	<strong class="text-danger">�Է��� �ߺ�Ȯ�� ����..</strong>			    
				</div>
				
				<div class="col-sm-3" >
					<input type="button" class="btn btn-info" onclick="execDaumPostcode()" value="�����ȣ ã��" readonly="readonly" >
				</div>
			</div>	
				
				<div class="form-group">
				  <label for="ssn" class=" col-sm-3 control-label">�ּ�</label>
				    <div class="col-sm-4">
						<input type="text" name='addr' class="form-control" id="address" placeholder="�ּ�">
					</div>
				</div>
				
				<div class="form-group">
				  <label for="ssn" class=" col-sm-3 control-label">���ּ�</label>
				    <div class="col-sm-4">			
						<input type="text" name='addrDetail' class="form-control" id="address_detail" placeholder="���ּ�">
					</div>
				</div>	
			
			<!-- <h1>���� : http://postcode.map.daum.net/guide</h1> -->
		  		  
		  <div class="form-group">
		    <label for="phone" class=" col-sm-3 control-label">�޴���ȭ��ȣ</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="phone1" id="phone1">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select>
		    </div>
		   
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="��ȣ">
		    </div>
		    
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="��ȣ">
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
	
</body>

</html>