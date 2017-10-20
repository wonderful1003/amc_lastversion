<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>

        <head>
            <meta charset="EUC-KR">

            <!-- ���� : http://getbootstrap.com/css/   ���� -->
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
            <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


            <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



            <script type="text/javascript">
                function fncGetScreenContent() { // ������ ���� ��ȭ �� ���� ��������
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

                                var displayValue = "<button type='button' id='updateScreenContent'>�����ؿ�</button>"

                                //$("#test01").after(displayValue);

                                $("input[name='movieNo']").after(displayValue);

                                $("#updateScreenContent").on("click", function() {
                                    fncUpdateScreenContent();
                                })
                            }
                        })

                    })
                }

                function fncAddScreenContent() { // ������ ����ϱ�

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
                            	alert("�󿵽ð��� �ߺ��Ǿ����ϴ�. �ٽ� �������ּ���");
                            }else{
                            	 fncGetScreenContentList();                
                            }
                           
                        }

                    });

                }

                function fncGetScreenContentList() { // �ѿ�ȭ�� ��ϵǾ��ִ� �󿵿� ���� ���� ����Ʈ�� ������
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
                                "<table border='1' id='screenContent'>		<tr>	<th>�󿵹�ȣ</th>	<th>��ȭ��ȣ</th>	<th>�󿵵������</th>" +
                                "<th>������</th>	 <th>�󿵰�</th><th>�󿵽��۽ð�</th>	<th>������ð�</th>		<th>����</th>" +
                                "<th>�û�ȸ����</th>				<th>�û�ȸ����</th>					<th>Ƽ�Ͽ��³�¥</th>		<th>�ʴ���</th> <th>�����ϱ�</th>	" +
                                "	 </tr>";

                            $.each(result, function(idx, val) {
                                console.log(idx + "" + val.screenContentNo);
                                var preview = val.previewFlag;
                                console.log(preview);

                                displayValue += "<tr>	<td> <input type='hidden' name='screenContentNo2' value='" + val.screenContentNo + "'> " + val.screenContentNo + 
                                " �����ϱ�</td>		<td>" + movieNo + "</td>	<td>" +
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
                                displayValue += "</td> <td>  <input type='hidden' name='screenContentNo2' value='" + val.screenContentNo + "'> " + val.screenContentNo + " �����ϱ� </td>	</tr>	"
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

                            var displayValue = "<button type='button' id='addScreenContent'>�����</button>"

                            $("input[name='movieNo']").after(displayValue);

                            $("#addScreenContent").on("click", function() {
                                fncAddScreenContent();

                            });


                        }

                    });
                }


                function fncUpdateScreenContent() { //������ ���� 

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
                            	alert("�󿵽ð��� �ߺ��Ǿ����ϴ�. �ٽ� �������ּ���");
                            }else{
                            	 fncGetScreenContentList();                
                            }
                            
                        }
                       
                        

                    });

                }

                function fncDeleteScreenContent() { // �󿵻���
                    $("td:nth-child(13)").on("click", function() {

                        var screenContentNo = $("input[name='screenContentNo2']", $(this)).val();



                        if (confirm("���� �������� ����ڽ��ϱ�? ") == true) {

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
                
                function fncNotEmptyScreenContent() { //�׽ð� �׻󿵰��� ��ϵǾ��ִ� �ð���������
                	  
                       
                     
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
                                    	
                                    	
                                    	var displayValue = "<b>���� "+screenDate +" "+screenTheater+"�󿵰��� ����Ǿ��ִ� �ð��Դϴ�. <br> </b> "
                                    	var result = JSONData;
                                    	$.each(result, function(idx, val) {
                                    		displayValue += "["+val.screenOpenTime + " - " +val.screenEndTime + "] "
                                    	})
                                    	

                                    	$("#checkDupTime").val(null);
                                    	$("#checkDupTime").html(displayValue);
                                    	
                                    }
                                })

                       
				}

				function addTime() { // ��ȭ���۽ð��� �Է��ϸ� ����Ÿ��+30���� ���Ͽ� �Է��Ѵ�.
				
					
				
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
							
							function ten(n) { // ���� ���� ���ڸ��������϶�
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

                    $("input[name='previewChecked']").on("click", function() { //�û�ȸ üũ�ϸ� �ڿ�  input Ȱ��ȭ üũ������ ��Ȱ��ȭ
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
<h1>����� ��ȭ���� �ý���</h1>
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
			<dt>��ȭ��ȣ</dt>
			<dd>${movie.movieNo}</dd>
			<dt>������</dt>
			<dd>${movie.openDt }</dd>
			<dt>�󿵸�����</dt>
			<dd>${movie.endDt }</dd>
			<dt>����Ÿ��</dt>
			<dd>${movie.showTm }��</dd>
			<dt>�������</dt>
			<dd>${movie.watchGradeNm }</dd>
			<dt>�帣</dt>
			<dd>${movie.genres }</dd>
			<dt>����</dt>
			<dd>${movie.directors }</dd>
			<dt>���</dt>
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
                        <th>�󿵹�ȣ</th>
                        <th>��ȭ��ȣ</th>
                        <th>�󿵵������</th>
                        <th>������</th>
                        <th>�󿵰�</th>
                        <th>�󿵽��۽ð�</th>
                        <th>������ð�</th>

                        <th>����</th>
                        <th>�û�ȸ����</th>
                        <th>�û�ȸ����</th>
                        <th>Ƽ�Ͽ��³�¥</th>
                        <th>�ʴ���</th>
                        <th>�����ϱ�</th>
                    </tr>
                    <c:set var="i" value="0" />
                    <c:forEach var="screenContent" items="${list }">
                        <c:set var="i" value="${i+1 }" />
                        <tr>
                            <td><input type="hidden" name="screenContentNo2" value='${screenContent.screenContentNo }'> ${screenContent.screenContentNo } �����ϱ�</td>
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
                            <td><input type="hidden" name="screenContentNo2" value='${screenContent.screenContentNo }'> ${screenContent.screenContentNo } �����ϱ�</td>
                        </tr>

                    </c:forEach>


                </table>

                <input type="date" name='screenDate' value='2017-10-18'>
                <select name="screenTheater" id="screenTheater">
						<option value="1">1�󿵰�</option>
						<option value="2">2�󿵰�</option>
				</select>
                <input type="time" name='screenContentOpenTime' value='20:00'>
                <input type="time" name='screenContentEndTime' readonly="readonly">
                <!-- 	<input type="text" placeholder="�󿵰�" name='screenTheater' value='1'> -->

                <input type="text" placeholder="����" name='ticketPrice' value='10000'>
                <input type="checkbox" value="" name='previewChecked' id="previewChecked">
                <input type="text" placeholder="�û�ȸ����" name='previewTitle' readonly="readonly">
                <input type="date" name='previewOpenDate' readonly="readonly"><input type="time" name='previewOpenTime' readonly="readonly">
                <input type="text" placeholder="�ʴ���" name='inviteActor' readonly="readonly">

                <input type="hidden" name="screenContentNo">
                <input type="hidden" name="screenOpenTime">
                <input type="hidden" name="screenEndTime">
                <input type="hidden" name="previewFlag">
                <input type="hidden" name="ticketOpenDate">
                <input type="hidden" name='movieNo' value='${movie.movieNo }'>
                <input type="hidden" name='showTm' value='${movie.showTm }'>
			
                <button type="button" id="addScreenContent">�����</button>
                <div id="checkDupTime" style="background-color:lightgray; margin-top:20px"> </div>
         
            </form>
</div>
        </body>

        </html>