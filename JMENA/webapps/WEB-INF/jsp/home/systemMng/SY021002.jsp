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
	var DeptCode = "";
	$(document).ready(function(){
		f_selectListEnaBranchMst();
		f_selectListEnaDeptMst();
	});
		

	function f_selectListEnaBranchMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		
		$('#leftList').jqGrid({
			//caption: '지사및부서관리'
			url:"/home/selectListEnaBranchMst.do" ,
			datatype:"json" ,
			mtype: 'POST',
			postData : {
				BRANCHNAME : $("#LS_BRANCHNAME").val(),
				BRANCHCODE : $("#RS_BRANCHCODE").val()
			},
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['지사코드', '지사 명', '사용여부'] ,
			colModel:[
				{name:"BRANCHCODE",			index:'BRANCHCODE',		width:60,		align:'center'}
				, {name:"BRANCHNAME",		index:'BRANCHNAME',		width:60,		align:'center'}
				, {name:"USEYN",			index:'USEYN',			width:60,		align:'center'}
			] ,
			rowNum:100 ,
			autowidth: true ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			//height: '100%',
			jsonReader: {
				repeatitems: false
			},
			onSelectRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
		        
				$("#RS_BRANCHCODE").val(selRowData.BRANCHCODE);
				$("#RS_BRANCHNAME").val(selRowData.BRANCHNAME);
				$("#RS_USEYN").val(selRowData.USEYN);
				
				f_selectListEnaDeptMst();
			} ,
			hidegrid: false
		});

	}
	
	function f_selectListEnaDeptMst(){
		$('#rightList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#rightList').jqGrid({
			//caption: '지사및부서관리'
			url:"/home/selectListEnaDeptMst.do" ,
			datatype:"json" ,
			postData : {
				BRANCHCODE : $("#RS_BRANCHCODE").val()
			},
			mtype: 'POST',
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['부서코드', '부서명', '부서구분', '정렬순서', '사용여부', '비고'] ,
			colModel:[
				{name:"DEPTCODE",		index:'DEPTCODE',	width:60,	align:'center', editable:true}
				, {name:"DEPTNAME",		index:'DEPTNAME',	width:60,	align:'center', editable:true}
				, {name:"DEPTGUBUN",	index:'DEPTGUBUN',	width:60,	align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=001", buildSelect:selectListEnaDeptCode} }
				, {name:"SORTKEY",		index:'SORTKEY',	width:60,	align:'center', editable:true}
				, {name:"USEYN",		index:'USEYN',		width:60,	align:'center', editable:true, edittype:'select', editoptions:{value: "Y:Y;N:N"} }
				, {name:"REMARK",		index:'REMARK',		width:60,	align:'center', editable:true}
			] ,
			
			
			rowNum:100 ,
			autowidth: true ,
			//rowList:[10,20,30] ,
			sortname: 'DEPTCODE' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			//height: '100%' ,
			jsonReader: {
				repeatitems: false
			},
			onSelectRow : function(rowid) {
				$('#rightList').jqGrid('editRow',rowid,false);
			},
			loadComplete: function() {
				
			},			
			hidegrid: false
		});
	}
	
	function selectListEnaDeptCode(data){
		var jsonValue = $.parseJSON(data).dcodeList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
		});
		
		result +="</select>";

		return result;
	   	
	}
	
	$(function(){
		$("#selectButton").click(function(){
			$("#RS_BRANCHCODE").val("");
			$("#RS_BRANCHNAME").val("");
			$("#RS_USEYN").val("Y");
			
			$('#rightList').jqGrid('clearGridData');
			
			f_selectListEnaBranchMst();
		}) 
	})
	
	function f_selectBranchMst() {
		var keyCode = window.event.keyCode;
		if(keyCode==13) {
			$("#selectButton").click();
		}
	}
	
	$(function() {
		$("#searchButton").click(function() {
			$("#LS_BRANCHNAME").val("");
			f_selectListEnaBranchMst();
		});
	})
	
	function f_searchBranchCode() {
		var keyCode = window.event.keyCode;
		if(keyCode==13) {
			$("#searchButton").click();
		}
	}

	$(function() {
		$("#insertButton").click(function() {
			$("#LS_BRANCHNAME").val("");
			$("#RS_BRANCHCODE").val("");
			$("#RS_BRANCHNAME").val("");
			$("#RS_USEYN").val("Y");
			
			$("#RS_BRANCHCODE").focus();
			
			$('#rightList').jqGrid('clearGridData');
		});
	})
	
	$(function() {
		$("#saveButton").click(function() {
			var formData = $("#SY021002").serialize();
			var BRANCHCODE = $("#RS_BRANCHCODE").val();
			var BRANCHNAME = $("#RS_BRANCHNAME").val();
			var USEYN = $("#RS_USEYN").val();
			
			if(BRANCHCODE == ""){
				alert("지사코드를 입력하세요.");
				$("#RS_BRANCHCODE").focus();
				return false;
			}
			
			if(BRANCHNAME == ""){
				alert("지사명을 입력하세요.");
				$("#RS_BRANCHNAME").focus();
				return false;
			}
			
		   	$.ajax({ 
				type: 'POST' ,
				url: "/home/saveEnaBranchMst.do", 
				data : formData,
				datatype:"json" ,
				success: function(data){
					if(data.rows[0].MSG == "success")
					{
						alert("저장이 완료되었습니다.");
						f_selectListEnaBranchMst();
					}else{
						alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
					}
					
				},
				error:function(e){  
					alert("지사정보를 저장중 오류가 발생하였습니다.");
				}  
			});
			
		});
	})

	$(function() {
		$("#addButton").click(function() {
			
			
			$('#addButton').attr('style','visibility:hidden');
			$("#rightList").jqGrid('addRow',0);
			$('#rightList').jqGrid('editRow',0,false);
			
		});
	})

	$(function() {
		$("#saveButton2").click(function() {
			$('#rightList').jqGrid('restoreRow',0, true);

			
			var cellData = $("#rightList").jqGrid('getCell', 0, 'DEPTCODE');
			alert(cellData);
			
			var cellData2 = $("#rightList").jqGrid('getCell', 2, 'DEPTCODE');
			alert(cellData2);
			
			var DEPTCODE = $("#jqg1_DEPTCODE").val();
			alert(DEPTCODE);
			
			f_selectListEnaDeptMst();
			$('#addButton').attr('style','visibility:visible');
			
/* 			var DEPTCODE = $("#jqg1_DEPTCODE").val();
			var DEPTNAME = $("#jqg1_DEPTNAME").val();
			var BRANCHCODE = $("#RS_BRANCHCODE").val();
			var DEPTGUBUN = $("#jqg1_DEPTGUBUN").val();
			var SORTKEY = $("#jqg1_SORTKEY").val();
			var USEYN = $("#jqg1_USEYN").val();
			var REMARK = $("#jqg1_REMARK").val();
			
			if(DEPTCODE==''){
				alert("부서 코드값을 입력하세요.");
				return false;
			}
			if(DEPTNAME==''){
				alert("부서이름을 입력하세요.");
				return false;
			}
			if(BRANCHCODE==''){
				alert("지사코드를 입력하세요.");
				return false;
			}
			if(DEPTGUBUN==''){
				alert("부서 구분을 입력하세요.");
				return false;
			}
			if(USEYN==''){
				alert("사용여부를 입력하세요.");
				return false;
			}
			
 		   	$.ajax({ 
				type: 'POST' ,
				url: "/home/saveEnaDeptMst.do", 
				data : {
					DEPTCODE : DEPTCODE,
					DEPTNAME : DEPTNAME,
					BRANCHCODE : BRANCHCODE,
					DEPTGUBUN : DEPTGUBUN,
					SORTKEY : SORTKEY,
					USEYN : USEYN,
					REMARK : REMARK
				},
				datatype:"json" ,
				success: function(data){
					if(data.rows[0].MSGCODE == "0000")
					{
						alert("부서 구분이 중복되어 저장되지 않습니다.\n\n부서구분을 확인하세요.");
						f_selectListEnaDeptMst();
					}else{
						if(data.rows[0].MSG == "success"){
							alert("저장이 완료되었습니다.");
							$('#addButton').attr('style','visibility:visible');
							f_selectListEnaDeptMst();
						}else{
							alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
						}
					}
				},
				error:function(e){  
					alert("부서정보를 저장중 오류가 발생하였습니다.");
				}  
			});
 */			
		});
	})
	
	
