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
		var v_ccode = "null";
		
		$(document).ready(function(){
			f_selectCcodeMst();
			f_selectCcodeDtl();
		});
		
		function f_selectCcodeMst() {
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListCcodeMst.do",
				postData : {
					CCODENAME:$("#S_CCODENAME_L").val()
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['공통코드', '공통코드 명'] ,
				colModel:[
					{name:"CCODE",			index:'CCODE',			width:60,		align:'center', sortable:false}
					, {name:"CCODENAME",	index:'CCODENAME',		width:60,		align:'center', sortable:false}
				] ,
				rowNum:100,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'CCODE' ,
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
		
		function f_selectCcodeDtl() {
			$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#bottomList').jqGrid({
				url:"/home/selectListCcodeDtl.do",
				postData : {
					CCODE:v_ccode
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['상세코드', '상세코드명', '사용여부', '정렬순서', 
							'비고', '관리구분1', '관리구분1명', '관리구분2', 
							'관리구분2명', '관리구분3', '관리구분3명', '관리구분4', '관리구분4명'] ,
				colModel:[
					{name:"DCODE",			index:'DCODE',		width:60,		align:'center', sortable:false}
					, {name:"DCODENAME",	index:'DCODENAME',	width:60,		align:'center', sortable:false}
					, {name:"USEYN",		index:'USEYN',		width:60,		align:'center', sortable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"SORTKEY",		index:'SORTKEY',	width:60,		align:'center', sortable:false}
					, {name:"REMARK",		index:'REMARK',		width:60,		align:'center', sortable:false}
					, {name:"AUX1",			index:'AUX1',		width:60,		align:'center', sortable:false}
					, {name:"AUX1DESC",		index:'AUX1DESC',	width:60,		align:'center', sortable:false}
					, {name:"AUX2",			index:'AUX2',		width:60,		align:'center', sortable:false}
					, {name:"AUX2DESC",		index:'AUX2DESC',	width:60,		align:'center', sortable:false}
					, {name:"AUX3",			index:'AUX3',		width:60,		align:'center', sortable:false}
					, {name:"AUX3DESC",		index:'AUX3DESC',	width:60,		align:'center', sortable:false}
					, {name:"AUX4",			index:'aux4',		width:60,		align:'center', sortable:false}
					, {name:"AUX4DESC",		index:'AUX4DESC',	width:60,		align:'center', sortable:false}
				] ,
				rowNum:100,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'DCODE' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(ids){
			
				} ,
				loadComplete: function() {
					
				},
				hidegrid: false
			});
		}
		
		$(function() {
			$("#selectButton").click(function() {
				$("#S_CCODE").val("");
				$("#S_CCODENAME_B").val("");
				$('#bottomList').jqGrid("clearGridData", true);
				f_selectCcodeMst();
			});
		})
		
		function f_selectKeyCcodeMst() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#selectButton").click();
			}
		}
		
		$(function() {
			$("#s_ccodeSearchButton").click(function() {
				var s_ccode = $("#S_CCODE").val();
				
				var ids = jQuery("#leftList").jqGrid('getDataIDs');
				
				ids.some(function(currentValue, index, array){
					var cellData = $("#leftList").jqGrid('getCell', ids[index], 'CCODE');
					if (cellData == s_ccode) {
		        		$("#leftList").jqGrid('setSelection', ids[index]);
		    			return true;
		        	}	        
				});
			});
		})
		
		function f_s_ccodeMstSelection() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#s_ccodeSearchButton").click();
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
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>공통코드명</td>
					<td><input type="text" id="S_CCODENAME_L" name="S_CCODENAME_L" onkeydown="f_selectKeyCcodeMst();"/></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>공통코드</td>
					<td><input type="text" id="S_CCODE" name="S_CCODE" onkeydown="f_s_ccodeMstSelection();" />&nbsp;<a class="ui-button ui-widget ui-corner-all" id="s_ccodeSearchButton" name="s_ccodeSearchButton">=></a></td>
				</tr>
				<tr>
					<td>공통코드명</td>
					<td><input type="text" id="S_CCODENAME_B" name="S_CCODENAME_B" /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table id="bottomList"></table>
		</div>
	</div>
</body>
</html>