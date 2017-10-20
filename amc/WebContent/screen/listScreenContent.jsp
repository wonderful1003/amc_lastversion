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
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



            <script type="text/javascript">
                function fncGetScreenContent() { // 수정을 위한 영화 상영 정보 가져오기
                    $("td:nth-child(1)").on("click", function() {

                        var screenContentNo = $("input[name='screenContentNo2']", $(this)).val();

                        $.ajax({
                            url: "/screen/json/updateScreenContent/" + screenContentNo,
                            method: "GET",
                            dataType: "json",
                            headers: {
                                "Accept": "application/json",
                                "Content-Type": "application/json"
                            },
                            success: function(JSONData, status) {
                                var screenDateTest = JSONData.screenDate;
                                screenDateTest = screenDateTest.replace(/\//gi, "-");

                                $("input[name='screenDate' ]").val(screenDateTest);
                                $("input[name='screenContentOpenTime' ]").val(JSONData.screenOpenTime);
                                $("input[name='screenContentEndTime' ]").val(JSONData.screenEndTime);
                                $("select[name='screenTheater' ]").val(JSONData.screenTheater);
                                $("input[name='ticketPrice' ]").val(JSONData.ticketPrice);
                                $("input[name='previewTitle' ]").val(null);
                                $("input[name='previewOpenDate' ]").val(null);
                                $("input[name='previewOpenTime' ]").val(null);
                                $("input[name='inviteActor' ]").val(null);
                                $("input[name='previewChecked' ]").attr("checked", false);
                                $("input:hidden[name='screenContentNo']").val(JSONData.screenContentNo);



                                if (JSONData.previewFlag == 'Y') {
                                    $("input[name='previewChecked' ]").attr("checked", true);

                                    var previewOpenDate = JSONData.ticketOpenDate;
                                    previewOpenDate = previewOpenDate.substr(0, 10);
                                    previewOpenDate = previewOpenDate.replace(/\//gi, "-");

                                    var previewOpenTime = JSONData.ticketOpenDate;
                                    previewOpenTime = previewOpenTime.substr(11, 15);

                                    $("input[name='previewTitle' ]").val(JSONData.previewTitle);
                                    $("input[name='previewOpenDate' ]").val(previewOpenDate);
                                    $("input[name='previewOpenTime' ]").val(previewOpenTime);
                                    $("input[name='inviteActor' ]").val(JSONData.inviteActor);
                                }

                                $("#addScreenContent").remove();
                                $("#updateScreenContent").remove();

                                var displayValue = "<button type='button' id='updateScreenContent'>수정해용</button>"

                                //$("#test01").after(displayValue);

                                $("input[name='movieNo']").after(displayValue);

                                $("#updateScreenContent").on("click", function() {
                                    fncUpdateScreenContent();
                                })
                            }
                        })

                    })
                }

                function fncAddScreenContent() { // 상영정보 등록하기

                    var movieNo = $("input[name='movieNo']").val();
                    var screenDate = $("input[name='screenDate']").val();
                    var screenOpenTime = $("input[name='screenDate']").val() + " " + $("input[name='screenContentOpenTime']").val();
                 //   var screenEndTime = $("input[name='screenDate']").val() + " " + $("input[name='screenContentEndTime']").val();
            	     var screenEndTime= $("input:hidden[name='screenEndTime']").val();
                    var screenTheater = $("option:selected").val();
                    var ticketPrice = $("input[name='ticketPrice']").val();
                    var previewChecked = $("input[name='previewChecked']").is(":checked");
                    var previewTitle = $("input[name='previewTitle']").val();
                    var ticketOpenDate = $("input[name='previewOpenDate']").val() + " " + $("input[name='previewOpenTime']").val();
                    var inviteActor = $("input[name='inviteActor']").val();
					alert(screenEndTime);
                    if (previewChecked == true) {
                        var previewFlag = "Y";
                 
					        
                    } else {
                        var previewFlag = "N";
                    }

                    $("input:hidden[name='screenOpenTime']").val(screenOpenTime);
                  //  $("input:hidden[name='screenEndTime']").val(screenEndTime);
                    $("input:hidden[name='previewFlag']").val(previewFlag);
                    $("input:hidden[name='ticketOpenDate']").val(ticketOpenDate);


                    $.ajax({
                        url: "/screen/json/addScreenContent/" + movieNo,
                        method: 'POST',

                        headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json"
                        },
                        data: JSON.stringify({
                            screenDate: screenDate,
                            screenOpenTime: screenOpenTime,
                            screenEndTime: screenEndTime,
                            screenTheater: screenTheater,
                            ticketPrice: ticketPrice,
                            previewTitle: previewTitle,
                            ticketOpenDate: ticketOpenDate,
                            inviteActor: inviteActor,
                            previewFlag: previewFlag

                        }),
                        dataType: "text",

                        success: function(JSONData, status) {
                       	 $("#previewChecked").attr("checked", false);
                         $("input[type !='hidden']").val(null);
                            $("#screenTheater").val('1'); 
                            //alert(  $("#previewChecked").is(":checked"));
                           // $("#previewChecked").attr("checked",true);
  				
                            console.log(JSONData);
                            
                            if(JSONData == -1){
                            	alert("상영시간이 중복되었습니다. 다시 선택해주세요");
                            }else{
                            	 fncGetScreenContentList();                
                            }
                           
                        }

                    });

                }

                function fncGetScreenContentList() { // 한영화에 등록되어있는 상영에 대한 정보 리스트를 가져옴
                    var movieNo = $("input[name='movieNo']").val();
                	
                    $.ajax({
                        url: "/screen/json/getScreenContentList/" + movieNo,
                        method: "GET",
                        dataType: "json",
                        headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json"
                        },
                        success: function(JSONData, status) {

                            $("#screenContent").remove();
                            

                            var result = JSONData;
                            var displayValue =
                                "<table border='1' id='screenContent'>		<tr>	<th>상영번호</th>	<th>영화번호</th>	<th>상영등록일자</th>" +
                                "<th>상영일자</th>	 <th>상영관</th><th>상영시작시간</th>	<th>상영종료시간</th>		<th>가격</th>" +
                                "<th>시사회여부</th>				<th>시사회제목</th>					<th>티켓오픈날짜</th>		<th>초대배우</th> <th>삭제하기</th>	" +
                                "	 </tr>";

                            $.each(result, function(idx, val) {
                                console.log(idx + "" + val.screenContentNo);
                                var preview = val.previewFlag;
                                console.log(preview);

                                displayValue += "<tr>	<td> <input type='hidden' name='screenContentNo2' value='" + val.screenContentNo + "'> " + val.screenContentNo + 
                                " 수정하깅</td>		<td>" + movieNo + "</td>	<td>" +
                                    val.screenContentRegDate + "</td>	<td>" + val.screenDate + "</td> <td>" + val.screenTheater + "</td>	<td>" + val.screenOpenTime +
                                    "</td> <td>" + val.screenEndTime + "</td>		<td>" + val.ticketPrice + "</td>		<td>" +
                                    val.previewFlag + "</td>		" + "	<td>"
                                if (val.previewTitle != null) {
                                    displayValue += val.previewTitle
                                }
                                displayValue += "</td>	<td>"
                                if (val.ticketOpenDate != null) {
                                    displayValue += val.ticketOpenDate
                                }
                                displayValue += "</td>		<td>"
                                if (val.ticketOpenDate != null) {
                                    displayValue += val.inviteActor
                                }
                                displayValue += "</td> <td>  <input type='hidden' name='screenContentNo2' value='" + val.screenContentNo + "'> " + val.screenContentNo + " 삭제하기 </td>	</tr>	"
                            })

                            displayValue += "</table>";

                            $("#test").html(displayValue);

                            $("td:nth-child(1)").on("click", function() {
                                fncGetScreenContent();
                            })

                            $("td:nth-child(13)").on("click", function() {
                                fncDeleteScreenContent();
                            })
                            $("#addScreenContent").remove();
                            $("#updateScreenContent").remove();

                            var displayValue = "<button type='button' id='addScreenContent'>등록행</button>"

                            $("input[name='movieNo']").after(displayValue);

                            $("#addScreenContent").on("click", function() {
                                fncAddScreenContent();

                            });


                        }

                    });
                }


                function fncUpdateScreenContent() { //상영정보 수정 

                    var screenDate = $("input[name='screenDate']").val();
                    var screenOpenTime = $("input[name='screenDate']").val() + " " + $("input[name='screenContentOpenTime']").val();
                   // var screenEndTime = $("input[name='screenDate']").val() + " " + $("input[name='screenContentEndTime']").val();
                   var screenEndTime= $("input:hidden[name='screenEndTime']").val();
                    var screenTheater = $("option:selected").val();
                    var ticketPrice = $("input[name='ticketPrice']").val();
                    var previewChecked = $("input[name='previewChecked']").is(":checked");
                    var previewTitle = $("input[name='previewTitle']").val();
                    var ticketOpenDate = $("input[name='previewOpenDate']").val() + " " + $("input[name='previewOpenTime']").val();
                    var inviteActor = $("input[name='inviteActor']").val();

                    var screenContentNo = $("input[name='screenContentNo']").val();




                    if (previewChecked == true) {
                        var previewFlag = "Y";
                    } else {
                        var previewFlag = "N";
                    }


                    $("input:hidden[name='screenOpenTime']").val(screenOpenTime);
                   // $("input:hidden[name='screenEndTime']").val(screenEndTime);
                    $("input:hidden[name='previewFlag']").val(previewFlag);
                    $("input:hidden[name='ticketOpenDate']").val(ticketOpenDate);


                    $.ajax({
                        url: "/screen/json/updateScreenContent/",
                        method: 'POST',

                        headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json"
                        },
                        data: JSON.stringify({
                            screenContentNo: screenContentNo,
                            screenDate: screenDate,
                            screenOpenTime: screenOpenTime,
                            screenEndTime: screenEndTime,
                            screenTheater: screenTheater,
                            ticketPrice: ticketPrice,
                            previewTitle: previewTitle,
                            ticketOpenDate: ticketOpenDate,
                            inviteActor: inviteActor,
                            previewFlag: previewFlag

                        }),
                        dataType: "text",

                        success: function(JSONData, status) {
                        	
                        	 $("input[type !='hidden']").val(null);
                             $("#screenTheater").val('1'); 
                           
                            fncGetScreenContentList();

                            
                            if(JSONData == -1){
                            	alert("상영시간이 중복되었습니다. 다시 선택해주세요");
                            }else{
                            	 fncGetScreenContentList();                
                            }
                            
                        }
                       
                        

                    });

                }

                function fncDeleteScreenContent() { // 상영삭제
                    $("td:nth-child(13)").on("click", function() {

                        var screenContentNo = $("input[name='screenContentNo2']", $(this)).val();



                        if (confirm("정말 상영정보를 지우겠습니까? ") == true) {

                            $.ajax({
                                url: "/screen/json/deleteScreenContent/" + screenContentNo,
                                method: "GET",
                                dataType: "json",
                                headers: {
                                    "Accept": "application/json",
                                    "Content-Type": "application/json"
                                },
                                success: function(JSONData, status) {
                                    fncGetScreenContentList();
                                }
                            })

                        } else {
                            return;
                        }
                    })
                }
                
                function fncNotEmptyScreenContent() { //그시간 그상영관에 등록되어있는 시간가져오기
                	  
                       
                     
                    	    	 var screenDate = $("input[name='screenDate']").val();
                                 var screenTheater = $("option:selected").val();
                    	        $.ajax({
                                    url: "/screen/json/notEmptyScreenContent/",
                                    method: "POST",
                                    dataType: "json",
                                    headers: {
                                        "Accept": "application/json",
                                        "Content-Type": "application/json"
                                    },
                                    data:JSON.stringify({
                                    	screenDate : screenDate,
                                    	screenTheater : screenTheater
                                    }),
                                    success: function(JSONData, status) {
                                    	
                                    	
                                    	var displayValue = "<b>현재 "+screenDate +" "+screenTheater+"상영관에 예약되어있는 시간입니다. <br> </b> "
                                    	var result = JSONData;
                                    	$.each(result, function(idx, val) {
                                    		displayValue += "["+val.screenOpenTime + " - " +val.screenEndTime + "] "
                                    	})
                                    	

                                    	$("#checkDupTime").val(null);
                                    	$("#checkDupTime").html(displayValue);
                                    	
                                    }
                                })

                       
				}

				function addTime() { // 영화시작시간을 입력하면 러닝타임+30분을 더하여 입력한다.
				
					
				
						$("input[name='screenContentOpenTime']").on("change", function () {
							$("input[name='screenContentEndTime']").val(null);
							var screenOpenTime = $("input[name='screenDate']").val() + " " + $("input[name='screenContentOpenTime']").val();
							var showTm = parseInt($("input[name='showTm']").val()) ;
							showTm += 30;
							//alert(showTm);
							$("input:hidden[name='screenOpenTime']").val(screenOpenTime);
							console.log(screenOpenTime);
							var date = new Date(Date.parse(screenOpenTime)+ showTm*1000*60);
							//alert(date);
							
							
							var yyyy = date.getFullYear();
							var mm = date.getMonth()+1;
							var dd = date.getDate();
							var hh = date.getHours();
							var mi = date.getMinutes();
							
							function ten(n) { // 받은 수가 두자리수이하일때
								return n<10? "0" + n : n;
							}
							
							
							console.log(yyyy);
							console.log(mm);
							console.log(dd);
							console.log(hh);
							console.log(mi);
							
						
							$("input[name='screenContentEndTime']").val(ten(hh)+":"+ten(mi));
							
							//var test = ten(yyyy)+"/"+ten(mm)+"/"+ten(dd)+" "+ten(hh)+":"+ten(mi);
							$("input:hidden[name='screenEndTime']").val( ten(yyyy)+"/"+ten(mm)+"/"+ten(dd)+" "+ten(hh)+":"+ten(mi));
				
							
								
								
							
							
						})
						
						
						
				
				
				
				
				}
                $(function() {
                    $("#addScreenContent").on("click", function() {
                        fncAddScreenContent();

                    });
                });

                $(function() {
                    fncGetScreenContent();
                    fncDeleteScreenContent();
                    fncNotEmptyScreenContent();
                    addTime();
                    
                    
                })

                $(function() {

                    $("input[name='previewChecked']").on("click", function() { //시사회 체크하면 뒤에  input 활성화 체크해제시 비활성화
                        var previewChecked = $("input[name='previewChecked']").is(":checked");
                        if (previewChecked == true) {
                            $("input[name='previewTitle' ]").removeAttr("readonly");
                            $("input[name='previewOpenDate' ]").removeAttr("readonly");
                            $("input[name='previewOpenTime' ]").removeAttr("readonly");
                            $("input[name='inviteActor' ]").removeAttr("readonly");
                        } else {
                            $("input[name='previewTitle' ]").val(null);
                            $("input[name='previewOpenDate' ]").val(null);
                            $("input[name='previewOpenTime' ]").val(null);
                            $("input[name='inviteActor' ]").val(null);

                            $("input[name='previewTitle' ]").attr("readonly", true);
                            $("input[name='previewOpenDate' ]").attr("readonly", true);
                            $("input[name='previewOpenTime' ]").attr("readonly", true);
                            $("input[name='inviteActor' ]").attr("readonly", true);
                        }
                    })
                    
                      $("input[name='screenDate").on("change", function () {
                    	  fncNotEmptyScreenContent();
                    	
                      })
                      
                      $("select[name='screenTheater']").on("click", function () {
                    	  fncNotEmptyScreenContent();
                    })	
                    
                     $("input[name='screenContentOpenTime").on("change", function () {
                    	  fncNotEmptyScreenContent();
                    	
                      })


                })
                

                
            </script>

	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
        </head>

        <body>

