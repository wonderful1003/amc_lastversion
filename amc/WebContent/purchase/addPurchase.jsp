<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% int index = (int)(java.lang.Math.random()*3.0); %>

<!DOCTYPE html>

<html>
<head>
	<title>Model2 MVC Shop</title>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!-- 	아임포트 CDN -->
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<style>
		body{
			padding-top : 70px;
		}
	</style>
	
	<script type="text/javascript">
	//imp초기화는 페이지 첫단에 해주는게 좋음
 	IMP.init('imp41659269');
	alert("afd");
	var things = "AMC : ";
	if( "${booking}"=="" ){
		things += "물품"
	}else{
		things += "예매"
	} 
	
	function kakaoPay(){
				IMP.request_pay({
				    pg : 'kakao',
				    pay_method : 'kapy',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : things,
				    amount : "${product.prodPrice}", /* ticket or product price */
				    buyer_email : "${user.userId}",
				    buyer_name : "${user.userName}",
				    buyer_tel : "${user.phone1}-${user.phone2}-${user.phone3}",
				    buyer_addr : "${user.addr}+${user.addrDetail}"
				}, function(rsp) {
				    if ( rsp.success ){
						
				    	alert("impuid : " + rsp.imp_uid); //결제되서 여기는 뜸
				    	console.log("impuid : "+rsp.imp_uid);
				    	var impUid = rsp.imp_uid; 
				    	
				    	$.ajax({
				    		url: "/cinema/json/checkPay/"+impUid, //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
				    		type: 'GET',
				    	}).done(function(data) {
				    		alert("data : " + data);
				    		var payStatusCheck = (data.split(','))[0];
				    		var amountCheck = (data.split(','))[1];
				    		alert("payStatusCheck : "+payStatusCheck+"\n"+"amountCheck : "+amountCheck);
				    		
				    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
				    		if (  payStatusCheck == 'paid' && amountCheck == '${product.prodPrice}') {
				    			var msg = '결제가 완료되었습니다.';
				    			msg += '\n고유ID : ' + rsp.imp_uid;
				    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
				    			msg += '\n결제 금액 : ' + rsp.paid_amount;
				    			msg += '\n카드 승인번호 : ' + rsp.apply_num;

				    			$("input[name='qrUrl']").val("https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl="+impUid);
				    			$("input[name='impId']").val(impUid);
				    			
				    			alert("AJAX 후 결제완료 후 "+"\n"+msg);
				    			
				    			addPurchase();
				    			
				    		} else {
				    			alert("AJAX 후 실패\n 결제 금액이 요청한 금액과 달라 결제를 자동취소처리 하였습니다");
				    			kakaoPayCancel(impUid);
				    			//[3] 아직 제대로 결제가 되지 않았습니다.
				    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
				    		}
				    	});
				    	
				    } else {
				        var msg = '결제에 실패하였습니다.';
				        var errorMsg = '실패사유 : ' + rsp.error_msg;
				        alert("AJAX 전 실패"+"\n"+msg+"\n"+errorMsg);
				    }//end of rsp.success else 
				}); //end of Imp.request_pay
			}//end of kakaoPay function
			
	function kakaoPayCancel(impUid){
		$.ajax({
		    		url: "/cinema/json/cancelPay/"+impUid,
		    		type: 'GET',
		    	}).done(function(data) {
		    		alert("data : " + data);
		    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
		    		if ( data == 'cancelled' ) {
		    			var msg = '취소가 성공적으로 처리되었습니다.';
		    			/* msg += '\n고유ID : ' + rsp.imp_uid;
		    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		    			msg += '\n결제 금액 : ' + rsp.paid_amount;
		    			msg += '\n카드 승인번호 : ' + rsp.apply_num; */

		    			alert("아작스 취소 후 "+"\n"+msg);
		    			
		    			//location.href="/index.jsp"
		    			location.href="/#"
		    			
		    		} else {
		    			alert("취소가 실패하였습니다.");
		    			//[3] 아직 제대로 결제가 되지 않았습니다.
		    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
		    		}
		    	});
	}//end of kakaoPayCancel function		
	
	function a(){
		$("input[name='qrUrl']").val("https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=123");
		alert($("input[name='qrUrl']").val());
	}

	function addPurchase(){
		
		$('form').attr('method','post').attr('action','addPurchase').submit();
		
	}

	
		$(function(){
			
			$('.add-purchase .btn-success:contains("구매")').bind('click',function(){
				alert();
				kakaoPay();
			});
			
		/* 	$('.add-purchase .btn-success:contains("구매")').bind('click',function(){
				$('form').attr('method','post').attr('action','addPurchase').submit();
			}); */
			
			$('.add-purchase .btn-info:contains("취소")').bind('click',function(){
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
		<h1>상품 구매</h1>
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
							<dt>상품명</dt>
							<dd>${product.prodName}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>총 수량</dt>
							<dd>${product.totalStock} 개</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>현재 판매량</dt>
							<dd>${product.salesStock} 개</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>현재 재고수량</dt>
							<dd>${product.stock} 개</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>판매시작일</dt>
							<dd>${product.salesOpenDate}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>판매종료일</dt>
							<dd>${product.salesEndDate}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>가격</dt>
							<dd>${product.prodPrice} 원</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>상세정보</dt>
							<dd>${product.prodDetail}</dd>
						</dl>
						<dl class="dl-horizontal">
							<dt>상품구성정보</dt>
							<dd>${product.prodSetInfo}</dd>
						</dl>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="form-group">
					<div class="row">
						<label for="inputPaymentOption" class="col-sm-3 control-label">결제방법</label>
						<div class="col-sm-3">
							<select class="form-control" id="inputPaymentOption" name="paymentOption">
								<option value="1">현금결제</option>
								<option value="2">신용카드</option>
							</select>
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					<div class="row">
						<label for="inputPurchaseCount" class="col-sm-3 control-label">구매수량</label>
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
						<label for="inputReceiverName" class="col-sm-3 control-label">받는사람</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputReceiverName" name="receiverName" value="${user.userName}">
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					
				  <div class="form-group">
				    <label for="phone" class=" col-sm-3 control-label">받는 분 연락처</label>
				     <div class="col-sm-2">
				      	<select class="form-control" name="receiverPhone1" id="receiverPhone1" value="${user.phone1}">
						  	<option value="010" >010</option>
							<option value="011" >011</option>
							<option value="016" >016</option>
							<option value="018" >018</option>
							<option value="019" >019</option>
						</select>
				     </div>
				   
				    <div class="col-sm-2">
				      <input type="text" class="form-control" id="receiverPhone2" name="receiverPhone2" placeholder="번호" value="${user.phone2}">
				    </div>
					    
				    <div class="col-sm-2">
				      <input type="text" class="form-control" id="receiverPhone3" name="receiverPhone3" placeholder="번호" value="${user.phone3}">
				    </div>	
				    <span class="col-sm-6"></span>			    	
				 </div>
							
					
					
					<div class="row">
						<label for="inputDlvyAddr" class="col-sm-3 control-label">배송지</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputDlvyAddr" name="addrDlvy" value="${user.addr}" >
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					
					<div class="row">
						<label for="inputDlvyAddr" class="col-sm-3 control-label">상세주소</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="inputDlvyAddr" name="addrDlvyDetail" value="${user.addrDetail}" >
						</div>
						<span class="col-sm-6"></span>
					</div>
					<br/>
					
					<div class="row">
						<div class="add-purchase col-sm-offset-3 col-sm-9">
							<button type="button" class="btn btn-success">
								구매
							</button>
							<button type="button" class="btn btn-info">
								취소
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