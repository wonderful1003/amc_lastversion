<%@ page import="com.amc.service.domain.User"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	User user = new User();
	user.setUserId("sadf@naver.com");
	user.setRole("admin");
	session.setAttribute("user", user);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
body {
      padding-top: 70px;
      }
      .thumbnail {
      width: 300px;
      height: 250px;
      overflow: auto;
}	
</style>
    

<!--  ///////////////////////// JavaScript ////////////////////////// -->

<script type="text/javascript">
	function addOpenAlarm() {
			$.ajax(
						{
							url : "/alarm/json/switchOpenAlarm?screenContentNo=10000&userId="
									+ "${sessionScope.user.userId}", //������ �˸� üũ ��û
							type : 'GET',
						}).done(function(data) {
					//���� ����� ���
					if (data == 'add') {
						var msg = '���¾˸��� ��û�Ǿ����ϴ�.';
						/* msg += '\n������ȭ : ' + movie����;
						 */
						alert(msg);
					} else {
						alert("���¾˸��� ��ҵǾ����ϴ�.");
					}
				});
	} //end of addOpenAlarm function

	function fncAddMovieComment() {
		var movieNo = $("input[name='movieNo']").val();
		var userId = $("input[name='userId']").val();
		var movieComment = $("textarea[name='movieComment']").val();

		console.log("adMovieComment()�� movieNo ==> " + movieNo);
		console.log("adMovieComment()�� userId ==> " + userId);
		console.log("adMovieComment()�� movieComment ==> " + movieComment);

		$.ajax({
			url : "/movie/json/addMovieComment/",
			type : 'POST',

			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				movie : {
					movieNo : movieNo
				},
				user : {
					userId : userId
				},
				movieComment : movieComment

			}),
			dataType : "text",

			success : function(JSONData, status) {
				console.log("fncAddMovieComment()");
			}
		})
	}

	function fncGetMovieComment() {
		var movieCommentNo;
		var movieComment;
		$(".movieCommentList:nth-child(4)")
				.on(	"click",	function() {
							movieCommentNo = $("input[name='movieCommentNo']", $(this)).val();
							movieComment = $("textarea[name='movieComment']", $(this)).val();
							console.log("fncUpdateMovieComment()�� movieCommentNo ==> "	+ movieCommentNo)
							console.log("fncUpdateMovieComment()�� movieComment ==> "	+ movieComment)

							$.ajax({
										url : "/movie/json/getMovieComment/" + movieCommentNo,
										type : 'GET',

										headers : {
											"Accept" : "application/json",
											"Content-Type" : "application/json"
										},

										dataType : "json",

										success : function(JSONData, status) {
											console.log("fncAddMovieComment() JSONData " + JSONData);
											
											$(	"#test").remove();
											///////////////////////////////////////////////////////////////var displayValue = "";
											
											
											
											
											var displayValue = "<div class='row' id='test'>"
													+ "<div class='col-xs-11'>"
													+ "<textarea class='form-control' name='movieComment2' placeholder='400�������� ������ �Է°����մϴ�.' rows=3 cols=140 >"
													+ JSONData.movieComment
													+ "</textarea>"
													+ "</div>"
													+ " <div>"
													+ "<button class='btn btn-primary col-xs-1' name='updateMovieComment' style='width:70px ;height:75px'>����</button>"
													+ "</div>" + "</div>";

											$(	"div[name='movieComment"+ movieCommentNo+ "']").html(displayValue);

											console.log("div[name='movieComment"+ movieCommentNo+ "']");

											$("button[name='updateMovieComment']").on("click", function() {
																$("input:hidden[name='movieCommentNo']").val(JSONData.movieCommentNo);
																$("input:hidden[name='movieComment']").val($("textarea[name='movieComment2']").val());
																fncUpdateMovieComment();
															})

										}
									}) //ajax ��

						}) //on()��
	}

	function fncUpdateMovieComment() {

		var movieComment = $("input:hidden[name='movieComment']").val();
		var movieCommentNo = $("input:hidden[name='movieCommentNo']").val();

		console.log("fncUpdateMovieComment() movieComment" + movieComment);
		console.log("fncUpdateMovieComment() movieCommentNo" + movieCommentNo);

		$.ajax({
			url : "/movie/json/updateMovieComment/",
			type : 'POST',

			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({

				movieComment : movieComment,
				movieCommentNo : movieCommentNo

			}),
			dataType : "text",

			success : function(JSONData, status) {
				console.log("fncAddMovieComment()");
			}
		})

	}

	function fncDeleteMovieComment() {

		var movieCommentNo;

		$(".movieCommentList:nth-child(5)").on("click",function() {
					movieCommentNo = $("input[name='movieCommentNo']", $(this)).val();

					console.log("fncDeleteMovieComment()�� movieCommentNo ==> "+ movieCommentNo)

					$.ajax({
						url : "/movie/json/deleteMovieComment/"+ movieCommentNo,
						type : 'GET',

						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},

						dataType : "json",

						success : function(JSONData, status) {
							console.log("fncAddMovieComment() JSONData "+ JSONData);
						
						}
					}) //ajax ��

				}) //on()��
	}
	
	function fncBlindCommentFlag() {
		var movieCommentNo;
		var blindCommentFlag;
		$(".movieCommentList:nth-child(6)").on("click", function () {
			movieCommentNo = $("input[name='movieCommentNo']", $(this)).val();
			blindCommentFlag = $("input[name='blindCommentFlag']", $(this)).val();
			
			console.log("fncBlindCommentFlag()�� movieCommentNo ==> "+ movieCommentNo)
			console.log("fncBlindCommentFlag()�� blindCommentFlag ==> "+ blindCommentFlag)
			
			$.ajax({
			url : "/movie/json/blindMoiveComment",
			type : 'POST',

			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({

				blindCommentFlag : blindCommentFlag,
				movieCommentNo : movieCommentNo

			}),
			dataType : "text",

			success : function(JSONData, status) {
				console.log("fncAddMovieComment()");
				var displayValue="<div class='movieCommentList' 	name='movieComment"+JSONData.movieCommentNo+"'>"+
				"����ε� ó���� �������Դϴ�." +"</div>";
				
				
			
			
				
			}
		})
		
			
		})
		
		
	}

	$(function() {
		 fncBlindCommentFlag();
		fncDeleteMovieComment();
		fncGetMovieComment();
		$("button[name='addMovieComment']").on("click", function() {
			fncAddMovieComment();
		})

	})
