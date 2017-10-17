<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

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


<html lang="UTF-8">
	

   <meta charset="UTF-8">
   
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/ui-darkness/jquery-ui.css" >  -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/sunny/jquery-ui.css">
    <link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker.css" />
    
     
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.14.1/css/ui.jqgrid.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.14.1/jquery.jqgrid.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.js"></script>
    <!--  <script src="<c:url value="/javascript/jqGridCommon.js"/>"></script>  	-->
	<!--  <script src="<c:url value="/javascript/jquery-3.1.0.min.js"/>"></script>  -->
	<!--  <script src="<c:url value="/javascript/jquery.form.min.js"/>"></script>  	-->
 

   
 <script type="text/javascript">
        $(document).ready(function(){
        	
        	$(function() {
        		$("#btn-upload").on("click", function(){
        			if(($("#file1").val() == "" || $("#file1").val() == null)) {
        			    alert("파일 첫 번째가 없습니다.");
        			} 
        			
        			//else if(($("#file2").val() == "" || $("#file2").val() == null)) {
        			//    alert("파일 두 번째가 없습니다.");
        			//} else {

        			   var form = new FormData(document.getElementById('uploadForm'));
        			    $.ajax({
        				      url: "/product/json/upload", //컨트롤러 URL
        				      data: form,
        				      dataType: 'json',
        				      processData: false,
        				      contentType: false,
        				      type: 'POST',
        				      success: function (response) {
        				    	  alert("성공적으로 파일 업로드되었습니다.");
        				    	  console.log(response);
        				      },error: function (jqXHR) {
        				    	   //alert("성공적으로 파일 업로드되었습니다.");
        					       alert(jqXHR.responseText);
        					       console.log(jqXHR.responseText);
        				      }
        			   });
        	/*

        			    $('#uploadForm').ajaxSubmit({
        				      url: "/pentode/upload.do", //컨트롤러 URL
        				      dataType: 'json',
        				      processData: false,
        				      contentType: false,
        				      type: 'POST',
        				      success: function (response) {
        				    	  alert("success");
        				    	  console.log(response);
        				      },error: function (jqXHR) {
        					      alert(jqXHR.responseText);
        				      }
        			   });
        	*/
        			//}
        		});
        	});
        	
        	
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
         $("#movie_list").jqGrid({
            	headers: { 
                      'Accept': 'application/json',
                      'Content-Type': 'application/json; charset=UTF-8' 
                 
              	},
            	
            	// ajax 요청주소
                url:"/movie/json/getAPIMoiveList",
                caption : "영화 API 등록",
                // 요청방식
                mtype:"post",
                // 결과물 받을 데이터 타입
                datatype:"json",
                edit : {
                	editCaption : "영화 등록",
                	bSubmit : "등록하기",
                	bCancel : "취소하기",
                	bYes : "예",
                	bNo  : "아니오",
                },
                
                ajaxGridOptions: { contentType: "application/json; charset=UTF-8" },
                ajaxRowOptions: { contentType: "application/json; charset=UTF-8", async: true },
                ajaxSelectOptions: { contentType: "application/json; charset=UTF-8", dataType: "JSON" },

                
                // 그리드 갭션                
                caption:"영화 API 등록",
                // 그리드 높이
                height:"auto",
                // 그리드(페이지)마다 보여줄 행의 수 -> 매개변수이름은 "rows"로 요청된다
                //rowNum:10,
                // rowNum변경 옵션
                //rowList:[10,15,20],
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
                          
                          afterSubmit: function (response, postdata) {
                              var json = $.parseJSON(response.responseText);

                              if (json) {
                                  $(gridName).jqGrid('setGridParam', { datatype: 'json' });
                                  return [json.success, json.message, json.id];
                              }

                              return [false, "Failed to get result from server.", null];
                          },
                          
                        
                          //{name:'갈 젤레즈니악', jsonmap: function (obj) { return getVaueByName(obj.directors, "갈 젤레즈니악");}}],
                          //{name:'peopleNm', index:'directors', align:"center", editable:true, edittype:"text"}],
                          
                   
                          
           // 네비게이션 도구를 보여줄 div요소
               	sortable: true,
                sortname: 'movieCd',
                pager:"#pager",
                rowNum:5,
                autowidth:true,
                // 전체 레코드수, 현재레코드 등을 보여줄지 유무
                multiselect: true,
                viewrecords:true,
                
                // 추가, 수정, 삭제 url
                editurl: "/movie/json/addMovie",
                contentType: 'multipart/form-data', 
                
                mtype:"post",
                // 결과물 받을 데이터 타입
                datatype:"json",
                enctype: "multipart/form-data",
                
                ajaxGridOptions:   { contentType: "application/json; charset=UTF-8" },
                ajaxRowOptions:    { contentType: "application/json; charset=UTF-8", async: true },
                ajaxSelectOptions: { contentType: "application/json; charset=UTF-8", dataType: "JSON" },

                 
                onclickSubmit: function(params, posdata) {
                	 uploadJqueryForm();
                },
            
                ondblClickRow: function (rowid, iRow, iCol, e) {
                    $(this).jqGrid('editRow', rowid, true, function () {
                        $("input, select", e.target).focus();
                    });
                    return;
                },
                
                afterSubmit: UploadImage, 
                
               
                
                mtype       : "POST",
                addParams: {addRowParams: {keys: true}, },
               
                //sortable: true 
                sortorder: "desc",
                loadonce : true,

                
                jSonReader : {
                	root:"rows",
                	page:"page",
                	total:"total",
                	records:"records",
                	repeatitems:false,
                	cell:"cell",
                	id:"movieCd"
                },

        	});
            // 네비게시션 도구 설정
            $("#movie_list").jqGrid(
                    "navGrid",
                    "#pager",
                     {search:true, edit:true, add:true, del:true,refresh:true},                   
                     {closeAfterEdit: true, reloadAfterSubmit: true},
                     {closeAfterAdd: true, reloadAfterSubmit: true},
                     {reloadAfterSubmit: true},            
                     {closeOnEscape:true} 
    
            );
   
	        });   
 
    </script>

    <%
  
    // 파라메터 설정
	String curPage = request.getParameter("curPage")==null?"1":request.getParameter("curPage");					    //현재페이지
	String itemPerPage = request.getParameter("itemPerPage")==null?"100":request.getParameter("itemPerPage");		//결과row수
	String movieNm = request.getParameter("movieNm")==null?"":request.getParameter("movieNm");						//영화명
	String directorNm = request.getParameter("directorNm")==null?"":request.getParameter("directorNm");				//감독명
	String openStartDt = request.getParameter("openStartDt")==null?"":request.getParameter("openStartDt");			//개봉연도 시작조건 ( YYYY )
	String openEndDt = request.getParameter("openEndDt")==null?"":request.getParameter("openEndDt");				//개봉연도 끝조건 ( YYYY )	
	String prdtStartYear = request.getParameter("prdtStartYear")==null?"":request.getParameter("prdtStartYear");	//제작연도 시작조건 ( YYYY )
	String prdtEndYear = request.getParameter("prdtEndYear")==null?"":request.getParameter("prdtEndYear");			//제작연도 끝조건    ( YYYY )
	String repNationCd = request.getParameter("repNationCd")==null?"":request.getParameter("repNationCd");			//대표국적코드 (공통코드서비스에서 '2204'로 조회된 국가코드)
	String[] movieTypeCdArr = request.getParameterValues("movieTypeCdArr")==null? null:request.getParameterValues("movieTypeCdArr");	//영화형태코드 배열 (공통코드서비스에서 '2201'로 조회된 영화형태코드)
	
	
	
	// 발급키
	String key = "430156241533f1d058c603178cc3ca0e";
	// KOBIS 오픈 API Rest Client를 통해 호출
    KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);

	// 영화코드조회 서비스 호출 (boolean isJson, String curPage, String itemPerPage,String directorNm, String movieCd, String movieNm, String openStartDt,String openEndDt, String ordering, String prdtEndYear, String prdtStartYear, String repNationCd, String[] movieTypeCdArr)
    String movieCdResponse = service.getMovieList(true, curPage, itemPerPage, movieNm, directorNm, openStartDt, openEndDt, prdtStartYear, prdtEndYear, repNationCd, movieTypeCdArr);
	// Json 라이브러리를 통해 Handling
	ObjectMapper mapper = new ObjectMapper();
	HashMap<String,Object> result = mapper.readValue(movieCdResponse, HashMap.class);

	request.setAttribute("result",result);

	// KOBIS 오픈 API Rest Client를 통해 코드 서비스 호출 (boolean isJson, String comCode )
	String nationCdResponse = service.getComCodeList(true,"2204");
	HashMap<String,Object> nationCd = mapper.readValue(nationCdResponse, HashMap.class);
	request.setAttribute("nationCd",nationCd);

	String movieTypeCdResponse = service.getComCodeList(true,"2201");
	HashMap<String,Object> movieTypeCd = mapper.readValue(movieTypeCdResponse, HashMap.class);
	request.setAttribute("movieTypeCd",movieTypeCd);
	

    %>    
