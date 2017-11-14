<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>매출 조회</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>


</head>

<script type="text/javascript">

	$(function(){
		var SALEDATE = $("#SALEDATE",opener.document).val();
		var SALEID = $("#SALEID",opener.document).val();
		
		$("#S_SALEDATE").val(SALEDATE);
		$("#S_SALEID").val(SALEID);
		selectListEnaSaleSudangList();
		
	
		
		$("#searchButton").click(function(){
			selectListEnaSaleSudangList();
		}); 
		
	})


	function selectListEnaSaleSudangList(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '수당관리'
			url:"/home/selectListEnaSaleSudangList.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['계약일자', '번호','담당자성명', '매매금액', '계약자성명',
			          '매출구분','담당자','관리번호','지역구분','주소','계약자성명','계약면적','계약평수','매매대금','매매단가','DC사항','DC율','DC금액','실판매가'],
			colModel:[
				 {name:"SALEDATE",		index:'PAYDATE',		width:100,		align:'center'}
				,{name:"SALEID",		index:'SALEID',			width:100,		align:'center'}
				,{name:"SALERNM",		index:'SALERNM',		width:100,		align:'center'}
				,{name:"SALEAMT",		index:'SALEAMT',		width:100,		align:'center'}
				,{name:"CONNAME",		index:'CONNAME',		width:100,		align:'center'}
				,{name:"SALEGUBUN",		index:'SALEGUBUN',		width:100,		align:'center', hidden:true}
				,{name:"SALERCD",		index:'SALERCD',		width:100,		align:'center', hidden:true}
//				,{name:"SALERNM",		index:'SALERNM',		width:100,		align:'center', hidden:true}
				,{name:"MANAGENO",		index:'MANAGENO',		width:100,		align:'center', hidden:true}
				,{name:"CITYCODE",		index:'CITYCODE',		width:100,		align:'center', hidden:true}
				,{name:"ADDRESS",		index:'ADDRESS',		width:100,		align:'center', hidden:true}
				,{name:"CONNAME",		index:'CONNAME',		width:100,		align:'center', hidden:true}
				,{name:"CONM2",			index:'CONM2',			width:100,		align:'center', hidden:true}
				,{name:"CONPY",			index:'CONPY',			width:100,		align:'center', hidden:true}
				,{name:"SALEAMT",		index:'SALEAMT',		width:100,		align:'center', hidden:true}
				,{name:"SALEDANGA",		index:'SALEDANGA',		width:100,		align:'center', hidden:true}
				,{name:"DCGUBUN",		index:'DCGUBUN',		width:100,		align:'center', hidden:true}
				,{name:"DCRATE",		index:'DCRATE',			width:100,		align:'center', hidden:true}
				,{name:"DCAMT",			index:'DCAMT',			width:100,		align:'center', hidden:true}
				,{name:"SELLAMT",		index:'SELLAMT',			width:100,		align:'center', hidden:true}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'sortKey' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			ondblClickRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
				$("#SALEDATE", parent.opener.document).val(selRowData.SALEDATE);
				$("#SALEID", parent.opener.document).val(selRowData.SALEID);
				$("#SALEGUBUN", parent.opener.document).val(selRowData.SALEGUBUN);
				$("#SALERCD1", parent.opener.document).val(selRowData.SALERCD);
//				$("#SALERNM", parent.opener.document).val(selRowData.SALERNM);
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
				$("#SELLAMT").val(selRowData.SELLAMT);
				$("#S_SALERCD", parent.opener.document).val(selRowData.SALERCD);
				window.self.close();
				selectListEnaSudangMst();
			} ,
			hidegrid: false
		});
	}	
	


</script>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:60%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<th>계약일자</th>
					<td><input type="text" class="inputName" id="S_SALEDATE" name="S_SALEDATE" /></td>
					<th>번호</th>
					<td><input type="text" class="inputName" id="S_SALEID" name="S_SALEID" />
					<a class="ui-button ui-widget ui-corner-all" id="searchButton" name="searchButton">조회 </a></td>					
				</tr>
			</table>
			<table id="leftList" width="98%"></table>
		</div>		
	</div>
</body>
</html>