<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>매출 조회</title>

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

	$(document).ready(function(){
		var SALEDATE = $("#SALEDATE",opener.document).val();
		var SALEID = $("#SALEID",opener.document).val();
		$("#S_SALEDATE").val(SALEDATE);
		$("#S_SALEID").val(SALEID);
		
		$("#searchButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#S_SALEDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#S_SALEID").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		
		selectListEnaSaleSudangList();
		

		
		$("#searchButton").click(function(){
			selectListEnaSaleSudangList();
		}); 
		
	})


	function selectListEnaSaleSudangList(){
		if($("#S_SALEID").val() == "" && $("#S_SALEDATE").val() == ""){
			alert("검색 조건을 입력 해 주세요");
			return;
		}
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '수당관리'
			url:"/home/selectListEnaSaleSudangList.do" ,
			mtype: 'POST',
			postData : {
				SALEID : $("#S_SALEID").val(),
				SALEDATE : $("#S_SALEDATE").val()
			},				
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['계약일자', '번호','담당자성명', '매매금액', '계약자성명',
			          '매출구분','담당자','관리번호','지역구분','주소','계약자성명','계약면적','계약평수','매매대금','매매단가','DC사항','DC율','DC금액','실판매가'],
			colModel:[
				 {name:"SALEDATE",		index:'PAYDATE',		width:120,		align:'center',	sortable:false}
				,{name:"SALEID",		index:'SALEID',			width:150,		align:'center',	sortable:false}
				,{name:"SALERNM",		index:'SALERNM',		width:150,		align:'center',	sortable:false}
				,{name:"SALEAMT",		index:'SALEAMT',		width:120,		align:'center',	sortable:false}
				,{name:"CONNAME",		index:'CONNAME',		width:150,		align:'center',	sortable:false}
				,{name:"SALEGUBUN",		index:'SALEGUBUN',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"SALERCD",		index:'SALERCD',		width:100,		align:'center',	sortable:false, hidden:true}
//				,{name:"SALERNM",		index:'SALERNM',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"MANAGENO",		index:'MANAGENO',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"CITYCODE",		index:'CITYCODE',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"ADDRESS",		index:'ADDRESS',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"CONNAME",		index:'CONNAME',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"CONM2",			index:'CONM2',			width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"CONPY",			index:'CONPY',			width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"SALEAMT",		index:'SALEAMT',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"SALEDANGA",		index:'SALEDANGA',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"DCGUBUN",		index:'DCGUBUN',		width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"DCRATE",		index:'DCRATE',			width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"DCAMT",			index:'DCAMT',			width:100,		align:'center',	sortable:false, hidden:true}
				,{name:"SELLAMT",		index:'SELLAMT',		width:100,		align:'center',	sortable:false, hidden:true}
			] ,
			rowNum:10000000,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'sortKey' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			loadtext : "조회 중",
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			ondblClickRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
				$("#SALEDATE", parent.opener.document).val(selRowData.SALEDATE);
				$("#SALEID", parent.opener.document).val(selRowData.SALEID);
				$("#SALEGUBUN", parent.opener.document).val(selRowData.SALEGUBUN);
				$("#SALERCD", parent.opener.document).val(selRowData.SALERCD);
				$("#SALERNM", parent.opener.document).val(selRowData.SALERNM);
				$("#BRANCHCODE", parent.opener.document).val(selRowData.BRANCHCODE);
				$("#MANAGENO", parent.opener.document).val(selRowData.MANAGENO);
				$("#CITYCODE", parent.opener.document).val(selRowData.CITYCODE);
				$("#ADDRESS", parent.opener.document).val(selRowData.ADDRESS);
				$("#CONNAME", parent.opener.document).val(selRowData.CONNAME);
				$("#CONM2", parent.opener.document).val(selRowData.CONM2);
				$("#CONPY", parent.opener.document).val(selRowData.CONPY);
				$("#SALEAMT", parent.opener.document).val(selRowData.SALEAMT);
				$("#SALEDANGA", parent.opener.document).val(selRowData.SALEDANGA);
				$("#DCGUBUN", parent.opener.document).val(selRowData.DCGUBUN);
				$("#DCRATE", parent.opener.document).val(selRowData.DCRATE);
				$("#DCAMT", parent.opener.document).val(selRowData.DCAMT);
				$("#SELLAMT", parent.opener.document).val(selRowData.SELLAMT);
				$("#S_SALEID", parent.opener.document).val(selRowData.SALEID);
				$(opener.location).attr("href", "javascript:selectListEnaSudangMst();");

				window.self.close();

			} ,
			hidegrid: false
		});
	}	
	


</script>
<body>
	<div id="contents" style="width:98%;" align="center">
		<div id="leftDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table width="100%">
				<tr>
					<th width="120">계약일자</th>
					<td width="120"><input type="text" class="inputName" id="S_SALEDATE" name="S_SALEDATE" /></td>
					<th width="120">번호</th>
					<td width="120"><input type="text" class="inputName" id="S_SALEID" name="S_SALEID" /></td>
					<td align="right"><input type="button" value="조회" id='searchButton' /></td>
				</tr>
			</table>
			<table id="leftList" width="98%"></table>
		</div>		
	</div>
</body>
</html>