<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	<title>${param.menu eq 'search' ? "��ǰ �����ȸ" : "��ǰ ����"}</title>
	
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 70px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		var currentPage = 0;
		
		function fncNextList(){
			currentPage++;
			$.ajax({
				url : 'json/getGoodsList/'+$('input:hidden[name="menu"]').val(),
				method : 'post',
				async : false,
				dataType : 'json',
				data : JSON.stringify({
						currentPage : currentPage,
				}),
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(JSON){
					var list = '';
					for( x in JSON.list){
						var product = JSON.list[x];
						list += '<div class="col-sm-6 col-md-4"><div class="thumbnail alert alert-'+(product.stock==0? 'danger':'warning')+'">';
						list += '<img src="../images/uploadFiles/'+(product.prodImage!=null ? product.prodImage : 'empty'+Math.floor(3*Math.random())+'.GIF')+'" class="img-responsive" data-holder-rendered="true" style="height: 200px; width: 100%; display: block;">';
						list += '<div class="caption">';
						list += '<input type="hidden" name="prodNo" value="'+product.prodNo+'">';
						list += '<h3>'+product.prodName+'</h3>';
						list += '<p>';
						list += '<div class="btn-group" role="group">';
						list += '<a href="#" class="btn btn-primary" role="button">';
						if($('input:hidden[name="menu"]').val()=='manage'){
							list += '��������';
						}else{
							list += '�󼼺���';
						}
						list += '</a>';
						if($('input:hidden[name="userId"]').val() != '' && $('input:hidden[name="menu"]').val()=='search'){
							list += '<a href="#" class="btn btn-default" role="button">����</a>';
						}
						list += '</div>';
						list += '</p></div></div></div>';
					}
					$('.col-md-9 > .row').html($('.col-md-9 > .row').html() + list);
					
					init();
				}
			});
		}
		
		function init(){
			$('a.btn-primary:contains("�󼼺���"), a.btn-primary:contains("��������")').unbind('click').bind('click',function(){
				self.location.href='getGoodsProduct?menu=${param.menu}&prodNo='+$(this).parent().parent().find('input:hidden').val();
			});
			
			$('a.btn-default:contains("����")').unbind('click').bind('click',function(){
				self.location.href='../purchase/addPurchase?prodNo='+$(this).parent().parent().find('input:hidden[name="prodNo"]').val();
			});
		};
		
		$( function() {
			while($(document).height() == $(window).height() && currentPage < $('input:hidden[name="maxPage"]').val()){
				fncNextList();
			}
			
		} );
		
		$(window).scroll(function(){
			
			if(currentPage < $('input:hidden[name="maxPage"]').val()){
				/* console.log($(window).scrollTop()+ "    :::    "+($(document).height()-$(window).height())); */
				if($(window).scrollTop() >= $(document).height()-$(window).height()){	 				
		//$(window).scrollTop()�� ������  $(document).height()-$(window).height()�̰Ͱ� ������ fncNextList�� ����Ǵ°� �����ε� ������� ������ �� �ȶ������� ũ��񱳸��ؾߵ�
					fncNextList();
				}
			}
		});
	

	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<%-- <form name="detailForm" action="/product/getGoodsList?menu=${param.menu }" method="post"> --%>
	
		<input type="hidden" name="menu" value="${param.menu}"/>
		<input type="hidden" name="maxPage" value="${resultPage.maxPage}"/>
		<input type="hidden" name="userId" value="${sessionScope.user.userId}"/>
		
		
		<div class="page-header text-info">
	       <span><h3>${param.menu eq 'search'? "��ǰ �����ȸ" : "��ǰ����" }&ensp;&ensp;
	      
	      <c:if test="${param.menu=='manage'}">
	       <button type="button" class="btn btn-primary pull-right"  float = "right"
	       			 onclick="location.href='/product/addProduct'">�� ǰ �� ��</button></h3></span>	
	      </c:if> 		
	    </div>
		
	  	<div class="container">
		<div class="row">
			<div class="col-md-9" role="main">
				<div class="page-header col-sm-offset-2 col-sm-10">
					<c:if test="${param.menu=='manage'}">
						<h1>��ǰ ����</h1>
					</c:if>
					<c:if test="${param.menu=='search'}">
						<h1>��ǰ ����</h1>
					</c:if>
				</div>
				<div class="row">
				
				</div>
			</div>
<%--  			<jsp:include page="../history.jsp">
				<jsp:param name="uri" value="../"/>
			</jsp:include>
 --%> 		</div>
	</div>
	  
 	</div>

</form>
</body>

</html>