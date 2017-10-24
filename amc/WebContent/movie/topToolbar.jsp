<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@page import="com.amc.service.domain.User"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	User user = new User();
	user.setUserId("testAdmin");
	user.setRole("admin");
	session.setAttribute("user", user);
%>

<head>
<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
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
	             <!-- ������ �α��� ������ �� -->
	             	<c:if test="${sessionScope.user ne null }">
		             	<li title="Click : �������� ����"><a href="#">ID : [${sessionScope.user.userId }]</a></li>
		             	<li><a href="#">�α׾ƿ�</a></li>
		             	<li><a href="#">����������</a></li>
	             	</c:if>
	             	
	             <!-- ������ ��α��� ������ �� -->	
	             	<c:if test="${sessionScope.user eq null }">
		             	<li>
		             		<input type="text" name="userId" placeholder="���̵�" width="300px">
		             		<input type="text" name="password" placeholder="��й�ȣ" width="300px">
		             	</li>
		             	<input type="button" value="�α���">
	             	</c:if>
	            </ul>
	           	 <!-- ������ ��α��� ������ �� -->	
             	<c:if test="${sessionScope.user eq null }">
	             	<li>
	             		<input type="text" name="userId" placeholder="���̵�" width="300px">
	             		<input type="text" name="password" placeholder="��й�ȣ" width="300px">
	             	</li>
	             	<input type="button" value="�α���">
             	</c:if>
 --%>	             	
	 			<c:if test="${empty user}">					
						<form class="navbar-form navbar-right">
						<!-- <a data-toggle="modal" href="../user/loginUser" data-target="#modal-testNew" role="button" data-backdrop="static"> -->
						<a data-toggle="modal" href="/user/loginUser" data-target="#modal-testNew" role="button" data-backdrop="static">
							<button type="button" class="btn btn-primary">Log in</button>
						</a>
							<button type="button" class="btn btn-primary">Sign in</button>
						</form>
					</li>	
				</c:if>	
				
				<c:if test="${!empty user}">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#" class="user-info">${sessionScope.user.userName}</a>
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
			$(self.location).attr("href","/booking/getScreenPreviewList");
		});
		
	 	//=============  ��ȭ�� Event  ó�� =============	
	 	$( "a:contains('��ȭ��')" ).on("click" , function() {
			$(self.location).attr("href","/cinema/theaterInfo");
		});
	 	
	 	//=============  Ŀ�´�Ƽ Event ó�� =============	
	 	$( "a:contains('Ŀ�´�Ƽ')" ).on("click" , function() {
			$(self.location).attr("href","/community/getFreeBoardList");
		});
	 	
	 	//============= ����� Event ó�� =============	
	 	$( "a:contains('�����')" ).on("click" , function() {
			$(self.location).attr("href","/product/getGoodsList");
		});
	 	
	 	//=============  ���� Event ó�� =============	
	 	$( "a:contains('����')" ).on("click" , function() {
			$(self.location).attr("href","/product/getGoodsList");
		});
	 	
	 	//=============  ������ Event ó�� =============	
	 	$( "a:contains('������')" ).on("click" , function() {
			$(self.location).attr("href","/product/getSnackList");
		});
	 	
	 	//=============  ȸ������ Event  ó�� =============	
	 	$( "a:contains('ȸ������')" ).on("click" , function() {
			$(self.location).attr("href","/user/getUserList");
		});
	 	
	 	//=============  ��ǰ���� Event  ó�� =============	
	 	$( "a:contains('��ǰ����')" ).on("click" , function() {
			$(self.location).attr("href","/product/getGoodsList");
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
	 	$( "a:contains('���Ű���')" ).on("click" , function() {ss
			$(self.location).attr("href","/booking/getAdminBookingList");
		});
	 	
	 	
	 	//============= login Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("input:contains('�α���')").on("click" , function() {
				$(self.location).attr("href","/user/loginUser");
			}); 
		 });
	 	
	 	//============= logout Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logoutUser");
			}); 
		 });
	 	
		//=============  �ֱ� �� ��ǰ  ó�� =============	
		 	$( "a:contains('�ֱ� �� ��ǰ')" ).on("click" , function() {
		 		openHistory();
			});
	 	
	</script>  