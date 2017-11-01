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
		var v_rightLastSel = 0;		//오른쪽 그리드 선택 id
	
		$(document).ready(function(){
			
			$("#S_FLAG_L").val("I");	//I : 저장, U : 수정
			$("#S_FLAG_R").val("U");	//I : 저장, U : 수정
			
			f_selectSysMst();
			f_selectSysDtl();
		});
	
		function f_selectSysMst() {
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				//caption: '시스템 및 메뉴관리' ,
				url:"/home/selectListSysMst.do" ,
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['시스템코드', '시스템 명', '정렬순서'] ,
				colModel:[
					{name:"SYSID",			index:'SYSID',		width:60,		align:'center', sortable:false, editable:true, edittype:'text'}
					,{name:"SYSNAME",		index:'SYSNAME',	width:60,		align:'center', sortable:false, editable:true, edittype:'text'}
					,{name:"SORTKEY",		index:'SORTKEY',	width:60,		align:'center', sortable:false, editable:true, edittype:'text'}
					] ,
				rowNum:10 ,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'SORTKEY' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(ids){
					$("#S_FLAG_L").val("U");
					
					var selRowData = $(this).jqGrid('getRowData', ids);
										
					$("#S_SYSID").val(selRowData.SYSID);
					$("#S_SYSNAME").val(selRowData.SYSNAME);
					$("#S_SORTKEY").val(selRowData.SORTKEY);
					
					$("#rightInsertButton").attr("style", "visibility");
					$("#rightSaveButton").attr("style", "visibility");
					
					f_selectSysDtl(selRowData.SYSID);
				} ,
				loadComplete : function() {
					v_rightLastSel = 0;
				},
				hidegrid: false
			});
		}
		
		function f_selectSysDtl(sysId) {
			$(function() {
				$('#rightList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
				
				$('#rightList').jqGrid({
					//caption: '시스템 및 메뉴관리' ,
					url:"/home/selectListSysDtl.do" ,
					postData : {
						SYSID : sysId
					},
					datatype:"json" ,
					mtype: 'POST',
					loadtext: '로딩중...',
					loadError:function(){alert("Error~!!");} ,
					colNames:['메뉴코드', '메뉴명', '사용여부', '비고', '정렬순서'] ,
					colModel:[
						{name:"MENUID",			index:'MENUID',		width:60,		align:'center', sortable:false, editable:true}
						, {name:"MENUNAME",		index:'MENUNAME',	width:60,		align:'center', sortable:false, editable:true}
						, {name:"USEYN",		index:'USEYN',		width:60,		align:'center', sortable:false, editable:true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
						, {name:"REMARK",		index:'REMARK',		width:60,		align:'center', sortable:false, editable:true}
						, {name:"SORTKEY",		index:'SORTKEY',	width:60,		align:'center', sortable:false, editable:true}
						] ,
					rowNum:10 ,
					autowidth: true ,
					rowList:[10,20,30] ,
					//pager: $('#rightNav') ,
					sortname: 'SORTKEY' ,
					viewrecords: true ,
					sortorder:'asc' ,
					width: "96%" ,
					jsonReader: {
						repeatitems: false
					},
					//height: '100%' ,
					onSelectRow: function(id){
						$("#rightInsertButton").attr("style", "visibility");
						$("#S_FLAG_R").val("U");
						if( v_rightLastSel != id ){
					        jQuery(this).jqGrid('restoreRow',v_rightLastSel,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
					        jQuery(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

					        v_rightLastSel = id;
						}
					} ,
					hidegrid: false
				});
			})
		}
		
		$(function() {
			$("#sysSearchButton").click(function(){
				var isNew = true;
				v_rightLastSel = 0;
				
				var sysId = $("#S_SYSID").val();
				
				var ids = jQuery("#leftList").jqGrid('getDataIDs');
				
				ids.some(function(currentValue, index, array){
					var cellData = $("#leftList").jqGrid('getCell', ids[index], 'SYSID');
					if (cellData == sysId) {
						isNew = false;
		        		$("#leftList").jqGrid('setSelection', ids[index]);
		    			return true;
		        	}	        
				});
				
				if (isNew == true) {
					$("#S_FLAG_L").val("I");
					
					$("#S_SYSNAME").val("");
					$("#S_SYSNAME").focus();
					$("#S_SORTKEY").val("");
				}
			});
		})
		
		function f_s_sysMstSelection() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#sysSearchButton").click();
			}
		}
		
		$(function() {
			$("#selectButton").click(function() {
				$("#S_SYSID").val("");
				$("#S_SYSNAME").val("");
				$("#S_SORTKEY").val("");
				$('#rightList').jqGrid("clearGridData", true);
				
				$("#rightInsertButton").attr("style", "visibility:hidden");
				$("#rightSaveButton").attr("style", "visibility:hidden");
				
				f_selectSysMst();
			});
		})
		
		$(function() {
			$("#insertButton").click(function() {
				$("#S_FLAG_L").val("I");
				
				$("#S_SYSID").val("");
				$("#S_SYSNAME").val("");
				$("#S_SORTKEY").val("");
				$("#leftList").jqGrid("resetSelection");
				
				$("#S_SYSID").focus();
			});
		})
		
		$(function() {
			$("#saveButton").click(function() {
				if ($("#S_SYSID").val() == "") {
					alert("시스템코드를 입력하셔야 합니다.");
					$("#S_SYSID").focus();
					return false;
				}
				
				if ($("#S_SYSNAME").val() == "") {
					alert("시스템 명을 입력하셔야 합니다.");
					$("#S_SYSNAME").focus();
					return false;
				}
				
				if ($("#S_SORTKEY").val() == "") {
					alert("정렬순서를 입력하셔야 합니다.");
					$("#S_SORTKEY").focus();
					return false;
				}
				
				var msg = "";
				if ($("#S_FLAG_L").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					$.ajax({ 
						type: 'POST' ,
						data: $("#SY011001").serialize(),
						url: "/home/insertDataSysMst.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							if (data.resultCode == "SUCCESS") {
								f_selectSysMst();
							} else {
								$("#S_SYSID").focus();
							}
						},
						error:function(e){  
							alert("[ERROR]System 저장  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
		
		function f_sysMstSave() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#saveButton").click();
			}
		}
		
		///////////////RIGHT BUTTON/////////////////////////
		$(function() {
			$("#rightInsertButton").click(function() {
				$("#S_FLAG_R").val("I");
				
				$("#rightList").jqGrid("addRow", 0);
				$(this).attr("style", "visibility:hidden");
			});
		})
		
		$(function() {
			$("#rightSaveButton").click(function() {
				var ids = $("#rightList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				$('#rightList').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#rightList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
				
				if (cellData.MENUID == "") {
					alert("메뉴 코드를 입력하셔야 합니다.");
					
					$('#rightList').jqGrid('editRow', ids, true);
					$("#"+ids+"_MENUID").focus();
					
					return false;
				}
				
				if (cellData.MENUNAME == "") {
					alert("메뉴 명을 입력하셔야 합니다.");
					
					$('#rightList').jqGrid('editRow', ids, true);
					$("#"+ids+"_MENUNAME").focus();
					
					return false;
				}
				
				if (cellData.SORTKEY == "") {
					alert("정렬 순서를 입력하셔야 합니다.");
					
					$('#rightList').jqGrid('editRow', ids, true);
					$("#"+ids+"_SORTKEY").focus();
					
					return false;
				}
				
				var msg = "";
				if ($("#S_FLAG_R").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					var formData = "S_FLAG_R=" + $("#S_FLAG_R").val() + "&SYSID=" + $("#S_SYSID").val() + "&MENUID=" + cellData.MENUID + "&MENUNAME=" + cellData.MENUNAME + "&USEYN=" + cellData.USEYN + "&REMARK=" + cellData.REMARK + "&SORTKEY=" + cellData.SORTKEY;
					
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/insertDataSysDtl.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG_R").val("U");
							v_rightLastSel = 0;
							
							alert(data.resultMsg);
							
							$("#rightInsertButton").attr("style", "visibility");
							$("#sysSearchButton").click();
						},
						error:function(e){  
							alert("[ERROR]Menu 저장  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
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
			<table id="leftList"></table>
			<div id="leftNav"></div>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<form id="SY011001">
				<input type="hidden" id="S_FLAG_L" NAME="S_FLAG_L" />
				<table class="blueone">
					<tr>
						<td>시스템코드</td>
						<td><input type="text" id="S_SYSID" name="S_SYSID" onkeydown="f_s_sysMstSelection();" />&nbsp;<a class="ui-button ui-widget ui-corner-all" id="sysSearchButton" name="sysSearchButton">=></a></td>
					</tr>
					<tr>
						<td>시스템 명</td>
						<td><input type="text" id="S_SYSNAME" name="S_SYSNAME" /></td>
					</tr>
					<tr>
						<td>정렬순서</td>
						<td><input type="text" id="S_SORTKEY" name="S_SORTKEY" onkeydown="f_sysMstSave();"/></td>
					</tr>
				</table>
				</form>
			<input type="hidden" id="S_FLAG_R" NAME="S_FLAG_R" />
			<table class="blueone">
				<tr>
					<td><a class="ui-button ui-widget ui-corner-all" id="rightInsertButton" name="rightInsertButton" style="visibility: hidden;">추가</a></td>
					<td><a class="ui-button ui-widget ui-corner-all" id="rightSaveButton" name="rightSaveButton" style="visibility: hidden;">저장</a></td>
				</tr>
			</table>
		<table id="rightList"></table>
			<div id="rightNav"></div>
		</div>
	</div>
</body>
</html>