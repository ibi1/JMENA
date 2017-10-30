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
					
					$("#SYSIDCOMBO").append(inHtml);
					$("#SYSIDCOMBO2").append(inHtml);
					
					$("#SYSIDCOMBO").change();
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		
		});
		
		$(function(){
			$("#SYSIDCOMBO").change(function() {
				g_menuId1 = "ALL";	//콤보에서 선택 시 무조건 전체를 선택하게 하기
				
				$("#MENUIDCOMBO").empty().data('options');
				
				if ($(this).val() == "ALL") {
					var inHtml = "";
					
					inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
					
					$("#MENUIDCOMBO").append(inHtml);
					
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
	
							$("#MENUIDCOMBO").append(inHtml);
							
							f_selectPgmList();	//그리드 가져오기
						},
						error:function(e){  
							alert("[ERROR]Menu Combo 호출 중 오류가 발생하였습니다.");
						}  
					});
				}
			});
			
			$("#SYSIDCOMBO2").change(function() {
				g_menuId2 = "ALL";	//콤보에서 선택 시 무조건 전체를 선택하게 하기
				
				$("#MENUIDCOMBO2").empty().data('options');
				
				if ($("#SYSIDCOMBO2").val() == "ALL") {
					var inHtml = "";
					
					inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
					
					$("#MENUIDCOMBO2").append(inHtml);
				} else {
					//메뉴 호출 (SY011001 데이터 사용)
					$.ajax({ 
						type: 'POST',
						data: "SYSID=" + $("#SYSIDCOMBO2").val(),
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
	
							$("#MENUIDCOMBO2").append(inHtml);
						},
						error:function(e){  
							alert("[ERROR]Menu Combo 호출 중 오류가 발생하였습니다.");
						}  
					});
				}
			});	
		})
		
		$(function(){
			$("#MENUIDCOMBO").change(function() {
				f_selectPgmList();
			});	
		})
		
		function f_selectPgmList() {
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				//caption: '시스템 및 메뉴관리' ,
				url:"/home/selectListMenuPgmTb.do" ,
				postData : {
					SYSID:$("#SYSIDCOMBO option:selected").val(),MENUID:$("#MENUIDCOMBO option:selected").val()
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
					, {name:"USEYN",		index:'USEYN',			width:60,		align:'center', sortable:false}
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
					
					$("#SYSIDCOMBO2").val(selRowData.SYSID).attr("selected", "selected").trigger("change");
					
					g_menuId2 = selRowData.MENUID;	//메뉴아이디 무조건 셋팅
					
					$("#S_PGMID1").val(selRowData.PGMID);
					$("#S_PGMID2").val(selRowData.PGMID);
					$("#S_PGMNAME").val(selRowData.PGMNAME);
					$("#S_REMARK").val(selRowData.REMARK);
					$("#S_USEYN").val(selRowData.USEYN).attr("selected", "selected");
					$("#S_SORTKEY").val(selRowData.SORTKEY);
				} ,
				loadComplete: function() {
					if($("#S_PGMID2").val() != "") {
						var ids = jQuery("#leftList").jqGrid('getDataIDs');
		
						ids.some(function(currentValue, index, array){
							var cellData = $("#leftList").jqGrid('getCell', ids[index], 'PGMID');
							if (cellData == $("#S_PGMID2").val()) {
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
				hidegrid: false ,
			});
		}
		
		$(function() {
			$("#pgmSearchButton").click(function(){
				var sysId = $("#SYSIDCOMBO2").val();
				
				var menuId = $("#MENUIDCOMBO2").val();
				
				$("#SYSIDCOMBO").val(sysId).attr("selected", "selected").trigger("change");
				
				g_menuId1 = menuId;	//메뉴아이디 무조건 셋팅
			});
		})
	</script>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>시스템구분</td>
					<td>
						<select id="SYSIDCOMBO" name="SYSIDCOMBO">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>메뉴구분</td>
					<td>
						<select id="MENUIDCOMBO" name="MENUIDCOMBO">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>프로그램명</td>
					<td><input type="text" id="S_PGMID1" name="S_PGMID1" /></td>
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
						<select id="SYSIDCOMBO2" name="SYSIDCOMBO2">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>메뉴구분</td>
					<td>
						<select id="MENUIDCOMBO2" name="MENUIDCOMBO2">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>프로그램ID</td>
					<td><input type="text" id="S_PGMID2" name="S_PGMID2" />&nbsp;<a class="ui-button ui-widget ui-corner-all" id="pgmSearchButton" name="pgmSearchButton">=></a></td>
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