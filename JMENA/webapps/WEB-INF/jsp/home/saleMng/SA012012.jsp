<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>  
<%
Date currDate = new Date();
SimpleDateFormat f = new SimpleDateFormat("yyyyMMddHHmmss");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>등기현황</title>
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
					<th width="120">기간</th>
					<td colspan="3">
						<input type="text" id="S_DEPOSITDATE_FR" /> - <input type="text" id="S_DEPOSITDATE_TO" />
					</td>
				</tr>
				<tr>
					<th width="120">매출구분</th>
					<td width="150"><select id="S_SALEGUBUN" style="width:120px"></select></td>
					<th width="120">등기여부</th>
					<td width="150">
						<select id="S_REGYN" style="width:120px">
							<option value="ALL" selected="selected">전체</option>
							<option value="Y">등기완료</option>
							<option value="N">미등기</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">주소(지번)</th>
					<td colspan="3"><input type="text" id="S_ADDRESS" /></td>
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

	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton, #excelButton").jqxButton({theme: 'energyblue', width: 80, height: 25});
		$("#S_DEPOSITDATE_FR, #S_DEPOSITDATE_TO").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##'});
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
		// 기간 초기화 : 잔금입금일
		init.setDate = function() {
			$("#S_DEPOSITDATE_FR").val(dateInput(1));
			$("#S_DEPOSITDATE_TO").val(dateInput(0));
		}
		// 매출구분 초기화
		init.setSaleGubun = function() {
			$("#S_SALEGUBUN").empty();
			$("#S_SALEGUBUN").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			
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
					$("#S_SALEGUBUN").append(sTemp);
				},
				error: function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 그리드 초기화
		init.setGrid = function() {
	        var param = {
	        	S_DEPOSITDATE_FR: $("#S_DEPOSITDATE_FR").val().replace(/[^0-9-]/g, ""),
	        	S_DEPOSITDATE_TO: $("#S_DEPOSITDATE_TO").val().replace(/[^0-9-]/g, ""),
	        	S_SALEGUBUN: $("#S_SALEGUBUN").val(),
	        	S_REGYN: $("#S_REGYN").val(),
	        	S_ADDRESS: $.trim($("#S_ADDRESS").val())
	        };
	        var source = {
        		type: "POST",
	        	url: "/home/SA012012_s1.do",
	        	data: param,
	            datatype: "json",
	            datafields: [
					{name: "SALEID", type: "string"},
					{name: "SALEDATE", type: "string"},
					{name: "NAME_SALEGUBUN", type: "string"},
					{name: "CONNAME", type: "string"},
					{name: "CONM2", type: "number"},
					{name: "CONPY", type: "number"},
					{name: "SALEDANGA", type: "number"},
					{name: "SELLAMT", type: "number"},
					{name: "NAME_REGYN", type: "string"},
					{name: "REGDATE", type: "string"},
					{name: "FULLADDRESS", type: "string"},
					{name: "KNAME", type: "string"},
					{name: "NAME_BRANCHCODE", type: "string"},
					{name: "MNGRNAME", type: "string"}
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
					{text: "매입구분", datafield: "NAME_SALEGUBUN", width: 80, cellsalign: "center", align: "center"},
					{text: "지사", datafield: "NAME_BRANCHCODE", width: 100, cellsalign: "center", align: "center"},
					{text: "실장", datafield: "MNGRNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "담당", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "계약자", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "계약날짜", datafield: "SALEDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "주소", datafield: "FULLADDRESS", width: 240, cellsalign: "left", align: "center"},
					{text: "면적", datafield: "CONM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
					{text: "평", datafield: "CONPY", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
					{text: "단가", datafield: "SALEDANGA", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "매매금액", datafield: "SELLAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "등기여부", datafield: "NAME_REGYN", width: 100, cellsalign: "center", align: "center"},
					{text: "등기일자", datafield: "REGDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "판매번호", datafield: "SALEID", width: 100, cellsalign: "center", align: "center", hidden: true}
	            ]
	        });			
		}
		
		init.setAuth();
		init.setDate();
		init.setSaleGubun();
		init.setGrid();
		
		// 조회 버튼 클릭 이벤트
		$("#selectButton").click(function() {
			if($("#S_DEPOSITDATE_FR").val().replace(/[^0-9]/g, "").length < 8) {
				alert("기간을 입력해주세요.");
				$("#S_DEPOSITDATE_FR").focus();
				return;
			}
			if($("#S_DEPOSITDATE_TO").val().replace(/[^0-9]/g, "").length < 8) {
				alert("기간을 입력해주세요.");
				$("#S_DEPOSITDATE_TO").focus();
				return;
			}
			init.setGrid();	
		});
		// 엑셀 버튼 클릭 이벤트
		$("#excelButton").click(function() {
			$("#mainGrid").jqxGrid('exportdata', 'xls', 'SA012012_<%=f.format(currDate)%>', true, null, false, null, 'utf-8'); 	
		});
	});
</script>