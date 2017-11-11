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
		var v_ccode = "null";
		var v_rightLastSel = 0;		//아래 그리드 선택 id
		
		$(document).ready(function(){
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#insertButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#saveButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#bottomInsertButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#bottomSaveButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			
			$("#searchButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
			
			$("#S_CCODE").jqxInput({theme: 'energyblue', height: 25, width: 100, maxLength: 3, minLength: 1});
			$("#S_CCODENAME_R").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			
			$("#S_CCODENAME_L").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			
			$("#S_FLAG_L").val("I");	//I : 저장, U : 수정
			$("#S_FLAG_B").val("U");	//I : 저장, U : 수정
			
			f_selectCcodeMst();
			f_selectCcodeDtl();
		});
		
		function f_selectCcodeMst() {
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListCcodeMst.do",
				postData : {
					CCODENAME:$("#S_CCODENAME_L").val()
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['공통코드', '공통코드 명'] ,
				colModel:[
					{name:"CCODE",			index:'CCODE',			width:60,		align:'center', sortable:false}
					, {name:"CCODENAME",	index:'CCODENAME',		width:60,		align:'center', sortable:false}
				] ,
				rowNum:100,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'CCODE' ,
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
					
					v_ccode = selRowData.CCODE;
					
					$("#S_CCODE").val(selRowData.CCODE);
					$("#S_CCODENAME_R").val(selRowData.CCODENAME);
					
					f_selectCcodeDtl();
				} ,
				loadComplete: function() {
					v_rightLastSel = 0;
					
					$("#S_CCODENAME_L").val("");
					
					var s_ccode = $("#S_CCODE").val();
					
					var ids = jQuery("#leftList").jqGrid('getDataIDs');
					
					ids.some(function(currentValue, index, array){
						var cellData = $("#leftList").jqGrid('getCell', ids[index], 'CCODE');
						if (cellData == s_ccode) {
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
		
		function f_selectCcodeDtl() {
			$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#bottomList').jqGrid({
				url:"/home/selectListCcodeDtl.do",
				postData : {
					CCODE:v_ccode
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['상세코드', '상세코드명', '사용여부', '정렬순서', 
							'비고', '관리구분1', '관리구분1명', '관리구분2', 
							'관리구분2명', '관리구분3', '관리구분3명', '관리구분4', '관리구분4명'] ,
				colModel:[
					{name:"DCODE",			index:'DCODE',		width:60,		align:'center', sortable:false, editable: true}
					, {name:"DCODENAME",	index:'DCODENAME',	width:60,		align:'center', sortable:false, editable: true}
					, {name:"USEYN",		index:'USEYN',		width:60,		align:'center', sortable:false, editable: true, edittype:'select', editoptions:{value: "Y:Y;N:N"}}
					, {name:"SORTKEY",		index:'SORTKEY',	width:60,		align:'center', sortable:false, editable: true}
					, {name:"REMARK",		index:'REMARK',		width:60,		align:'center', sortable:false, editable: true}
					, {name:"AUX1",			index:'AUX1',		width:60,		align:'center', sortable:false, editable: true}
					, {name:"AUX1DESC",		index:'AUX1DESC',	width:60,		align:'center', sortable:false, editable: true}
					, {name:"AUX2",			index:'AUX2',		width:60,		align:'center', sortable:false, editable: true}
					, {name:"AUX2DESC",		index:'AUX2DESC',	width:60,		align:'center', sortable:false, editable: true}
					, {name:"AUX3",			index:'AUX3',		width:60,		align:'center', sortable:false, editable: true}
					, {name:"AUX3DESC",		index:'AUX3DESC',	width:60,		align:'center', sortable:false, editable: true}
					, {name:"AUX4",			index:'aux4',		width:60,		align:'center', sortable:false, editable: true}
					, {name:"AUX4DESC",		index:'AUX4DESC',	width:60,		align:'center', sortable:false, editable: true}
				] ,
				rowNum:100,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'DCODE' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(id){
					if (id > 0) {
						$("#S_FLAG_B").val("U");
					} else {
						$("#S_FLAG_B").val("I");
					}
					
					if( v_rightLastSel != id ){
				        jQuery(this).jqGrid('restoreRow',v_rightLastSel,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
				        jQuery(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

				        v_rightLastSel = id;
					}
				} ,
				loadComplete: function() {
					
				},
				hidegrid: false
			});
		}
		
		$(function() {
			$("#selectButton").click(function() {
				$("#S_CCODE").val("");
				$("#S_CCODENAME_R").val("");
				$('#bottomList').jqGrid("clearGridData", true);
				
				f_selectCcodeMst();
			});
		})
		
		function f_selectKeyCcodeMst() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#selectButton").click();
			}
		}
		
		$(function() {
			$("#insertButton").click(function() {
				$("#S_FLAG_L").val("I");
				
				$("#S_CCODE").val("");
				$("#S_CCODE").focus();
				$("#S_CCODENAME_R").val("");
				
				$("#leftList").jqGrid("resetSelection");
				$('#bottomList').jqGrid('clearGridData');
			});
		})
		
		$(function() {
			$("#saveButton").click(function() {
				if ($("#S_CCODE").val() == "") {
					alert("공통코드를 입력하셔야 합니다.");
					$("#S_CCODE").focus();
					return false;
				}
				
				if ($("#S_CCODENAME_R").val() == "") {
					alert("공통코드명을 입력하셔야 합니다.");
					$("#S_CCODENAME_R").focus();
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
						data: $("#SY011005").serialize(),
						url: "/home/insertDataCcodeMst.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							if (data.resultCode == "SUCCESS") {
								f_selectCcodeMst();
							} else {
								$("#S_CCODE").focus();
							}
						},
						error:function(e){  
							alert("[ERROR]공통코드 저장  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
		
		function f_saveCcodeMst() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#saveButton").click();
			}
		}
		
		$(function() {
			$("#searchButton").click(function() {
				if( $("#S_CCODE").val() == "") {
					alert("공통 코드를 입력하셔야 합니다."); 
					$("#S_CCODE").focus();
					 
					 return false;
				}
				
				$("#S_CCODENAME_R").val("");
				$("#S_CCODENAME_R").focus();
					
				$('#bottomList').jqGrid("clearGridData", true);	
				
				f_selectCcodeMst();
			});
		})
		
		function f_s_ccodeMstSelection() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#searchButton").click();
			}
		}
		
		/////Bottom Button ///////////
		$(function() {
			$("#bottomInsertButton").click(function() {
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				if (ids == null || ids == "") {
					alert("선택된 공통코드가 없습니다.");
					
					return false;
				}
				
				//v_rightLastSel = 0;
				$("#S_FLAG_B").val("I");
				
				$("#bottomList").jqGrid("addRow", 0);
			});
		})
		
		$(function() {
			$("#bottomSaveButton").click(function() {
				var ids = $("#bottomList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				$('#bottomList').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#bottomList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기

				if (ids == null || ids == "") {
					alert("선택된 공통코드가 없습니다.");
					
					return false;
				}
				
				if (cellData.DCODE == "") {
					alert("상세 코드를 입력하셔야 합니다.");
					
					$('#bottomList').jqGrid('editRow', ids, true);
					$("#"+ids+"_DCODE").focus();
					
					return false;
				}
				
				if (cellData.DCODENAME == "") {
					alert("상세 코드명을 입력하셔야 합니다.");
					
					$('#bottomList').jqGrid('editRow', ids, true);
					$("#"+ids+"_DCODENAME").focus();
					
					return false;
				}
				
				if (cellData.SORTKEY == "") {
					alert("정렬순서를 입력하셔야 합니다.");
					
					$('#bottomList').jqGrid('editRow', ids, true);
					$("#"+ids+"_SORTKEY").focus();
					
					return false;
				}
				
				var msg = "";
				if ($("#S_FLAG_B").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					var formData = "S_FLAG_B=" + $("#S_FLAG_B").val() + 
									"&CCODE=" + $("#S_CCODE").val() + 
									"&DCODE=" + cellData.DCODE + 
									"&DCODENAME=" + cellData.DCODENAME + 
									"&USEYN=" + cellData.USEYN + 
									"&SORTKEY=" + cellData.SORTKEY +
									"&REMARK=" + cellData.REMARK +
									"&AUX1=" + cellData.AUX1 +
									"&AUX1DESC=" + cellData.AUX1DESC +
									"&AUX2=" + cellData.AUX2 +
									"&AUX2DESC=" + cellData.AUX2DESC +
									"&AUX3=" + cellData.AUX3 +
									"&AUX3DESC=" + cellData.AUX3DESC +
									"&AUX4=" + cellData.AUX4 +
									"&AUX4DESC=" + cellData.AUX4DESC;
									
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/insertDataCcodeDtl.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG_R").val("U");
							
							v_rightLastSel = 0;
							
							alert(data.resultMsg);
							
							f_selectCcodeDtl();
						},
						error:function(e){  
							alert("[ERROR]세부 코드 저장  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel = 0;
					$("#searchButton").click();
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
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>공통코드명</td>
					<td><input type="text" id="S_CCODENAME_L" name="S_CCODENAME_L" onkeydown="f_selectKeyCcodeMst();"/></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<form id="SY011005">
				<input type="hidden" id="S_FLAG_L" NAME="S_FLAG_L" />
				<table class="blueone">
					<tr>
						<td>공통코드</td>
						<td><input type="text" id="S_CCODE" name="S_CCODE" onkeydown="f_s_ccodeMstSelection();" /></td>
						<td><input type="button" id='searchButton' /></td>
					</tr>
					<tr>
						<td>공통코드명</td>
						<td><input type="text" id="S_CCODENAME_R" name="S_CCODENAME_R" onkeydown="f_saveCcodeMst();" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<input type="hidden" id="S_FLAG_B" NAME="S_FLAG_B" />
			<div style="width:96%; float:left; padding: 10px" align="left">
				<table align="right">
					<tr>
						<td><input type="button" value="추가" id='bottomInsertButton' /></td>
						<td><input type="button" value="저장" id='bottomSaveButton' /></td>
					</tr>
				</table>
			</div>
			<div id="rightDiv2" style="width:96%; float:left; padding: 10px" align="left">
				<table id="bottomList"></table>
			</div>
		</div>
	</div>
</body>
</html>