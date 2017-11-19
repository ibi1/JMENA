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
		var g_menuId1 = "ALL";
		var g_menuId2 = "ALL";
		
		$(document).ready(function(){
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			
			$("#sysSearchButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
			
			//$("#S_SYSIDCOMBO_L").jqxComboBox({theme: 'energyblue', autoDropDownHeight: true,  height: 25, width: 120});
			//$("#S_MENUIDCOMBO_L").jqxComboBox({theme: 'energyblue', autoDropDownHeight: true,  height: 25, width: 120});
			$("#S_PGMNAME_L").jqxInput({theme: 'energyblue', height: 25, width: 250});
			//$("#S_SYSIDCOMBO_R").jqxComboBox({theme: 'energyblue', autoDropDownHeight: true,  height: 25, width: 120});
			//$("#S_MENUIDCOMBO_R").jqxComboBox({theme: 'energyblue', autoDropDownHeight: true,  height: 25, width: 120});
			$("#S_PGMID_R").jqxInput({theme: 'energyblue', height: 25, width: 100});
			$("#S_PGMNAME_R").jqxInput({theme: 'energyblue', height: 25, width: 250});
			$("#S_REMARK").jqxInput({theme: 'energyblue', height: 25, width: 100});
			//s$("#S_USEYN").jqxComboBox({theme: 'energyblue', autoDropDownHeight: true,  height: 25, width: 100});
			$("#S_SORTKEY").jqxInput({theme: 'energyblue', height: 25, width: 100});
			
			
			$("#S_FLAG").val("U");
			
		   	//시스템 메뉴 호출 (SY011001 데이터 사용)
		   	$.ajax({ 
				type: 'POST' ,
				url: "/home/selectListSysMst.do", 
				dataType : 'json' , 
				success: function(data){
					var inHtml = "";
					
					data.rows.forEach(function(currentValue, index, array){
						inHtml += "<option value='" + currentValue.SYSID + "'>" + currentValue.SYSNAME + "</option>\n";
					});
					
					$("#S_SYSIDCOMBO_L").append(inHtml);
					$("#S_SYSIDCOMBO_R").append(inHtml);
					
					$("#S_SYSIDCOMBO_L").change();
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});

		   	
		});
		
		$(function(){
			$("#S_SYSIDCOMBO_L").change(function() {
				g_menuId1 = "ALL";	//콤보에서 선택 시 무조건 전체를 선택하게 하기
				
				$("#S_MENUIDCOMBO_L").empty().data('options');
				
				if ($(this).val() == "ALL") {
					var inHtml = "";
					
					inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
					
					$("#S_MENUIDCOMBO_L").append(inHtml);
					
					f_selectPgmList();	//그리드 가져오기
				} else {
					//메뉴 호출 (SY011001 데이터 사용)
					$.ajax({ 
						type: 'POST',
						data: "SYSID=" + $(this).val(),
						url: "/home/selectListSysDtl.do", 
						dataType : 'json' , 
						success: function(data){
							var inHtml = "";
							var selected = "";
							 
							if (g_menuId1 == "ALL") {
								selected = "selected='selected'";
							}
							inHtml += "<option value='ALL' " + selected + ">전체</option>\n";
							
							data.rows.forEach(function(currentValue, index, array){
								selected = (g_menuId1 == currentValue.MENUID) ? "selected='selected'" : "";
								
								inHtml += "<option value='" + currentValue.MENUID + "' " + selected + ">" + currentValue.MENUNAME + "</option>\n";
							});
	
							$("#S_MENUIDCOMBO_L").append(inHtml);
							
							f_selectPgmList();	//그리드 가져오기
						},
						error:function(e){  
							alert("[ERROR]Menu Combo 호출 중 오류가 발생하였습니다.");
						}  
					});
				}
			});
			
			$("#S_SYSIDCOMBO_R").change(function() {
				g_menuId2 = "ALL";	//콤보에서 선택 시 무조건 전체를 선택하게 하기
				
				$("#S_MENUIDCOMBO_R").empty().data('options');
				
				if ($("#S_SYSIDCOMBO_R").val() == "ALL") {
					var inHtml = "";
					
					inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
					
					$("#S_MENUIDCOMBO_R").append(inHtml);
				} else {
					//메뉴 호출 (SY011001 데이터 사용)
					$.ajax({ 
						type: 'POST',
						data: "SYSID=" + $("#S_SYSIDCOMBO_R").val(),
						url: "/home/selectListSysDtl.do", 
						dataType : 'json' , 
						success: function(data){
							var inHtml = "";
							var selected = "";
							 
							if (g_menuId2 == "ALL") {
								selected = "selected='selected'";
							}
							
							inHtml += "<option value='ALL' " + selected + ">전체</option>\n";
						
							data.rows.forEach(function(currentValue, index, array){
								selected = (g_menuId2 == currentValue.MENUID) ? "selected='selected'" : "";
								
								inHtml += "<option value='" + currentValue.MENUID + "' " + selected + ">" + currentValue.MENUNAME + "</option>\n";
							});
	
							$("#S_MENUIDCOMBO_R").append(inHtml);
						},
						error:function(e){  
							alert("[ERROR]Menu Combo 호출 중 오류가 발생하였습니다.");
						}  
					});
				}
			});	
		})
		
		$(function(){
			$("#S_MENUIDCOMBO_L").change(function() {
				f_selectPgmList();
			});	
		})
		
		function f_selectPgmList() {
			$(function() {
				$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
				
				$("#leftList").jqGrid({
					url:"/home/selectListMenuPgmTb.do" ,
					postData : {
						SYSID:$("#S_SYSIDCOMBO_L option:selected").val(),MENUID:$("#S_MENUIDCOMBO_L option:selected").val()
					},
					datatype:"json" ,
					mtype: 'POST',
					loadtext: '로딩중...',
					loadError:function(){alert("Error~!!");} ,
					colNames:['시스템ID', '시스템구분', '메뉴ID', '메뉴구분', '프로그램ID', '프로그램명', '메뉴정렬키', '비고', '사용여부'] ,
					colModel:[
						{name:"SYSID",			index:'SYSID',			width:80,		align:'center', sortable:false, hidden: true}
						, {name:"SYSNAME",		index:'SYSNAME',		width:200,		align:'center', sortable:false}
						, {name:"MENUID",		index:'MENUID',			width:80,		align:'center', sortable:false, hidden: true}
						, {name:"MENUNAME",		index:'MENUNAME',		width:200,		align:'center', sortable:false}
						, {name:"PGMID",		index:'PGMID',			width:100,		align:'center', sortable:false}
						, {name:"PGMNAME",		index:'PGMNAME',		width:200,		align:'center', sortable:false}
						, {name:"SORTKEY",		index:'SORTKEY',		width:80,		align:'center', sortable:false}
						, {name:"REMARK",		index:'REMARK',			width:250,		align:'center', sortable:false}
						, {name:"USEYN",		index:'USEYN',			width:80,		align:'center', sortable:false}
					] ,
					rowNum:100,
					autowidth: true ,
					shrinkToFit: false,
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
						$("#S_FLAG").val("U");
						
						var selRowData = $(this).jqGrid('getRowData', id);
						
						$("#S_SYSIDCOMBO_R").val(selRowData.SYSID).attr("selected", "selected").trigger("change");
						
						g_menuId2 = selRowData.MENUID;	//메뉴아이디 무조건 셋팅
						
						$("#S_PGMNAME_L").val(selRowData.PGMNAME);
						$("#S_PGMID_R").val(selRowData.PGMID);
						$("#S_PGMNAME_R").val(selRowData.PGMNAME);
						$("#S_REMARK").val(selRowData.REMARK);
						$("#S_USEYN").val(selRowData.USEYN).attr("selected", "selected");
						$("#S_SORTKEY").val(selRowData.SORTKEY);
					} ,
					loadComplete: function() {
						if($("#S_PGMID_R").val() != "") {
							var ids = $("#leftList").jqGrid('getDataIDs');
			
							ids.some(function(currentValue, index, array){
								var cellData = $("#leftList").jqGrid('getCell', ids[index], 'PGMID');
								if (cellData == $("#S_PGMID_R").val()) {
					        		$("#leftList").jqGrid('setSelection', ids[index]);
					    			return true;
					        	} else {
					        		//없을 경우 신규 데이터 입력으로...
					        		$("#S_FLAG").val("I");
					        		
					        		$("#S_PGMNAME_R").val("").focus();
					        		$("#S_REMARK").val("");
					        		$("#S_USEYN").val("Y").attr("selected", "selected");
					        		$("#S_SORTKEY").val("");
					        	}        
							});
						}
					},
					hidegrid: false
				});
			})
		}
		
		$(function() {
			$("#pgmSearchButton").click(function(){
				var sysId = $("#S_SYSIDCOMBO_R").val();
				
				var menuId = $("#S_MENUIDCOMBO_R").val();
				
				$("#S_SYSIDCOMBO_L").val(sysId).attr("selected", "selected").trigger("change");
				
				g_menuId1 = menuId;	//메뉴아이디 무조건 셋팅
			});
		})
		
		function f_s_pgmIdSelection() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#pgmSearchButton").click();
			}
		}
		
		function f_clear() {
			$("#S_SYSIDCOMBO_L").val("ALL").attr("selected", "selected").trigger("change");
			$("#S_SYSIDCOMBO_R").val("ALL").attr("selected", "selected").trigger("change");
			$("#S_PGMID_R").val("");
			$("#S_PGMNAME_L	").val("");
			$("#S_PGMNAME_R").val("");
			$("#S_REMARK").val("");
			$("#S_USEYN").val("Y").attr("selected", "selected");
			$("#S_SORTKEY").val("");
		}
		
		$(function() {
			$("#selectButton").click(function() {
				$("#S_FLAG").val("U");
				
				f_clear();
				
				f_selectPgmList();
			});
		})
		
		$(function() {
			$("#insertButton").click(function() {
				$("#S_FLAG").val("I");
				
				f_clear();
				
				$("#S_SYSIDCOMBO_R").focus();
			});
		})
		
		$(function() {
			$("#saveButton").click(function() {
				if ($("#S_SYSIDCOMBO_R").val() == "ALL") {
					alert("시스템구분을 선택셔야 합니다.");
					$("#S_SYSIDCOMBO_R").focus();
					return false;
				}
				
				if ($("#S_MENUIDCOMBO_R").val() == "ALL") {
					alert("메뉴구분을 선택셔야 합니다.");
					$("#S_MENUIDCOMBO_R").focus();
					return false;
				}
				
				if ($("#S_PGMID_R").val() == "") {
					alert("프로그램ID를 입력하셔야 합니다.");
					$("#S_PGMID_R").focus();
					return false;
				}
				
				if ($("#S_PGMNAME_R").val() == "") {
					alert("프로그램명을 입력하셔야 합니다.");
					$("#S_PGMNAME_R").focus();
					return false;
				}
				
				if ($("#S_SORTKEY").val() == "") {
					alert("정렬순서를 입력하셔야 합니다.");
					$("#S_SORTKEY").focus();
					return false;
				}
				
				var msg = "";
				if ($("#S_FLAG").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					$.ajax({ 
						type: 'POST' ,
						data: $("#SY011002").serialize(),
						url: "/home/insertDataPgmTb.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG").val("U");
							
							alert(data.resultMsg);
							
							$("#pgmSearchButton").click();
						},
						error:function(e){  
							alert("[ERROR]프로그램 저장  중 오류가 발생하였습니다.");
						}  
					});
				
				}
			});
		})
		
		function f_saveKeyDown() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#saveButton").click();
			}
		}
	</script>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id='selectButton' /></td>
					<td><input type="button" value="추가" id='insertButton' /></td>
					<td><input type="button" value="저장" id='saveButton' /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:58%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">시스템구분</th>
					<td>
						<select id="S_SYSIDCOMBO_L" name="S_SYSIDCOMBO_L">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>메뉴구분</th>
					<td>
						<select id="S_MENUIDCOMBO_L" name="S_MENUIDCOMBO_L">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>프로그램명</th>
					<td><input type="text" id="S_PGMNAME_L" name="S_PGMNAME_L" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
			<div id="leftNav"></div>
		</div>
		<div id="rightDiv" style="width:38%; float:left; padding: 10px" align="left">
			<form id="SY011002">
			<input type="hidden" id="S_FLAG" name="S_FLAG" />
			<table>
				<tr>
					<th width="120">시스템구분</tH>
					<td colspan="2">
						<select id="S_SYSIDCOMBO_R" name="S_SYSIDCOMBO_R">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>메뉴구분</th>
					<td colspan="2">
						<select id="S_MENUIDCOMBO_R" name="S_MENUIDCOMBO_R">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>프로그램ID</th>
					<td width="100"><input type="text" id="S_PGMID_R" name="S_PGMID_R" onkeydown="f_s_pgmIdSelection();" /></td>
					<td><input type="button" id='sysSearchButton' /></td>
					
				</tr>
				<tr>
					<td></td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<th>프로그램명</th>
					<td colspan="2"><input type="text" id="S_PGMNAME_R" name="S_PGMNAME_R" /></td>
				</tr>
				<tr>
					<th>비고</th>
					<td colspan="2"><input type="text" id="S_REMARK" name="S_REMARK" /></td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td colspan="2">
						<select id="S_USEYN" name="S_USEYN">
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>정렬순서</th>
					<td colspan="2"><input type="text" id="S_SORTKEY" name="S_SORTKEY" onkeydown="f_saveKeyDown();" /></td>
				</tr>
			</table>
			</form>
		</div>
	</div>




</body>
</html>