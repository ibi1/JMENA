<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />
	
	<script type="text/javascript">
		$(document).ready(function(){
			f_selectBankMst();
		});
		
		function f_selectBankMst() {
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListBankMst.do",
				postData : {
					BANKNAME:$("#S_BANKNAME").val()
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['기관코드', '금융기관명', '사용여부', '확장코드'] ,
				colModel:[
					{name:"BANKCODE",		index:'BANKCODE',	width:60,	align:'center', sortable:false}
					, {name:"BANKNAME",		index:'BANKNAME',	width:60,	align:'center', sortable:false}
					, {name:"USEYN",		index:'USEYN',		width:60,	align:'center', sortable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"AUXCODE",		index:'AUXCODE',	width:60,	align:'center', sortable:false}
				] ,
				rowNum:100,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'BANKCODE' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(ids){
					var selRowData = $(this).jqGrid('getRowData', ids);
					
					v_ccode = selRowData.CCODE;
					
					$("#S_CCODE").val(selRowData.CCODE);
					$("#S_CCODENAME_B").val(selRowData.CCODENAME);
					
					f_selectCcodeDtl();
				} ,
				loadComplete: function() {
					
				},
				hidegrid: false
			});
		}
		
		$(function() {
			$("#selectButton").click(function() {
				f_selectBankMst();
			});
		})
		
		function f_selectKeyBankMst() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#selectButton").click();
			}
		}
	</script>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td><a class="ui-button ui-widget ui-corner-all" id="selectButton" name="selectButton">조회</a></td>
					<td><a class="ui-button ui-widget ui-corner-all" id="insertButton" name="insertButton">추가</a></td>
					<td><a class="ui-button ui-widget ui-corner-all" id="saveButton" name="saveButton">저장</a></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:96%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>금융기관</td>
					<td><input type="text" id="S_BANKNAME" name="S_BANKNAME" onkeydown="f_selectKeyBankMst();"/></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
	</div>
</body>
</html>