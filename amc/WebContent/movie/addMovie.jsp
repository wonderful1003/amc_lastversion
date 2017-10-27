<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.amc.service.domain.User"%>

<%@page import="java.util.Arrays"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%> 
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

   
<html lang="UTF-8">
	

<head>
   <meta charset="UTF-8">
   
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">  
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/sunny/jquery-ui.css">
    <link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-/1.7.1/css/bootstrap-datepicker.css" />
    
     
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.14.1/css/ui.jqgrid.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.14.1/jquery.jqgrid.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.js"></script>
  
 
 
<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       <!-- 절대경로로 변경  -->
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
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!-- 영화 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span>영화</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">현재 상영영화</a></li>
	                         <li><a href="#">상영 예정영화</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">시사회</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- 예매 DrowDown  -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span>예매</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">영화 예매</a></li>
		                         <li><a href="#">시사회 예매</a></li>
		                     </ul>
		                </li>
		                
	              <!-- 영화관  -->
					  <li><a href="#">영화관</a></li>
				
				  <!-- 커뮤니티  -->  
					  <li><a href="#">커뮤니티</a></li>
		                
	              <!-- 스토어 DrowDown  -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span>스토어</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">굿즈</a></li>
		                         <li><a href="#">스낵바</a></li>
		                     </ul>
		                </li>
	                 
	             <!-- 관리자메뉴 DrowDown  -->
	             
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >[관리자 메뉴]</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">회원관리</a></li>
		                         <li><a href="#">상품관리</a></li>
		                         <li><a href="#">판매관리</a></li>
		                         <li><a href="#">영화관리</a></li>
		                         <li><a href="#">상영관리</a></li>
		                         <li><a href="#">예매관리</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	             </ul>
	             
	             
	             
	             <ul class="nav navbar-nav navbar-right">
	             <!-- 유저가 로그인 상태일 시 -->
	             	<c:if test="${sessionScope.user ne null }">
		             	<li title="Click : 개인정보 수정"><a href="#">ID : [${sessionScope.user.userId }]</a></li>
		             	<li><a href="#">로그아웃</a></li>
		             	<li><a href="#">마이페이지</a></li>
	             	</c:if>
	             	
	             <!-- 유저가 비로그인 상태일 시 -->	
	             	<c:if test="${sessionScope.user eq null }">
		             	<li>
		             		<input type="text" name="userId" placeholder="아이디" width="300px">
		             		<input type="text" name="password" placeholder="비밀번호" width="300px">
		             	</li>
		             	<input type="button" value="로그인">
	             	</c:if>
	            </ul>
	           	 <!-- 유저가 비로그인 상태일 시 -->	
             	<c:if test="${sessionScope.user eq null }">
	             	<li>
	             		<input type="text" name="userId" placeholder="아이디" width="300px">
	             		<input type="text" name="password" placeholder="비밀번호" width="300px">
	             	</li>
	             	<input type="button" value="로그인">
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
						<li><a href="#">로그아웃</a></li>
					</ul>
				</c:if>     
		
		</div>
		<!-- dropdown hover END -->	       
	</div>
