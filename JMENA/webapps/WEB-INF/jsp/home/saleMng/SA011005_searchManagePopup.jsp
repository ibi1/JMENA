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
			var BUYGUBUN = $("#SALEGUBUN",opener.document).val();
			
			f_selectListEnaBuyMstPopup(BUYGUBUN);
		});
		
		function f_selectListEnaBuyMstPopup(BUYGUBUN){
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				//caption: '매입관리'
				url:"/home/SA011005_selectListEnaBuyMstPopup.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					BUYGUBUN : BUYGUBUN
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['매입번호', '매입일자', '매입구분', '관리번호', '지역코드',
				          '지역구분', '시/도코드', '시/도구분',  '지목', '주소',
				          '원지주 성명', '주민번호', '분양면적', '잔여면적', '분양평수',
				          '잔여평수', '판매단가', '매입단가'],
				colModel:[
					{name:"BUYID",				index:'BUYID',			width:100,	align:'center', sortable:false}
					, {name:"BUYDATE",			index:'BUYDATE',		width:100,	align:'center', sortable:false}
					, {name:"BUYGUBUN",			index:'BUYGUBUN',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"MANAGENO",			index:'MANAGENO',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"CITYCODE",			index:'CITYCODE',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"CITYNAME",			index:'CITYNAME',		width:100,	align:'center', sortable:false}
					, {name:"BOROUGHCODE",		index:'BOROUGHCODE',	width:100,	align:'center', sortable:false, hidden:true}
					, {name:"BOROUGHNAME",		index:'BOROUGHNAME',	width:100,	align:'center', sortable:false}
					, {name:"USETYPE",			index:'USETYPE',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"ADDRESS",			index:'ADDRESS',		width:100,	align:'center', sortable:false}
					, {name:"OWNERNAME",		index:'OWNERNAME',		width:100,	align:'center', sortable:false}
					, {name:"OWNERJUMINID",		index:'OWNERJUMINID',	width:100,	align:'center', sortable:false}
					, {name:"CONBM2",			index:'CONBM2',			width:100,	align:'center', sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"CONJM2",			index:'CONJM2',			width:100,	align:'center', sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"CONBPY",			index:'CONBPY',			width:100,	align:'center', sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"CONJPY",			index:'CONJPY',			width:100,	align:'center', sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"PMDANGA",			index:'PMDANGA',		width:100,	align:'center', sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}, hidden:true}
					, {name:"BUYDANGA",			index:'BUYDANGA',		width:100,	align:'center', sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}, hidden:true}
				],
				rowNum:10000000,
				autowidth: true,
				shrinkToFit: false,
				rowList:[10,20,30],
				sortname: 'BUYDATE',
				viewrecords: true,
				sortorder:'asc',
				width: "96%",
				jsonReader: {
					repeatitems: false
				},
				height: '500px',
				onSelectRow: function(ids){
					
				} ,
				ondblClickRow: function(id,irow,icol,e) {
					var selRowData = $(this).jqGrid('getRowData', id);
					
					$("#MANAGENO",opener.document).val(selRowData.MANAGENO);
					$("#CITYCODE",opener.document).val(selRowData.CITYCODE);
					$("#ADDRESS",opener.document).val(selRowData.ADDRESS);
					$("#OWNERNAME",opener.document).val(selRowData.OWNERNAME);
					$("#OWNERJUMINID",opener.document).val(selRowData.OWNERJUMINID);
					$("#CONBM2",opener.document).val(selRowData.CONBM2);
					$("#CONJM2",opener.document).val(selRowData.CONJM2);
					$("#CONBPY",opener.document).val(selRowData.CONBPY);
					$("#CONJPY",opener.document).val(selRowData.CONJPY);
					//매입의 판매단가를 매출의 매매단가로 넣기
					$("#SALEDANGA",opener.document).val(selRowData.PMDANGA);
					
					//위탁일 경우 위탁수수료 계산을 위해 필요함
					$("#BUYDANGA",opener.document).val(selRowData.BUYDANGA);
					
					$("#CONBM2",opener.document).click();
					$("#CONJM2",opener.document).click();
					$("#CONBPY",opener.document).click();
					$("#CONJPY",opener.document).click();
					$("#SALEDANGA",opener.document).click();
					
					//매매대금 계산
					opener.f_saleAmtRule();
					
					//dc금액, 실판매가 계산
					opener.f_dangaRule();
					
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