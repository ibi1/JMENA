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
		var v_rightLastSel = 0;
		
		$(document).ready(function(){

			$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			
			$("#rightSaveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#sysSearchButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
			
			$("#S_USERNAME_L").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#S_USERID").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#S_USERNAME_R").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#S_PASSWORD").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			//$("#S_USEYN").jqxComboBox({theme: 'energyblue', autoDropDownHeight: true,  height: 25, width: 100});
			$("#S_PHONENO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#S_MOBILENO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			
			
			$("#S_FLAG").val("U");
			
			f_selectUserMst();
			f_selectUserSysTb();
		});
		
		function f_selectUserMst() {
			$(function() {
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
						{name:"USERID",			index:'USERID',		width:100,	align:'center', sortable:false}
						, {name:"PASSWORD",		index:'PASSWORD',	width:100,	align:'center', sortable:false, hidden:true}
						, {name:"USERNAME",		index:'USERNAME',	width:150,	align:'center', sortable:false}
						, {name:"USEYN",		index:'USEYN',		width:70,	align:'center', sortable:false}
						, {name:"USERGUBUN",	index:'USERGUBUN',	width:70,	align:'center', sortable:false, hidden:true}
						, {name:"PHONENO",		index:'PHONENO',	width:90,	align:'center', sortable:false, hidden:true}
						, {name:"MOBILENO",		index:'MOBILENO',	width:90,	align:'center', sortable:false, hidden:true}
					] ,
					rowNum:100,
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
								$("#S_FLAG").val("U");
				        		$("#leftList").jqGrid('setSelection', ids[index]);
				    			return true;
				        	} else {
				        		$("#S_FLAG").val("I");
				        	}
						});
					},
					hidegrid: false
				});
			})
		}
		
		function f_selectUserSysTb() {
			$(function() {
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
						{name:"SYSID",			index:'SYSID',		width:100,	align:'center', sortable:false}
						, {name:"SYSNAME",		index:'SYSNAME',	width:150,	align:'center', sortable:false}
						//, {name:"AUTH_YN",		index:'AUTH_YN',	width:60,	align:'center', sortable:false, editable:true, edittype:'select', editoptions:{dataUrl:"/home/selectTest.do", buildSelect:setAuth_YNSelectBox}}
						, {name:"AUTH_YN",		index:'AUTH_YN',	width:70,	align:'center', sortable:false, editable:true, edittype:'select', editoptions:{value: "Y:Y;N:N"}}
						, {name:"REMARK",		index:'REMARK',		width:250,	align:'center', sortable:false, editable:true}
					] ,
					rowNum:100,
					autowidth: true ,
					shrinkToFit: false,
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
					onSelectRow: function(id){
						if( v_rightLastSel != id ){
					        $(this).jqGrid('restoreRow',v_rightLastSel,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
					        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경
	
					        v_rightLastSel = id;
						}
					} ,
					loadComplete: function() {
						
					},
					hidegrid: false
				});
			})
		}
		
		function setAuth_YNSelectBox(data){
			var jsonValue = $.parseJSON(data).rows;
			var result = "<select>";
			
			jsonValue.some(function(currentValue, index, array){
				result += "<option value='" + currentValue.VALUE + "'>" + currentValue.LABEL + "</option>\n";
			});
			
			result +="</select>";

			return result;
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
				$("#S_USERNAME_R").focus();
			});
		})
		
		$(function() {
			$("#selectButton").click(function() {
				$("#S_FLAG").val("U");
				
				f_rightClear("N");
				
				f_selectUserMst();
			});
		})
		
		$(function() {
			$("#insertButton").click(function() {
				$("#S_FLAG").val("I");
				
				f_rightClear("N");
				
				$("#S_USERID").focus();
				
				$("#leftList").jqGrid("resetSelection");
			});
		})
		
		$(function() {
			$("#saveButton").click(function() {
				if ($("#S_USERID").val() == "") {
					alert("사용자 아이디를 입력하셔야 합니다.");
					$("#S_USERID").focus();
					
					return false;
				}
				
				if ($("#S_USERNAME_R").val() == "") {
					alert("사용자 명을 입력하셔야 합니다.");
					$("#S_USERNAME_R").focus();
					
					return false;
				}
				
				if ($("#S_PASSWORD").val() == "") {
					alert("비밀번호를 입력하셔야 합니다.");
					$("#S_PASSWORD").focus();
					
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
						data: $("#SY011003").serialize(),
						url: "/home/insertDataUserMst.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG").val("U");
							
							alert(data.resultMsg);
							
							$("#s_userIdSearchButton").click();
						},
						error:function(e){  
							alert("[ERROR]프로그램 저장  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
		
		function f_saveUser() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#saveButton").click();
			}
		}
		
		$(function() {
			$("#rightSaveButton").click(function() {
				var ids = $("#rightList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기

				$('#rightList').jqGrid('saveRow', ids, false, 'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#rightList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
				
				if (ids == null || ids == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				if (confirm("시스템 " + cellData.SYSID + "코드의 권한을 수정하시겠습니까?") == true) {
					$.ajax({ 
						type: 'POST' ,
						data: "USERID=" + $("#S_USERID").val() + "&SYSID=" + cellData.SYSID + "&AUTH_YN=" + cellData.AUTH_YN + "&REMARK=" + cellData.REMARK,
						url: "/home/updateDataUserSysTb.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG").val("U");
							
							alert(data.resultMsg);
							
							f_selectUserSysTb();
						},
						error:function(e){  
							alert("[ERROR]권한 수정  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
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
		<div id="leftDiv" style="width:48%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">사용자명</th>
					<td><input type="text" id="S_USERNAME_L" name="S_USERNAME_L" onkeydown="f_onEncterUserName();" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; padding: 10px" align="left">
			<form id="SY011003">
			<input type="hidden" id="S_FLAG" name="S_FLAG"/>
			<table>
				<tr>
					<th width="120">사용자</th>
					<td width="100"><input type="text" id="S_USERID" name="S_USERID" onkeydown="f_onEncterUserId();" />
					<td><input type="button" id='sysSearchButton' /></td>
					</td>
				</tr>
				<tr>
					<th width="120">사용자명</th>
					<td colspan="2"><input type="text" id="S_USERNAME_R" name="S_USERNAME_R" /></td>
				</tr>
				<tr>
					<th width="120">비밀번호</th>
					<td colspan="2"><input type="text" id="S_PASSWORD" name="S_PASSWORD" onkeydown="f_saveUser();"/></td>
				</tr>
				<tr>
					<th width="120">사용여부</th>
					<td colspan="2">
						<select id="S_USEYN" name="S_USEYN">
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">사용자구분</th>
					<td colspan="2">
						<input type="radio" id="S_USERGUBUN" name="S_USERGUBUN" value="B" checked="checked" />일반사용자
						<input type="radio" id="S_USERGUBUN" name="S_USERGUBUN" value="A" />관리자
					</td>
				</tr>
				<tr>
					<th width="120">연락처</th>
					<td colspan="2"><input type="text" id="S_PHONENO" name="S_PHONENO" /></td>
				</tr>
				<tr>
					<th width="120">모바일</th>
					<td colspan="2"><input type="text" id="S_MOBILENO" name="S_MOBILENO" onkeydown="f_saveUser();"/></td>
				</tr>
			</table>
			</form>
			<table align="right">
				<tr>
					<td><input type="button" value="저장" id='rightSaveButton' /></td>
				</tr>
			</table>
			<br />
			<br />
			<table id="rightList"></table>
		</div>
	</div>
</body>
</html>