</head>


<body>
<!--  <form id="uploadForm" enctype="multipart/form-data" method="POST" action="/product/json/upload">  -->
<form id="uploadForm" enctype="multipart/form-data" method="POST">  
	<br/> <br/>
	<table id="movie_list"></table>    
    <div id="pager" class="scroll" style="text-align:center"></div>
    <div id="load_time" class="scroll" style="text-align:center"></div>
	
	<p> 스킬컷 파일 업로드 (최대3개 순차적으로 선택가능) </p>

<!-- 	
	<div><input type="file" id="file1" name="file" required="required" /></div>
	<div><input type="file" id="file2" name="file" required="required" /></div>
	<div><input type="file" id="file2" name="file" required="required" /></div>	
    <br/>
	&nbsp; <div><button id="btn-upload">파일 업로드</button></div>
 -->
    <div class="widget" >
	
	
	<div> 추가할 영화 CD : <input class="ui-button ui-widget ui-corner-all"  type="text" id="movieCd" name="movieCd" required="required" /></div>
	<div><input class="ui-button ui-widget ui-corner-all"  type="file" id="file1" name="file" required="required" /></div>
	<div><input class="ui-button ui-widget ui-corner-all"  type="file" id="file2" name="file"  /></div>
	<div><input class="ui-button ui-widget ui-corner-all"  type="file" id="file2" name="file"  /></div>   
    
    <br/> 
  	<div> <button id="btn-upload">파일 업로드</button></div>
	
	
    </div>	
 
</form>
</body>
</html>