<jsp:include page="/layout/topToolbar.jsp" />

<div class="container">
<h1>여기는 영화관리 시스템</h1>
<br>
<br>


	<div>
			<div> <h3>${movie.movieNm }</h3></div>
	</div>
	<div>
	<div class="col-xs-3" >
		<div><img src="${movie. postUrl}"></div>
		
	</div>
	
	<div class="col-xs-5">
		<dl class="dl-horizontal"> 
			<dt>영화번호</dt>
			<dd>${movie.movieNo}</dd>
			<dt>개봉일</dt>
			<dd>${movie.openDt }</dd>
			<dt>상영마감일</dt>
			<dd>${movie.endDt }</dd>
			<dt>러닝타임</dt>
			<dd>${movie.showTm }분</dd>
			<dt>관람등급</dt>
			<dd>${movie.watchGradeNm }</dd>
			<dt>장르</dt>
			<dd>${movie.genres }</dd>
			<dt>감독</dt>
			<dd>${movie.directors }</dd>
			<dt>배우</dt>
			<dd>${movie.actors }</dd>
			
		</dl>
	</div>
	</div>
            <br>
             <br>
             <br>
             <br>
             <br>
             <br>
             <br>
           <br>
             <br>
             <br>
             <br>
	
	
            
          
 
           
           

            <form name='screenContent' method="post">
                <div id='test'></div>
                <table border="1" id='screenContent'>
                    <tr>
                        <th>상영번호</th>
                        <th>영화번호</th>
                        <th>상영등록일자</th>
                        <th>상영일자</th>
                        <th>상영관</th>
                        <th>상영시작시간</th>
                        <th>상영종료시간</th>

                        <th>가격</th>
                        <th>시사회여부</th>
                        <th>시사회제목</th>
                        <th>티켓오픈날짜</th>
                        <th>초대배우</th>
                        <th>삭제하기</th>
                    </tr>
                    <c:set var="i" value="0" />
                    <c:forEach var="screenContent" items="${list }">
                        <c:set var="i" value="${i+1 }" />
                        <tr>
                            <td><input type="hidden" name="screenContentNo2" value='${screenContent.screenContentNo }'> ${screenContent.screenContentNo } 수정하깅</td>
                            <td>${screenContent.movie.movieNo }</td>
                            <td>${screenContent.screenContentRegDate }</td>
                            <td>${screenContent.screenDate }</td>
                            <td>${screenContent.screenTheater }</td>
                            <td>${screenContent.screenOpenTime }</td>
                            <td>${screenContent.screenEndTime }</td>

                            <td>${screenContent.ticketPrice }</td>
                            <td>${screenContent.previewFlag }</td>
                            <td>${screenContent.previewTitle }</td>
                            <td>${screenContent.ticketOpenDate}</td>
                            <td>${screenContent.inviteActor}</td>
                            <td><input type="hidden" name="screenContentNo2" value='${screenContent.screenContentNo }'> ${screenContent.screenContentNo } 삭제하기</td>
                        </tr>

                    </c:forEach>


                </table>

                <input type="date" name='screenDate' value='2017-10-18'>
                <select name="screenTheater" id="screenTheater">
						<option value="1">1상영관</option>
						<option value="2">2상영관</option>
				</select>
                <input type="time" name='screenContentOpenTime' value='20:00'>
                <input type="time" name='screenContentEndTime' readonly="readonly">
                <!-- 	<input type="text" placeholder="상영관" name='screenTheater' value='1'> -->

                <input type="text" placeholder="가격" name='ticketPrice' value='10000'>
                <input type="checkbox" value="" name='previewChecked' id="previewChecked">
                <input type="text" placeholder="시사회제목" name='previewTitle' readonly="readonly">
                <input type="date" name='previewOpenDate' readonly="readonly"><input type="time" name='previewOpenTime' readonly="readonly">
                <input type="text" placeholder="초대배우" name='inviteActor' readonly="readonly">

                <input type="hidden" name="screenContentNo">
                <input type="hidden" name="screenOpenTime">
                <input type="hidden" name="screenEndTime">
                <input type="hidden" name="previewFlag">
                <input type="hidden" name="ticketOpenDate">
                <input type="hidden" name='movieNo' value='${movie.movieNo }'>
                <input type="hidden" name='showTm' value='${movie.showTm }'>
			
                <button type="button" id="addScreenContent">등록행</button>
                <div id="checkDupTime" style="background-color:lightgray; margin-top:20px"> </div>
         
            </form>
</div>
        </body>

        </html>