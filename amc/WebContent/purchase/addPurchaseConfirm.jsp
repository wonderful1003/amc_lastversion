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
			$('a.btn-success:contains("Ȯ��")').bind('click',function(){
				self.location.href='listPurchase?searchKeyword=purchaseList&searchCondition=${sessionScope.user.userId}';
			});
		});
	</script>
	
</head>

<body>

	<jsp:include page="../layout/topToolbar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>

<div class="container">	
	<div class="page-header col-sm-offset-2 col-sm-10">
		<h1>�ֹ��� �Ϸ�Ǿ����ϴ�.</h1>
	</div>
	<dl class="dl-horizontal">
		<dt>��ǰ��</dt>
		<dd>${purchase.purchaseProd.prodName}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>���� ����</dt>
		<dd>${purchase.purchaseCount} ��</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>����</dt>
		<dd>${purchase.totalProdPrice} ��</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>���� ���</dt>
		<dd>${purchase.paymentOption=='1'? '���ݱ���':'�ſ뱸��'}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>������ ��</dt>
		<dd>${purchase.receiverName}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>����ó</dt>
		<dd>${purchase.receiverPhone1}&emsp;${purchase.receiverPhone2}&emsp;${purchase.receiverPhone3}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>�����</dt>
		<dd>${purchase.addrDlvy}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>���ּ�</dt>
		<dd>${purchase.addrDlvyDetail}</dd>
	</dl>
	<div class="btn-group" role="group" >
		<a href="#" class="add btn btn-success" role="button">Ȯ��</a>
	</div>
	

</div>

</body>
</html>