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
			
			$('#tabs').tabs();
			
/* 			$('a.add:contains("Ȯ��")').bind('click',function(){
				self.location.href = 'getGoodsList?menu=manage';
			});
			
			$('a.add:contains("�߰����")').bind('click',function(){
				self.location.href = 'addProduct';
			}); */
			
			$('a.btn-default:contains("�������")').bind('click',function(){
				self.location.href = 'getGoodsList?menu=${param.menu}';
			});

			$('a.btn-success:contains("�����Ϸ�����")').bind('click',function(){
				self.location.href = '/purchase/addPurchase?prodNo='+$('input:hidden[name="prodNo"]').val();
			});

		});

	</script>
</head>

<body bgcolor="#ffffff" text="#000000">


	<jsp:include page="../layout/topToolbar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>
	
	<div class="container">
		<div class="col-md-9" role="main">
			<div id="tabs">
			<ul>
					<li>
						<a href="#tabs-1">
							<c:if test="${param.menu=='search'}">
								��ǰ������
							</c:if>
							<c:if test="${param.menu=='manage'}">
								������ ����
							</c:if>
						</a>
					</li>
				</ul>
			
			<div class="row" id="tabs-1">
				<input type="hidden" name="prodType" value="${product.prodType}"/>
				<input type="hidden" name="prodNo" value="${product.prodNo}"/>
				<div class="col-xs-5">				
					<c:if test="${!empty product.prodImage}">
						<img src="../images/uploadFiles/${product.prodImage}" class="img-responsive"/>
					</c:if>
					<c:if test="${empty product.prodImage}">
						<img src="../images/uploadFiles/empty<%=index%>.GIF" class="img-responsive"/>
					</c:if>
				</div>
				<div class="col-xs-7">
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
						<dt>��ǰ������</dt>
						<dd>${product.prodDetail}</dd>
					</dl>
					<dl class="dl-horizontal">
						<dt>��ǰ��������</dt>
						<dd>${product.prodSetInfo}</dd>
					</dl>
					<div class="btn-group" role="group">
						<c:if test="${param.menu=='search' && !empty user}">
							<a href="#" class="btn btn-success" role="button">�����Ϸ�����</a>
						</c:if>
						<a href="#" class="btn btn-default" role="button">�������</a>
					</div>
					
				</div>
			</div>
		</div>
	</div>

</body>
</html>
