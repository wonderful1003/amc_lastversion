<%@ page import="com.amc.service.domain.User"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
 
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	
	<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
	<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-social/5.1.1/bootstrap-social.css" />
	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
    
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	

	
<script type="text/javascript">
var movieNo
var userId 
var screenContentNo
var movieNm 

window.fbAsyncInit = function() {
    FB.init({
     // appId      : '688547171338913',
      xfbml      : true,
      version    : 'v2.10'
    });
    FB.AppEvents.logPageView();
  };


  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
      js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.10&appId=688547171338913';
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
  
  function posting() {
	  FB.ui({
		    method: 'share_open_graph',
		    action_type: 'og.shares',
		    action_properties: JSON.stringify({
		    	   object:{
	                    
	                    'og:title': 'AMC',
	                    'og:description': '영화 '+movieNm+'상세보기',
	                    'og:url':  'http://192.168.0.32:8080/movie/getMovie?movieNo='+movieNo+'&menu=search',
	              
	                    'og:image': 'http://192.168.0.32:8080/images/common/AMC_Logo.png'
	                    
	                }
		      }),
		 
		    mobile_iframe: true,
		  
		  }, function(response){});
		
}
  
  
	var targetDiv;
		function fncGetPageList(currentPage) {
		    $("#currentPage").val(currentPage)
		    console.log( "ddd"+ $("#currentPage").val());
		    $("form").attr("method", "POST").attr("action", "/movie/getMovie?movieNo="+movieNo+"&menu=search").submit();
		}


	function addOpenAlarm() {
		$.ajax(
						{
							url : "/alarm/json/switchOpenAlarm?screenContent.screenContentNo="+screenContentNo+"&user.userId="
									+ "${sessionScope.user.userId}", //서버로 알림 체크 요청
									
							type : 'GET',
						}).done(function(data) {
					//정상 통신인 경우
					if (data == 'add') {
						var msg = '오픈알림이 신청되었습니다.';
						/* msg += '\n무슨영화 : ' + movie정보;
						 */
						alert(msg);
					} else {
						alert("오픈알림이 취소되었습니다.");
					}
				});
	} //end of addOpenAlarm function

	function fncAddMovieComment() {
		
		var movieComment = $("textarea[name='movieComment']").val();

		console.log("adMovieComment()의 movieNo ==> " + movieNo);
		console.log("adMovieComment()의 userId ==> " + userId);
		console.log("adMovieComment()의 movieComment ==> " + movieComment);

		$.ajax({
			url : "/movie/json/addMovieComment/",
			type : 'POST',

			headers : {

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
			dataType : "json",

			success : function(JSONData, status) {
				console.log("fncAddMovieComment()");
			}
		})
	}
	
	function fncGetMovieComment(){
		var movieCommentNo;
		var movieComment;
		$(".movieCommentList:nth-child(4)").on("click", function () {
			movieComment = $(this).parent().find("#movieComment").find("span").find("input").val();
			movieCommentNo = $("input[name='movieCommentNo']", $(this)).val();
			
			$("input:hidden[name='movieComment']").val(movieComment);
			
			movieComment = $("input:hidden[name='movieComment']").val();
			
			
			displayValue = "<div id='test02'>"+movieComment+"</div>";
			console.log(displayValue);
			
			if( targetDiv != null){
			
				targetDiv.find('#movieComment').html(displayValue);
			}
				targetDiv = $(this).parent();
				
				
				
				 
				
				
				var	displayValue = "<div class='row' id='updateMovieComment'>"
					+ "<div class='col-xs-11'>"
					+ "<textarea class='form-control' name='movieComment2' placeholder='400자이하의 감상평만 입력가능합니다.' rows=3 cols=140 >"
					+ movieComment
					+ "</textarea>"
					+ "</div>"
					+ " <div>"
					+ "<button class='btn btn-primary col-xs-1' name='updateMovieComment' style='width:70px ;height:75px'>수정</button>"
					+ "</div>" + "</div>";

					
					
				$(	"div[name='movieComment"+ movieCommentNo+ "']").html(displayValue);

				console.log("div[name='movieComment"+ movieCommentNo+ "']");
				
				 
					

				$("button[name='updateMovieComment']").on("click", function() {
									$("input:hidden[name='movieCommentNo']").val(movieCommentNo);
									$("input:hidden[name='movieComment']").val($("textarea[name='movieComment2']").val());
									
									fncUpdateMovieComment();
			})

								
					
				
			
			
			
			
		})
	}
	
	
	
	
	
/* 
	function fncGetMovieComment2() {
		var movieCommentNo;
		var movieComment;
		
		
		$(".movieCommentList:nth-child(4)").on(	"click",	function() {
							movieCommentNo = $("input[name='movieCommentNo']", $(this)).val();
							movieComment = $("textarea[name='movieComment']", $(this)).val();
							movieComment2 = $("input[name='movieCommentNo2']", $(this)).val();
							console.log("fncUpdateMovieComment()의 movieCommentNo ==> "	+ movieCommentNo)
							console.log("fncUpdateMovieComment()의 movieComment2 ==> "	+ movieComment2)
							
						
							
								displayValue2 = "<div id='test02'>"+movieComment2+"</div>";

							if( targetDiv != null){
								console.log(displayValue2)
								alert("까꿍")
								alert(targetDiv.find('#test03').html());
								targetDiv.find('#test03').html(displayValue2);
							}
								targetDiv = $(this).parent();

						
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
											
											var	displayValue = "<div class='row' id='test'>"
													+ "<div class='col-xs-11'>"
													+ "<textarea class='form-control' name='movieComment2' placeholder='400자이하의 감상평만 입력가능합니다.' rows=3 cols=140 >"
													+ JSONData.movieComment
													+ "</textarea>"
													+ "</div>"
													+ " <div>"
													+ "<button class='btn btn-primary col-xs-1' name='updateMovieComment' style='width:70px ;height:75px'>수정</button>"
													+ "</div>" + "</div>";

											$(	"div[name='movieComment"+ movieCommentNo+ "']").html(displayValue);

											console.log("div[name='movieComment"+ movieCommentNo+ "']");
											
											 
												

											$("button[name='updateMovieComment']").on("click", function() {
																$("input:hidden[name='movieCommentNo']").val(JSONData.movieCommentNo);
																$("input:hidden[name='movieComment']").val($("textarea[name='movieComment2']").val());
																fncUpdateMovieComment();
															})

															
										}
									}) //ajax 끝

						}) //on()끝
	}
 */
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
				
				var	displayValue = "<div class='row' id='updateMovieComment'>"
					+ "<div class='col-xs-11'>"
					+ movieComment
					+ "</textarea>"
					+ "</div>"
					+ " </div>";

					console.log("test"+movieComment+"            " +movieCommentNo)
				$(	"div[name='movieComment"+ movieCommentNo+ "']").html(displayValue);
					
					
					$("hidden[name='movieComment']").val(movieComment);

				
				
			}
		})

	}

	function fncDeleteMovieComment() {

		var movieCommentNo;

		$(".movieCommentList:nth-child(5)").on("click",function() {
					movieCommentNo = $("input[name='movieCommentNo']", $(this)).val();

					console.log("fncDeleteMovieComment()의 movieCommentNo ==> "+ movieCommentNo)

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
					}) //ajax 끝

				}) //on()끝
	}
	
	function fncBlindCommentFlag() {
		var movieCommentNo;
		var blindCommentFlag;
		$(".movieCommentList:nth-child(6)").on("click", function () {
			movieCommentNo = $("input[name='movieCommentNo']", $(this)).val();
			blindCommentFlag = $("input[name='blindCommentFlag']", $(this)).val();
			
			console.log("fncBlindCommentFlag()의 movieCommentNo ==> "+ movieCommentNo)
			console.log("fncBlindCommentFlag()의 blindCommentFlag ==> "+ blindCommentFlag)
			if(blindCommentFlag == 'N'){
				console.log('dddd');
				if(confirm("정말 블라인드 처리를 하시겠습니까?") == true){
					
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
						}
					})
	
				}else{
					return;
				}
			}else{
				console.log('dddd');
				if(confirm("정말 블라인드 처리를 취소 하시겠습니까?") == true){
					
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
						}
					})
	
				}else{
					return;
				}
			}
			
		
			
		})
		
		
	}

	$(function() {
		movieNo = $("input[name='movieNo']").val();
		userId = $("input[name='userId']").val();
		screenContentNo = $("input[name='screenContentNo']").val();
		movieNm = $("input[name='movieNm']").val();
	
	
		console.log(userId);
		$("button[name='booking']").on("click", function() {
			
				$(self.location).attr("href","/booking/getScreenMovieList");
			
		})
		
		$("button[name='wish']").on("click", function() {
			if(userId == ""){
				alert('로그인 후 이용가능합니다')
			}else{
				//$(self.location).attr("href","/booking/getScreenMovieList");
				


			}
		})

		
		
 		$("button[name='ticketOpen']").on("click", function() {
			if(userId == ""){
				alert('로그인 후 이용가능합니다')
			}else{
				addOpenAlarm()
			}
		})  
		
		
		 fncBlindCommentFlag();
		fncDeleteMovieComment();
		fncGetMovieComment();
		$("button[name='addMovieComment']").on("click", function() {
			fncAddMovieComment();
		})
		targetDiv = null;
		
	})
	

	