</script>

<body>

	<jsp:include page="/layout/topToolbar.jsp" />


	<input type="button" value="���� �˸� ��û"
		onClick="javascript:addOpenAlarm()">


	<div class="container">
		<div>
			<div class="page-header">
				<h2 class=" text-info">${movie.movieNm }</h2>
			</div>

			<div class="row ">

				<!--  <div class="col-xs-1 col-md-2"></div> -->

				<div class="col-md-2">
					<div>
						<br> <img src="${movie. postUrl}">
					</div>
				</div>

				<div class="col-md-10">
					<div>
						<h3 class=" text-info"></h3>
					</div>
					<div class="row">
						<div class="col-md-2">������</div>
						<div class="col-md-10">
							<input type="hidden" name='openDt' value="${movie.openDt }">${movie.openDt }</div>
					</div>
					<div class="row">
						<div class="col-md-2">����</div>
						<div class="col-md-10">${movie.directors }</div>
					</div>
					<div class="row">
						<div class="col-md-2">���</div>
						<div class="col-md-10">${movie.actors }</div>
					</div>
					<div class="row">
						<div class="col-md-2">�帣</div>
						<div class="col-md-10">${movie.genres }</div>
					</div>
					<div class="row">
						<div class="col-md-2">����Ÿ��</div>
						<div class="col-md-10">${movie.showTm }��</div>
					</div>
					<div class="row">
						<div class="col-md-2">�������</div>
						<div class="col-md-10">${movie.watchGradeNm }</div>
					</div>
					<div class="row">
						<button>��Ʈ����</button>
						<button>�����ϱ����</button>
						<button>��ũ���������</button>
					</div>
					<div>
						<button>Ƽ�Ͽ��¾˸�</button>
					</div>
				</div>
				<!--  <div class="col-xs-1 col-md-2"></div> -->
			</div>
		</div>
		<hr>

		<br>
		<div class="col-md-12" style="margin-bottom: 50px">
			<div
				style="border: 1px solid black; border-radius: 0.5em; padding: 10px;">
				<h3>�ٰŸ�</h3>
				<div>${movie.synopsis }</div>
			</div>
			<br>
			<div
				style="border: 1px solid black; border-radius: 0.5em; padding: 10px;">
				<h3>��ƿ��</h3>
				<div>${movie.steelCut1 }</div>
			</div>
			<br>
			<div
				style="border: 1px solid black; border-radius: 0.5em; padding: 10px;">
				<h3>Ʈ���Ϸ�</h3>
				<div>${movie.trailer }</div>
			</div>
		</div>



		<form method="post">
			<div class="col-md-12" style="margin-bottom: 50px">
				<div>
					<div style="margin-bottom: 30px">
						<h3>������</h3>
						<table>
							<tr>
								<c:if test="${user.userId !=null}">
									<td><textarea class="form-control" name="movieComment"
											placeholder="400�������� ������ �Է°����մϴ�." rows=3 cols=140></textarea></td>
								</c:if>
								<c:if test="${user.userId ==null}">
									<td><textarea class="form-control" name="movieComment"
											placeholder="�α��� �� �̿����ּ���" rows=3 cols=140></textarea></td>
								</c:if>
								<td><button class="btn btn-primary" name="addMovieComment"
										style="width: 70px; height: 75px">���</button></td>
							</tr>
						</table>
					</div>

					<div>
						<p>��ü ${resultPage.totalCount } ��, ���� ${resultPage.currentPage }
							������</p>
					</div>
					<hr style="border: solid 1px lightgray" />


					<c:set var="i" value="0" />
					<c:forEach var="movieComment" items="${list }">
						<c:set var="i" value="${i+1 }" />
						<div id="movieCommentList">
							<div class="movieCommentList" name="movieCommentListUserId">
								<h4>${movieComment.user.userId }</h4>
							</div>
							<div class="movieCommentList" 	name="movieComment${movieComment.movieCommentNo }">
							<c:if test="${movieComment.blindCommentFlag.trim() == 'Y'}">
									<span style="color:gray">����ε� ó�� �� �������Դϴ�.</span>
								</c:if> 
								<c:if test="${movieComment.blindCommentFlag.trim() == 'N'}">
									${movieComment.movieComment }
								</c:if>
								
							</div>

							<span class="movieCommentList">
								${movieComment.movieCommentRegDate }	
							</span> 
							<span class="movieCommentList">							
								<input type="hidden" name="movieCommentNo" value="${movieComment.movieCommentNo }">
								<i class="glyphicon glyphicon-pencil"></i> 
							</span>
							<span class="movieCommentList">
								<input type="hidden"name="movieCommentNo" value="${movieComment.movieCommentNo }">
								<i class="glyphicon glyphicon-trash"></i> 
							</span>								 
							<span class="movieCommentList">								 
								<input type="hidden" name="movieCommentNo" value="${movieComment.movieCommentNo }">
								<input type="hidden" name="blindCommentFlag" value="${movieComment.blindCommentFlag }">								
								<c:if test="${movieComment.blindCommentFlag.trim() == 'Y'}">
									<i class="glyphicon glyphicon-eye-open"></i>
								</c:if> 
								<c:if test="${movieComment.blindCommentFlag.trim() == 'N'}">
									<i class="glyphicon glyphicon-eye-close"></i>
								</c:if>
							</span>

						</div>

						<hr style="border: solid 1px lightgray" />
					</c:forEach>


				</div>
			</div>

			<div id="hidden">
				<input type="hidden" name='movieNo' value="${movie.movieNo }">
				<input type="hidden" name='userId' value="${user.userId }">
				<input type="hidden" name='movieComment' value="${movieComment.movieComment }"> 
				<input type="hidden" name='movieCommentNo' value="${movieComment.movieCommentNo }">
			</div>

		</form>



	</div>




</body>

</html>