<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
		//============= "����"  Event ���� =============
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#remove").on("click" , function() {
				alert("���� �����Ұ̴ϱ�?lll");
				$("form").attr("method" , "POST").attr("action" , "/product/removeProduct").submit();
			});
		});	
		
	
		//============= "����"  Event ���� =============
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				alert("dd");
				fncUpdateProduct();
			});
		});	
		
		
		//============= "���"  Event ó�� ��  ���� =============
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	
			
		//=============�޷�  Event ó�� =============
		$( function() {
		    $( "#manuDate" ).datepicker({
		      showOn: "button",
		      buttonImage: "../images/ct_icon_date.gif",
		      buttonImageOnly: true,
		    });
		});

		///////////////////////////////////////////////////////////////////////
		function fncUpdateProduct() {
			alert("dd2");
			var name=$("input[name='prodName']").val();
			
			if(name == null || name.length <1){
				alert("��ǰ����  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
				
			//Debug...
			//alert("phone : "+value);				
			$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();
		}
	
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	<form name="updatePurchase" method="post"	action="/updatePurchase.do?tranNo=${purchase.tranNo }">
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">�������� ����</h3>
	       <h5 class="text-muted">���� ������ <strong class="text-danger">����</strong>�� �ּ���.</h5>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		<input type="hidden" value="${purchase.tranNo}">
		<input type="hidden" name="purchaseProd.prodNo" value="${param.prodNo}" />
		
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
		    <div class="col-sm-4">${purchase.buyer.userId}
		      <input type="text" readonly="readonly" class="form-control" name="buyerId" value="${purchase.buyer.userId}">
		    </div>
		  </div>		
		
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		    <div class="col-sm-4">
		      	<select name="paymentOption" class="form-control">
					<option value="1" ${!empty purchase.paymentOption && purchase.paymentOption == '1' ? "selected" : "" } >���ݱ���</option>
					<option value="2" ${!empty purchase.paymentOption && purchase.paymentOption == '2' ? "selected" : "" } >�ſ뱸��</option>
				</select>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" name="receiverName" value="${purchase.receiverName }">	
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">������ ����ó</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="receiverPhone"  value="${purchase.receiverPhone }">
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="receiverAddr" value="${purchase.dlvyAddr}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="receiverRequest" value="${purchase.dlvyRequest }">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="dlvyDate">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>		      
			  <a class="btn btn-primary btn" href="#" role="button">�� &nbsp;��</a>
			  <button id="remove" type="button" class="btn btn-danger"  >�� &nbsp;��</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
 	
</body>

</html>