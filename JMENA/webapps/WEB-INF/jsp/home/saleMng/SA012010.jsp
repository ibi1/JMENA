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
	<title>위탁매출 - 위탁수수료 현황</title>
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
					<td colspan="5">
						<select id="S_YEAR"></select>
						<select id="S_MONTH"></select>
					</td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td width="150"><select id="S_BRANCHCODE" style="width:120px"></select></td>
					<th width="120">부서</th>
					<td width="150"><select id="S_DEPTCODE" style="width:120px"></select></td>
					<th width="120">담당자명</th>
					<td><input type="text" id="S_KNAME" /></td>
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
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;

	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton, #excelButton").jqxButton({theme: 'energyblue', width: 80, height: 25});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150});
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
		// 년도 초기화 : 잔금입금일
		init.setYear = function() {
			var sTemp = "";
			for(var y = year + 1; y >= 2013; y--) {
				sTemp += "<option value=\""+ y +"\"";
					if(y == year) sTemp += " selected=\"selected\"";
				sTemp += ">"+ y +"년</opton>";	
			}
			$("#S_YEAR").append(sTemp);
		}
		// 월 초기화 : 잔금입금일
		init.setMonth = function() {
			var sTemp = "";
			for(var m = 1; m <= 12; m++) {
				sTemp += "<option value=\""+ addZero(m) +"\"";
					if(m == month) sTemp += " selected=\"selected\"";
				sTemp += ">"+ m +"월</opton>";	
			}
			$("#S_MONTH").append(sTemp);
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
		// 부서 초기화
		init.setDept = function(c) {
			$("#S_DEPTCODE").empty();
			$("#S_DEPTCODE").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			
			if(c) {
			   	$.ajax({ 
			   		type: "POST",
					url: "/codeCom/deptMstList.do", 
					dataType: "json",
					data : {BRANCHCODE : c},
					success: function(data) {
						var sTemp = "";
						data.deptMstList.forEach(function(currentValue, index, array) {
							sTemp += "<option value=\"" + currentValue.DEPTCODE + "\">" + currentValue.DEPTNAME + "</option>";
						});
						$("#S_DEPTCODE").append(sTemp);
					},
					error: function(e) {  
						alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
					}  
				});
			}
		}
		// 그리드 초기화
		init.setGrid = function() {
	        var param = {
	        	S_DEPOSITDATE: $("#S_YEAR").val() +"-"+ $("#S_MONTH").val(),
	        	S_BRANCHCODE: $("#S_BRANCHCODE").val(),
	        	S_DEPTCODE: $("#S_DEPTCODE").val(),
	        	S_KNAME: $.trim($("#S_KNAME").val())
	        };
	        var source = {
        		type: "POST",
	        	url: "/home/selectListSA012010.do",
	        	data: param,
	            datatype: "json",
	            datafields: [
					{name: "SALEID", type: "string"},
					{name: "OWNERNAME", type: "string"},
					{name: "DEPOSITDATE", type: "string"},
					{name: "BRANCHNAME", type: "string"},
					{name: "DEPTNAME", type: "string"},
					{name: "KNAME", type: "string"},
					{name: "MNGRNAME", type: "string"},
					{name: "FULLADDRESS", type: "string"},
					{name: "CONNAME", type: "string"},
					{name: "CONM2", type: "number"},
					{name: "SELLAMT", type: "number"},
					{name: "AGENCYAMT", type: "number"}
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
					{text: "판매번호", datafield: "SALEID", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "원지주", datafield: "OWNERNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "잔금완료일", datafield: "DEPOSITDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "지사", datafield: "BRANCHNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "부서", datafield: "DEPTNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "담당", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "실장", datafield: "MNGRNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "주소", datafield: "FULLADDRESS", width: 240, cellsalign: "left", align: "center"},
					{text: "계약자", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "면적", datafield: "CONM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
					{text: "매매대금", datafield: "SELLAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "수수료", datafield: "AGENCYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"}
	            ]
	        });			
		}
		
		init.setAuth();
		init.setYear();
		init.setMonth();
		init.setBranch();
		init.setDept();
		init.setGrid();
		
		// 지사 콤보 체인지 이벤트
		$("#S_BRANCHCODE").change(function() {
			init.setDept($(this).val());
		});
		// 조회 버튼 클릭 이벤트
		$("#selectButton").click(function() {
			init.setGrid();	
		});
		// 엑셀 버튼 클릭 이벤트
		$("#excelButton").click(function() {
			$("#mainGrid").jqxGrid('exportdata', 'xls', 'SA012010_<%=f.format(currDate)%>', true, null, false, null, 'utf-8'); 	
		});
	});
</script>