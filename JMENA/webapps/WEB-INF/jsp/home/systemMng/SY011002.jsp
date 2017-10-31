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
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				//caption: '시스템 및 메뉴관리' ,
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
					{name:"SYSID",			index:'SYSID',			width:60,		align:'center', sortable:false, hidden:true}
					, {name:"SYSNAME",		index:'SYSNAME',		width:60,		align:'center', sortable:false}
					, {name:"MENUID",		index:'MENUID',			width:60,		align:'center', sortable:false, hidden:true}
					, {name:"MENUNAME",		index:'MENUNAME',		width:60,		align:'center', sortable:false}
					, {name:"PGMID",		index:'PGMID',			width:60,		align:'center', sortable:false}
					, {name:"PGMNAME",		index:'PGMNAME',		width:60,		align:'center', sortable:false}
					, {name:"SORTKEY",		index:'SORTKEY',		width:60,		align:'center', sortable:false}
					, {name:"REMARK",		index:'REMARK',			width:60,		align:'center', sortable:false}
					, {name:"USEYN",		index:'USEYN',			width:60,		align:'center', sortable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
				] ,
				rowNum:100 ,
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
					var selRowData = $(this).jqGrid('getRowData', ids);
					
					$("#S_SYSIDCOMBO_R").val(selRowData.SYSID).attr("selected", "selected").trigger("change");
					
					g_menuId2 = selRowData.MENUID;	//메뉴아이디 무조건 셋팅
					
					$("#S_PGMID_L").val(selRowData.PGMID);
					$("#S_PGMID_R").val(selRowData.PGMID);
					$("#S_PGMNAME").val(selRowData.PGMNAME);
					$("#S_REMARK").val(selRowData.REMARK);
					$("#S_USEYN").val(selRowData.USEYN).attr("selected", "selected");
					$("#S_SORTKEY").val(selRowData.SORTKEY);
				} ,
				loadComplete: function() {
					if($("#S_PGMID_R").val() != "") {
						var ids = jQuery("#leftList").jqGrid('getDataIDs');
		
						ids.some(function(currentValue, index, array){
							var cellData = $("#leftList").jqGrid('getCell', ids[index], 'PGMID');
							if (cellData == $("#S_PGMID_R").val()) {
				        		$("#leftList").jqGrid('setSelection', ids[index]);
				    			return true;
				        	} else {
				        		//없을 경우 신규 데이터 입력으로...
				        		$("#S_PGMNAME").val("").focus();
				        		$("#S_REMARK").val("");
				        		$("#S_USEYN").val("Y").attr("selected", "selected");
				        		$("#S_SORTKEY").val("");
				        	}        
						});
					}
				},
				hidegrid: false
			});
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
		
		$(function() {
			$("#selectButton").click(function() {
				
				f_selectPgmList();
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
			<table class="blueone">
				<tr>
					<td>시스템구분</td>
					<td>
						<select id="S_SYSIDCOMBO_L" name="S_SYSIDCOMBO_L">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>메뉴구분</td>
					<td>
						<select id="S_MENUIDCOMBO_L" name="S_MENUIDCOMBO_L">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>프로그램명</td>
					<td><input type="text" id="S_PGMID_L" name="S_PGMID_L" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
			<div id="leftNav"></div>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>시스템구분</td>
					<td>
						<select id="S_SYSIDCOMBO_R" name="S_SYSIDCOMBO_R">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>메뉴구분</td>
					<td>
						<select id="S_MENUIDCOMBO_R" name="S_MENUIDCOMBO_R">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>프로그램ID</td>
					<td><input type="text" id="S_PGMID_R" name="S_PGMID_R" onkeydown="f_s_pgmIdSelection();" />&nbsp;<a class="ui-button ui-widget ui-corner-all" id="pgmSearchButton" name="pgmSearchButton">=></a></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>프로그램명</td>
					<td><input type="text" id="S_PGMNAME" name="PGMNAME" /></td>
				</tr>
				<tr>
					<td>비고</td>
					<td><input type="text" id="S_REMARK" name="REMARK" /></td>
				</tr>
				<tr>
					<td>사용여부</td>
					<td>
						<select id="S_USEYN" name="USEYN">
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>정렬순서</td>
					<td><input type="text" id="S_SORTKEY" name="SORTKEY" /></td>
				</tr>
			</table>
		</div>
	</div>




</body>
</html>