</script>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<td align="right">
						<a class="ui-button ui-widget ui-corner-all" id="selectButton" name="selectButton">조회</a>
						<a class="ui-button ui-widget ui-corner-all" id="insertButton" name="insertButton">추가</a>
						<a class="ui-button ui-widget ui-corner-all" id="saveButton" name="saveButton">저장</a>
					</td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>지사명</td>
					<td><input type="text" id="LS_BRANCHNAME" name="LS_BRANCHNAME" onkeydown="f_selectBranchMst();"/></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<form id="SY021002">
				<table class="blueone">
					<tr>
						<td>지사코드</td>
						<td><input type="text" id="RS_BRANCHCODE" name="RS_BRANCHCODE" onkeydown="f_searchBranchCode();"/>&nbsp;<a class="ui-button ui-widget ui-corner-all" id="searchButton" name="searchButton">=></a></td>
					</tr>
					<tr>
						<td>지사명</td>
						<td><input type="text" id="RS_BRANCHNAME" name="RS_BRANCHNAME" /></td>
					</tr>
					<tr>
						<td>사용여부</td>
						<td>
							<select id="RS_USEYN" name="RS_USEYN" style="width:50px;">
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</td>
					</tr>
				</table>
			</form>
			<br/>
			<div id="topDiv2" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
				<table width="99%">
					<tr>
						<td align="right">
							<a class="ui-button ui-widget ui-corner-all" id="addButton" name="addButton">추가</a>
							<a class="ui-button ui-widget ui-corner-all" id="saveButton2" name="saveButton2">저장</a>
						</td>
					</tr>
				</table>
			</div>
			<br/>			
			<br/>
			<br/>
			<table id="rightList"></table>
		</div>
	</div>
</body>
</html>