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
      <table id="myGrid"></table>
      <div id="pager"></div>
      <button id="export">Export to Excel</button>
    </form>
	

    <script type="text/javascript"> 
    
    var gridJson = { page: 1, total: 2, records: 10, rows: [
             { Id: 0, Label: "Custom Field 1", LastUpdatedDate: "10/02/2012" },
             { Id: 1, Label: "Custom Field 2", LastUpdatedDate: "10/02/2012"}]
         };
  
         //setup the grid
         $("#myGrid").empty().jqGrid({
             datatype: 'jsonstring',
             datastr: gridJson,
             colNames: ['Id', 'Custom Field Name', 'Last Update', 'Action'],
             colModel: [{ name: 'Id', index: 'Id', hidden: true, classes: 'id' },
                        { name: 'Label', index: 'Label', width: 500 },
                        { name: 'LastUpdatedDate', index: 'LastUpdatedDate', width: 200 },
                        { width: 132, sortable: false, classes: 'action', align: 'center'}],
             pager: jQuery('#pager'),
             jsonReader: {
                 repeatitems: false
             },
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
			$("#myGrid").jqGrid("exportToExcel",{
				includeLabels : true,
				includeGroupHeader : true,
				includeFooter: true,
				fileName : "jqGridExport.xlsx",
				maxlength : 40 // maxlength for visible string data 
			})
	    });
         
         
    
    
    
       /*  $(document).ready(function () {
            $("#jqGrid").jqGrid({
                url: 'data.json',
                datatype: "json",
                colModel: [
					{ label: 'Category Name', name: 'CategoryName', width: 75 },
					{ label: 'Product Name', name: 'ProductName', width: 90 },
					{ label: 'Country', name: 'Country', width: 100 },
					{ label: 'Price', 
						name: 'Price', 
						width: 80, 
						sorttype: 'number', 
						//formatter: 'number',
						align: 'right'
					},
					{ label: 'Quantity', name: 'Quantity', width: 80, sorttype: 'integer', formatter : 'integer', formatoptions : {thousandsSeparator : ' '} }                   
                ],
				loadonce: true,
				viewrecords: true,
                footerrow: true,
                userDataOnFooter: true, // use the userData parameter of the JSON response to display data on footer
                width: 780,
                height: 200,
                rowNum: 150
            });
			
			$("#export").on("click", function(){
				$("#jqGrid").jqGrid("exportToExcel",{
					includeLabels : true,
					includeGroupHeader : true,
					includeFooter: true,
					fileName : "jqGridExport.xlsx",
					maxlength : 40 // maxlength for visible string data 
				})
			})
        });
 */
    </script>

    
</body>
</html>