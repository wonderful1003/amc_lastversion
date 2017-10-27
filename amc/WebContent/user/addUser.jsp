<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="euc-kr">	
	<!-- 참조 : http://getbootstrap.com/css/    -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- 카카오 API -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<title>Login Demo - Kakao JavaScript SDK</title>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- 카카오 API -->
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 다음 주소 CDN -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body{
			padding-top : 70px;
		}
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		var check = false;
		//============= "가입"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		
/* 		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	
	
 */		
		function fncAddUser() {
			
			var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
			var birth=$("input[name='birth']").val();
			var check=true
			
			if(id == null || id.length <1){
				alert("아이디는 반드시 입력하셔야 합니다.");
				/* return check=false; */
				return;
			}
			if(id != null && (id.indexOf('@') < 1 || id.indexOf('.') == -1) ){
				alert("이메일형식이아닙니다.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("패스워드는  반드시 입력하셔야 합니다.");
				/* return check=false; */
				return; 
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("패스워드 확인은  반드시 입력하셔야 합니다.");
				/* return check=false; */
				return;
			}
			if(name == null || name.length <1){
				alert("이름은  반드시 입력하셔야 합니다.");
				/* return check=false; */
				return;
			}
			if( pw != pw_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:text[name='password2']").focus();
				/* return check=false; */
				return;
			}			
			if( birth == null || birth.length <1 ) {				
				alert("생년월일은 반드시 입력해야합니다..");				
				/* return check=false; */
				return;
			}
			
				
			var value = "";	
			if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
				var value = $("option:selected").val() + "-" 
									+ $("input[name='phone2']").val() + "-" 
									+ $("input[name='phone3']").val();
			}

			/* $("input:hidden[name='phone']").val( value ); */
			
			if(check == true){
				alert('회원가입을 축하합니다.');
				$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
			}
			
			/* $("form").attr("method" , "POST").attr("action" , "/user/addUser").submit(); */
		}
		
 
