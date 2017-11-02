<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

</head>
<script type="text/javascript">
	var BoroughCode = "";
	$(document).ready(function(){
		
		f_selectListEnaCityMst();
		f_selectListEnaCityDtl();		
	});


	function f_selectListEnaCityMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '지역관리'
			url:"/home/selectListEnaCityMst.do" ,
			datatype:"json" ,
			mtype: 'POST',
			postData : {
				CITYCODE : $("#RS_CITYCODE").val()
			},
			loadError:function(){alert("Error~!!");} ,
			colNames:['시/도 코드', '시/도 명', '정렬순서'] ,
			colModel:[
				{name:"CITYCODE",		index:'CITYCODE',		width:60,		align:'center'}
				, {name:"CITYNAME",		index:'CITYNAME',		width:60,		align:'center'}
				, {name:"SORTKEY",		index:'SORTKEY',		width:60,		align:'center'}
			] ,
			rowNum:100 ,
			autowidth: true ,
			rowList:[10,20,30] ,
			sortname: 'SORTKEY' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			//height: '100%' ,
			jsonReader: {
				repeatitems: false
			},
			onSelectRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
		        
				$("#RS_CITYCODE").val(selRowData.CITYCODE);
				$("#RS_CITYNAME").val(selRowData.CITYNAME);
				$("#RS_SORTKEY").val(selRowData.SORTKEY);
				
				f_selectListEnaCityDtl(selRowData.CITYCODE);
			} ,
			hidegrid: false
		});
	}
	
	function f_selectListEnaCityDtl(){
		$('#rightList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#rightList').jqGrid({
			//caption: '지역관리'
			url:"/home/selectListEnaCityDtl.do" ,
			datatype:"json" ,
			mtype: 'POST',
			postData : {
				CITYCODE : $("#RS_CITYCODE").val()
			},
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['시/구/군 코드', '시/구/군 명', '사용여부', '비고', '정렬순서'] ,
			colModel:[
				{name:"BOROUGHCODE",	index:'BOROUGHCODE',	width:60,	align:'center', editable:true}
				, {name:"BOROUGHNAME",	index:'BOROUGHNAME',	width:60,	align:'center', editable:true}
				, {name:"USEYN",		index:'USEYN',			width:60,	align:'center', editable:true, edittype:'select', editoptions:{value: "Y:Y;N:N"} }
				, {name:"REMARK",		index:'REMARK',			width:60,	align:'center', editable:true}
				, {name:"SORTKEY",		index:'SORTKEY',		width:60,	align:'center', editable:true}
			] ,
			rowNum:100 ,
			autowidth: true ,
			rowList:[10,20,30] ,
			sortname: 'BOROUGHCODE' ,
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
			hidegrid: false
		});
	}
	
	$(function(){
		$("#selectButton").click(function(){
			$("#RS_CITYCODE").val("");
			$("#RS_CITYNAME").val("");
			$("#RS_SORTKEY").val("");
			
			$('#rightList').jqGrid('clearGridData');
			
			f_selectListEnaCityMst();
		}) 
	})
	
	$(function() {
		$("#searchButton").click(function() {
			f_selectListEnaCityMst();
		});
	})
	
	$(function() {
		$("#insertButton").click(function() {
			$("#RS_CITYCODE").val("");
			$("#RS_CITYNAME").val("");
			$("#RS_SORTKEY").val("");
			
			$("#RS_CITYCODE").focus();
			
			$('#rightList').jqGrid('clearGridData');
		});
	})

	$(function() {
		$("#saveButton").click(function() {
			var formData = $("#SY021003").serialize();
			var CITYCODE = $("#RS_CITYCODE").val();
			var CITYNAME = $("#RS_CITYNAME").val();
			var SORTKEY = $("#RS_SORTKEY").val();
			
			if(CITYCODE == ""){
				alert("시/도코드를 입력하세요.");
				$("#RS_CITYCODE").focus();
				return false;
			}
			
			if(CITYNAME == ""){
				alert("시도 명을 입력하세요.");
				$("#RS_CITYNAME").focus();
				return false;
			}
			
		   	$.ajax({ 
				type: 'POST' ,
				url: "/home/saveEnaCityMst.do", 
				data : formData,
				datatype:"json" ,
				success: function(data){
					if(data.rows[0].MSG == "success")
					{
						alert("저장이 완료되었습니다.");
						f_selectListEnaCityMst();
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

			
			var cellData = $("#rightList").jqGrid('getCell', 0, 'BOROUGHCODE');
			alert(cellData);
			
			var cellData2 = $("#rightList").jqGrid('getCell', 2, 'BOROUGHCODE');
			alert(cellData2);
			
			var DEPTCODE = $("#jqg1_BOROUGHCODE").val();
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
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<form id="SY021003">
				<table class="blueone">
					<tr>
						<td>시/도 코드</td>
						<td><input type="text" id="RS_CITYCODE" name="RS_CITYCODE" />&nbsp;<a class="ui-button ui-widget ui-corner-all" id="searchButton" name="searchButton">=></a></td>
					</tr>
					<tr>
						<td>시도 명</td>
						<td><input type="text" id="RS_CITYNAME" name="RS_CITYNAME" /></td>
					</tr>
					<tr>
						<td>정렬순서</td>
						<td><input type="text" id="RS_SORTKEY" name="RS_SORTKEY" /></td>
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