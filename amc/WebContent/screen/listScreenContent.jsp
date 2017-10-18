<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	
	
<script type="text/javascript">

	function fncAddScreenContent() {
		
		var movieNo = $("input[name='movieNo']").val();
		var screenDate = $("input[name='screenDate']").val();
		var screenOpenTime = $("input[name='screenDate']").val()+" "+$("input[name='screenContentOpenTime']").val();
		var screenEndTime = $("input[name='screenDate']").val()+" "+$("input[name='screenContentEndTime']").val();
		var screenTheater =$("input[name='screenTheater']").val();
		var ticketPrice = $("input[name='ticketPrice']").val();
		var previewChecked = $("input[name='previewChecked']").is(":checked"); 
		var previewTitle = $("input[name='previewTitle']").val();
		var ticketOpenDate =  $("input[name='previewOpenDate']").val()+" "+$("input[name='previewOpenTime']").val();
		var inviteActor = $("input[name='inviteActor']").val();
	
	 
		
		if(previewChecked == true){
			var previewFlag = "Y";
		}else{
			var previewFlag="N";
		}
		
		$("input:hidden[name='screenOpenTime']").val(screenOpenTime);
		$("input:hidden[name='screenEndTime']").val(screenEndTime);
		$("input:hidden[name='previewFlag']").val(previewFlag);
		$("input:hidden[name='ticketOpenDate']").val(ticketOpenDate);
		
		
		
		$("form").attr("method", "POST").attr("action", "/screen/json/addScreenContent/"+movieNo).submit();

	}
	
	$(function () {
		$("#add").on("click", function () {
			
			$.ajax(
				{
					type:'post',
					url: "/screen/json/addScreenContent/"+movieNo,
					headers : {
						"Accept" : "application/json"
						"Content-Type" : "application/json"
					},
					data : {
						JSON.stringify(
								{screenDate : screenDate},
								{screenOpenTime : screenOpenTime},
								{screenEndTime : screenEndTime},
								{screenTheater : screenTheater},
								{ticketPrice : ticketPrice},
								{previewChecked : previewChecked},
								{previewTitle : previewTitle},
								{ticketOpenDate : ticketOpenDate},
								{inviteActor : inviteActor},
								{previewFlag : previewFlag}
						)
					},
					
				}		
			);
			fncAddScreenContent();
		});
	});
</script>


</head>
	
<body>



	       여기는 영화관리 시스템

<form>

<table border="1">
	<tr>
		<th>상영번호</th>
		<th>영화번호</th>
		<th>상영등록일자</th>
		<th>상영일자</th>
		<th>상영시작시간</th>
		<th>상영종료시간</th>
		<th>상영관</th>
		<th>가격</th>
		<th>시사회여부</th>
		<th>시사회제목</th>
		<th>티켓오픈날짜</th>
		<th>초대배우</th>
	</tr>
	<c:set var="i" value="0"/>
	<c:forEach var ="screenContent" items="${list }">
		<c:set var="i" value="${i+1 }"/>
		<tr>
			<td>${screenContent.screenContentNo }  	<a href='/screen/json/updateScreenContent/${screenContent.movie.movieNo }'> 수정하깅</a></td>
			<td>${screenContent.movie.movieNo }</td>
			<td>${screenContent.screenContentRegDate }</td>
			<td>${screenContent.screenDate }</td>
			<td>${screenContent.screenOpenTime }</td>
			<td>${screenContent.screenEndTime }</td>
			<td>${screenContent.screenTheater }</td>
			<td>${screenContent.ticketPrice }</td>
			<td>${screenContent.previewFlag }</td>
			<td>${screenContent.previewTitle }</td>
			<td>${screenContent.ticketOpenDate}</td>
			<td>${screenContent.inviteActor}</td>
		</tr>

	</c:forEach>

	
</table>

	<input type="date" name='screenDate'>
		<input type="time" name='screenContentOpenTime'>
		<input type="time" name ='screenContentEndTime'>
		<input type="text" placeholder="상영관" name='screenTheater'>
		<input type="text" placeholder="가격"  name='ticketPrice'>
		<input type="checkbox" value="" name='previewChecked' >
		<input type="text" placeholder="시사회제목" name='previewTitle'>
		<input type="date"  name='previewOpenDate'><input type="time"  name='previewOpenTime'>
		<input type="text" placeholder="초대배우" name='inviteActor'>
	
		<input type="hidden" name="screenOpenTime">
		<input type="hidden" name="screenEndTime">
		<input type="hidden" name="previewFlag">
		<input type="hidden" name="ticketOpenDate">
		<input type="hidden" name='movieNo' value='10000'>
	
<button type="button" id="add">등록행</button>
</form>

</body>
</html>