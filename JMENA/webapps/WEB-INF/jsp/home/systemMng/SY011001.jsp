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
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#rightInsertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#rightSaveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			
			$("#sysSearchButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
			   
			$("#S_SYSID").jqxInput({theme: 'energyblue', height: 25, width: 100, maxLength: 2, minLength: 1});
			$("#S_SYSNAME").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
			$("#S_SORTKEY").jqxFormattedInput({theme: 'energyblue', height: 23, width: 94, radix: 'decimal', value: ''});
			
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
					{name:"SYSID",			index:'SYSID',		width:130,		align:'center', sortable:false}
					,{name:"SYSNAME",		index:'SYSNAME',	width:210,		align:'center', sortable:false}
					,{name:"SORTKEY",		index:'SORTKEY',	width:100,		align:'center', sortable:false}
					] ,
				rowNum:100 ,
				autowidth: true ,
				//shrinkToFit: false,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'SORTKEY' ,
				viewrecords: true ,
				sortorder:'asc' ,
				//width: "auto" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(ids){
					v_rightLastSel = 0;
					$("#S_FLAG_L").val("U");
					
					var selRowData = $(this).jqGrid('getRowData', ids);
										
					$("#S_SYSID").val(selRowData.SYSID);
					$("#S_SYSNAME").val(selRowData.SYSNAME);
					$("#S_SORTKEY").val(selRowData.SORTKEY);
						
					f_selectSysDtl(selRowData.SYSID);
				} ,
				loadComplete : function() {
					v_rightLastSel = 0;
					
					var sysId = $("#S_SYSID").val();
					
					var ids = jQuery("#leftList").jqGrid('getDataIDs');
					
					ids.some(function(currentValue, index, array){
						var cellData = $("#leftList").jqGrid('getCell', ids[index], 'SYSID');
						if (cellData == sysId) {
							$("#S_FLAG_L").val("U");
			        		$("#leftList").jqGrid('setSelection', ids[index]);
			    			return true;
			        	} else {
			        		$("#S_FLAG_L").val("I");
			        	}	        
					});
				},
				hidegrid: false
			});
		}
		
		function f_selectSysDtl(sysId) {
			$(function() {
				$('#rightList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
				
				$('#rightList').jqGrid({
					caption: '시스템 메뉴관리' ,
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
						{name:"MENUID",			index:'MENUID',		width:150,		align:'center', sortable:false, editable:true}
						, {name:"MENUNAME",		index:'MENUNAME',	width:250,		align:'center', sortable:false, editable:true}
						, {name:"USEYN",		index:'USEYN',		width:100,		align:'center', sortable:false, editable:true, edittype:'select', editoptions:{value: "Y:Y;N:N"}}
						, {name:"REMARK",		index:'REMARK',		width:200,		align:'center', sortable:false, editable:true}
						, {name:"SORTKEY",		index:'SORTKEY',	width:100,		align:'center', sortable:false, editable:true}
						] ,
					rowNum:100 ,
					autowidth: true ,
					shrinkToFit: false,
					rowList:[10,20,30] ,
					//pager: $('#rightNav') ,
					sortname: 'SORTKEY' ,
					viewrecords: true ,
					sortorder:'asc' ,
					width: "800px" ,
					jsonReader: {
						repeatitems: false
					},
					//height: '100%' ,
					onSelectRow: function(id){
						if (id > 0) {
							$("#S_FLAG_R").val("U");
						} else {
							$("#S_FLAG_R").val("I");
						}
						
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
		
		$(function() {
			$("#sysSearchButton").click(function(){
				if( $("#S_SYSID").val() == "") {
					alert("시스템 코드를 입력하셔야 합니다."); 
					$("#S_SYSID").focus();
					 
					 return false;
				}
				
				$("#S_SYSNAME").val("");
				$("#S_SYSNAME").focus();
				$("#S_SORTKEY").val("");
				
				$('#rightList').jqGrid('clearGridData');
				
				f_selectSysMst();
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
				$('#rightList').jqGrid('clearGridData');
				
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
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				if (ids == null || ids == "") {
					alert("선택된 시스템이 없습니다.");
					
					return false;
				}
				
				$("#S_FLAG_R").val("I");
				
				$("#rightList").jqGrid("addRow", 0);
			});
		})
		
		$(function() {
			$("#rightSaveButton").click(function() {
				var ids = $("#rightList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				$('#rightList').jqGrid('saveRow',v_rightLastSel,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#rightList").jqGrid('getRowData', v_rightLastSel); //셀 전체 데이터 가져오기
				
				if (v_rightLastSel == 0 || v_rightLastSel == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				if (cellData.MENUID == "") {
					alert("메뉴 코드를 입력하셔야 합니다.");
					
					$('#rightList').jqGrid('editRow', v_rightLastSel, true);
					$("#"+ids+"_MENUID").focus();
					
					return false;
				}
				
				if (cellData.MENUNAME == "") {
					alert("메뉴 명을 입력하셔야 합니다.");
					
					$('#rightList').jqGrid('editRow', v_rightLastSel, true);
					$("#"+ids+"_MENUNAME").focus();
					
					return false;
				}
				
				if (cellData.SORTKEY == "") {
					alert("정렬 순서를 입력하셔야 합니다.");
					
					$('#rightList').jqGrid('editRow', v_rightLastSel, true);
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
							
							$("#sysSearchButton").click();
						},
						error:function(e){  
							alert("[ERROR]Menu 저장  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel = 0;
					$("#sysSearchButton").click();
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
		<div id="leftDiv" style="width:38%; float:left; padding: 10px" align="left">
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:58%; float:left; padding: 10px" align="left">
			<form id="SY011001">
				<input type="hidden" id="S_FLAG_L" NAME="S_FLAG_L" />
				<table width="600">
					<tr>
						<th width="120">시스템코드</th>
						<td width="100"><input type="text" id="S_SYSID" name="S_SYSID" onkeydown="f_s_sysMstSelection();" /></td>
						<td><input type="button" id='sysSearchButton' /></td>
					</tr>
					<tr>
						<th>시스템 명</th>
						<td colspan="2"><input type="text" id="S_SYSNAME" name="S_SYSNAME" /></td>
					</tr>
					<tr>
						<th>정렬순서</th>
						<td colspan="2"><input type="text" id="S_SORTKEY" name="S_SORTKEY" onkeydown="f_sysMstSave();"/></td>
					</tr>
				</table>
			</form>
			
			<input type="hidden" id="S_FLAG_R" NAME="S_FLAG_R" />
			<table align="right">
				<tr>
					<td><input type="button" value="추가" id='rightInsertButton' /></td>
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