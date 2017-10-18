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
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
   	<!-- Favicons -->
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
	<link rel="shortcut icon" href="../assets/ico/favicon.png">
   
   
    <!-- Bootstrap Dropdown Hover JS -->
   	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

	<!-- JQUERY Date Picker -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
	function checkSearchedWord(obj){
		if(obj.value.length >0){
			//Ư������ ����
			var expText = /[%=><]/ ;
			if(expText.test(obj.value) == true){
				alert("Ư�����ڸ� �Է� �Ҽ� �����ϴ�.") ;
				obj.value = obj.value.split(expText).join(""); 
				return false;
			}
			
			//Ư�����ڿ�(sql������� �յڰ�������) ����
			var sqlArray = new Array(
				//sql �����
				"OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC",
	             		 "UNION",  "FETCH", "DECLARE", "TRUNCATE" 
			);
			
			var regex ;
			var regex_plus ;
			for(var i=0; i<sqlArray.length; i++){
				regex = new RegExp("\\s" + sqlArray[i] + "\\s","gi") ;
				if (regex.test(obj.value)) {
				    alert("\"" + sqlArray[i]+"\"��(��) ���� Ư�����ڷ� �˻��� �� �����ϴ�.");
					obj.value =obj.value.replace(regex, "");
					return false;
				}
				
				regex_plus = new RegExp( "\\+" + sqlArray[i] + "\\+","gi") ;
				if (regex_plus.test(obj.value)) {
				    alert("\"" + sqlArray[i]+"\"��(��) ���� Ư�����ڷ� �˻��� �� �����ϴ�.");
					obj.value =obj.value.replace(regex_plus, "");
					return false;
				}
			}
		}
		return true ;
	}

	// ���뿹 (api ȣ�� ���� �˻��� üũ) 
	function searchJuso(){
		if (!checkSearchedWord(document.form.keyword)) {
			return ;
		}
	}
	
	 function fncAddPurchase(){
			//Form ��ȿ�� ����
		 	var receiverName = document.addPurchase.receiverName.value;
			var receiverPhone = document.addPurchase.receiverPhone.value;
			var dlvyAddr = document.addPurchase.dlvyAddr.value;
			var dlvyDate = document.addPurchase.dlvyDate.value;
	
		 	var receiverName = $("input[name='receiverName']").val();
			var receiverPhone = $("input[name='receiverPhone']").val();
			var dlvyAddr = $("input[name='dlvyAddr']").val();
			var dlvyDate = $("input[name='dlvyDate']").val();

			
			if(receiverName == null || receiverName.length<1){
				alert("�������̸��� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if(receiverPhone == null || receiverPhone.length<1){
				alert("����ó�� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if(dlvyAddr == null || dlvyAddr.length<1){
				alert("�ּҴ� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(dlvyDate == null || dlvyDate.length<1){
				alert("���������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
	
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();	
		 };
		
	 	$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "button.btn.btn-primary" ).on("click" , function() {			
				fncAddPurchase();
			});
		});	 
			
	 	$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "td.ct_btn01:contains('���')" ).on("click" , function() {			
				 history.go(-1);
			});
		});	 
	 	 
		
		$( function() {
		    $( "#dlvyDate" ).datepicker({
		      showOn: "button",
		      buttonImage: "../images/ct_icon_date.gif",
		      buttonImageOnly: true,		     
		      dateFormat: 'yymmdd',
		    });
		});

		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "#dlvyAddr" ).on("click" , function() {			
				 checkSearchedWord(obj);
			});
		});	 
		
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	<form class="form-horizontal" name="addPurchase" method="post" enctype="multipart/form-data">
		<input type="hidden" name="prodNo" value="${product.prodNo}" />
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">��ǰ��������</h3>
	       <h5 class="text-muted">��ǰ ���������� <strong class="text-danger">Ȯ��</strong>�� �ּ���.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<br/>

  		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<br/>
		
		<div class="row">
			<table width="1400" border="0" >
		  		<div class="col-xs-4 col-md-2 "><strong>��ǰ������</strong></div>
				<div class="col-xs-8 col-md-4">${ product.prodDetail }</div>								
			</table>		
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${ product.manuDate }</div>
		</div>
	
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		
		<br/>
 	
		<div class="row" name = "Id">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ھ��̵�</strong></div>
			<div class="col-xs-8 col-md-4">${ user.userId }</div>
			<input type="hidden" name="buyerId" value="${user.userId}" />
		</div>
		
		<br/>
		
 		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���Ź��</strong></div>			
				<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
					<option value="1" selected="selected">���ݱ���</option>
					<option value="2">�ſ뱸��</option>
				</select>		
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������̸�</strong></div>
			<div class="col-xs-8 col-md-4">
				<input type="text" name="receiverName" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" value="${user.userName}" />
			</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ڿ���ó</strong></div>
			<div class="col-xs-8 col-md-4">
				<input 	type="text" name="receiverPhone" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" value="${user.phone}" />			
			</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 " id="dlvyAddr"><strong>�������ּ�</strong></div>
			<div class="col-xs-8 col-md-4">
				<input 	type="text" name="dlvyAddr" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" 	value="${user.addr}" />
						
						
			</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ſ�û����</strong></div>
			<div class="col-xs-8 col-md-4">
				<input	type="text" name="dlvyRequest" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" />
			</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����������</strong></div>
			<div class="col-xs-8 col-md-4">				
				<p><input type="text" readonly="readonly" readonly="readonly" id="dlvyDate" name="dlvyDate" placeholder="�޷��� Ŭ�����ּ���"></p>						
			</div>
		</div> 
 		
		<br/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			 	<a class="btn btn-primary btn" title="�󼼸����ȸ" href="#" role="button">��&nbsp;��</a>
	  		
	  		
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	</form>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>