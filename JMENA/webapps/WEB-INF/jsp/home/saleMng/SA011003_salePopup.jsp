<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#SALEDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			var SALEDATE = $("#SALEDATE").val();
			f_selectListEnaSaleMstPopup(SALEDATE);
			
		});
	
		//매출관리 메인 그리드 팝업
		function f_selectListEnaSaleMstPopup(SALEDATE){
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListEanSalePopup.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					SALEDATE : SALEDATE
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['계약번호', '계약일자', '계약구분', '계약자', '계약자 연락처',
				          '계약자 주소', '계약면적', '계약평수', '계약대금(실판매가)', '입금구분',
				          '입금예정일', '입금예정금액', '입금순번'] ,
				colModel:[  
					{name:"SALEID",			index:'SALEID',			width:100,		align:'center'}
					, {name:"SALEDATE",		index:'SALEDATE',		width:100,		align:'center'}
					, {name:"SALEGUBUN",	index:'SALEGUBUN',		width:100,		align:'center'}
					, {name:"CONNAME",		index:'CONNAME',		width:100,		align:'center'}
					, {name:"CONTELNO",		index:'CONTELNO',		width:100,		align:'center'}
					, {name:"CONADDRESS",	index:'CONADDRESS',		width:100,		align:'center'}
					, {name:"CONM2",		index:'CONM2',			width:100,		align:'center'}
					, {name:"CONPY",		index:'CONPY',			width:100,		align:'center'}
					, {name:"SELLAMT",		index:'SELLAMT',		width:100,		align:'center'}
					, {name:"DEPOSITGUBUN",	index:'DEPOSITGUBUN',	width:100,		align:'center'}
					, {name:"DEPOSITDATE",	index:'DEPOSITDATE',	width:100,		align:'center'}
					, {name:"DEPOSITAMT",	index:'DEPOSITAMT',		width:100,		align:'center'}
					, {name:"IPGUMSEQ",		index:'IPGUMSEQ',		width:100,		align:'center', hidden:true}
				] ,
				rowNum:5000,
				autowidth: true,
				shrinkToFit: false,
				rowList:[10,20,30],
				sortname: 'SALEDATE',
				viewrecords: true,
				sortorder:'desc',
				width: "98%",
				jsonReader: {
					repeatitems: false
				},
				height: '360px',
				onSelectRow: function(ids) {
					
				} ,
				ondblClickRow: function(id,irow,icol,e) {
					var selRowData = $(this).jqGrid('getRowData', id);

 					
					$("#dtl_SALEID",opener.document).val(selRowData.SALEID);
					$("#dtl_SALEDATE",opener.document).val(selRowData.SALEDATE);
					$("#dtl_SALEGUBUN",opener.document).val(selRowData.SALEGUBUN);
					$("#dtl_CONNAME",opener.document).val(selRowData.CONNAME);
					$("#dtl_CONTELNO",opener.document).val(selRowData.CONTELNO);
					$("#dtl_CONADDRESS",opener.document).val(selRowData.CONADDRESS);
					$("#dtl_CONM2",opener.document).val(selRowData.CONM2);
					$("#dtl_CONPY",opener.document).val(selRowData.CONPY);
					$("#dtl_SELLAMT",opener.document).val(selRowData.SELLAMT);
					$("#dtl_DEPOSITGUBUN",opener.document).val(selRowData.DEPOSITGUBUN);
					$("#dtl_DEPOSITDATE",opener.document).val(selRowData.DEPOSITDATE);
					$("#dtl_DEPOSITAMT",opener.document).val(selRowData.DEPOSITAMT);
					$("#dtl_IPGUMSEQ",opener.document).val(selRowData.IPGUMSEQ);
					
					opener.bottomListAdd();
					
					
					self.close();
				},
				loadComplete: function(ids) {
					
				},
				hidegrid: false
			});
		}
		
		$(function() {
			$("#selectButton").click(function() {

				f_selectListEnaSaleMstPopup($("#SALEDATE").val());
			});
		});
		
		
	</script>
</head>
<body>
	<div id="contents" style="width:800px;" align="center">
		<div id="topDiv" style="width:98%; float:left;padding: 10px" align="left">
			<table width="98%">
				<tr>
					<th width="150">* 계약일자</th>
					<td><input type="text" id="SALEDATE" name="SALEDATE" />    <input type="button" value="조회" id='selectButton' /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table id="leftList"></table>
		</div>
	</div>
</body>
</html>