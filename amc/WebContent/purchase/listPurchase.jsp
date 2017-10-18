<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	<title>���� �����ȸ</title>
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<!--  ///////////////////////// �ֿ��̲�  ////////////////////////// -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	
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
            padding-top : 50px;
        }
      label {
			display: inline-block;
			width: 10em;
		}
        
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//�˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScript �̿�
	function fncGetList(currentPage){
		$("#currentPage").val(currentPage)
	  	$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit(); 
	} 

	//===========================================//
	 $(function() {
		 
		//==> �˻� Event ����ó���κ�
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
		 $( "td:nth-child(1)" ).on("click" , function() {
			 self.location = "/purchase/getPurchase?tranNo="+$(this).find("input[type='hidden']").val(); 			 		
		});
	
		//============= prodName�� ������  Event  ó��(Click) =============	
 		$( "#buyer" ).on("click" , function() {
				alert(  $( this ).text().trim() );
				self.location = "/user/getUser?userId="+${buyer};	
		}); 
			
		$("#arrive").on("click", function(){
			self.location = "/purchase/updateTranCode?tranNo="+${purchase.tranNo}+"&tranCode=3";		
		});
		
		//==> �Ʒ��� ���� ������ ������ ??
		//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
		$(".ct_list_pop:nth-child(2n+1)" ).css("background-color" , "whitesmoker");
	});	

	
	
	//============= prodNo �������� Event  ó�� (double Click)=============
/* 	 $(function() {
		 
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(  "td:nth-child(6) > i" ).on("click" , function() {

				var prodNo = $(this).next().val();
			
				$.ajax( 
						{
							url : "/purchase/json/getProduct/"+prodNo ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {

								//alert("JSONData : \n"+JSONData);
								
								var displayValue = "<h6>"
															+"��ǰ��ȣ    : "+JSONData.prodNo+"<br/>"
															+"��ǰ��	  : "+JSONData.prodName+"<br/>"
															+"��ǰ�̹��� : "+JSONData.fileName+"<br/>"
															+"������    : "+JSONData.prodDetail+"<br/>"
															+"��������    : "+JSONData.manuDate+"<br/>"
															+"�� ��	  : "+JSONData.price+"<br/>"
															+"�������    : "+JSONData.regDate+"<br/>"
															+"</h6>";
								$("h6").remove();
								$( "#"+prodNo+"" ).html(displayValue);
							}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
				
		});
				
		//==> �Ʒ��� ���� ������ ������ ??
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	});	
 */	
	</script>
	
</head>

<body>
	
<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/layout/topToolbar.jsp" />
 	<!-- ToolBar End /////////////////////////////////////-->

<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
<div class="container">
	
<form name="detailForm" action="/purchase/listPurchase" method="post">
<form name="menu" value=${param.menu } type="hidden"/>

	<div class="page-header text-info">
	      <h3>���� �����ȸ</h3>
	</div>
   
<!-- table ����  Start /////////////////////////////////////-->
	<div class="row">
   
	    <div class="col-md-6 text-left">
	    	<p class="text-primary">
	    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
	    	</p>
	    </div> 
	    <div class="col-md-6 text-right">	    		  
			  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
			  	  
	   	</div>  	
	</div>
<!-- table ����  Start /////////////////////////////////////-->

 
<!--  table Start /////////////////////////////////////-->
	<table class="table table-hover table-striped" >
    
      <thead>
        <tr>
          <th align="center">No</th>         
          <th align="left">ȸ��ID</th>
		  <th align="left">��ǰ��</th>                     
          <th align="left">ȸ����</th>
          <th align="left">��ȭ��ȣ</th>
          <th align="left">�����Ȳ</th>
          <th align="left">��������</th>
        </tr>
	</thead>
     
	<tbody>
	  <c:set var="i" value="0" />
	  <c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr>
		  <td align="center">
			<c:if test="${purchase.tranCode == '1' }">
				<input type="hidden" value="${purchase.tranNo}">
				${i}
			</c:if>
			<c:if test="${purchase.tranCode != '1'}">
				<input type="hidden" value="${purchase.tranNo}">
				${i}
			</c:if>		 
		  </td>
		  <td id="buyer" align="left" title="Click : ȸ�������� Ȯ��">${buyer}
		  </td>
		  <td align="left">${purchaseProd.prodName}</td>					
		  <td align="left">${purchase.receiverName}</td>
		  <td align="left">${purchase.receiverPhone}</td>
		  <td align="left">����	
			<c:choose>
				<c:when test="${purchase.tranCode == '1  '}">
					���ſϷ� 
				</c:when>
				
				<c:when test="${purchase.tranCode == '2  '}">
					�����
				</c:when>
				<c:when test="${purchase.tranCode == '3  '}">
					��ۿϷ�
				</c:when>
				
				<c:otherwise>
				 	purchase.tranCode�� 1 ~3 �� �ƴմϴ�.
		 		</c:otherwise>
			</c:choose>
				���� �Դϴ�.
			</td>
		  
		  <td align="left" id="arrive">
			  <c:if test="${purchase.tranCode == '2  '}">
				<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo }&tranCode=3">���ǵ���</a>
			  </c:if>
		  </td>
		
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${purchase.tranNo}"></i>
			  	<input type="hidden" value="${purchase.tranNo}">
			  </td>
			
		</tr>
	   </c:forEach>
      
	</tbody>
    
    </table>
 <!--  table End /////////////////////////////////////-->
  
</div>
<!--  ȭ�鱸�� div End /////////////////////////////////////-->
<input type="hidden" id="currentPage" name="currentPage" value=""/>
<jsp:include page="../common/pageNavigator_new.jsp"/>
<!-- PageNavigation End... -->

</form>
</body>
</html>