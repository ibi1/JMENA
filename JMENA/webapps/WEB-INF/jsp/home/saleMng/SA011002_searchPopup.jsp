<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JMENA</title>
	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

	<script type="text/javascript" src="/resource/js/jquery.js"></script>
	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var SALEDATE = $("#SALEDATE",opener.document).val();
			
			f_selectListEnaSaleMstBDtlPopup(SALEDATE);
		});
		
		//매출관리 소비대차 메인 그리드
		function f_selectListEnaSaleMstBDtlPopup(SALEDATE){
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListEanSaleMstBDtlPopup.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					SALEDATE : SALEDATE
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['계약일자', '계약번호', '관리번호', '지역', '주소', '계약면적', '계약평수',  '차입자성명', '차입대금', '지급이자'],
				colModel:[
					{name:"SALEDATE",		index:'SALEDATE',		width:100,	align:'center',	sortable:false},
					{name:"SALEID",			index:'SALEID',			width:100,	align:'center',	sortable:false},
					{name:"MANAGENO",		index:'MANAGENO',		width:100,	align:'center',	sortable:false},
					{name:"CITYCODE",		index:'CITYCODE',		width:100,	align:'center',	sortable:false},
					{name:"ADDRESS",		index:'ADDRESS',		width:100,	align:'center',	sortable:false},
					{name:"CONM2",			index:'CONM2',			width:100,	align:'center',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}},
					{name:"CONPY",			index:'CONPY',			width:100,	align:'center',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}},
					{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center',	sortable:false},
					{name:"BRROWAMT",		index:'BRROWAMT',		width:100,	align:'center',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}},
					{name:"PAYAMT",			index:'PAYAMT',			width:100,	align:'center',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}},
				],
				rowNum:10000000,
				autowidth: true,
				shrinkToFit: false,
				rowList:[10,20,30],
				sortname: 'SALEDATE',
				viewrecords: true,
				sortorder:'desc',
				width: "96%",
				jsonReader: {
					repeatitems: false
				},
				height: '400px',
				onSelectRow: function(ids){
					
				} ,
				ondblClickRow: function(id,irow,icol,e) {
					var selRowData = $(this).jqGrid('getRowData', id);
					
					$("#SALEID",opener.document).val(selRowData.SALEID);
					
					opener.f_selectListEnaSaleMstBDtl();
					
					self.close();
				},
				loadComplete: function(ids) {
					//전체 카운트
					var countRow = $("#leftList").jqGrid('getGridParam', 'records');
					$("#leftListCount").html(countRow);
				},
				hidegrid: false
			});
		}
	</script>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:100%; float:left; padding: 10px" align="left">
			<div align="right">총 건수 : <font color="red"><sapn id="leftListCount"></sapn></font>건</div>
			<table id="leftList"></table>
		</div>
	</div>
</body>
</html>