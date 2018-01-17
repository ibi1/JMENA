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
	<title>해약현황</title>
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
					<th width="120">해약기간</th>
					<td colspan="5">
						<input type="text" id="S_CHGDATE_FR" /> - <input type="text" id="S_CHGDATE_TO" />
					</td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td width="150"><select id="S_BRANCHCODE" style="width:120px"></select></td>
					<th width="120">담당자</th>
					<td width="180"><input type="text" id="S_KNAME" /></td>
					<th width="120">계약자</th>
					<td width="150"><input type="text" id="S_CONNAME" /></td>
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
		$("#S_CHGDATE_FR, #S_CHGDATE_TO").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##'});
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
		// 해약기간 초기화
		init.setDate = function() {
			$("#S_CHGDATE_FR").val(dateInput(1));
			$("#S_CHGDATE_TO").val(dateInput(0));
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
        		S_CHGDATE_FR: $("#S_CHGDATE_FR").val().replace(/[^0-9-]/g, ""),
        		S_CHGDATE_TO: $("#S_CHGDATE_TO").val().replace(/[^0-9-]/g, ""),
        		S_BRANCHCODE: $("#S_BRANCHCODE").val(),
        		S_KNAME: $.trim($("#S_KNAME").val()),
        		S_CONNAME: $.trim($("#S_CONNAME").val()),
        		S_ADDRESS: $.trim($("#S_ADDRESS").val())
	        };
	        var source = {
	        	type: "POST",
	        	url: "/home/SA012013_s1.do",
	        	data: param,
	            datatype: "json",
	            datafields: [
					{name: "SALEID", type: "string"},
					{name: "SALEDATE", type: "string"},
					{name: "SALEGUBUN", type: "string"},
					{name: "NAME_SALEGUBUN", type: "string"},
					{name: "SALERCD", type: "string"},
					{name: "CONNAME", type: "string"},
					{name: "ADDRESS", type: "string"},
					{name: "CONM2", type: "number"},
					{name: "CONPY", type: "number"},
					{name: "CHGDATE", type: "string"},
					{name: "SELLAMT", type: "number"},
					{name: "CONPYDANGA", type: "number"},
					{name: "SUGUMAMT1", type: "number"},
					{name: "SUGUMAMT2", type: "number"},
					{name: "SUGUMAMT3", type: "number"},
					{name: "SUM_SUGUMAMT", type: "number"},
					{name: "REFUNDAMT", type: "number"},
					{name: "REFUNDDATE", type: "string"},
					{name: "KNAME", type: "string"},
					{name: "BRANCHCODE", type: "string"},
					{name: "NAME_BRANCHCODE", type: "string"},
					{name: "SUM_SUGUMRATE", type: "number"},
					{name: "REFUNDRATE", type: "number"}
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
					{text: "매출구분", datafield: "NAME_SALEGUBUN", width: 80, cellsalign: "center", align: "center"},
					{text: "해약일자", datafield: "CHGDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "계약일자", datafield: "SALEDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "지사", datafield: "NAME_BRANCHCODE", width: 100, cellsalign: "center", align: "center"},
					{text: "담당자", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "고객명", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "계약물건", datafield: "ADDRESS", width: 200, cellsalign: "left", align: "center"},
					{text: "계약면적", datafield: "CONM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
					{text: "계약평수", datafield: "CONPY", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},					
					{text: "실판매가", datafield: "SELLAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "평단가", datafield: "CONPYDANGA", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "계약금", datafield: "SUGUMAMT1", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "중도금", datafield: "SUGUMAMT2", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "잔금", datafield: "SUGUMAMT3", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "입금총액", datafield: "SUM_SUGUMAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "입금율", datafield: "SUM_SUGUMRATE", width: 60, cellsalign: "right", align: "center"},
					{text: "환불액", datafield: "REFUNDAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "환불율", datafield: "REFUNDRATE", width: 60, cellsalign: "right", align: "center"},
					{text: "환불일", datafield: "REFUNDDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "계약번호", datafield: "SALEID", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "매출구분(코드)", datafield: "SALEGUBUN", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "담당자(코드)", datafield: "SALERCD", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "지사(코드)", datafield: "BRANCHCODE", width: 100, cellsalign: "center", align: "center", hidden: true}
	            ]
	        });
		}
		
		init.setAuth();
		init.setDate();
		init.setBranch();
		init.setMainGrid();
		
		// 조회 버튼 클릭 이벤트
		$("#selectButton").click(function() {
			if($("#S_CHGDATE_FR").val().replace(/[^0-9]/g, "").length < 8) {
				alert("해약기간을 입력해주세요.");
				$("#S_CHGDATE_FR").focus();
				return;
			}
			if($("#S_CHGDATE_TO").val().replace(/[^0-9]/g, "").length < 8) {
				alert("해약기간을 입력해주세요.");
				$("#S_CHGDATE_TO").focus();
				return;
			}
			init.setMainGrid();
		});
		// 엑셀 버튼 클릭 이벤트
		$("#excelButton").click(function() {
			$("#mainGrid").jqxGrid('exportdata', 'xls', 'SA012013_<%=f.format(currDate)%>', true, null, false, null, 'utf-8'); 	
		});
	});
</script>