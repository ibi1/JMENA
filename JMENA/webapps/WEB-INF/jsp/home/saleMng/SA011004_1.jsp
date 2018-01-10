<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<title>입금목록</title>	
	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.base.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.light.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.energyblue.css" type="text/css" />
	<style>
        html, body
        {
            width: 100%;
            height: 100%;
            box-sizing: border-box;
            margin: 0;
            font-size : 13px;
        }
        th
        {
        	height : 22px;
			text-align: center;
			font-weight: bold;
			border: 1px solid #CCC;
			background-color: #ffffff;
        }
        select
        {
		    min-height: 25px;
		    min-width: 16px;
		    margin: 0px;
		    border-width: 1px;
		    border-style: solid;
		    font-size: 13px;
		    padding: 0px;
		    padding-left: 3px;
		    padding-right: 3px;
		    border-color: #a4bed4;
		    -webkit-border-radius: 3px;
		}
    </style>	
	<script type="text/javascript" src="/resource/js/jquery.js"></script>
	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcore.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxnotification.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxtabs.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxsplitter.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttons.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttongroup.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxinput.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxmaskedinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxformattedinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxnumberinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxlistbox.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcombobox.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxtree.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.pager.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.edit.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.export.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.grouping.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.aggregates.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.columnsresize.js"></script> 
	<script type="text/javascript" src="/resource/js/common.js"></script>
	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>
</head>
<body>
	<div id="contents" style="width:550px;" align="center">
		<div id="mainDiv" style="width:100%; float:left;padding: 10px;" align="left">
			<div align="right" style="padding-top:10px; padding-bottom:3px">
				총 건수 : <font color="red"><sapn id="mainGridCount"></sapn></font>건
			</div>
			<table id="mainGrid"></table>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var init = {};
	var mainGridData = {};
	var gIPGUMDATE = $("#IPGUMDATE", opener.document).val();
	
	$(document).ready(function() {
		// 메인 그리드 초기화
		init.setMainGrid = function() {
			var param = {S_IPGUMDATE : gIPGUMDATE.replace(/[^0-9-]/g, "")};
			$("#mainGrid").jqGrid("GridUnload");
			$("#mainGrid").jqGrid({
				mtype: "POST",
				url: "/home/SA011004_s2.do",
				postData : JSON.stringify(param),
				ajaxGridOptions : {contentType: "application/json;charset=UTF-8"},
				datatype: "json",
			   	colModel:[			   	    
					{label: "입금일자", name: "IPGUMDATE", sortable: false, width: 80, align: "center"},
			   		{label: "입금인", name: "IPGUMPERSON", sortable: false, width: 60, align: "center"},
			   		{label: "입금금액", name: "IPGUMAMT", sortable: false, width: 80, align: "right", formatter: "number", formatoptions: {thousandsSeparator: ",", defaulValue: ""}},
			   		{label: "입금구분", name: "NAME_IPGUMGUBUN", sortable: false, width: 60, align: "center"},
			   		{label: "입금처리금액", name: "SUM_SUGUMAMT", sortable: false, hidden: true},		
			   		{label: "미처리잔액", name: "REM_IPGUMAMT", sortable: false, hidden: true},
			   		{label: "입금번호", name: "IPGUMID", sortable: false, hidden: true},
			   		{label: "입금형태(코드)", name: "IPGUMTYPE", sortable: false, hidden: true},
			   		{label: "입금형태", name: "NAME_IPGUMTYPE", sortable: false, hidden: true},
			   		{label: "입금구분(코드)", name: "IPGUMGUBUN", sortable: false, hidden: true},
			   		{label: "입금은행(코드)", name: "BANKGUBUN", sortable: false, hidden: true},
			   		{label: "입금은행", name: "NAME_BANKGUBUN", sortable: false, hidden: true},
			   		{label: "비고", name: "REMARK", sortable: false, hidden: true},
			   		{label: "입금인", name: "IPGUMPERSON", sortable: false, hidden: true}
			   	],
			   	rowNum: -1,
			   	autowidth: true,
			   	gridview: true,
			   	height: "400px",
				jsonReader: {
					root: "rows",
					repeatitems: false
				},				
				loadtext: "로딩중...",
				loadError: function(x, s, e) {
					alert("[ERROR]"+ e);
				},
				loadComplete: function(data) {
					var rCount = $("#mainGrid").jqGrid("getGridParam", "records");
					$("#mainGridCount").text(rCount);
				},
				ondblClickRow: function(rowid, iRow, iCol) {
					mainGridData = $(this).jqGrid("getRowData", rowid);
					
					window.opener.fnReset();
					
					$("#IPGUMDATE", opener.document).val(mainGridData.IPGUMDATE);
					$("#IPGUMTYPE", opener.document).val(mainGridData.IPGUMTYPE);
					$("#IPGUMGUBUN", opener.document).val("005");
					$("#R_IPGUMID", opener.document).val(mainGridData.IPGUMID);
					$("#BANKGUBUN", opener.document).val(mainGridData.BANKGUBUN);
					$("#IPGUMPERSON", opener.document).val(mainGridData.IPGUMPERSON);
					$("#IPGUMAMT", opener.document).val(setComma(mainGridData.IPGUMAMT));
					$("#txtIpgumAmt", opener.document).val(setComma(mainGridData.IPGUMAMT));
					
					window.self.close();
				}
			});			
		};
		init.setMainGrid();
	});
</script>