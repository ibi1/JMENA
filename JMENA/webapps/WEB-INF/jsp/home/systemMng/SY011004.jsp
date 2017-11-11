<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />
	<style>
	 .ui-jqgrid .ui-jqgrid-htable th div {
	    height:auto;
	    overflow:hidden;
	    padding-right:4px;
	    padding-top:2px;
	    position:relative;
	    vertical-align:text-top;
	    white-space:normal !important;
	}
	</style>
	<script type="text/javascript">
		var v_selectUserId = "";	//선택된 사용자
		
		$(document).ready(function(){
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			
			$("#S_USERNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			
			$("#saveButton").on('click', function () {
				var ids = $("#rightList").jqGrid('getDataIDs');
				var len = ids.length;
			
				if (len == 0) {
					alert("저장할 데이터가 없습니다.");
				
					return false;
				}
				
				//그리드 데이터를 배열에 저장
				//userid, pgmid, sysid, menuid, auth_s, auth_i, auth_u, auth_d, auth__p
				var userIdArr = [];
				var pgmIdArr = [];
				var sysIdArr = [];
				var menuIdArr = [];
				var authSArr = [];
				var authIArr = [];
				var authUArr = [];
				var authDArr = [];
				var authPArr = [];
				
				var leftIds = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				var cellData = $("#leftList").jqGrid('getRowData', leftIds); //셀 전체 데이터 가져오기
				var userId = cellData.USERID;
				var sysId = $("#SYSIDCOMBO").val();				
				var menuId = $("#MENUIDCOMBO").val();
				
				ids.some(function(currentValue, index, array){
					pgmIdArr.push($("#rightList").jqGrid('getCell', array[index], 'PGMID'));
					sysIdArr.push($("#rightList").jqGrid('getCell', array[index], 'SYSID'));
					menuIdArr.push($("#rightList").jqGrid('getCell', array[index], 'MENUID'));
					authSArr.push($("#rightList").jqGrid('getCell', array[index], 'AUTH_S'));
					authIArr.push($("#rightList").jqGrid('getCell', array[index], 'AUTH_I'));
					authUArr.push($("#rightList").jqGrid('getCell', array[index], 'AUTH_U'));
					authDArr.push($("#rightList").jqGrid('getCell', array[index], 'AUTH_D'));
					authPArr.push($("#rightList").jqGrid('getCell', array[index], 'AUTH_P'));
				});
				
				if(confirm("저장하시겠습니까?") == true) {
				 	$.ajax({ 
						type: 'POST' ,
						url: "/home/insertDataUserPgmAuthTb.do", 
						data: {
							'USERID':userId, 
							'SYSID':sysId,
							'MENUID':menuId,
							'pgmIdArr':pgmIdArr, 
							'sysIdArr':sysIdArr, 
							'menuIdArr':menuIdArr,
							'authSArr':authSArr,
							'authIArr':authIArr,
							'authUArr':authUArr,
							'authDArr':authDArr,
							'authPArr':authPArr
						},
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
						},
						error:function(e){  
							alert("[ERROR]사용자 별 권한 설정 중 오류가 발생하였습니다.");
						}  
					});
				}
			});
			
			f_selectSysMst();
			f_selectUserMst4();
			f_selectUserPgmAuthTb();			
		});
		
		function f_selectSysMst() {
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
					
					$("#SYSIDCOMBO").change();
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		$(function(){
			$("#SYSIDCOMBO").change(function() {
				$("#MENUIDCOMBO").empty().data('options');
				
				if ($(this).val() == "ALL") {
					var inHtml = "";
					
					inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
					
					$("#MENUIDCOMBO").append(inHtml);
					
					f_selectUserPgmAuthTb();	//그리드 가져오기
				} else {
					//메뉴 호출 (SY011001 데이터 사용)
					$.ajax({ 
						type: 'POST',
						data: "SYSID=" + $("#SYSIDCOMBO").val(),
						url: "/home/selectListSysDtl.do", 
						dataType : 'json' , 
						success: function(data){
							var inHtml = "";
							
							inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
							
							data.rows.forEach(function(currentValue, index, array){
								inHtml += "<option value='" + currentValue.MENUID + "'>" + currentValue.MENUNAME + "</option>\n";
							});
	
							$("#MENUIDCOMBO").append(inHtml);
							
							f_selectUserPgmAuthTb();	//그리드 가져오기
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
				f_selectUserPgmAuthTb();
			});	
		})
	
		function f_selectUserMst4() {
			$(function() {
				$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
				
				$('#leftList').jqGrid({
					url:"/home/selectListUserMst4.do",
					postData : {
						USERGUBUN:$("input:radio[name=S_USERGUBUN]:checked").val(),
						USERNAME:$("#S_USERNAME").val()
					},
					datatype:"json" ,
					mtype: 'POST',
					loadtext: '로딩중...',
					loadError:function(){alert("Error~!!");} ,
					colNames:['사용자ID', '사용자명'] ,
					colModel:[
						{name:"USERID",			index:'USERID',		width:120,	align:'center', sortable:false}
						, {name:"USERNAME",		index:'USERNAME',	width:180,	align:'center', sortable:false}
					] ,
					rowNum:1000,
					autowidth: true ,
					shrinkToFit: false,
					rowList:[10,20,30] ,
					//pager: $('#leftNav') ,
					sortname: 'USERID' ,
					viewrecords: true ,
					sortorder:'asc' ,
					width: "96%" ,
					jsonReader: {
						repeatitems: false
					},
					//height: '100%' ,
					onSelectRow: function(ids){
						var selRowData = $(this).jqGrid('getRowData', ids);
						
						v_selectUserId = selRowData.USERID;
						
						f_selectUserPgmAuthTb();
					} ,
					loadComplete: function() {
						v_selectUserId = "";	//초기화
						$("#SYSIDCOMBO").val("ALL").attr("selected", "selected").trigger("change");
						$('#rightList').jqGrid("clearGridData", true);
					},
					hidegrid: false
				});
			})
		}
		
		function f_selectUserPgmAuthTb() {
			$(function() {
				$('#rightList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
				
				$('#rightList').jqGrid({
					url:"/home/selectListUserPgmAuthTb.do",
					postData : {
						USERID:v_selectUserId,SYSID:$("#SYSIDCOMBO option:selected").val(),MENUID:$("#MENUIDCOMBO option:selected").val()
					},
					datatype:"json" ,
					mtype: 'POST',
					loadtext: '로딩중...',
					loadError:function(){alert("Error~!!");} ,
					colNames:['시스템코드', '시스템 명', '메뉴코드', '메뉴 명', '프로그램ID', '프로그램 명', 
					          "조회<br/><input type='checkbox' id='chkAllAUTH_S' name='chkAllAUTH_S' onclick='checkBox(event, \"AUTH_S\")' />", 
					          "입력<br/><input type='checkbox' id='chkAllAUTH_I' name='chkAllAUTH_I' onclick='checkBox(event, \"AUTH_I\")' />", 
					          "수정<br/><input type='checkbox' id='chkAllAUTH_U' name='chkAllAUTH_U' onclick='checkBox(event, \"AUTH_U\")' />", 
					          "삭제<br/><input type='checkbox' id='chkAllAUTH_D' name='chkAllAUTH_D' onclick='checkBox(event, \"AUTH_D\")' />", 
					          "출력<br/><input type='checkbox' id='chkAllAUTH_P' name='chkAllAUTH_P' onclick='checkBox(event, \"AUTH_P\")' />", 
					          ] ,
					colModel:[
						  {name:"SYSID",		index:'SYSID',		width:120,		align:'center', sortable:false, hidden:true}
						, {name:"SYSNAME",		index:'SYSNAME',	width:150,		align:'center', sortable:false}
						, {name:"MENUID",		index:'MENUID',		width:120,		align:'center', sortable:false, hidden:true}
						, {name:"MENUNAME",		index:'MENUNAME',	width:150,		align:'center', sortable:false}
						, {name:"PGMID",		index:'PGMID',		width:120,		align:'center', sortable:false}
						, {name:"PGMNAME",		index:'PGMNAME',	width:200,		align:'center', sortable:false}
						, {name:"AUTH_S",		index:'AUTH_S',		width:50,		align:'center', sortable:false, editable: true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
						, {name:"AUTH_I",		index:'AUTH_I',		width:50,		align:'center', sortable:false, editable: true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
						, {name:"AUTH_U",		index:'AUTH_U',		width:50,		align:'center', sortable:false, editable: true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
						, {name:"AUTH_D",		index:'AUTH_D',		width:50,		align:'center', sortable:false, editable: true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
						, {name:"AUTH_P",		index:'AUTH_P',		width:50,		align:'center', sortable:false, editable: true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					] ,
					rowNum:1000,
					autowidth: true ,
					shrinkToFit: false,
					rowList:[10,20,30] ,
					//pager: $('#leftNav') ,
					sortname: 'PGMID' ,
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
				
				
			})
		}
		
		//그리드 체크박스
		function checkBox(e, cell) {
			var ids = $("#rightList").jqGrid('getDataIDs');
			var len = ids.length;
			var chkFlag = "N";
			
			if (len == 0) {
				alert("선택할 데이터가 없습니다.");
				
				return false;
			}
			
			$("#chkAll"+cell).is(":checked") ? chkFlag = "Y" : chkFlag = "N";
			
		    //debugger;
		   	e = e || event;/* get IE event ( not passed ) */
		    e.stopPropagation ? e.stopPropagation() : e.cancelBubble = false;

			ids.some(function(currentValue, index, array){
				$("#rightList").jqGrid('setCell', array[index], cell, chkFlag);
			});
		}
		
		$(function() {
			$("#selectButton").click(function() {
				f_selectUserMst4();
			});
		})
		
		function f_selectUserList() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#selectButton").click();
			}
		}
	</script>
</head>
<body class='default'>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id='selectButton' /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">사용자구분</th>
					<td>
						<input type="radio" id="S_USERGUBUN" name="S_USERGUBUN" value="B" checked="checked" />일반사용자
						<input type="radio" id="S_USERGUBUN" name="S_USERGUBUN" value="A" />관리자
					</td>
				</tr>
				<tr>
					<th>사용자 명</th>
					<td><input type="text" id="S_USERNAME" name="S_USERNAME" onkeydown="f_selectUserList();"/></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">시스템구분</th>
					<td>
						<select id="SYSIDCOMBO" name="SYSIDCOMBO">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>메뉴구분</th>
					<td>
						<select id="MENUIDCOMBO" name="MENUIDCOMBO">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
			</table>
			<table width="100%">
				<tr>
					<td align="right">
						<input type="button" value="저장" id='saveButton' />
					</td>
				</tr>
			</table>
			<table id="rightList"></table>
		</div>
	</div>
</body>
</html>