/*  		$(function(){
 			$('#email_select').change(function(){
 				if($('#email_select').val() == "1"){
 					$('#last_email').val(""); //값 초기화
 					$('#last_email').prop("readonly",false); //활성화
 				} else if($('#email_select').val()==""){
 					$('#last_email').val(""); //값 초기화
 					$('#last_email').prop("readonly",true); //textBox 비활성화
 				} else {
 					$('#last_email').val($('#email_select').val()); //선택값 입력
 					$('#last_email').prop("readonly",true); //비활성화
 				}
 			});
 		});
 */ 	
 
 
		//==>""이메일" 유효성Check / ID중복확인" Event 처리 및 연결
		$(function(){					
			$('#userId').bind('keyup', function(){
				var userId = $(this).val().trim();
				var tempId = userId.split(".");
                console.log("userId :: " + userId);
                console.log("tempId :: " + tempId);
					$.ajax({
						url : 'json/checkDuplication/'+tempId,
						method : 'get',
						dataType : 'json', 
						 headers : {
							'Accept' : 'application/json',
							'Content-Type' : 'application/json'
						}, 
						success : function(JSONData , status){
							/* alert("JSONData" + JSONData); */
							if(JSONData){
								$('span.help-block').html('사용가능한 아이디 입니다.').css('color','blue');
								check = true;
							}else{
								$('span.help-block').html('이미 존재하는 아이디 입니다.').css('color','red');
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
			$('#password2').bind('keyup',function(){
				if( $('#password').val() != $(this).val()){
					$('span.help-block2').text("비밀번호가 다릅니다.").css('color','red');
				}else{
					$('span.help-block2').text("확인").css('color','blue');
				}
			});
		});
		
		
		
		
		////다음 주소 API////////////////////////////////////////////////////////////////////////////////////////////////
			function execDaumPostcode() {
				
		        new daum.Postcode({
		            oncomplete: function(data) {
		            	
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var fullAddr = ''; // 최종 주소 변수
		                var extraAddr = ''; // 조합형 주소 변수
		
		                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    fullAddr = data.roadAddress;
		
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    fullAddr = data.jibunAddress;
		                }
		
		                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
		                if(data.userSelectedType === 'R'){
		                    //법정동명이 있을 경우 추가한다.
		                    if(data.bname !== ''){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있을 경우 추가한다.
		                    if(data.buildingName !== ''){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
		                document.getElementById('address').value = fullAddr;
		
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById('address_detail').focus();
		            },
		        
		            theme: {
		    	 		bgColor: "#ECECEC", //바탕 배경색
		    	 		searchBgColor: "#0B65C8", //검색창 배경색
		    	 		contentBgColor: "#FFFFFF", //본문 배경색(검색결과,결l과없음,첫화면,검색서제스트)
		    	 		pageBgColor: "#FAFAFA", //페이지 배경색
		    	 		textColor: "#333333", //기본 글자색
		    	 		queryTextColor: "#FFFFFF", //검색창 글자색
		    	 		postcodeTextColor: "#FA4256", //우편번호 글자색
		    	 		emphTextColor: "#008BD3", //강조 글자색
		    	 		outlineColor: "#E0E0E0" //테두리
		    		}   
	            
		        }).open();
		    }

	</script>		
    
</head>

<body bgcolor="#ffffff" text="#000000">

	<jsp:include page="../layout/topToolbar.jsp">
		<jsp:param name="uri" value="../"/>
	</jsp:include>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="page-header col-sm-offset-2 col-sm-10">	
		<h1>회 원 가 입</h1>
		</div>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
			
		  <div class="form-group">
		    <label for="userId" class="col-sm-3 control-label">아 이 디</label>
		    <div class="col-sm-3">
		   	 <input type="text" class="form-control" value="${email}" id="userId" name="userId" placeholder="ID입력" aria-describedby="helpBlock" readonly/>
		    <!--  <input type="text" class="form-control" id="first_email" placeholder="ID입력" aria-describedby="helpBlock" />
		       @<input type="text" class="form-control" id="last_email" placeholder="이메일입력" aria-describedby="helpBlock" />
		    	<select id="email_select">
		    		<option value="" selected>::선택하기::</option>
		    		<option value="naver.com">naver.com</option>
		    		<option value="nate.com">nate.com</option>
		    		<option value="daum.net">daum.net</option>
		    		<option value="gmail.com">gmail.com</option>
		    		<option value="1">::직접입력::</option>
		    	</select> -->
		    </div>	
		    <span id="helpBlock" class="help-block col-sm-6"></span>		    
		  </div>
		  
		  <div class="form-group">
		    <label for="password" class=" col-sm-3 control-label">비밀번호</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class=" col-sm-3 control-label">비밀번호 확인</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호 확인" aria-describedby="helpBlock2" >
		    </div>
		     <span id="helpBlock2" class="help-block2 col-sm-6"></span>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class=" col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="회원이름">
		    </div>
		  </div>
		 
		   <span>		  
		  
		  <div class="form-group">
			  <label for="birth" class="col-sm-3 control-label">생 년 월 일</label>
			 	 <div class="col-sm-4">
			  		<input type="date" class="form-control" name="birth" id="birth" placeholder="생년월일" >
			  	</div>
			</div>
		  
		  <div class="form-group">
			  <label for="calendarType" class="col-sm-3 control-label">양력음력 구분</label>
			 	 <div class="col-sm-4">			  		
			  	  	<input type='radio' name='calendarType' value='S' checked="checked">양력
					<input type='radio' name='calendarType' value='L'>음력
			  	</div>
		  </div>
		  
		  <div class="form-group">
			  <label for="gender" class="col-sm-3 control-label">양력음력 구분</label>
			 	 <div class="col-sm-4">			  		
			  	  	<input type='radio' name='gender' value='M' checked="checked">남자
					<input type='radio' name='gender' value='F'>여자
			  	</div>
		  </div>
		  
		 
		  </span>
		  
		  <div class="form-group">
		    <label for="ssn" class=" col-sm-3 control-label">우편번호</label>
		    <div class="col-sm-4">		      
			    <input type="text" class="form-control" id="postcode" placeholder="우편번호" readonly>
			    	  	<strong class="text-danger">입력전 중복확인 부터..</strong>			    
				</div>
				
				<div class="col-sm-3" >
					<input type="button" class="btn btn-info" onclick="execDaumPostcode()" value="우편번호 찾기" readonly="readonly" >
				</div>
			</div>	
				
				<div class="form-group">
				  <label for="ssn" class=" col-sm-3 control-label">주소</label>
				    <div class="col-sm-4">
						<input type="text" name='addr' class="form-control" id="address" placeholder="주소">
					</div>
				</div>
				
				<div class="form-group">
				  <label for="ssn" class=" col-sm-3 control-label">상세주소</label>
				    <div class="col-sm-4">			
						<input type="text" name='addrDetail' class="form-control" id="address_detail" placeholder="상세주소">
					</div>
				</div>	
			
			<!-- <h1>참조 : http://postcode.map.daum.net/guide</h1> -->
		  		  
		  <div class="form-group">
		    <label for="phone" class=" col-sm-3 control-label">휴대전화번호</label>
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
		  </div>
		  		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >가 &nbsp;입</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
	
</body>

</html>