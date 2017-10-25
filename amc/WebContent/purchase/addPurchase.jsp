<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% int index = (int)(java.lang.Math.random()*3.0); %>

<!DOCTYPE html>

<html>
<head>
	<title>Model2 MVC Shop</title>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
		body{
			padding-top : 70px;
		}
	</style>
	
	<script type="text/javascript">
		$(function(){
			
			$('.add-purchase .btn-success:contains("����")').bind('click',function(){
				$('form').attr('method','post').attr('action','addPurchase').submit();
			});
			
			$('.add-purchase .btn-info:contains("���")').bind('click',function(){
				history.go(-1);
			});
			
			$('#inputDlvyDate').datepicker({
				dateFormat : 'yymmdd'
			})

		});
		
	</script>
</head>

<body>

	<jsp:include page="../layout/topToolbar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>
	
<div class="container">

	<div class="page-header col-sm-offset-2 col-sm-10">
		<h1>��ǰ ����</h1>
	</div>
	<form class="add-product form-horizontal">
		<input type="hidden" name="purchaseProd.prodNo" value="${product.prodNo }" />
		<input type="hidden" name="purchaseProd.prodName" value="${product.prodName }"/>
		<input type="hidden" name="buyer.userId" value="${user.userId }"/>
		<input type="hidden" name="tranCode" value="1"/>
		
		<div class="row">
			<div class="col-md-6">
				<div class="row">
					<input type="hidden" name="prodType" value="${product.prodType}"/>
					<input type="hidden" name="prodNo" value="${product.prodNo}"/>
					<div class="col-xs-4">
						<c:if test="${!empty product.prodImage}">
							<img src="../images/uploadFiles/${product.prodImage}" class="img-responsive"/>
						</c:if>
						<c:if test="${empty product.prodImage}">
							<img src="../images/uploadFiles/empty<%=index%>.GIF" class="img-responsive"/>
						</c:if>
					</div>
					<div class="col-xs-8">
						<dl class="dl-horizontal">
							<dt>��ǰ��</dt>
							<dd>${product.prodName}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>�� ����</dt>
							<dd>${product.totalStock} ��</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>���� �Ǹŷ�</dt>
							<dd>${product.salesStock} ��</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>���� ������</dt>
							<dd>${product.stock} ��</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>�ǸŽ�����</dt>
							<dd>${product.salesOpenDate}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>�Ǹ�������</dt>
							<dd>${product.salesEndDate}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>����</dt>
							<dd>${product.prodPrice} ��</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>������</dt>
							<dd>${product.prodDetail}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>��ǰ��������</dt>
							<dd>${product.prodSetInfo}</dd>
						</dl>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="form-group">
					<div class="row">
						<label for="inputPaymentOption" class="col-sm-3 control-label">�������</label>
						<div class="col-sm-3">
							<select class="form-control" id="inputPaymentOption" name="paymentOption">
								<option value="1">���ݰ���</option>
								<option value="2">�ſ�ī��</option>
							</select>
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputPurchaseCount" class="col-sm-3 control-label">���ż���</label>
						<div class="col-sm-3">
							<select class="form-control" id="inputPurchaseCount" name="purchaseCount">
								<c:forEach var="i" begin="1" end="${product.stock>10? 10 : product.stock}">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputReceiverName" class="col-sm-3 control-label">�޴»��</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputReceiverName" name="receiverName" value="${user.userName}">
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputReceiverPhone" class="col-sm-3 control-label">����ó</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputReceiverPhone" name="receiverPhone" value="${user.phone1}">
							<input type="text" class="form-control" id="inputReceiverPhone" name="receiverPhone" value="${user.phone1}">
							<input type="text" class="form-control" id="inputReceiverPhone" name="receiverPhone" value="${user.phone1}">
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputDlvyAddr" class="col-sm-3 control-label">�����</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputDlvyAddr" name="dlvyAddr" value="${user.addr}" >
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<div class="add-purchase col-sm-offset-3 col-sm-9">
							<button type="button" class="btn btn-success">
								����
							</button>
							<button type="button" class="btn btn-info">
								���
							</button>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		
	</form>
	
</div>


</body>
</html>