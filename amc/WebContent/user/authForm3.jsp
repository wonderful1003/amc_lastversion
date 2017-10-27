<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<title>Model2 MVC Shop</title>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<style>
		body{
			padding-top : 70px;
		}
	</style>

	<script type="text/javascript">
		var check = false;
		
		function fncAddUser() {
			// Form ��ȿ�� ����
			var id=$('#inputId').val();
			var pw=$('#inputPassword').val();
			var pw_confirm=$('#inputPassword2').val();
			var name=$('#inputName').val();
			
			if(id == null || id.length <1){
				alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(!check){
				alert("�̹� �����ϴ� ���̵� �Դϴ�.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(name == null || name.length <1){
				alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			if(pw != pw_confirm) {
				alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
				$('#inputPassword2').focus();
				return;
			}
				
			var value="";
			if( $('#inputPhone2').val() != "" && $('#inputPhone3').val() != "" ){
				var value = $('option:selected').val() + "-"
									+ $('#inputPhone2').val() + "-"
									+ $('#inputPhone3').val();
			}
			$('input:hidden[name="phone"]').val(value);
			
			$('form.add-user').attr('method','post').attr('action','addUser').submit();
		}
		
		$(function(){
			$('.col-sm-9 button:contains("Sign in")').bind('click', function(){
				console.log('??');
				fncAddUser();
			});
		});
		
		$(function(){
			$('td.ct_btn01:contains("���")').bind('click', function(){
				$('form.add-user')[0].reset();
				$('span').val("");
			});
		});
		
		$(function(){
			
			$('#inputEmail').bind('change', function(){
				
				var email=$('input[name="email"]').val();
				
				if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
					alert("�̸��� ������ �ƴմϴ�.");
				}
			});
		});
		
		function checkSsn() {
			var ssn1, ssn2; 
			var nByear, nTyear; 
			var today; 
		
			ssn = document.detailForm.ssn.value;
			// ��ȿ�� �ֹι�ȣ ������ ��츸 ���� ��� ����, PortalJuminCheck �Լ��� CommonScript.js �� ���� �ֹι�ȣ üũ �Լ��� 
			if(!PortalJuminCheck(ssn)) {
				alert("�߸��� �ֹι�ȣ�Դϴ�.");
				return false;
			}
		}
		
		function PortalJuminCheck(fieldValue){
		    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
			var num = fieldValue;
		    if (!pattern.test(num)) return false; 
		    num = RegExp.$1 + RegExp.$2;
		
			var sum = 0;
			var last = num.charCodeAt(12) - 0x30;
			var bases = "234567892345";
			for (var i=0; i<12; i++) {
				if (isNaN(num.substring(i,i+1))) return false;
				sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
			}
			var mod = sum % 11;
			return ((11 - mod) % 10 == last) ? true : false;
		}
		
		$(function(){
			$('#inputId').bind('keyup', function(){
				var userId = $(this).val().trim();
				console.log("${userId}");
				$.ajax({
					url : 'json/checkDuplication/'+userId,
					method : 'get',
					dataType : 'json',
					headers : {
						'Accept' : 'application/json',
						'Content-Type' : 'application/json'
					},
					success : function(JSONData , status){
						alert(status);
						if(JSONData){
							$('span.help-block').html('��� ������ ���̵� �Դϴ�.').css('color','blue');
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
			$('#inputPassword2').bind('keyup',function(){
				if( $('#inputPassword').val() != $(this).val()){
					$('span.help-block2').text("��й�ȣ�� �ٸ��ϴ�.").css('color','red');
				}else{
					$('span.help-block2').text("Ȯ��").css('color','blue');
				}
			});
		});
		
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<jsp:include page="../layout/topToolbar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>

<div class="container">

	<div class="page-header col-sm-offset-2 col-sm-10">
		<h1>ȸ�� ����</h1>
	</div>
	<form class="add-user form-horizontal">
		<div class="form-group">
			<div class="row">
				<label for="inputId" class="col-sm-3 control-label">���̵�</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="inputId" name="userId" placeholder="ID" aria-describedby="helpBlock">
				</div>
				<span id="helpBlock" class="help-block col-sm-6"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputPassword" class="col-sm-3 control-label">��й�ȣ</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" id="inputPassword" name="password" placeholder="Password">
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputPassword2" class="col-sm-3 control-label">��й�ȣȮ��</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" id="inputPassword2" name="password2" placeholder="Password Check" aria-describedby="helpBlock2">
				</div>
				<span id="helpBlock2" class="help-block2 col-sm-6"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputName" class="col-sm-3 control-label">�̸�</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="inputName" name="userName" placeholder="Name">
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputSsn" class="col-sm-3 control-label">�ֹε�Ϲ�ȣ</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="inputSsd" name="ssd" placeholder="Jumin��">
				</div>
				<span class="col-sm-3"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputAddr" class="col-sm-3 control-label">�ּ�</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="inputAddr" name="addr" placeholder="Address">
				</div>
			</div>
			<br/>
			<div class="row">
				<label for="inputPhone1" class="col-sm-3 control-label">��ȭ��ȣ</label>
				<input type="hidden" name="phone">
				<div class="col-sm-2">
					<select class="form-control" id="inputPhone1" name="phone1">
						<option>010</option>
						<option>011</option>
						<option>016</option>
						<option>018</option>
						<option>019</option>
					</select>
				</div>
				<label for="inputPhone2" class="col-sm-1 control-label">-</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="inputPhone2" name="phone2">
				</div>
				<label for="inputPhone3" class="col-sm-1 control-label">-</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="inputPhone3" name="phone3">
				</div>
				<span class="col-sm-1"></span>
			</div>
			<br/>
			<div class="row">
				<label for="inputEmail" class="col-sm-3 control-label">�̸���</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="inputEmail" name="email" placeholder="E-mail">
				</div>
			</div>
			<br/>
			<div class="row">
				<div class="col-sm-offset-3 col-sm-9">
					<button type="button" class="btn btn-success">Sign in</button>
				</div>
			</div>
		</div>
	</form>
</div>
</body>
</html>
