<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">
	
<head>
    <title>Bootstrap datepicket demo</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script> 	
   	<!-- <script src="https://code.jquery.com/jquery-3.2.1.js"></script> -->
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>   
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
    <script type='text/javascript'>
    

/* 	//============= "로그인"  Event 연결 =============
	$( function() {		
		$("button.btn.btn-primary").on("click" , function() {
			fncgetId();			
		});	
	});	
			
	function fncgetId() {
		var name=$("#userName").val(); 		alert(name);
		var birth=$("#birth").val(); 		alert(birth);
		var phone=$("#phone").val();	 	alert(phone);	
		
		if(name == null || name.length <1) {
			alert('이름을 입력하지 않으셨습니다.');
			$("#userName").focus();
			return;
		}
		
		if(birth == null || birth.length <1) {
			alert('생일을 입력하지 않으셨습니다.');
			$("#birth").focus();
			return;
		}
		
		if(phone == null || phone.length <1) {
			alert('휴대폰번호를 입력하지 않으셨습니다.');
			$("#phone").focus();
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/user/getId").submit();
	}
 */
	
		//============= "인증메일발송"  Event 연결 =============
 	$(function() {
		$( "#sendpassword" ).on("click" , function() {
			fncSendMail();
		});
	});	

	$(function() {
		$( "#findId" ).on("click" , function() {
			fncfindId();
		});
	});	



 
	//============= userId 에 회원정보보기  Event  처리 (double Click)=============
	function fncfindId() {
		/* $(function() { */
	/* 	$( 'button.btn.btn-primary' ).on("click" , function() { */
			alert("여기는 ajax");
			var u = $("#userName").val();
			var b = $("#birth").val();
			var p1 = $("#phone1").val();
			var p2 = $("#phone2").val();
			var p3 = $("#phone3").val();
	
				$.ajax({
					url : "/user/json/getId/" ,
					method : "POST" ,							
					async : "true",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						userName : u,
						birth : b,
						phone1 : p1,
						phone2 : p2,
						phone3 : p3
					}),
					dataType : "text",
					success : function(JSONData , status) {
						var displayValue = "<h6>"
													+"아이디 : "+JSONData+"<br/>"										
													+"</h6>";	
						$("h6").remove();							
						$( "#userId" ).html(displayValue);								
					}
				});
		
		/* }); */
		
/* 	}); */ 
 
	}
	function fncSendMail() {
		
		 var userId=$("input[name='userId']").val();			    
		 if(userId != "" && (userId.indexOf('@') < 1 || userId.indexOf('.') == -1) 
			 || userId == ""){
	    	alert("이메일 형식이 아닙니다.");
	    	return;
	     }
		alert("여기는 이메일 보내기");
		$("form").attr("method" , "POST").attr("action" , "/user/sendPassword").submit();
	}

    </script>
    
<style>
.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:first-child a { color:#f00; }
.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:last-child a { color:#00f; }
</style>

<jsp:include page="../layout/topToolbar.jsp"/>

</head>

<body>
    <div class="container">
        
        <div class="page-header col-sm-offset-2 col-sm-10">	
        	<h1>아이디 / 패스워드 찾기</h1>
        </div>
        
     	 <form class="form-horizontal">	
     	 		
			<div class="form-group">
			  <label for="userName" class="col-sm-4 control-label">이 름</label>
			 	 <div class="col-sm-6">
			  		<input type="text" class="form-control" name="userName" id="userName" placeholder="이름" >
			  </div>
			</div>   
			
			<div class="form-group">
			  <label for="birth" class="col-sm-4 control-label">생 년 월 일</label>
			 	 <div class="col-sm-6">
			  		<input type="date" class="form-control" name="birth" id="birth" placeholder="생년월일" >
			  	</div>
			</div>
			
		  <div class="form-group">
		    <label for="ssn" class=" col-sm-4 control-label">휴대전화번호</label>
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
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
		    </div>
		    
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
		    </div>
		    <!-- <input type="hidden" name="phone"  /> -->
		  </div>
	
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" id="findId" class="btn btn-primary"  >확 &nbsp;인</button>
			    </div>
			</div>
			
		</form>
			  
		  <div class="form-group">
			  	<div class="col-sm-offset-4  col-sm-4 text-center">
			  	<i class="glyphicon glyphicon-ok" id= "userId"></i>
			  	<input type="hidden" value="${user.userId}">
			  	</div>
			</div>  
		
		</br></br></br>
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
		
	   <form class="form-horizontal" id="findPassword" >
		   
		   <fieldset>			
		   <legend class="screen_out"></legend>
			<div class="form-group">
			  <label for="userId" class="col-sm-4 control-label">이메일 아이디</label>
			 	 <div class="col-sm-6">
			  		<input type="text" class="form-control" name="userId" id="email" placeholder="이름" autofocus autocomplete="off" required>
			  </div>
			</div>   
			
			<div class="form-group">
			  <label for="userName" class="col-sm-4 control-label">이 름</label>
			 	 <div class="col-sm-6">
			  		<input type="text" class="form-control" name="userName" id="userName" placeholder="이름" >
			  </div>
			</div>   
			
		  <div class="form-group">
		    <label for="ssn" class=" col-sm-4 control-label">휴대전화번호</label>
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
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
		    </div>
		    
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
		    </div>
		    <!-- <input type="hidden" name="phone"  /> -->
		  </div>
	
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" id="sendpassword" class="btn btn-primary"  >비밀번호발송</button>
			    </div>
			</div>
			</fieldset>
		</form>
		    
	
		<!-- Modal 화면 tool bar로 부터 받아오기	 --> 
		<div id="modal-testNew" class="modal fade" tabindex="-1" role="dialog" 
										aria-labelledby="테스트정보 등록" aria-describedby="테스트 모달">
		    <div class="modal-dialog" style="width:1200px;height:700px">
		        <div class="modal-content">
		        </div>
		    </div>
		</div> 
    </div>
</body>
</html>