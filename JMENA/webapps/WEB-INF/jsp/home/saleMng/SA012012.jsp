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
<script type="text/javascript">
	var init = {};

	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton").jqxButton({width: 80, height: 25, theme: 'energyblue'});
		$("#excelButton").jqxButton({width: 80, height: 25, theme: 'energyblue'});
		$("#S_DEPOSITDATE_FR").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
		$("#S_DEPOSITDATE_TO").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
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
				dataType : "json",
				data : {CCODE : "007"},
				success: function(data) {
					var sTemp = "";
					data.dcodeList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.DCODE + "\">" + currentValue.DCODENAME + "</option>";
					});
					$("#S_SALEGUBUN").append(sTemp);
				},
				error:function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 등기구분 초기화
		init.setRegGubun = function() {
			$("#S_REGYN").empty();
			
			var sTemp = "";
			sTemp += "<option value=\"ALL\" selected=\"selected\">전체</option>";
			sTemp += "<option value=\"Y\">등기완료</option>";
			sTemp += "<option value=\"N\">미등기</option>";
			$("#S_REGYN").append(sTemp);
		}
		// 그리드 초기화
		init.setGrid = function() {
			var url = "/home/selectListSA012012.do"
					+ "?S_DEPOSITDATE_FR="+ $("#S_DEPOSITDATE_FR").val()
					+ "&S_DEPOSITDATE_TO="+ $("#S_DEPOSITDATE_TO").val()
					+ "&S_SALEGUBUN="+ $("#S_SALEGUBUN").val()
					+ "&S_REGYN="+ $("#S_REGYN").val();
			
	        // prepare the data
	        var source = {
	            datatype: "json",
	            datafields: [
					{name: "SALEID", type: "string"},
					{name: "SALEGUBUNNAME", type: "string"},
					{name: "KNAME", type: "string"},
					{name: "MNGRNAME", type: "string"},
					{name: "CONNAME", type: "string"},
					{name: "SALEDATE", type: "string"},
					{name: "FULLADDRESS", type: "string"},
					{name: "CONM2", type: "number"},
					{name: "CONPY", type: "number"},
					{name: "SALEDANGA", type: "number"},
					{name: "SELLAMT", type: "number"},
					{name: "REGNAME", type: "string"},
					{name: "REGDATE", type: "string"}
	            ],
	            root: "rows",
	            //record: "records",
	            id: 'SALEID',
	            url: url
	        };
	        var dataAdapter = new $.jqx.dataAdapter(source, {
	            loadComplete: function(data) {	            	
	            	var countRow = $('#grdList').jqxGrid('getrows');
	            	$("#grdRowCount").html(countRow.length);
	            },
	            loadError: function (xhr, status, error) { alert("Error~~!"); }
	        });
			// initialize jqxGrid
	        $("#grdList").jqxGrid({
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
	            columns: [
					{text: "판매번호", datafield: "SALEID", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "매입구분", datafield: "SALEGUBUNNAME", width: 80, cellsalign: "center", align: "center"},
					{text: "담당", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "실장", datafield: "MNGRNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "계약자", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "계약날짜", datafield: "SALEDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "주소", datafield: "FULLADDRESS", width: 240, cellsalign: "left", align: "center"},
					{text: "면적", datafield: "CONM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f"},
					{text: "평", datafield: "CONPY", width: 80, cellsalign: "right", align: "center", cellsformat: "f"},
					{text: "단가", datafield: "SALEDANGA", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "매매금액", datafield: "SELLAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "등기여부", datafield: "REGNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "등기일자", datafield: "REGDATE", width: 100, cellsalign: "center", align: "center"}
	            ]
	        });			
		}
		
		init.setDate();
		init.setSaleGubun();
		init.setRegGubun();
		init.setGrid();
		
		// 조회 버튼 클릭 이벤트
		$("#selectButton").click(function() {
			init.setGrid();	
		});
		// 엑셀 버튼 클릭 이벤트
		$("#excelButton").click(function() {
			$("#grdList").jqxGrid('exportdata', 'xls', 'SA012012_<%=f.format(currDate)%>', true, null, false, null, 'utf-8'); 	
		});
	});
</script>
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
					<td>
						<input type="text" id="S_DEPOSITDATE_FR" /> -
						<input type="text" id="S_DEPOSITDATE_TO" />
					</td>
				</tr>
				<tr>
					<th width="120">검색기준</th>
					<td>
						<select id="S_SALEGUBUN" style="width:120px"></select>	
					</td>
				</tr>
				<tr>
					<th width="120">검색기준</th>
					<td>
						<select id="S_REGYN" style="width:120px"></select>	
					</td>
				</tr>
			</table>
			<br/>
			<div align="right">총 건수 : <font color="red"><sapn id="grdRowCount"></sapn></font>건</div>
			<div id="grdList"></div>
		</div>
	</div>
</body>
</html>