<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수당 수령인 추가</title>

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
            padding: 3px;
            box-sizing: border-box;
            margin: 0;
        }
        th
        {
        	height : 22px;
			text-align: center;
			font-weight: bold;
			border: 1px solid #CCC;
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
	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>


</head>

<script type="text/javascript">
	var v_rightLastSel = 0;
	$(document).ready(function(){
//		var SALEID = $("#SALEID",opener.document).val();
		var insacode = $("#INSACODE",opener.document).val();
		selectListEnaTexPayerItem(insacode);
	})
	
	
	function selectListEnaTexPayerItem(insacode){
		$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList').jqGrid({
			//caption: '신고인관리'
			url:"/home/selectListEnaTexPayerItem.do" ,
			postData : {
				INSACODE : insacode
			},		
			datatype:"json" ,
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['사번','순번','소득신고인', '주민번호', '거래은행코드','거래은행' ,'계좌번호', '계좌주', '기본계좌', '비고'] ,
			colModel:[
				 {name:"INSACODE",		index:'INSACODE',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"ITEMSEQ",		index:'ITEMSEQ',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"PAYERNAME",		index:'PAYERNAME',		width:100,		align:'center',	sortable:false}
				,{name:"PAYERID",		index:'PAYERID',		width:120,		align:'center',	sortable:false}
				,{name:"BANKID",		index:'BANKID',			width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"BANKNAME",		index:'BANKNAME',		width:100,		align:'center',	sortable:false}
				,{name:"ACCTNO",		index:'ACCTNO',			width:100,		align:'center',	sortable:false}
				,{name:"ACCTOWNER",		index:'ACCTOWNER',		width:100,		align:'center',	sortable:false}
				,{name:"BASICACCT",		index:'BASICACCT',		width:100,		align:'center',	sortable:false}			
				,{name:"REMARK",		index:'REMARK',			width:100,		align:'center',	sortable:false}
			] ,
			rowNum:10000000,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'ITEMSEQ' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: '96%' ,
			jsonReader: {
				repeatitems: false
			},
			//, height: '100%'
			onSelectRow: function(id){
				
			} ,
			loadComplete: function() {			
			},
			ondblClickRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);				
				$("#bottomList", parent.opener.document).setCell($("#bottomList", parent.opener.document).jqGrid('getGridParam', 'selrow'),"PAYERNAME",selRowData.PAYERNAME);
				$("#bottomList", parent.opener.document).setCell($("#bottomList", parent.opener.document).jqGrid('getGridParam', 'selrow'),"PAYERID",selRowData.PAYERID);
				$("#bottomList", parent.opener.document).setCell($("#bottomList", parent.opener.document).jqGrid('getGridParam', 'selrow'),"BANKID",selRowData.BANKID);
				$("#bottomList", parent.opener.document).setCell($("#bottomList", parent.opener.document).jqGrid('getGridParam', 'selrow'),"BANKNAME",selRowData.BANKNAME);
				$("#bottomList", parent.opener.document).setCell($("#bottomList", parent.opener.document).jqGrid('getGridParam', 'selrow'),"ACCTNO",selRowData.ACCTNO);
				$("#bottomList", parent.opener.document).setCell($("#bottomList", parent.opener.document).jqGrid('getGridParam', 'selrow'),"ACCTOWNER",selRowData.ACCTOWNER);
				window.self.close();
			},
			hidegrid: false
		});
	}
</script>
<body>
	<div id="contents" style="width:800px;" align="center">
		<div id="leftDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table id="bottomList" width="98%"></table>
		</div>
	</div>
</body>
</html>