</div>
 
 </head>
 
   
 
 

   
 <script type="text/javascript">
 
	//============= START TOPTOOL BAR ==========================

	function openHistory(){
		popWin = window.open("../openHistory.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	}

		
	//=============  현재 상영영화 Event  처리 =============	
	$( "a:contains('현재 상영영화'),a:contains('ID')" ).on("click" , function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(self.location).attr("href","/movie/getMovieList?menu=movie");
	});
	
	
	//=============  상영 예정영화 Event  처리 =============	
	$( "a:contains('상영 예정영화')" ).on("click" , function() {
		$(self.location).attr("href","/movie/getMovieList?menu=commingsoon");
	});
	
	//=============  시사회 Event  처리 =============	
	$( "a:contains('시사회')" ).on("click" , function() {
		$(self.location).attr("href","/movie/getMovieList?menu=preview");
	});
	
	//=============  예매 Event  처리 =============	
	$( "a:contains('예매')" ).on("click" , function() {
		$(self.location).attr("href","/booking/getScreenMovieList");
	});
	
	//=============  영화 예매 Event  처리 =============	
	$( "a:contains('영화 예매')" ).on("click" , function() {
		$(self.location).attr("href","/booking/getScreenMovieList");
	});
	
	//=============  시사회 예매 Event  처리 =============	
	$( "a:contains('시사회 예매')" ).on("click" , function() {
		$(self.location).attr("href","/booking/getScreenPreviewList");
	});
	
	//=============  영화관 Event  처리 =============	
	$( "a:contains('영화관')" ).on("click" , function() {
		$(self.location).attr("href","/cinema/theaterInfo");
	});
	
	//=============  커뮤니티 Event 처리 =============	
	$( "a:contains('커뮤니티')" ).on("click" , function() {
		$(self.location).attr("href","/community/getFreeBoardList");
	});
	
	//============= 스토어 Event 처리 =============	
	$( "a:contains('스토어')" ).on("click" , function() {
		$(self.location).attr("href","/product/getGoodsList");
	});
	
	//=============  굿즈 Event 처리 =============	
	$( "a:contains('굿즈')" ).on("click" , function() {
		$(self.location).attr("href","/product/getGoodsList");
	});
	
	//=============  스낵바 Event 처리 =============	
	$( "a:contains('스낵바')" ).on("click" , function() {
		$(self.location).attr("href","/product/getSnackList");
	});
	
	//=============  회원관리 Event  처리 =============	
	$( "a:contains('회원관리')" ).on("click" , function() {
		$(self.location).attr("href","/user/getUserList");
	});
	
	//=============  상품관리 Event  처리 =============	
	$( "a:contains('상품관리')" ).on("click" , function() {
		$(self.location).attr("href","/product/getGoodsList");
	});
	
	//=============  판매관리 Event  처리 =============	
	$( "a:contains('판매관리')" ).on("click" , function() {
		$(self.location).attr("href","/purchase/getSaleList");
	});
	
	//=============  영화관리 Event  처리 =============	
	$( "a:contains('영화관리')" ).on("click" , function() {
		$(self.location).attr("href","/movie/getMovieList?menu=manage");
	});
	
	//=============  상영관리 Event  처리 =============	
	$( "a:contains('상영관리')" ).on("click" , function() {
		$(self.location).attr("href","/screen/getScreenList");
	});
	
	//=============  예매관리 Event  처리 =============	
	$( "a:contains('예매관리')" ).on("click" , function() {ss
		$(self.location).attr("href","/booking/getAdminBookingList");
	});
	
	
	//============= login Event  처리 =============	
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	 	$("input:contains('로그인')").on("click" , function() {
			$(self.location).attr("href","/user/loginUser");
		}); 
	 });
	
	//============= logout Event  처리 =============	
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	 	$("a:contains('로그아웃')").on("click" , function() {
			$(self.location).attr("href","/user/logoutUser");
		}); 
	 });
	
	//=============  최근 본 상품  처리 =============	
	 	$( "a:contains('최근 본 상품')" ).on("click" , function() {
	 		openHistory();
		});
	
 
    //============= END OF TOPTOOL BAR ==========================
 
 
 
        $(document).ready(function(){
         	
        	
        	function delButton (cellvalue, options, rowObject) {
        		   return '<input type="button" onclick="delete('+cellvalue+')" value="DEL"/>'; 
        	 };
        	 
        	 
        	function UploadImage(response, postdata) {
        		

        		    var data = $.parseJSON(response.responseText);

        		    console.log("UploadImage called");
        		    if (data.success == true) {
        		        if ($("#file").val() != "") {
        		            ajaxFileUpload(data.id);
        		        }
        		    }  

        		    return [data.success, data.message, data.id];

        	}
        	
        	
        	function Result_From_Server(resp, postdata)
			{
        		
        		alert("Update is succefully");
				// you should return from server OK in sucess, any other message on error
				if(resp.responseText == "OK")
				{
					console.log("test");
				alert("Update is succefully")
				return [true,"",""]
				}
				else {
					console.log("test2");
				alert("Update failed")
				return [true,"",""]
				}
			}
        	
        	
		/*     $("#export").on("click", function(){
					alert("called ");
				$("#movie_list").jqGrid("exportToExcel",{
					includeLabels : true,
					includeGroupHeader : true,
					includeFooter: true,
					fileName : "jqGridExport.xlsx",
					maxlength : 2000 // maxlength for visible string data 
				})
			});
 */
   
        	function ajaxFileUpload(id) 	{
        	
        	 console.log("ajaxFileUpload called");
        	
        		    $("#loading")
        		    .ajaxStart(function () {
        		        $(this).show();
        		    })
        		    .ajaxComplete(function () {
        		        $(this).hide();
        		    });

        		    $.ajaxFileUpload
        		    (
        		        {
        		            url: '@Url.Action("UploadImage")',
        		            secureuri: false,
        		            fileElementId: 'file',
        		            dataType: 'json',
        		            data: { id: id },
        		            success: function (data, status) {

        		                if (typeof (data.success) != 'undefined') {
        		                    if (data.success == true) {
        		                        return;
        		                    } else {
        		                        alert(data.message);
        		                    }
        		                }
        		                else {
        		                    return alert('Failed to upload logo!');
        		                }
        		            },
        		            error: function (data, status, e) {
        		                return alert('Failed to upload logo!');
        		            }
        		        }
        		    )          }     
        	 
        	
        	function setClickRowColor(gridNm, rowId){
	    	    var ids = $('#'+gridNm).getDataIDs();

        	    $.each(ids, function(idx){
        	        idx+=1;
        	        if(idx==rowId){
        	            $('#'+gridNm).setRowData(idx, false, {background:'#DDFFFF'});
        	        }else{
        	            $('#'+gridNm).setRowData(idx, false, {background:'#FFFFFF'});
        	        }
        	    });
        	}
       	 
        	function formatImage(cellValue, options, rowObject) {
                 //var imageHtml = "<img src='images/" + cellValue + "' originalValue='" + cellValue + "' />";
                 
                 var imageHtml = "<img src='images/149747_P25_095225.jpg' originalValue='149747_P25_095225.jpg' />";
                 
                 return imageHtml;
            }

        
        	function pickdates(id){
        		jQuery("#"+id+"_movieEndDate","#movie_list").datepicker({dateFormat:"yy-mm-dd"});
        	}
   	
        	var getVaueByName = function (directors, colName) {
                var i, count = directors.length, item;
                
                console.log("directors.length", directors.length);
                
                for (i = 0; i < count; i += 1) {
                    item = directors[i];
                    
                	//console.log("item" + item.peopleNm);
                    
                    
                    if (item.colname === colName) {
                    	
                    	console.log("item" + item.peopleNm);
                        return item.peopleNm;
                    }
                    
                    return item.peopleNm; 
                }
                return '';
            };
        
            
        
        
         $("#movie_list").jqGrid( 
        		{         			
        
            	// ajax 요청주소
                url:"/movie/json/getAPIMoiveList",
                caption : "영화 API 등록",
                // 요청방식
                mtype:"post",
                // 결과물 받을 데이터 타입
                datatype:"json",   
          
                // 그리드 높이
                height:"auto",
               
                // 컬럼명
                colNames:['영화CD','영화명','제작국가','상영마감','줄거리','트레일러'],
                // 컬럼 데이터(추가, 삭제, 수정이 가능하게 하려면 autoincrement컬럼을 제외한 모든 컬럼을 editable:true로 지정)
                // edittyped은 text, password, ... input type명을 사용
                     
                colModel:[
                          {name:'movieCd', key: true,index:'movieCd',align:"left",sorttype:"int",width:90, sortable:true,editable:true},
                          {name:'movieNm', index:'movieNm', align:"left",width:90, sortable:true, editable:true},                       
   	                      {name:'nationAlt', index:'nationAlt',align:"left", width:90,sortable:true, editable:true},              
                          {name:'movieEndDate', index:'movieEndDate',align:"left",                         	    
                        	      editable:true, editoptions:{size:10, 
                                  dataInit:function(el){ 
                                        $(el).datepicker({dateFormat:'yy-mm-dd'}); 
                                  }, 
                                  defaultValue: function(){ 
                                    var currentTime = new Date(2017,10,1); 
                                    var month = parseInt(currentTime.getMonth() + 1); 
                                    month = month <= 9 ? "0"+month : month; 
                                    var day = currentTime.getDate(); 
                                    day = day <= 9 ? "0"+day : day; 
                                    var year = currentTime.getFullYear(); 
                                    return year+"-"+month + "-"+day; 
                                  } 
                                }                	     
                          },
                    
                          {name:'synopsis', index:'synopsis',align:"left", width:90,sortable:true, editable:true, 
                        	     edittype: "textarea",editoptions: { rows: 3, wrap: "off",style: 'overflow-x: hidden',}},                     
                          {name:'trailer', index:'trailer',align:"left", width:90,editable:true}
                          ],
                          
         
           // 네비게이션 도구를 보여줄 div요소
                hidegrid : true,                        // grid 전체를 접는 오른쪽 상단 아이콘 disable
            	beforeSelectRow : function(invid) {                // 선택한 로우 색상 변경
                  setClickRowColor('movie_list', invid);
                    return true;
               }, 
 
 

               	sortable: true,
                sortname: 'movieCd',
                pager:"#pager777",
            	rowNum:10,
               	//rowList:[10,20,30],             
                autowidth:true,
                // 전체 레코드수, 현재레코드 등을 보여줄지 유무
                multiselect: true,
                viewrecords:true,
                
                // 추가, 수정, 삭제 url
                editurl: "/movie/json/addMovie",    
    
                mtype:"post",
                // 결과물 받을 데이터 타입
                datatype:"json",
                enctype: "multipart/form-data",
                
          
                //sortable: true 
                sortorder: "desc",
                loadonce : true,
                
                //afterSubmit: Result_From_Server,         
               
                
                jSonReader : {
                	root:"rows",
                	page:"page",
                	total:"total",
                	records:"records",
                	repeatitems:false,
                	cell:"cell",
                	id:"movieCd"
                },
                
                afterSubmit : function(response, postdata) {
                	alert("aaa");
                    return [false, response.responseText, ""];
                    // Tried with return [true, response.responseText, ""]; and few more
                 } ,
                 
                 beforeSubmit : function( postdata, formid ) {
                	 
                	 alert("aaa");
                     if(someconditionOK) {
                         return [true,''];
                     } else {
                         return [false,'Error submiting data'];
                     }
                 },
        
           		loadComplete: function(data) {
          			alert ("records="+$("#movie_list").getGridParam("records"));
                },  
                
                
    	       
        	});
         
        
       
/* jQuery("#movie_list").jqGrid('navGrid','#pager777',
     		 {}, //options
     		 {height:280,reloadAfterSubmit:false}, // edit options
     		 {height:280,reloadAfterSubmit:false}, // add options
     		 {reloadAfterSubmit:false}, // del options
     		 {}, // search options   		 
     	
     		 
     	
     		{
     		 afterSubmit: function (response) {
			             // you should return from server OK in sucess, any other message on error
			             alert("after Submit");
			             if (response.responseText == true) {
			                 alert("Update is succefully")
			                 return [true, "", ""]
			             }
			             else {
			                 alert("Update failed")
			                 return [false, "", ""]
			             }
			           },
			    	 }
      		   );
      		});     */
 
      		
      	  // 네비게시션 도구 설정
      	/*   $("#movie_list").jqGrid(
      	         		"navGrid",
      	                "#pager777"                 
      	     );
      	    });  
      	     */
 

       
      // 네비게시션 도구 설정
	  $("#movie_list").jqGrid(
	         		"navGrid",
	                "#pager777",
	                
	                
	                {search:true, edit:true, add:true, del:true},
	                {closeAfterEdit: true, reloadAfterSubmit: true},
	                {closeAfterAdd: true, reloadAfterSubmit: true},
	                {reloadAfterSubmit: true}
	     );
	    })
	    
	

    </script>

<body>


<form id="uploadForm" method="POST">  
	<br/> <br/>  <br/> <br/> 
       
	
	
	<table id="movie_list"></table>    
    <div id="pager777" class="scroll" style="text-align:center"></div>
    <div id="load_time" class="scroll" style="text-align:center"></div>

	
	<!-- <button id="export">Export to Excel</button> 
	 -->

</form>
</body>
</html>

