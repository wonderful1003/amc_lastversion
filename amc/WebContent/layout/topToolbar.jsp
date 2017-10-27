<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@page import="com.amc.service.domain.User"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- ���Ⱑ �ٸ� jsp �������� �ִ� cdn ����///////////////////////////////////////////////////////////////////////////////////////////// -->
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0" /> -->
	
	<!--  �ظ� CDN ��������-->
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->	
	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->


	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- ���Ⱑ �ٸ� jsp �������� �ִ� cdn ��/////////////////////////////////////////////////////////////////////////////////////////////// -->
	
	<!--  �ظ� ĳ���� ��� js-->
	<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
  
   	<!-- īī�� �α��� -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- īī�� �α��� -->
   
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
</head>

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	 
	<div class="container">
	       <!-- �����η� ����  -->
		<a class="navbar-brand" href="/index.jsp">
			<img src="/images/common/AMC_Logo.png" width="80px" height="30px"/>
		</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	             <ul class="nav navbar-nav">
	             
	              <!-- ��ȭ DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span>��ȭ</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">���� �󿵿�ȭ</a></li>
	                         <li><a href="#">�� ������ȭ</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">�û�ȸ</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- ���� DrowDown  -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span>����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">��ȭ ����</a></li>
		                         <li><a href="#">�û�ȸ ����</a></li>
		                     </ul>
		                </li>
		                
	              <!-- ��ȭ��  -->
					  <li><a href="#">��ȭ��</a></li>
				
				  <!-- Ŀ�´�Ƽ  -->  
					  <li><a href="#">Ŀ�´�Ƽ</a></li>
		                
	              <!-- ����� DrowDown  -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span>�����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">����</a></li>
		                         <li><a href="#">������</a></li>
		                     </ul>
		                </li>
	                 
	             <!-- �����ڸ޴� DrowDown  -->
	             
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >[������ �޴�]</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">ȸ������</a></li>
		                         <li><a href="#">��ǰ����</a></li>
		                         <li><a href="#">�ǸŰ���</a></li>
		                         <li><a href="#">��ȭ����</a></li>
		                         <li><a href="#">�󿵰���</a></li>
		                         <li><a href="#">���Ű���</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	             </ul>
	             
	             
	             
	             <ul class="nav navbar-nav navbar-right">
	             <li>
	             	<div></div>
	             </li>
	             <li>
	             	<div></div>
	             </li>
	             <li>
	             	<div></div>
	             </li>
	             <li>
	           		<div style = margin:10px>
						<form class="form-inline" action="/cinema/unifiedSearch" method="post" role="form">
							<input type="text" class="form-control" name="searchKeyword" placeholder="���հ˻�">
							<input type="button" class="form-control" value="�˻�" onClick="javascript:unifiedSearch()">
						</form>
					</div>  
	          	 </li>
	             </ul>
	             
	           	 <!-- ������ ��α��� ������ �� -->	
	 			<c:if test="${empty user}">		
	 				<li>			
						<form class="navbar-form navbar-right">
						<!-- <a data-toggle="modal" href="../user/loginUser" data-target="#modal-testNew" role="button" data-backdrop="static"> -->
						<a data-toggle="modal" href="/user/loginUser" data-target="#modal-testNew" role="button" data-backdrop="static">
							<button type="button" class="btn btn-primary">Log in</button>
						</a >
							<a href="/user/authForm.jsp"><button type="button" class="btn btn-primary">Sign in</button></a>
						</form>
					</li>	
				</c:if>	
				
				<c:if test="${!empty user}">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#" class="user-info">[${sessionScope.user.userName}]</a>
						<li><a href="/cinema/myPage.jsp">����������</a></li>
						<li><a href="#">�α׾ƿ�</a></li>
					</ul>
				</c:if> 
   
		</div>
		<!-- dropdown hover END -->	       
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
   	
	   	function openHistory(){
	   		popWin = window.open("../openHistory.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	   	}
	   	
	   	function unifiedSearch(){
	   		$("form").attr("method" , "POST").attr("action" , "/cinema/unifiedSearch").submit();
	   	}
   	
		
		//============= ��ȭ Event  ó�� =============	
		/*  $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('��ȭ')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/movie/getMovieList"
			}); 
		 }); */
		
		//=============  ���� �󿵿�ȭ Event  ó�� =============	
	 	$( "a:contains('���� �󿵿�ȭ'),a:contains('ID')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/movie/getMovieList?menu=movie");
		});
		
		
	 	//=============  �� ������ȭ Event  ó�� =============	
	 	$( "a:contains('�� ������ȭ')" ).on("click" , function() {
			$(self.location).attr("href","/movie/getMovieList?menu=commingsoon");
		});
	 	
	 	//=============  �û�ȸ Event  ó�� =============	
	 	$( "a:contains('�û�ȸ')" ).on("click" , function() {
			$(self.location).attr("href","/movie/getMovieList?menu=preview");
		});
	 	
	 	//=============  ���� Event  ó�� =============	
	 	$( "a:contains('����')" ).on("click" , function() {
			$(self.location).attr("href","/booking/getScreenMovieList");
		});
	 	
	 	//=============  ��ȭ ���� Event  ó�� =============	
	 	$( "a:contains('��ȭ ����')" ).on("click" , function() {
			$(self.location).attr("href","/booking/getScreenMovieList");
		});
	 	
	 	//=============  �û�ȸ ���� Event  ó�� =============	
	 	$( "a:contains('�û�ȸ ����')" ).on("click" , function() {
			$(self.location).attr("href","/booking/getPreviewList");
		});
		
	 	//=============  ��ȭ�� Event  ó�� =============	
	 	$( "a:contains('��ȭ��')" ).on("click" , function() {
			$(self.location).attr("href","/cinema/theaterInfo.jsp");
		});
	 	
	 	//=============  Ŀ�´�Ƽ Event ó�� =============	
	 	$( "a:contains('Ŀ�´�Ƽ')" ).on("click" , function() {
			$(self.location).attr("href","/community/getFreeBoardList");
		});
	 	
	 	//============= ����� Event ó�� =============	
	 	$( "a:contains('�����')" ).on("click" , function() {
			$(self.location).attr("href","/product/getGoodsList?menu=search");
		});
	 	
	 	//=============  ���� Event ó�� =============	
	 	$( "a:contains('����')" ).on("click" , function() {
			$(self.location).attr("href","/product/getGoodsList?menu=search");
		});
	 	
	 	//=============  ������ Event ó�� =============	
	 	$( "a:contains('������')" ).on("click" , function() {
			$(self.location).attr("href","/product/getSnackList?menu=search");
		});
	 	
	 	//=============  ȸ������ Event  ó�� =============	
	 	$( "a:contains('ȸ������')" ).on("click" , function() {
			$(self.location).attr("href","/user/getUserList");
		});
	 	
	 	//=============  ��ǰ���� Event  ó�� =============	
	 	$( "a:contains('��ǰ����')" ).on("click" , function() {
			$(self.location).attr("href","/product/getGoodsList?menu=manage");
		});
	 	
	 	//=============  �ǸŰ��� Event  ó�� =============	
	 	$( "a:contains('�ǸŰ���')" ).on("click" , function() {
			$(self.location).attr("href","/purchase/getSaleList");
		});
	 	
	 	//=============  ��ȭ���� Event  ó�� =============	
	 	$( "a:contains('��ȭ����')" ).on("click" , function() {
			$(self.location).attr("href","/movie/getMovieList?menu=manage");
		});
	 	
	 	//=============  �󿵰��� Event  ó�� =============	
	 	$( "a:contains('�󿵰���')" ).on("click" , function() {
			$(self.location).attr("href","/screen/getScreenList");
		});
	 	
	 	//=============  ���Ű��� Event  ó�� =============	
	 	$( "a:contains('���Ű���')" ).on("click" , function() {
			$(self.location).attr("href","/booking/getAdminBookingList");
		});
	 	
	 	
/* 	 	//============= login Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("input:contains('�α���')").on("click" , function() {
				$(self.location).attr("href","/user/loginUser");
			}); 
		 });
 */	 	
	 	//============= logout Event  ó�� =============	
/*		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logoutUser");
			}); 
		 });
 */	 	
 
	 $(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a:contains('�α׾ƿ�')").on("click" , function() {
			//alert("īī���α׾ƿ�");
			logoutWithKakao();
			
		}); 
	});
 
		function logoutWithKakao() {
			Kakao.init('fc5658887af25f840e94144f6722b228');
			Kakao.Auth.logout(function(){
				setTimeout(function(){
					location.href="/user/logoutUser/"
				},300);
				});
		}

		//=============  �ֱ� �� ��ǰ  ó�� =============	
		 	$( "a:contains('�ֱ� �� ��ǰ')" ).on("click" , function() {
		 		openHistory();
			});
	 	
	</script>  