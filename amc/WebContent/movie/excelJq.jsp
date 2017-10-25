<!DOCTYPE html>
<html lang="en">
<head>
    <!-- The jQuery library is a prerequisite for all jqSuite products -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- This is the Javascript file of jqGrid -->   
    
     
    <script type="text/ecmascript" src="../javascript/trirand/src/jquery.jqGrid.js"></script>
    
   
    <!-- This is the localization file of the grid controlling messages, labels, etc.
    <!-- We support more than 40 localizations -->
    <script type="text/ecmascript" src="../javascript/trirand/i18n/grid.locale-en.js"></script>
	
	<script type="text/javascript" language="javascript" src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
    <!-- A link to a jQuery UI ThemeRoller theme, more than 22 built-in and many more custom -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/sunny/jquery-ui.css">
    <!-- The link to the CSS that the grid needs -->
    <link rel="stylesheet" type="text/css" media="screen" href="../css/trirand/ui.jqgrid.css" />
    <meta charset="utf-8" />
    <title>jqGrid Export to CSV, PDF, Excel</title>
</head>
<body>

   <!--  <table id="jqGrid"></table>
	<button id="export">Export to Excel</button>
	 -->
	
	 <form id="form1">
      <table id="movie_list"></table>
      <div id="pager"></div>
      <button id="export">Export to Excel</button>
    </form>
	

    <script type="text/javascript"> 
    
         //setup the grid
         $("#movie_list").empty().jqGrid({
        	 url:"/movie/json/getAPIMoiveList",
        	 caption : "Movie API register",
        	 mtype:"post",
        	 datatype:"json",
             colNames: ['MovieCD', 'MovieTitle', 'Produced Nation', 'EndDate','Synopsis','Trailer'],
             colModel: [{ name: 'Id', index: 'Id', hidden: true, classes: 'id' },
                        { name: 'Label', index: 'Label', width: 500 },
                        { name: 'LastUpdatedDate', index: 'LastUpdatedDate', width: 200 },
                        { width: 132, sortable: false, classes: 'action', align: 'center'}],
             pager: jQuery('#pager'),            
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
              
             loadonce: true,          
             width: 832,
             height: "100%",
             scrollOffset: 20,
             rowNum: 10,
             rowList: [10, 15, 20, 25],
             sortname: 'Label',
             sortorder: "asc",
             viewrecords: true,
             hoverrows: false,
             caption: "",           
             beforeSelectRow: function (rowid, e) { return false; } //this disables row being highlighted when clicked
         });

     	$("#export").on("click", function(){
			$("#movie_list").jqGrid("exportToExcel",{
				includeLabels : true,
				includeGroupHeader : true,
				includeFooter: true,
				fileName : "jqGridExport.xlsx",
				maxlength : 5000 // maxlength for visible string data 
			})
	    });
    
    
    
    </script>

    
</body>
</html>