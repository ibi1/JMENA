<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<title>계약현황</title>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<td align="right">
						<input type="button" value="조회" id="selectButton" />
						<input type="button" value="엑셀" id="excelButton" />
					</td>
				</tr>
			</table>
		</div>
		<div id="mainDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">매입기간</th>
					<td colspan="5">
						<input type="text" id="S_BUYDATE_FR" /> - <input type="text" id="S_BUYDATE_TO" />
					</td>
				</tr>
				<tr>
					<th width="120">매입구분</th>
					<td width="150"><select id="S_BUYGUBUN" style="width:120px"></select></td>
					<th width="120">지사</th>
					<td width="150"><select id="S_BRANCHCODE" style="width:120px"></select></td>
					<th width="120">담당자</th>
					<td width="150"><input type="text" id="S_KNAME" /></td>
				</tr>
				<tr>
					<th width="120">주소(지번)</th>
					<td colspan="5"><input type="text" id="S_ADDRESS" /></td>
				</tr>
			</table>
			<div align="right" style="padding-top:10px; padding-bottom:3px">
				총 건수 : <font color="red"><sapn id="mainGridCount"></sapn></font>건
			</div>
			<div id="mainGrid"></div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var init = {};
	var leftGridData = {};
	
	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton, #excelButton").jqxButton({theme: 'energyblue', width: 80, height: 25});
		$("#S_BUYDATE_FR, #S_BUYDATE_TO").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##'});
		$("#S_KNAME, #S_CONNAME").jqxInput({theme: 'energyblue', width: 150, height: 25});
		$("#S_ADDRESS").jqxInput({theme: 'energyblue', width: 250, height: 25});
		// 버튼권한 설정
		init.setAuth = function() {
			<%if("N".equals(session.getAttribute("AUTH_I"))) {%>
			<%}%>
			<%if("N".equals(session.getAttribute("AUTH_D"))) {%>
			<%}%>
			<%if("N".equals(session.getAttribute("AUTH_P"))) {%>
			$("#excelButton").hide();
			<%}%>
		}
		// 매입기간 초기화
		init.setDate = function() {
			$("#S_BUYDATE_FR").val(dateInput(1));
			$("#S_BUYDATE_TO").val(dateInput(0));
		}
		// 매입구분 초기화
		init.setBuyGubun = function() {
			$("#S_BUYGUBUN").empty();
			$("#S_BUYGUBUN").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			
			$.ajax({ 
				type: "POST" ,
				url: "/codeCom/dcodeList.do", 
				dataType: "json",
				data : {CCODE : "007"},
				success: function(data) {
					var sTemp = "";
					data.dcodeList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.DCODE + "\">" + currentValue.DCODENAME + "</option>";
					});
					$("#S_BUYGUBUN").append(sTemp);
				},
				error: function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 지사 초기화
		init.setBranch = function() {
			$("#S_BRANCHCODE").empty();
			$("#S_BRANCHCODE").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			
			$.ajax({ 
				type: "POST",
				url: "/codeCom/branchMstList.do", 
				dataType: "json", 
				success: function(data) {
					var sTemp = "";
					data.branchMstList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.BRANCHCODE + "\">" + currentValue.BRANCHNAME + "</option>";
					});
					$("#S_BRANCHCODE").append(sTemp);
				},
				error: function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 그리드 초기화
		init.setMainGrid = function() {
	        var param = {
        		S_BUYDATE_FR: $("#S_BUYDATE_FR").val().replace(/[^0-9-]/g, ""),
        		S_BUYDATE_TO: $("#S_BUYDATE_TO").val().replace(/[^0-9-]/g, ""),
        		S_BUYGUBUN: $("#S_BUYGUBUN").val(),
        		S_BRANCHCODE: $("#S_BRANCHCODE").val(),
        		S_KNAME: $.trim($("#S_KNAME").val()),
        		S_CONNAME: $.trim($("#S_CONNAME").val()),
        		S_ADDRESS: $.trim($("#S_ADDRESS").val())
	        };
	        var source = {
	        	type: "POST",
	        	url: "/home/MM012003_s1.do",
	        	data: param,
	            datatype: "json",
	            datafields: [
					{name: "BUYID", type: "string"},
					{name: "BUYDATE", type: "string"},
					{name: "OWNERNAME", type: "string"},
					{name: "ADDRESS", type: "string"},
					{name: "BUYM2", type: "number"},
					{name: "BUYAMT", type: "number"},
					{name: "SALEID", type: "string"},
					{name: "SALEDATE", type: "string"},
					{name: "CONNAME", type: "string"},
					{name: "CONM2", type: "number"},
					{name: "REMM2", type: "number"},
					{name: "DCRATE", type: "number"},
					{name: "SELLAMT", type: "number"},
					{name: "DEPOSITDATE", type: "string"},
					{name: "KNAME", type: "string"},
					{name: "NAME_BRANCHCODE", type: "string"}
	            ],
	            root: "rows"
	        };
	        var dataAdapter = new $.jqx.dataAdapter(source, {
	            loadComplete: function(data) {	            	
	            	var countRow = $("#mainGrid").jqxGrid("getrows");
	            	$("#mainGridCount").text(countRow.length);
	            },
	            loadError: function(x, s, e) {
	            	alert("[ERROR]"+ e);
	            }
	        });
	        $("#mainGrid").jqxGrid({
	        	theme: 'energyblue',
	        	sorttogglestates: 0,
	        	sortable: false,
	            width: '100%',
	            source: dataAdapter,                
	            pageable: false,
	            autoheight: false,
	            altrows: true,
	            enabletooltips: true,
	            editable: false,
	            selectionmode: 'singlerow',
	            columnsresize: true,
	            columns: [
					{text: "매입일", datafield: "BUYDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "매도자", datafield: "OWNERNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "지번", datafield: "ADDRESS", width: 200, cellsalign: "left", align: "center"},
					{text: "면적", datafield: "BUYM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
					{text: "금액", datafield: "BUYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "계약일", datafield: "SALEDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "지사", datafield: "NAME_BRANCHCODE", width: 80, cellsalign: "center", align: "center"},
					{text: "담당", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "계약자", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "면적", datafield: "CONM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
					{text: "잔여면적", datafield: "REMM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
					{text: "DC율", datafield: "DCRATE", width: 50, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "실판매가", datafield: "SELLAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "잔금여부", datafield: "DEPOSITDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "구매번호", datafield: "BUYID", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "판매번호", datafield: "SALEID", width: 100, cellsalign: "center", align: "center", hidden: true}
	            ]
	        });
		}
		
		init.setAuth();
		init.setDate();
		init.setBuyGubun();
		init.setBranch();
		init.setMainGrid();
		
		// 조회 버튼 클릭 이벤트
		$("#selectButton").click(function() {
			if($("#S_BUYDATE_FR").val().replace(/[^0-9]/g, "").length < 8) {
				alert("매입기간을 입력해주세요.");
				$("#S_BUYDATE_FR").focus();
				return;
			}
			if($("#S_BUYDATE_TO").val().replace(/[^0-9]/g, "").length < 8) {
				alert("매입기간을 입력해주세요.");
				$("#S_BUYDATE_TO").focus();
				return;
			}
			init.setMainGrid();
		});
		// 엑셀 버튼 클릭 이벤트
		$("#excelButton").click(function() {
			//$("#mainGrid").jqxGrid('exportdata', 'xls', 'MM012003', true, null, false, null, 'utf-8');
			if($.trim($("#mainGridCount").text()) == "0") {
				alert("엑셀로 내려받을 데이터가 없습니다.");
				return;
			} else {
				var param = {
	        		S_BUYDATE_FR: $("#S_BUYDATE_FR").val().replace(/[^0-9-]/g, ""),
	        		S_BUYDATE_TO: $("#S_BUYDATE_TO").val().replace(/[^0-9-]/g, ""),
	        		S_BUYGUBUN: $("#S_BUYGUBUN").val(),
	        		S_BRANCHCODE: $("#S_BRANCHCODE").val(),
	        		S_KNAME: $.trim($("#S_KNAME").val()),
	        		S_CONNAME: $.trim($("#S_CONNAME").val()),
	        		S_ADDRESS: $.trim($("#S_ADDRESS").val())
		        };
				$.download("/home/MM012003_e1.do", param, "post");
			};
		});
	});
</script>