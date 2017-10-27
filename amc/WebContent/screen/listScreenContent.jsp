<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>

        <head>
            <meta charset="EUC-KR">
            
            	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

            <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<!--          <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
            <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

            <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">  -->
            <!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
      <!--       
     <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	 -->
	

            <script type="text/javascript">
                function fncGetScreenContent() { // 수정을 위한 영화 상영 정보 가져오기
                    $("td:nth-child(11)").on("click", function() {
                        var screenContentNo = $("input[name='screenContentNo2']", $(this)).val();

                        console.log(screenContentNo + "screenContentNo2가왜안나온다냐");
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
                                   // $("input[name='previewChecked' ]").attr("checked", true);
									 $("#previewChecked").prop("checked", true);
									 console.log("음");
                                    var previewOpenDate = JSONData.ticketOpenDate;
                                    previewOpenDate = previewOpenDate.substr(0, 10);
                                    previewOpenDate = previewOpenDate.replace(/\//gi, "-");

                                    var previewOpenTime = JSONData.ticketOpenDate;
                                    previewOpenTime = previewOpenTime.substr(11, 15);

                                    $("input[name='previewTitle' ]").val(JSONData.previewTitle);
                                    $("input[name='previewOpenDate' ]").val(previewOpenDate);
                                    $("input[name='previewOpenTime' ]").val(previewOpenTime);
                                    $("input[name='inviteActor' ]").val(JSONData.inviteActor);
                                    
                                    $("input[name='previewTitle' ]").removeAttr("readonly");
                                    $("input[name='previewOpenDate' ]").removeAttr("readonly");
                                    $("input[name='previewOpenTime' ]").removeAttr("readonly");
                                    $("input[name='inviteActor' ]").removeAttr("readonly");
                                    
                                    console.log("8.++++++");

                                    
                                }else{
                                	
                                	   console.log("9.++++++");

                                	   
                                	   
                                	$("input[name='previewTitle' ]").attr("readonly", true);
                                    $("input[name='previewOpenDate' ]").attr("readonly", true);
                                    $("input[name='previewOpenTime' ]").attr("readonly", true);
                                    $("input[name='inviteActor' ]").attr("readonly", true);
                                }

                                $("#addScreenContent").remove();
                                $("#updateScreenContent").remove();

                                var displayValue = "<button type='button' class='btn btn-primary' id='updateScreenContent'>수정</button>"

                                $("#button").html(displayValue);
                                
                                console.log("1.++++++");

                             
                                $("#updateScreenContent").on("click", function() {
                                	 console.log("2.++++++");
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
                    var screenEndTime = $("input:hidden[name='screenEndTime']").val();
                    var screenTheater = $("option:selected").val();
                    var ticketPrice = $("input[name='ticketPrice']").val();
                    var previewChecked = $("input[name='previewChecked']").is(":checked");
                    var previewTitle = $("input[name='previewTitle']").val();
                    var ticketOpenDate = $("input[name='previewOpenDate']").val() + " " + $("input[name='previewOpenTime']").val();
                    var inviteActor = $("input[name='inviteActor']").val();

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

                            $("#previewChecked").prop("checked", false);
                            $("input[type !='hidden']").val(null);
                            $("#screenTheater").val('1');
                            $("input[name='previewTitle' ]").attr("readonly", true);
                            $("input[name='previewOpenDate' ]").attr("readonly", true);
                            $("input[name='previewOpenTime' ]").attr("readonly", true);
                            $("input[name='inviteActor' ]").attr("readonly", true);

                            if (JSONData == -1) {
                                alert("상영시간이 중복되었습니다. 다시 선택해주세요");
                            } else if (JSONData == -2) {
                                alert("이미 이영화에 시사회가 등록되어 있습니다.");
                                
                            } else {
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

                            //  $("input[name='screenContentTable']").remove();
                                                        $("#screenContentTBody").remove();
                                                        

                                                        var result = JSONData;
                                                        var displayValue =  "<tbody id='screenContentTBody'>"
                                                    
                                                        $.each(result, function(idx, val) {
                                                        	var preview = val.previewFlag;
                                                        	displayValue += 
                                                        		"<tr class='text-center'>"+
                                                            	"<td>"+val.screenContentNo+"</td>"+
                                                            	"<td>"+val.screenDate+"</td>"+
                                                            	"<td>"+val.screenTheater+"</td>"+
                                                            	"<td>"+val.screenOpenTime+"</td>"+
                                                            	"<td>"+val.screenEndTime+"</td>"+
                                                            	"<td>"+val.ticketPrice+"</td>"+
                                                            	"<td>"+val.previewFlag+"</td>"+
                                                            	"<td>"
                                                            	if (val.previewTitle != null) {
                                                            		displayValue += val.previewTitle
                                                            	}
                                                            	displayValue += "</td><td>"
                                                            	if (val.previewTitle != null) {
                                                            		displayValue += val.ticketOpenDate
                                                            	}
                                                            	displayValue += "</td> <td>"
                                                            	if (val.previewTitle != null) {
                                                            		displayValue += val.inviteActor
                                                            	}
                                                            	displayValue += "</td> <td> <input type='hidden' name='screenContentNo2' value='"+val.screenContentNo+"'><i class='glyphicon glyphicon-pencil'></i></td>"+
                                                            	"<td><input type='hidden' name='screenContentNo2' value='"+val.screenContentNo+"'><i class='glyphicon glyphicon-trash'></i><td>"
                                                            	"</tr>"
                                                            	
                                                        })
                                                        displayValue +=  "</tbody>"
                               
                                                        $("#screenContentTHead").after(displayValue);
                                                     
                                                        console.log("3.++++++");
                                                      
                                                        $("#previewChecked").prop("checked", false);
                                                        $("input[type !='hidden']").val(null);
                                                        $("#screenTheater").val('1');
                                                        $("input[name='previewTitle' ]").attr("readonly", true);
                                                        $("input[name='previewOpenDate' ]").attr("readonly", true);
                                                        $("input[name='previewOpenTime' ]").attr("readonly", true);
                                                        $("input[name='inviteActor' ]").attr("readonly", true);

                           /*  $("#screenContentTBody").remove();

                            var result = JSONData;
                            var displayValue =
                                "<table class='table table-hover' id='screenContentTable' width='800px'>" +
                                "<thead id='screenContentTHead' >" +
                                "<tr>" +
                                "<th class='text-center' width='4%'>상영번호</th>" +
                                "<th class='text-center' width='8%'>상영일자</th>" +
                                "<th class='text-center' width='8%'>상영관</th>" +
                                "<th class='text-center' width='8%'>상영시작시간</th>" +
                                "<th class='text-center' width='8%'>상영종료시간</th>" +
                                "<th class='text-center' width='8%'>가격</th>" +
                                "<th class='text-center' width='5%'>시사회</th>" +
                                "<th class='text-center' width='13%'>시사회제목</th>" +
                                "<th class='text-center' width='10%'>티켓오픈날짜</th>" +
                                "<th class='text-center' width='18%'>초대배우</th>" +
                                "<th class='text-center' width='5%'>수정</th>" +
                                "<th class='text-center' width='5%'>삭제</th>" +
                                "</tr>" +
                                "</thead>" +
                                "<tbody id='screenContentTBody' width='800px'>"



                            $.each(result, function(idx, val) {
                                var preview = val.previewFlag;
                                displayValue +=
                                    "<tr class='text-center'>" +
                                    "<td>" + val.screenContentNo + "</td>" +
                                    "<td>" + val.screenDate + "</td>" +
                                    "<td>" + val.screenTheater + "</td>" +
                                    "<td>" + val.screenOpenTime + "</td>" +
                                    "<td>" + val.screenEndTime + "</td>" +
                                    "<td>" + val.ticketPrice + "</td>" +
                                    "<td>" + val.previewFlag + "</td>" +
                                    "<td>"
                                if (val.previewTitle != null) {
                                    displayValue += val.previewTitle
                                }
                                displayValue += "</td><td>"
                                if (val.previewTitle != null) {
                                    displayValue += val.ticketOpenDate
                                }
                                displayValue += "</td> <td>"
                                if (val.previewTitle != null) {
                                    displayValue += val.inviteActor
                                }
                                displayValue += "</td> <td> <input type='hidden' name='screenContentNo2' value='" + val.screenContentNo + "'><i class='glyphicon glyphicon-pencil'></i></td>" +
                                    "<td><input type='hidden' name='screenContentNo2' value='" + val.screenContentNo + "'><i class='glyphicon glyphicon-trash'></i><td>"
                                "</tr>"

                            })
                            displayValue +=
                                "<tr>" +
                                "<td></td>" +
                                "<td><input type='date' class='form-control input-sm' name='screenDate' id='screenDate'></td>" +
                                "<td>" +
                                " <select class='form-control input-sm' name='screenTheater' id='screenTheater'>" +
                                "<option value='1'>1상영관</option>" +
                                "<option value='2'>2상영관</option>	" + 
                                "</select>" +
                                "</td>" +
                                "<td><input type='time' class='form-control input-sm' name='screenContentOpenTime'></td>" +
                                "<td><input type='time' class='form-control input-sm' name='screenContentEndTime' readonly='readonly'></td>" +
                                "<td><input type='text' class='form-control input-sm' placeholder='가격' name='ticketPrice'></td>" +
                                "<td><input type='checkbox' class='checkbox '  name='previewChecked' id='previewChecked'></td>" +
                                "<td><input type='text' class='form-control input-sm' placeholder='시사회제목' name='previewTitle' readonly='readonly'></td>" +
                                "<td><input type='date' class='form-control input-sm' name='previewOpenDate' id='previewOpenDate' readonly='readonly'>" +
                                "<input type='time' class='form-control input-sm' name='previewOpenTime' readonly='readonly'></td>" +
                                "<td><input type='text' class='form-control input-sm' placeholder='초대배우' name='inviteActor' readonly='readonly'></td>" +
                                "<td> <div id ='button'><button type='button' class='btn btn-primary' id='addScreenContent'>등록</button></div></td>" +
                                " <td></td>" +
                                "</tr>" +
                                "</tbody>" +
                                "</table>"

                            $("#screenContentTHead").after(displayValue); */

                            $("td:nth-child(11)").on("click", function() {
                            	 console.log("4.++++++");
                                fncGetScreenContent();
                            })

                            $("td:nth-child(12)").on("click", function() {
                                fncDeleteScreenContent();
                            })
                            $("#addScreenContent").remove();
                            $("#updateScreenContent").remove();

                            var displayValue = "<button type='button' class='btn btn-primary' id='addScreenContent'>등록</button>"

                            $("#button").html(displayValue);

                            $("#addScreenContent").on("click", function() {
                                fncAddScreenContent();

                            });
                            
                            $("input[name='screenContentOpenTime']").on("change", function() {
                                addTime();
                            })
                            $("input[name='screenDate").on("change", function() {
                                fncNotEmptyScreenContent();

                            })

                            $("select[name='screenTheater']").on("click", function() {
                                fncNotEmptyScreenContent();
                            })
                            


                        }

                    });
                }



                function fncUpdateScreenContent() { //상영정보 수정 

                    var screenDate = $("input[name='screenDate']").val();
                    var screenOpenTime = $("input[name='screenDate']").val() + " " + $("input[name='screenContentOpenTime']").val();
                    // var screenEndTime = $("input[name='screenDate']").val() + " " + $("input[name='screenContentEndTime']").val();

                    var screenTheater = $("option:selected").val();
                    var ticketPrice = $("input[name='ticketPrice']").val();
                    var previewChecked = $("input[name='previewChecked']").is(":checked");
                    var previewTitle = $("input[name='previewTitle']").val();
                    var ticketOpenDate = $("input[name='previewOpenDate']").val() + " " + $("input[name='previewOpenTime']").val();
                    var inviteActor = $("input[name='inviteActor']").val();
                    var movieNo = $("input[name='movieNo']").val();
                    var screenContentNo = $("input[name='screenContentNo']").val();
                    addTime();
                    var screenEndTime = $("input:hidden[name='screenEndTime']").val();


                    console.log(screenEndTime + "나와라좀");
                    if (previewChecked == true) {
                        var previewFlag = "Y";
                    } else {
                        var previewFlag = "N";
                    }



                    $("input:hidden[name='screenOpenTime']").val(screenOpenTime);
                    // $("input:hidden[name='screenEndTime']").val(screenEndTime);
                    $("input:hidden[name='previewFlag']").val(previewFlag);
                    $("input:hidden[name='ticketOpenDate']").val(ticketOpenDate);

                    console.log(movieNo + "왜안돼");
                    $.ajax({
                        url: "/screen/json/updateScreenContent/" + movieNo,
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

                            $("#previewChecked").prop("checked", false);
                            $("input[type !='hidden']").val(null);
                            $("#screenTheater").val('1');
                            $("input[name='previewTitle' ]").attr("readonly", true);
                            $("input[name='previewOpenDate' ]").attr("readonly", true);
                            $("input[name='previewOpenTime' ]").attr("readonly", true);
                            $("input[name='inviteActor' ]").attr("readonly", true);

                            if (JSONData == -1) {
                                alert("상영시간이 중복되었습니다. 다시 선택해주세요");
                            } else if (JSONData == -2) {
                                alert("이미 이영화에 시사회가 등록되어 있습니다.");
                            } else if(JSONData == -3){
                            	 alert('DB연결에 실패하였습니다.')
                            }else {
                                fncGetScreenContentList();
                            }


                            fncGetScreenContentList();
                        }



                    });

                }

                function fncDeleteScreenContent() { // 상영삭제
                    $("td:nth-child(12)").on("click", function() {

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
                                    console.log(JSONData);


                                    fncGetScreenContentList();
                                },

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
                        data: JSON.stringify({
                            screenDate: screenDate,
                            screenTheater: screenTheater
                        }),
                        success: function(JSONData, status) {


                            var displayValue = "<b>현재 " + screenDate + " " + screenTheater + "상영관에 예약되어있는 시간입니다. <br> </b> "
                            var result = JSONData;
                            $.each(result, function(idx, val) {
                                displayValue += "[" + val.screenOpenTime + " - " + val.screenEndTime + "] "
                            })


                            $("#checkDupTime").val(null);
                            $("#checkDupTime").html(displayValue);

                        }
                    })


                }

                function addTime() { // 영화시작시간을 입력하면 러닝타임+30분을 더하여 입력한다.

                    //  $("input[name='screenContentOpenTime']").on("change", function () {
                    $("input[name='screenContentEndTime']").val(null);
                    var screenOpenTime = $("input[name='screenDate']").val() + " " + $("input[name='screenContentOpenTime']").val();


                    var showTm = parseInt($("input[name='showTm']").val());
                    showTm += 30;

                    $("input:hidden[name='screenOpenTime']").val(screenOpenTime);
                    var date = new Date(Date.parse(screenOpenTime) + showTm * 1000 * 60);

                    var yyyy = date.getFullYear();
                    var mm = date.getMonth() + 1;
                    var dd = date.getDate();
                    var hh = date.getHours();
                    var mi = date.getMinutes();

                    function ten(n) { // 받은 수가 두자리수이하일때
                        return n < 10 ? "0" + n : n;
                    }



                    $("input[name='screenContentEndTime']").val(ten(hh) + ":" + ten(mi));

                    //var test = ten(yyyy)+"/"+ten(mm)+"/"+ten(dd)+" "+ten(hh)+":"+ten(mi);
                    $("input:hidden[name='screenEndTime']").val(ten(yyyy) + "/" + ten(mm) + "/" + ten(dd) + " " + ten(hh) + ":" + ten(mi));
                    var screenEndTime = $("input:hidden[name='screenEndTime']").val();
                    console.log(screenEndTime + "??>>?");
                    //  })

                }

                $(function() {
                    $("#addScreenContent").on("click", function() {
                        fncAddScreenContent();
                    });

                });


                $(function() {
                    fncGetScreenContent();
                    fncDeleteScreenContent();
                    //  fncNotEmptyScreenContent();
                    //addTime();
                    //dateSelect();

                })

                $(function() {
                    $("input[name='screenContentOpenTime']").on("change", function() {
                        addTime();
                    })
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

                    $("input[name='screenDate").on("change", function() {
                        fncNotEmptyScreenContent();

                    })

                    $("select[name='screenTheater']").on("click", function() {
                        fncNotEmptyScreenContent();
                    })
                    $("button[name='contentList']").on("click", function () {
                    	$(self.location).attr("href","/screen/getScreenList");
					})

                })
                
                $(function() {
                var 	openDt = new Date($("input[name='openDt']").val());
                var endDt = new Date($("input[name='endDt']").val());
                var today = new Date();
                var startDt 
               	var screenDate
                console.log("+++"+screenDate)
                
               
                console.log("openDt "+ openDt);
                console.log("today "+ today);
                console.log(openDt > today)
                
                if(openDt > today){
            		startDt = openDt
            	}else{
            		startDt = today
            	}
                
                
                console.log("startDt " + startDt);
                console.log("endDt " + endDt);
    $( "#screenDate" ).datepicker({
    	dateFormat : 'yy-mm-dd',
    	minDate : startDt,
    	maxDate : endDt,
    	
    });
 
     $("input[name='screenDate").on("change", function() {
                	screenDate = new Date( $("input[name='screenDate").val());
                	console.log(screenDate);
                    $( "#previewOpenDate" ).datepicker({
                    	dateFormat : 'yy-mm-dd',
                    	minDate : today,
                    	maxDate : screenDate
                    	
                    });
                })
                

    
    
});
                
                
            </script>

            <style>
                body {
                    padding-top: 70px;
                }
            </style>

        </head>

        <body>

            <jsp:include page="/layout/topToolbar.jsp" />



            <div class="container">
                <div class="page-header">
                    <h2 class=" text-info">영화 상영 관리</h2>
                </div>
      
                <div class="row">

                    <div class="col-xs-1 col-md-2"></div>

                    <div class="col-xs-4 col-md-2">
                        <div> <br> <img src="${movie. postUrl}"> </div>
                    </div>
                    <div class="col-xs-6 col-md-6">
                        <div>
                            <h3 class=" text-info">${movie.movieNm }</h3>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">영화번호 </div>
                            <div class="col-xs-8">${movie.movieNo}</div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">개봉일 </div>
                            <div class="col-xs-8"><input type="hidden" name='openDt' value="${movie.openDt }">${movie.openDt }</div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">상영마감일 </div>
                            <div class="col-xs-8"><input type="hidden" name='endDt' value="${movie.endDt }">${movie.endDt }</div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">감독 </div>
                            <div class="col-xs-8">${movie.directors }</div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">배우 </div>
                            <div class="col-xs-8">${movie.actors }</div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">장르 </div>
                            <div class="col-xs-8">${movie.genres }</div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">러닝타임 </div>
                            <div class="col-xs-8">${movie.showTm }분</div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">관람등급 </div>
                            <div class="col-xs-8">${movie.watchGradeNm }</div>
                        </div>
                    </div>
                    <div class="col-xs-1 col-md-2"></div>
                </div>


                <div>
                    <div id='screenContentAfterTable'></div>
                    <form name='screenContent' id='screenContent' method="post">
                        <table class="table table-hover" id='screenContentTable'>
                            <thead id="screenContentTHead">
                                <tr>
                                    <th class="text-center" width="4%">상영번호</th>
                                    <th class="text-center" width="8%">상영일자</th>
                                    <th class="text-center" width="8%">상영관</th>
                                    <th class="text-center" width="8%">상영시작시간</th>
                                    <th class="text-center" width="8%">상영종료시간</th>
                                    <th class="text-center" width="8%">가격</th>
                                    <th class="text-center" width="5%">시사회</th>
                                    <th class="text-center" width="13%">시사회제목</th>
                                    <th class="text-center" width="10%">티켓오픈날짜</th>
                                    <th class="text-center" width="18%">초대배우</th>
                                    <th class="text-center" width="5%">수정</th>
                                    <th class="text-center" width="5%">삭제</th>
                                </tr>
                            </thead>
                            <tbody id="screenContentTBody">
                                <c:set var="i" value="0" />
                                <c:forEach var="screenContent" items="${list }">
                                    <c:set var="i" value="${i+1 }" />
                                    <tr class="text-center">
                                        <td>${screenContent.screenContentNo }</td>
                                        <td>${screenContent.screenDate }</td>
                                        <td>${screenContent.screenTheater }</td>
                                        <td>${screenContent.screenOpenTime }</td>
                                        <td>${screenContent.screenEndTime }</td>
                                        <td>${screenContent.ticketPrice }</td>
                                        <td>${screenContent.previewFlag }</td>
                                        <td>${screenContent.previewTitle }</td>
                                        <td>${screenContent.ticketOpenDate}</td>
                                        <td>${screenContent.inviteActor}</td>
                                        <td><input type="hidden" name="screenContentNo2" value='${screenContent.screenContentNo }'><i class="glyphicon glyphicon-pencil"></i></td>
                                        <td><input type="hidden" name="screenContentNo2" value='${screenContent.screenContentNo }'><i class="glyphicon glyphicon-trash"></i></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                           <tbody>
                                <tr>
                                    <td colspan="2"><input type="text"  class="form-control input-sm" name='screenDate' id='screenDate' placeholder="상영일자"   readonly="readonly"></td>
                                    <td>
                                        <select class="form-control input-sm" name="screenTheater" id="screenTheater">
       								<option value="1">1상영관</option>						
       								<option value="2">2상영관</option>				
       								</select>
                                    </td>
                                    <td><input type="time" class="form-control input-sm" name='screenContentOpenTime'></td>
                                    <td><input type="time" class="form-control input-sm" name='screenContentEndTime' readonly="readonly"></td>
                                    <td><input type="text" class="form-control input-sm" placeholder="가격" name='ticketPrice'></td>
                                    <td><input type="checkbox" class="checkbox " name='previewChecked' id="previewChecked"></td>
                                    <td><input type="text" class="form-control input-sm" placeholder="시사회제목" name='previewTitle' readonly="readonly"></td>
                                    <td><input type="text" class="form-control input-sm" name='previewOpenDate' id='previewOpenDate' readonly="readonly"><input type="time" class="form-control input-sm" name='previewOpenTime' readonly="readonly"></td>
                                    <td><input type="text" class="form-control input-sm" placeholder="초대배우" name='inviteActor' readonly="readonly"></td>
                                    <td>
                                        <div id="button"><button type="button" class="btn btn-primary" id="addScreenContent">등록</button></div>
                                    </td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                        <input type="hidden" name="screenContentNo">
                        <input type="hidden" name="screenOpenTime">
                        <input type="hidden" name="screenEndTime">
                        <input type="hidden" name="previewFlag">
                        <input type="hidden" name="ticketOpenDate">
                        <input type="hidden" name='movieNo' value='${movie.movieNo }'>
                        <input type="hidden" name='showTm' value='${movie.showTm }'>
                        <div id="checkDupTime" style="background-color:lightgray;"> </div>

                    </form>
                   <p align="middle"><button type="button" class="btn btn-primary" name="contentList">상영목록으로 가기</button> </p>
                    <div></div>
                </div>
            </div>
        </body>

        </html>