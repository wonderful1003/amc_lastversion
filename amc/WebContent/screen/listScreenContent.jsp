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

	function fncGetScreenContent(){
		$("td:nth-child(1)").on("click", function () {
			
			var screenContentNo = $("input[name='screenContentNo2']", $(this)).val();
		
		
			
			$.ajax({
				url : "/screen/json/updateScreenContent/"+screenContentNo,
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function (JSONData, status) {
					var screenDateTest = JSONData.screenDate;
					screenDateTest = screenDateTest.replace(/\//gi,"-");
					

					
					
					
					$("input[name='screenDate' ]").val(screenDateTest);
					
					$("input[name='screenContentOpenTime' ]").val(JSONData.screenOpenTime);
					
					$("input[name='screenContentEndTime' ]").val(JSONData.screenEndTime);
					
					$("input[name='screenTheater' ]").val(JSONData.screenTheater);
					
					$("input[name='ticketPrice' ]").val(JSONData.ticketPrice);
					$("input[name='previewTitle' ]").val(null);
					$("input[name='previewOpenDate' ]").val(null);
					$("input[name='previewOpenTime' ]").val(null);
					$("input[name='inviteActor' ]").val(null);
					
					if(JSONData.previewFlag == 'Y'){
						$("input[name='previewChecked' ]").is(":checked") == true;
						var previewOpenDate = JSONData.ticketOpenDate;
						previewOpenDate = previewOpenDate.substr(0,10);
						
						previewOpenDate = previewOpenDate.replace(/\//gi,"-");
						
						var previewOpenTime = JSONData.ticketOpenDate;
						previewOpenTime = previewOpenTime.substr(11,15);
					
						
						$("input[name='previewTitle' ]").val(JSONData.previewTitle);
						$("input[name='previewOpenDate' ]").val(previewOpenDate);
						$("input[name='previewOpenTime' ]").val(previewOpenTime);
						$("input[name='inviteActor' ]").val(JSONData.inviteActor);
						
					}
					

					
				}
			})
			
		})
	}

	function fncAddScreenContent() {
		
		var movieNo = $("input[name='movieNo']").val();
		var screenDate = $("input[name='screenDate']").val();
		var screenOpenTime = $("input[name='screenDate']").val()+" "+$("input[name='screenContentOpenTime']").val();
		var screenEndTime = $("input[name='screenDate']").val()+" "+$("input[name='screenContentEndTime']").val();
		var screenTheater =$("option:selected").val();
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

		$.ajax(
				{url: "/screen/json/addScreenContent/"+movieNo,
					method : 'POST',
					
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify(	{
						screenDate : screenDate,
						screenOpenTime : screenOpenTime,
						screenEndTime : screenEndTime,
						screenTheater : screenTheater,
						ticketPrice : ticketPrice,
						previewTitle : previewTitle,
						ticketOpenDate : ticketOpenDate,
						inviteActor : inviteActor,
						previewFlag : previewFlag
						
					})	, 
					dataType : "text",
					
					success: function (JSONData, status) {
						console.log("jjj   "+status);
					
						//getPage("/screen/getScreenContentList/"+movieNo);
						
						$("input[type !='hidden']").val(null);
						
					}
					
				}		
			);
		
	//	$("form").attr("method", "POST").attr("action", "/screen/json/addScreenContent/"+movieNo).submit();
	fncGetScreenContentList ();

	}
	
	function fncGetScreenContentList () {
		var movieNo = $("input[name='movieNo']").val();
		console.log("어ㅐ안애");
		$.ajax({
			url : "/screen/json/getScreenContentList/"+movieNo,
			method : "GET",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function (JSONData, status) {
		
				$("#screenContent").remove();
				
				var result = JSONData;
		
				var displayValue = 	
					"<table border='1' id='screenContent'>		<tr>	<th>상영번호</th>	<th>영화번호</th>	<th>상영등록일자</th>"+
						"<th>상영일자</th>	<th>상영시작시간</th>	<th>상영종료시간</th>	<th>상영관</th>	<th>가격</th>"+
						"<th>시사회여부</th>				<th>시사회제목</th>					<th>티켓오픈날짜</th>					<th>초대배우</th>	"+
					"	 </tr>";
			
				$.each(result, function (idx, val) {
					console.log(idx+""+ val.screenContentNo);
					var preview = val.previewFlag;
					console.log(preview);
					
						 displayValue +=  "<tr>	<td> <input type='hidden' name='screenContentNo2' value='"+val.screenContentNo+"'> "+	val.screenContentNo+ "수정하깅</td>		<td>"+ movieNo+"</td>	<td>"+
							val.screenContentRegDate+"</td>	<td>"+val.screenDate +"</td>	<td>"+			val.screenOpenTime +
							"</td> <td>"+val.screenEndTime +"</td>	<td>"+	val.screenTheater+"</td>	<td>"+val.ticketPrice +"</td>		<td>"+
							val.previewFlag +"</td>		" + "	<td>"
							if(val.previewTitle != null ){
										displayValue +=  val.previewTitle  
										}
							displayValue += "</td>	<td>"
								if(val.ticketOpenDate != null ){
									displayValue += val.ticketOpenDate
									}
							displayValue += "</td>		<td>"
							
								if(val.ticketOpenDate != null ){
									displayValue += val.inviteActor
									}
							
							displayValue +=  "</td>	</tr>	"
					
				})
				console.log(displayValue);
				displayValue += "</table>";
				console.log(displayValue);
					$("#test").html(displayValue);
					alert("ddd");
										
			}

		});
	}
	function fncGetUpdate () {
		
	
	}
	
	function fncPostUpdate() {
		
	}
	
	
	$(function () {
		$("#add").on("click", function () {
			fncAddScreenContent();
			
		});
	});
	
	$(function () {
		fncGetScreenContent();
	})
</script>


</head>
	
<body>



	       여기는 영화관리 시스템

<form name='screenContent' method="post">
<div id='test'></div>
<table border="1" id='screenContent'>
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
			<td><input type="hidden" name="screenContentNo2" value='${screenContent.screenContentNo }'> ${screenContent.screenContentNo }  	수정하깅</td>
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

		<input type="date" name='screenDate' value='2017-10-18'>
		<input type="time" name='screenContentOpenTime' value='20:00'>
		<input type="time" name ='screenContentEndTime' value='22:00'>
	<!-- 	<input type="text" placeholder="상영관" name='screenTheater' value='1'> -->
		<select name="screenTheater" >
			<option value="1">1상영관</option>
			<option value="2">2상영관</option>
		</select>
		<input type="text" placeholder="가격"  name='ticketPrice' value='10000'>
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