</script>

<style>
body {
	padding-top: 70px;
}

textarea {
	rows: 3;
	cols: 140;
	resize: none;
}
div.img{
	width : 150px; hieght:200px; line-height:200px;
	text-align : center;
}
#realTimeSearch{
width:500px;
height: 300px;
}
.your-class img{
	height : calc(50vh - 100px);
	width : auto;
	margin : 0 auto;
}
.slick-prev:before,
.slick-next:before{
	color : #f06060;
}
#twitterSearch{
color:#065a69;
}

</style>

<body>




	<jsp:include page="/layout/topToolbar.jsp" />



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
						<div class="col-md-2">개봉일</div>
						<div class="col-md-10">
							<input type="hidden" name='openDt' value="${movie.openDt }">${movie.openDt }</div>
					</div>
					<div class="row">
						<div class="col-md-2">감독</div>
						<div class="col-md-10">${movie.directors }</div>
					</div>
					<div class="row">
						<div class="col-md-2">배우</div>
						<div class="col-md-10">${movie.actors }</div>
					</div>
					<div class="row">
						<div class="col-md-2">장르</div>
						<div class="col-md-10">${movie.genres }</div>
					</div>
					<div class="row">
						<div class="col-md-2">러닝타임</div>
						<div class="col-md-10">${movie.showTm }분</div>
					</div>
					<div class="row">
						<div class="col-md-2">관람등급</div>
						<div class="col-md-10">${movie.watchGradeNm }</div>
					</div>
					<br>
					<div class="row center-block col-md-12" >
						&emsp;&emsp;
						<div id='wishAfter'></div>
						<button class="btn btn-link btn-lg" name="wish" ><h3><i class="glyphicon glyphicon-heart-empty" id="heartempty" style="color:#f06060; text-align : center; margin:0 auto;"></i></h3></button>
						<button class="btn btn-pinterest" style="width:100px" name="booking">예매하기</button>
						<button class="btn btn-facebook" style="width:100px"  onClick="javascript:posting()"  ><i class="fa fa-facebook"> &nbsp; </i>공유하기</button>
						<c:if test="${screenContent.screenContentNo != 0 }">
							<button  class="btn btn-vimeo"     name = "ticketOpen">티켓오픈알림</button><!-- -->
						</c:if>						
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
				<h3>줄거리</h3>
				<div>${movie.synopsis }</div>
			</div>
			<br>
			<div		style="border: 1px solid black; border-radius: 0.5em; padding: 10px;">
				<h3>스틸컷</h3>

				
					<c:if test="${movie.steelCut1 !=  null}">
					
				
						<div class="center-block your-class" style="width:800px">
			   					<div >
			 					 	<div class="image center-block "  ><img  src="/images/movie/${movie.steelCut1 }" /></div>
			 					</div>			 				
			 				<c:if test="${movie.steelCut2 != null }">
								<div>
									<div class="image"><img class="steelCut" src="/images/movie/${movie.steelCut2 }"/></div>
								</div>
							</c:if>	
							<c:if test="${movie.steelCut3 != null }">
								<div>
									<div class="image"><img class="steelCut" src="/images/movie/${movie.steelCut3 }"/></div>
								</div>
							</c:if>				
						</div>
						
	
					 </c:if> 
					  
					  
				<div></div>
			</div>
			<br>
			<div
				style="border: 1px solid black; border-radius: 0.5em; padding: 10px;">
				<h3>트레일러</h3>
				<div></div>
			<p align="middle"><iframe  width="960" height="500" src="${movie.trailer }" frameborder="0" allowfullscreen></iframe></p>
			</div>
		</div>
		<div class='row'>
			<div class='col-md-3'>			
				<h3>예매자 성별 차트</h3>
				<canvas id="genderChart" width="400" height="400"></canvas>
			</div>
			<div class='col-md-3'>
				<h3>예매자 나이 차트</h3>
				<canvas id="ageChart" width="400" height="400"></canvas>
			</div>
			<div class='col-md-6'><h3><span class="fa fa-twitter" id='twitterSearch' > </span>  ${movie.movieNm}  실시간 트위터 검색</h3>
				
			<iframe id="realTimeSearch" src="http://192.168.0.10:1337/${movie.movieNm }" frameborder = 0 >		 
					  <p>Your browser does not support iframes.</p>
			</iframe>
			
			</div>
		</div>



	
			<div class="col-md-12" style="margin-bottom: 50px">
				<div style="margin-bottom: 30px">
					<h3>감상평</h3>
					<table>
						<tr>
							<c:if test="${user.userId !=null}">
								<td><textarea class="form-control" name="movieComment"
										placeholder="400자이하의 감상평만 입력가능합니다." rows=3 cols=140></textarea></td>
							</c:if>
							<c:if test="${user.userId ==null}">
								<td><textarea class="form-control" name="movieComment"
										placeholder="로그인 후 이용해주세요" rows=3 cols=140 readonly="readonly"></textarea></td>
							</c:if>
							<td><button class="btn btn-primary" name="addMovieComment" <c:if test="${user.userId ==null}">disabled="disabled"</c:if>
									style="width: 70px; height: 75px"  >등록</button></td>
						</tr>
					</table>
				</div>

				<div>
					<p>전체 ${resultPage.totalCount } 건, 현재 ${resultPage.currentPage }
						페이지</p>
				</div>
				<hr style="border: solid 1px lightgray" />


				<div>
					<c:set var="i" value="0" />
					<c:forEach var="movieComment" items="${list }">
						<c:set var="i" value="${i+1 }" />
						<div id="movieCommentList">
							<div class="movieCommentList" name="userId${movieComment.movieCommentNo }">
								<h4>${movieComment.user.userId }</h4>
							</div>
						<div id="movieComment" class="movieCommentList" 	name="movieComment${movieComment.movieCommentNo }">
							<c:if test="${movieComment.blindCommentFlag.trim() == 'Y'}">
									<span style="color:gray">블라인드 처리 된 감상평입니다.</span>
									<c:if test="${user.role == 'admin'}">
									<br>
									<span style="color:gray">${movieComment.movieComment }</span>
									
									</c:if>
							</c:if> 
							<c:if test="${movieComment.blindCommentFlag.trim() == 'N'}">
								<span>	
									${movieComment.movieComment }
									<input type="hidden" value="${movieComment.movieComment }" name='movieComment2'>
								</span>
							</c:if>
						</div>
							<span class="movieCommentList">
								${movieComment.movieCommentRegDate }	
							</span> 
							<c:if test="${user.userId == movieComment.user.userId || user.role == 'admin'}">
							<span class="movieCommentList">							
								<input type="hidden" name="movieCommentNo" value="${movieComment.movieCommentNo }">
								<i class="glyphicon glyphicon-pencil"></i> 
							</span>
							<span class="movieCommentList">
								<input type="hidden"name="movieCommentNo" value="${movieComment.movieCommentNo }">
								<i class="glyphicon glyphicon-trash"></i> 
							</span>								 
							<c:if test="${user.role == 'admin'}">
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
							</c:if>
							</c:if>
						</div>
						<hr style="border: solid 1px lightgray" />
					</c:forEach>

				</div>
			</div>

			<div id="hidden">
				<input type="hidden" name='movieNm' value="${movie.movieNm }">
				<input type="hidden" name='movieNo' value="${movie.movieNo }">
				<input type="hidden" name='userId' value="${user.userId }">
				<input type="hidden" name='movieComment' value="${movieComment.movieComment }"> 
				<input type="hidden" name='movieCommentNo' value="${movieComment.movieCommentNo }">
				<input type="hidden" name='screenContentNo' value="${screenContent.screenContentNo }">
			
				<input type="hidden" name='femaleCnt' value="${movie.femaleCnt}">
				<input type="hidden" name="maleCnt" value="${movie.maleCnt}" />
				<input type="hidden" name="age10s" value="${movie.age10s}" />
				<input type="hidden" name="age20s" value="${movie.age20s}" />
				<input type="hidden" name="age30s" value="${movie.age30s}" />
				<input type="hidden" name="age40s" value="${movie.age40s}" />
				<input type="hidden" name="age50s" value="${movie.age50s}" />
				<input type="hidden" name="age60s" value="${movie.age60s}" />
				<input type="hidden" name="age60sMore" value="${movie.age60sMore}" />
			
			
				<form>
					<input type="hidden" id="currentPage" name="currentPage" value="" />
				</form>
			</div>




	</div>

