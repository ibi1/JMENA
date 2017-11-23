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
				url:"/home/selectListEanSaleMstPopup.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					SALEDATE : SALEDATE
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['계약번호', '계약일자', 
				          '관리번호', '지역구분', '지사구분', '주소', '원지주성명', '주민번호', '분양면적', '잔여면적', '분양평수', '잔여평수', 
				          '매출구분', '담당자', '매입번호', '게약자성명', '게약자주민번호', '계약자주소', 
				          '계약자연락처', '계약면적', '계약평수', '비고', '매매금액', '매매단가', '할인구분', '할인율', '할인금액', '실판매가', '위탁수수료', 
				          '공동명의구분', '등기여부', '등기일자', '해약여부', '해약일자'],
				colModel:[
					{name:"SALEID",			index:'SALEID',			width:100,	align:'center',	sortable:false},
					{name:"SALEDATE",		index:'SALEDATE',		width:100,	align:'center',	sortable:false},
					{name:"MANAGENO",		index:'MANAGENO',		width:100,	align:'center',	sortable:false},
					{name:"CITYCODE",		index:'CITYCODE',		width:100,	align:'center',	sortable:false},
					{name:"BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"ADDRESS",		index:'ADDRESS',		width:100,	align:'center',	sortable:false},
					{name:"OWNERNAME",		index:'OWNERNAME',		width:100,	align:'center',	sortable:false, hidden:true},
					{name:"OWNERJUMINID",	index:'OWNERJUMINID',	width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONBM2",			index:'CONBM2',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONJM2",			index:'CONJM2',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONBPY",			index:'CONBPY',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONJPY",			index:'CONJPY',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"SALEGUBUN",		index:'SALEGUBUN',		width:100,	align:'center',	sortable:false},
					{name:"SALERCD",		index:'SALERCD',		width:100,	align:'center',	sortable:false, hidden:true},
					{name:"BUYID",			index:'BUYID',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center',	sortable:false},
					{name:"CONJUMINID",		index:'CONJUMINID',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONADDRESS",		index:'CONADDRESS',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONTELNO",		index:'CONTELNO',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONM2",			index:'CONM2',			width:100,	align:'center',	sortable:false},
					{name:"CONPY",			index:'CONPY',			width:100,	align:'center',	sortable:false},
					{name:"REMARK",			index:'REMARK',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"SALEAMT",		index:'SALEAMT',		width:100,	align:'center',	sortable:false},
					{name:"SALEDANGA",		index:'SALEDANGA',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"DCGUBUN",		index:'DCGUBUN',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"DCRATE",			index:'DCRATE',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"DCAMT",			index:'DCAMT',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"SELLAMT",		index:'SELLAMT',		width:100,	align:'center',	sortable:false},
					{name:"AGENCYAMT",		index:'AGENCYAMT',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"JOINYN",			index:'JOINYN',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"REGYN",			index:'REGYN',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"REGDATE",		index:'REGDATE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CANCELYN",		index:'CANCELYN',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CANCELDATE",		index:'CANCELDATE',		width:100,	align:'center',	sortable:false,	hidden:true}
				],
				rowNum:1000,
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

/* 					
					$("#SL_SALEDATE_FR",opener.document).val(selRowData.SALEDATE);
					$("#SL_SALEDATE_TO",opener.document).val(selRowData.SALEDATE);
					$("#SALEID",opener.document).val(selRowData.SALEID);
					
					opener.f_selectListEnaSaleMst();
 */					
					
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
					<th width="150">* 계약일자/번호</th>
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