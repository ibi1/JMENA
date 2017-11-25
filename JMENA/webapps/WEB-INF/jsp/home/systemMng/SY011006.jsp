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
		var auth_i = true;

		$(document).ready(function(){
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });

			$("#S_BANKNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			
			<%if ("N".equals(session.getAttribute("AUTH_I"))) { %>
				$("#insertButton").hide();
				$("#saveButton").hide();
				auth_i = false;
			<% }%>
			
			$("#S_FLAG").val("U");
			
			f_selectBankMst();
		});
		
		function f_selectBankMst() {
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListBankMst.do",
				postData : {
					BANKNAME:$("#S_BANKNAME").val()
				},
				datatype:"json" ,
				mtype: 'POST',
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['기관코드', '금융기관명', '사용여부', '확장코드'] ,
				colModel:[
					{name:"BANKCODE",		index:'BANKCODE',	width:120,	align:'center', sortable:false, editable:true}
					, {name:"BANKNAME",		index:'BANKNAME',	width:200,	align:'center', sortable:false, editable:true}
					, {name:"USEYN",		index:'USEYN',		width:100,	align:'center', sortable:false, editable:true, edittype:'select', editoptions:{value: "Y:Y;N:N"}}
					, {name:"AUXCODE",		index:'AUXCODE',	width:100,	align:'center', sortable:false, editable:true}
				] ,
				rowNum:1000,
				autowidth: true ,
				shrinkToFit: false,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'BANKCODE' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(id){
					if (id > 0) {
						$("#S_FLAG").val("U");
					} else {
						$("#S_FLAG").val("I");
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
		}
		
		$(function() {
			$("#selectButton").click(function() {
				v_rightLastSel = 0;
				
				f_selectBankMst();
			});
		})
		
		function f_selectKeyBankMst() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#selectButton").click();
			}
		}
		
		$(function() {
			$("#insertButton").click(function() {
				$("#S_FLAG").val("I");
				
				$("#leftList").jqGrid("addRow", 0);
			});
		})
		
		$(function() {
			$("#saveButton").click(function() {
				var ids = $("#rightList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				$('#leftList').jqGrid('saveRow',v_rightLastSel,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#leftList").jqGrid('getRowData', v_rightLastSel); //셀 전체 데이터 가져오기
				
				if (v_rightLastSel == 0 || v_rightLastSel == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				if (cellData.BANKCODE == "") {
					alert("기관 코드를 입력하셔야 합니다.");
					
					$('#leftList').jqGrid('editRow', v_rightLastSel, true);
					$("#"+ids+"_BANKCODE").focus();
					
					return false;
				}
				
				if (cellData.BANKNAME == "") {
					alert("금융기관명을 입력하셔야 합니다.");
					
					$('#leftList').jqGrid('editRow', v_rightLastSel, true);
					$("#"+ids+"_BANKNAME").focus();
					
					return false;
				}
				
				var msg = "";
				if ($("#S_FLAG").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					var formData = "S_FLAG=" + $("#S_FLAG").val() + "&BANKCODE=" + cellData.BANKCODE + "&BANKNAME=" + cellData.BANKNAME + "&USEYN=" + cellData.USEYN + "&AUXCODE=" + cellData.AUXCODE;
					
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/insertDataBankMst.do", 
						dataType : 'json',
						success: function(data){
							$("#S_FLAG_R").val("U");
							
							v_rightLastSel = 0;
							
							alert(data.resultMsg);
							
							$("#selectButton").click();
						},
						error:function(e){  
							alert("[ERROR]Menu 저장  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					$("#selectButton").click();
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
		<input type="hidden" id="S_FLAG" name="S_FLAG" />
		<div id="leftDiv" style="width:48%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">금융기관</th>
					<td><input type="text" id="S_BANKNAME" name="S_BANKNAME" onkeydown="f_selectKeyBankMst();"/></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
	</div>
</body>
</html>