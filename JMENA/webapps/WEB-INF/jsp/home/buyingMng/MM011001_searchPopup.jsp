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
			var BUYDATE = $("#BUYDATE",opener.document).val();
			
			f_selectListMMBuyMstPopup(BUYDATE);
		});
		
		function f_selectListMMBuyMstPopup(BUYDATE){
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListMMBuyMstPopup.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					BUYDATE : BUYDATE
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['계약일자', '계약번호', '매입구분', '관리번호', '지역', '주소'],
				colModel:[
					{name:"BUYDATE",			index:'BUYDATE',		width:100,	align:'center', sortable:false}
					, {name:"BUYID",			index:'BUYID',			width:100,	align:'center', sortable:false}
					, {name:"BUYGUBUN",			index:'BUYGUBUN',		width:100,	align:'center', sortable:false}
					, {name:"MANAGENO",			index:'MANAGENO',		width:100,	align:'center', sortable:false}
					, {name:"CITYNAME",			index:'CITYNAME',		width:100,	align:'center', sortable:false}
					, {name:"ADDRESS",			index:'ADDRESS',		width:100,	align:'center', sortable:false}
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
					
					$("#LS_BUYDATE_FR",opener.document).val(selRowData.BUYDATE);
					$("#LS_BUYDATE_TO",opener.document).val(selRowData.BUYDATE);
					$("#BUYID",opener.document).val(selRowData.BUYID);
					
					opener.f_selectListEnaBuyMst();
					
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