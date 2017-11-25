<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

</head>
<script type="text/javascript">
	var BoroughCode = "";
	var v_rightLastSel = 0;		//오른쪽 그리드 선택 id
	var auth_i = true;

	$(document).ready(function(){
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#rightInsertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#rightSaveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#RS_CITYCODE").jqxInput({theme: 'energyblue', height: 25, width: 100, maxLength: 3, minLength: 1});
		$("#RS_CITYNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#RS_SORTKEY").jqxFormattedInput({theme: 'energyblue', height: 23, width: 94, radix: 'decimal', value: ''});
		
		$("#searchButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });

		<%if ("N".equals(session.getAttribute("AUTH_I"))) { %>
			$("#insertButton").hide();
			$("#saveButton").hide();
			$("#rightInsertButton").hide();
			$("#rightSaveButton").hide();
			auth_i = false;
		<% }%>
		
		
		f_selectListEnaCityMst();
		f_selectListEnaCityDtl();		
	});


	function f_selectListEnaCityMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '지역관리'
			url:"/home/selectListEnaCityMst.do" ,
			datatype:"json" ,
			mtype: 'POST',
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['시/도 코드', '시/도 명', '정렬순서'] ,
			colModel:[
				{name:"CITYCODE",		index:'CITYCODE',		width:120,		align:'center', sortable:false}
				, {name:"CITYNAME",		index:'CITYNAME',		width:200,		align:'center', sortable:false}
				, {name:"SORTKEY",		index:'SORTKEY',		width:80,		align:'center', sortable:false}
			] ,
			rowNum:100 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'SORTKEY' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			//height: '100%' ,
			jsonReader: {
				repeatitems: false
			},
			onSelectRow: function(ids){
				v_rightLastSel = 0;
				
				$("#S_FLAG_L").val("U");
				
				var selRowData = $(this).jqGrid('getRowData', ids);
		        
				$("#RS_CITYCODE").val(selRowData.CITYCODE);
				$("#RS_CITYNAME").val(selRowData.CITYNAME);
				$("#RS_SORTKEY").val(selRowData.SORTKEY);
				
				f_selectListEnaCityDtl(selRowData.CITYCODE);
			},
			loadComplete : function() {
				v_rightLastSel = 0;
				
				var cityCode = $("#RS_CITYCODE").val();
				
				var ids = jQuery("#leftList").jqGrid('getDataIDs');
				
				ids.some(function(currentValue, index, array){
					var cellData = $("#leftList").jqGrid('getCell', ids[index], 'CITYCODE');
					if (cellData == cityCode) {
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
	
	function f_selectListEnaCityDtl(){
		$('#rightList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#rightList').jqGrid({
			//caption: '지역관리'
			url:"/home/selectListEnaCityDtl.do" ,
			datatype:"json" ,
			mtype: 'POST',
			postData : {
				CITYCODE : $("#RS_CITYCODE").val()
			},
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['시/구/군 코드', '시/구/군 명', '사용여부', '비고', '정렬순서'] ,
			colModel:[
				{name:"BOROUGHCODE",	index:'BOROUGHCODE',	width:120,	align:'center', sortable:false, editable:true}
				, {name:"BOROUGHNAME",	index:'BOROUGHNAME',	width:200,	align:'center', sortable:false, editable:true}
				, {name:"USEYN",		index:'USEYN',			width:80,	align:'center', sortable:false, editable:true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"} }
				, {name:"REMARK",		index:'REMARK',			width:250,	align:'center', sortable:false, editable:true}
				, {name:"SORTKEY",		index:'SORTKEY',		width:80,	align:'center', sortable:false, editable:true}
			] ,
			rowNum:100 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'BOROUGHCODE' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			//height: '100%' ,
			jsonReader: {
				repeatitems: false
			},
			onSelectRow : function(id) {
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
			},
			hidegrid: false
		});
	}
	
	$(function() {
		$("#searchButton").click(function() {
			if( $("#RS_CITYCODE").val() == "") {
				alert("시/도 코드를 입력하셔야 합니다."); 
				$("#RS_CITYCODE").focus();
				 
				 return false;
			}
			
			$("#RS_CITYNAME").val("");
			$("#RS_CITYNAME").focus();
			$("#RS_SORTKEY").val("");

			$('#rightList').jqGrid("clearGridData", true);
			
			f_selectListEnaCityMst();
		});
	})
	
	function f_searchCityCode() {
		var keyCode = window.event.keyCode;
		if(keyCode==13) {
			$("#searchButton").click();
		}
	}
	
	$(function(){
		$("#selectButton").click(function(){
			$("#RS_CITYCODE").val("");
			$("#RS_CITYNAME").val("");
			$("#RS_SORTKEY").val("");
			
			$('#rightList').jqGrid('clearGridData');
			
			f_selectListEnaCityMst();
		}) 
	})
	
	$(function() {
		$("#insertButton").click(function() {
			$("#S_FLAG_L").val("I");
			
			$("#RS_CITYCODE").val("");
			$("#RS_CITYNAME").val("");
			$("#RS_SORTKEY").val("");
			$("#leftList").jqGrid("resetSelection");
			$('#rightList').jqGrid('clearGridData');
			
			$("#RS_CITYCODE").focus();
		});
	})

	$(function() {
		$("#saveButton").click(function() {
			if ($("#RS_CITYCODE").val() == "") {
				alert("시/도 코드를 입력하셔야 합니다.");
				$("#RS_CITYCODE").focus();
				return false;
			}
			
			if ($("#RS_CITYNAME").val() == "") {
				alert("시/도 명을 입력하셔야 합니다.");
				$("#RS_CITYNAME").focus();
				return false;
			}
			
			if ($("#RS_SORTKEY").val() == "") {
				alert("정렬순서를 입력하셔야 합니다.");
				$("#RS_SORTKEY").focus();
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
					data: $("#SY021003").serialize(),
					url: "/home/insertEnaCityMst.do", 
					dataType : 'json' , 
					success: function(data){
						alert(data.resultMsg);
						
						if (data.resultCode == "SUCCESS") {
							f_selectListEnaCityMst();
						} else {
							$("#RS_CITYCODE").focus();
						}
					},
					error:function(e){  
						alert("[ERROR]시/도 처리  중 오류가 발생하였습니다.");
					}  
				});
			}
		});
	})
	
	function f_cityCodeSave() {
		var keyCode = window.event.keyCode;
		if(keyCode==13) {
			$("#saveButton").click();
		}
	}
	
	$(function() {
		$("#rightInsertButton").click(function() {
			var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("선택된 시/도 구분이 없습니다.");
				
				return false;
			}
			
			$("#S_FLAG_R").val("I");
			
			$("#rightList").jqGrid("addRow", 0);
		});
	})
	
	$(function() {
		$("#rightSaveButton").click(function() {
			$('#rightList').jqGrid('saveRow',v_rightLastSel,false,'clientArray'); //선택된 놈 뷰 모드로 변경

			var cellData = $("#rightList").jqGrid('getRowData', v_rightLastSel); //셀 전체 데이터 가져오기
			
			if (v_rightLastSel == 0 || v_rightLastSel == "") {
				alert("그리드를 선택하셔야 합니다.");
				
				return false;
			}
			
			if (cellData.BOROUGHCODE == "") {
				alert("시/구/군 코드를 입력하셔야 합니다.");
				
				$('#rightList').jqGrid('editRow', v_rightLastSel, true);
				$("#"+ids+"_BOROUGHCODE").focus();
				
				return false;
			}
			
			if (cellData.BOROUGHNAME == "") {
				alert("시/구/군 명을 입력하셔야 합니다.");
				
				$('#rightList').jqGrid('editRow', v_rightLastSel, true);
				$("#"+ids+"_BOROUGHNAME").focus();
				
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
				var formData = "S_FLAG_R=" + $("#S_FLAG_R").val() + "&CITYCODE=" + $("#RS_CITYCODE").val() + "&BOROUGHCODE=" + cellData.BOROUGHCODE + "&BOROUGHNAME=" + cellData.BOROUGHNAME + "&USEYN=" + cellData.USEYN + "&REMARK=" + cellData.REMARK + "&SORTKEY=" + cellData.SORTKEY;
				
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/insertEnaCityDtl.do", 
					dataType : 'json' , 
					success: function(data){
						$("#S_FLAG_R").val("U");
						
						v_rightLastSel = 0;
						
						alert(data.resultMsg);
						
						$("#searchButton").click();
					},
					error:function(e){  
						alert("[ERROR]시/도/군 정보 처리  중 오류가 발생하였습니다.");
					}  
				});
			} else {
				v_rightLastSel = 0;
				$("#searchButton").click();
			}
		});
	})
</script>
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
			<form id="SY021003">
				<input type="hidden" id="S_FLAG_L", name="S_FLAG_L" />
 				<table>
					<tr>
						<th width="120">시/도 코드</th>
						<td width="100"><input type="text" id="RS_CITYCODE" name="RS_CITYCODE" onkeydown="f_searchCityCode();"/></td>
						<td><input type="button" id='searchButton' /></td>
					</tr>
					<tr>
						<th width="120">시도 명</th>
						<td colspan="2"><input type="text" id="RS_CITYNAME" name="RS_CITYNAME" /></td>
					</tr>
					<tr>
						<th width="120">정렬순서</th>
						<td colspan="2"><input type="text" id="RS_SORTKEY" name="RS_SORTKEY" onkeydown="f_cityCodeSave();"/></td>
					</tr>
				</table>
			</form>
			<input type="hidden" id="S_FLAG_R" name="S_FLAG_R" />
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