<jsp:include page="../common/pageNavigator.jsp" />


</body>
<script>

var ctx1 = document.getElementById("genderChart").getContext('2d');
var femaleCnt = $("input:hidden[name='femaleCnt']").val();
var maleCnt = $("input:hidden[name='maleCnt']").val();
console.log(femaleCnt)
console.log(maleCnt)
var genderData = {
	
	
	    datasets: [{
	        data: [
	               maleCnt, femaleCnt 
	        ],	       
	        backgroundColor : [
	                           'rgb(54, 162, 235)',
	                           'rgb(255, 99, 132)'
	             	    ],	             	    
	             	    borderColer : [
	             			'rgb(255, 99, 132)',
	             			'rgb(54, 162, 235)'         
	             	    ]
	    }],

	    // These labels appear in the legend and in the tooltips when hovering different arcs
	    labels: [
	        '남자',
	        '여자'
	    ]
	    
	};

var ageChart = new Chart(ctx1, {
	  type: 'pie',
	    data: genderData,
	    options: {
            responsive: true
            
        }
   
});




var ctx2 = document.getElementById("ageChart").getContext('2d');


var age10s = $("input:hidden[name='age10s']").val();
var age20s = $("input:hidden[name='age20s']").val();
var age30s = $("input:hidden[name='age30s']").val();
var age40s = $("input:hidden[name='age40s']").val();
var age50s = $("input:hidden[name='age50s']").val();
var age60s = $("input:hidden[name='age60s']").val();
var age60sMore = $("input:hidden[name='age60sMore']").val();

var ageData ={
		 labels: ['10대', '20대', '30대', '40대', '50대', '60대', '60대+' ],
	
	        
	    datasets: [{
	    	
	    	label : '성별',
	        data: [
	               age10s, age20s,age30s,age40s,age50s,age60s, age60sMore
	        ],	       
	        backgroundColor : '#808080',	             	    
	             	  
	    }]
	};

var barChart = new Chart(ctx2, {
	    type: 'bar',
	    data: ageData,
	    options: {
	    	legend:{
	    		display : false
	    	},
	    
            responsive: true,
            scales :{
            	yAxes:[{
            		ticks :{
            			min : 0,
            			stepSize : 1
            		}
            	}]	
        }
       
        }
	});   


$(document).ready(function(){
    $('.your-class').slick({
    	centerMode:true,
    	
        	edgeFriction : 2,
        	dots: true,
      	  infinite: true,
      	  speed: 500,
  	  fade: true,
  	  prevArrow : '<button type="button" class="slick-prev">Previous</button>'
    });
  
    
  });
	
</script>
</html>