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
			f_selectUserMst();
			f_selectUserSysTb();
		});
		
		function f_selectUserMst() {
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListUserMst.do" ,
				postData : {
					USERNAME:$("#S_USERNAME_L").val()
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['사용자ID', '비밀번호', '사용자명', '사용여부', '사용자구분', '연락처', '모바일'] ,
				colModel:[
					{name:"USERID",			index:'USERID',		width:60,	align:'center', sortable:false}
					, {name:"PASSWORD",		index:'PASSWORD',	width:60,	align:'center', sortable:false, hidden:true}
					, {name:"USERNAME",		index:'USERNAME',	width:60,	align:'center', sortable:false}
					, {name:"USEYN",		index:'USEYN',		width:60,	align:'center', sortable:false}
					, {name:"USERGUBUN",	index:'USERGUBUN',	width:60,	align:'center', sortable:false, hidden:true}
					, {name:"PHONENO",		index:'PHONENO',	width:60,	align:'center', sortable:false, hidden:true}
					, {name:"MOBILENO",		index:'MOBILENO',	width:60,	align:'center', sortable:false, hidden:true}
				] ,
				rowNum:100,
				autowidth: true ,
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
					
					$("#S_USERID").val(selRowData.USERID);
					$("#S_USERNAME_R").val(selRowData.USERNAME);
					$("#S_PASSWORD").val(selRowData.PASSWORD);
					$("#S_USEYN").val(selRowData.USEYN).attr("selected", "selected");
					$("input:radio[name=S_USERGUBUN]:input[value=" + selRowData.USERGUBUN + "]").attr("checked", true);
					$("#S_PHONENO").val(selRowData.PHONENO);
					$("#S_MOBILENO").val(selRowData.MOBILENO);
					
					f_selectUserSysTb();
				} ,
				loadComplete: function() {
					var userId = $("#S_USERID").val();
					
					var ids = jQuery("#leftList").jqGrid('getDataIDs');
					
					ids.some(function(currentValue, index, array){
						var cellData = $("#leftList").jqGrid('getCell', ids[index], 'USERID');
						if (cellData == userId) {
			        		$("#leftList").jqGrid('setSelection', ids[index]);
			    			return true;
			        	}	        
					});
				},
				hidegrid: false
			});
		}
		
		function f_selectUserSysTb() {
			$('#rightList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#rightList').jqGrid({
				url:"/home/selectListUserSysTb.do" ,
				postData : {
					USERID:$("#S_USERID").val()
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['시스템코드', '시스템명', '사용여부', '비고'] ,
				colModel:[
					{name:"SYSID",			index:'SYSID',		width:60,	align:'center', sortable:false}
					, {name:"SYSNAME",		index:'SYSNAME',	width:60,	align:'center', sortable:false}
					, {name:"AUTH_YN",		index:'AUTH_YN',	width:60,	align:'center', sortable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"REMARK",		index:'REMARK',		width:60,	align:'center', sortable:false}
				] ,
				rowNum:100,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'SYSID' ,
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
		
		function f_onEncterUserName() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#selectButton").click();
			}
		}
		
		function f_onEncterUserId() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#s_userIdSearchButton").click();
			}
		}
		
		function f_rightClear(delFlag) {
			if (delFlag == "Y") $("#S_USERNAME_L").val("");
			if (delFlag == "N") $("#S_USERID").val("");
			$("#S_USERNAME_R").val("");
			$("#S_PASSWORD").val("");
			$("#S_USEYN").val("Y").attr("selected", "selected");
			$("input:radio[name=S_USERGUBUN]:input[value=B]").attr("checked", true);
			$("#S_PHONENO").val("");
			$("#S_MOBILENO").val("");
			
			$('#rightList').jqGrid("clearGridData", true);
		}
		
		$(function() {
			$("#s_userIdSearchButton").click(function() {
				f_rightClear("Y");
				f_selectUserMst();
			});
		})
		
		$(function() {
			$("#selectButton").click(function() {
				f_rightClear("N");
				f_selectUserMst();
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
					<td>사용자명</td>
					<td><input type="text" id="S_USERNAME_L" name="S_USERNAME_L" onkeydown="f_onEncterUserName();" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>사용자</td>
					<td><input type="text" id="S_USERID" name="S_USERID" onkeydown="f_onEncterUserId();" />&nbsp;<a class="ui-button ui-widget ui-corner-all" id="s_userIdSearchButton" name="s_userIdSearchButton">=></a></td>
				</tr>
				<tr>
					<td>사용자명</td>
					<td><input type="text" id="S_USERNAME_R" name="S_USERNAME_R" /></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="text" id="S_PASSWORD" name="S_PASSWORD" /></td>
				</tr>
				<tr>
					<td>사용여부</td>
					<td>
						<select id="S_USEYN" name="S_USEYN">
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>사용자구분</td>
					<td>
						<input type="radio" id="S_USERGUBUN" name="S_USERGUBUN" value="B" checked="checked" />일반사용자
						<input type="radio" id="S_USERGUBUN" name="S_USERGUBUN" value="A" />관리자
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td><input type="text" id="S_PHONENO" name="S_PHONENO" /></td>
				</tr>
				<tr>
					<td>모바일</td>
					<td><input type="text" id="S_MOBILENO" name="S_MOBILENO" /></td>
				</tr>
			</table>
			<table class="blueone">
				<tr>
					<td><a class="ui-button ui-widget ui-corner-all" id="saveButton" name="rightSaveButton">저장</a></td>
				</tr>
			</table>
			<table id="rightList"></table>
		</div>
	</div>
</body>
</html>