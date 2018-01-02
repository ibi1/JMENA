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
	<title>매입현황</title>
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
					<th width="120">매출기간</th>
					<td>
						<input type="text" id="S_BUYDATE_FR" /> -
						<input type="text" id="S_BUYDATE_TO" />
					</td>
				</tr>
				<tr>
					<th width="120">검색기준</th>
					<td>
						<select id="S_BUYGUBUN" style="width:120px"></select>
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
		$("#selectButton, #excelButton").jqxButton({width: 80, height: 25, theme: 'energyblue'});
		$("#S_BUYDATE_FR, #S_BUYDATE_TO").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
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
		// 매출기간 초기화
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
				dataType : "json",
				data : {CCODE : "014"},
				success: function(data) {
					var sTemp = "";
					data.dcodeList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.DCODE + "\">" + currentValue.DCODENAME + "</option>";
					});
					$("#S_BUYGUBUN").append(sTemp);
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
			sTemp += "<option value=\"R\">잔량</option>";
			sTemp += "<option value=\"Y\">등기완료</option>";
			sTemp += "<option value=\"N\">미등기</option>";
			$("#S_REGYN").append(sTemp);
		}
		// 그리드 초기화
		init.setMainGrid = function() {
			var param = {
				S_BUYDATE_FR: $("#S_BUYDATE_FR").val(),
				S_BUYDATE_TO: $("#S_BUYDATE_TO").val(),
				S_BUYGUBUN: $("#S_BUYGUBUN").val(),
				S_REGYN: $("#S_REGYN").val()
			};
	        var source = {
	        	type: "POST",
	        	url: "/home/selectListMM012002.do",
	        	data: param,
	        	datatype: "json",
	            datafields: [
					{name: "BUYID", type: "string"},
					{name: "BUYGUBUNNAME", type: "string"},
					{name: "OWNERNAME", type: "string"},
					{name: "BUYDATE", type: "string"},
					{name: "FULLADDRESS", type: "string"},
					{name: "BUYM2", type: "number"},
					{name: "BUYPY", type: "number"},
					{name: "BUYDANGA", type: "number"},
					{name: "BUYAMT", type: "number"},
					{name: "REGNAME", type: "string"},
					{name: "REGDATE", type: "string"},
					{name: "CONM2", type: "number"},
					{name: "REMM2", type: "number"}
	            ],
	            root: "rows"
	        };
	        var dataAdapter = new $.jqx.dataAdapter(source, {
	            loadComplete: function(data) {	            	
	            	var countRow = $("#mainGrid").jqxGrid("getrows");
	            	$("#mainGridCount").html(countRow.length);
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
					{text: "구매번호", datafield: "BUYID", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "매입구분", datafield: "BUYGUBUNNAME", width: 80, cellsalign: "center", align: "center"},
					{text: "원지주", datafield: "OWNERNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "계약날짜", datafield: "BUYDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "주소", datafield: "FULLADDRESS", width: 240, cellsalign: "left", align: "center"},
					{text: "면적", datafield: "BUYM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f"},
					{text: "평", datafield: "BUYPY", width: 80, cellsalign: "right", align: "center", cellsformat: "f"},
					{text: "단가", datafield: "BUYDANGA", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "매매금액", datafield: "BUYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "등기여부", datafield: "REGNAME", width: 80, cellsalign: "center", align: "center"},
					{text: "등기일자", datafield: "REGDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "매출면적", datafield: "CONM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f"},
					{text: "잔여면적", datafield: "REMM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f"}
	            ]
	        });			
		}
		
		init.setAuth();
		init.setDate();
		init.setBuyGubun();
		init.setRegGubun();
		init.setMainGrid();
		
		// 조회 버튼 클릭 이벤트
		$("#selectButton").click(function() {
			init.setMainGrid();	
		});
		// 엑셀 버튼 클릭 이벤트
		$("#excelButton").click(function() {
			$("#mainGrid").jqxGrid('exportdata', 'xls', 'MM012002_<%=f.format(currDate)%>', true, null, false, null, 'utf-8'); 	
		});
	});
</script>