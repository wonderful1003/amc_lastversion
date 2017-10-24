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
     
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.14.1/css/ui.jqgrid.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.14.1/jquery.jqgrid.min.js"></script>
    <!--  <script src="../javascript/jqGridCommon.js"></script>  -->
   



   
 <script type="text/javascript">
        $(document).ready(function(){
        	
        	function delButton (cellvalue, options, rowObject) {
        		   return '<input type="button" onclick="delete('+cellvalue+')" value="DEL"/>'; 
        	 };

        	
        	
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
                caption : "영화목록",
                // 요청방식
                mtype:"post",
                // 결과물 받을 데이터 타입
                datatype:"json",
                
                ajaxGridOptions: { contentType: "application/json; charset=UTF-8" },
                ajaxRowOptions: { contentType: "application/json; charset=UTF-8", async: true },
                ajaxSelectOptions: { contentType: "application/json; charset=UTF-8", dataType: "JSON" },

                
                // 그리드 갭션                
                caption:"영화 목록",
                // 그리드 높이
                height:"auto",
                // 그리드(페이지)마다 보여줄 행의 수 -> 매개변수이름은 "rows"로 요청된다
                //rowNum:10,
                // rowNum변경 옵션
                //rowList:[10,15,20],
                // 컬럼명
                colNames:['영화CD','영화명','제작연도','개봉연도','제작국가','제작장르','감독'],
                // 컬럼 데이터(추가, 삭제, 수정이 가능하게 하려면 autoincrement컬럼을 제외한 모든 컬럼을 editable:true로 지정)
                // edittyped은 text, password, ... input type명을 사용
                colModel:[
                          {name:'movieCd', key: true,index:'movieCd',align:"center",sorttype:"int",width:90, sortable:true,editable:true},
                          {name:'movieNm', index:'movieNm', align:"center",width:90, sortable:true, editable:true},
                          // {name:'movieNmEn', index:'movieNmEn',  width:100, align:"center",sorttype:"int",editable:true, edittype:"text"},
                          {name:'prdtYear', index:'prdtYear', width:150, align:"center",sortable:true, editable:true},
                          {name:'openDt', index:'openDt', align:"center", editable:true, edittype:"text"},
   	                      {name:'nationAlt', index:'nationAlt',align:"center", width:90,sortable:true, editable:true},
                          {name:'genreAlt', index:'genreAlt', align:"center", editable:true, edittype:"text"},
                          {name:'peopleNm', jsonmap: function (obj) { return getVaueByName(obj.directors, "peopleNm");}}],
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
                editurl: "/product/json/getOperation",
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
                }
                
         
              
 
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
<form id='myForm' action="/product/json/listMovieDetail" method="post">

	<br/> <br/>
	
    <table id="movie_list"></table>
    
    <div id="pager" class="scroll" style="text-align:center"></div>
    <div id="load_time" class="scroll" style="text-align:center"></div>
    
    <br/> <br/>
      
		영화CD :<input type="text" name="movieCD">
		
			
		<input type="submit" name="" value="조회">
    

</form>
</body>
</html>

