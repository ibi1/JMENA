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
<title>매출현황</title>
<script type="text/javascript">
	var init = {};

	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton").jqxButton({width: 80, height: 25, theme: 'energyblue'});
		$("#excelButton").jqxButton({width: 80, height: 25, theme: 'energyblue'});
		$("#S_BUYDATE_FR").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
		$("#S_BUYDATE_TO").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1, maxLength: 10});
		// 매출기간 초기화
		init.setDate = function() {
			$("#S_BUYDATE_FR").val(dateInput(1));
			$("#S_BUYDATE_TO").val(dateInput(0));
		}
		// 지사 초기화
		init.setBranch = function() {
			$("#S_BRANCHCODE").empty();
			$("#S_BRANCHCODE").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			
			$.ajax({ 
				type: "POST",
				url: "/codeCom/branchMstList.do", 
				dataType : "json", 
				success: function(data) {
					var sTemp = "";
					data.branchMstList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.BRANCHCODE + "\">" + currentValue.BRANCHNAME + "</option>";
					});
					$("#S_BRANCHCODE").append(sTemp);
				},
				error:function(e) {  
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
					dataType : "json", 
					data : {
						BRANCHCODE : c,
					},
					success: function(data) {
						var sTemp = "";
						data.deptMstList.forEach(function(currentValue, index, array) {
							sTemp += "<option value=\"" + currentValue.DEPTCODE + "\">" + currentValue.DEPTNAME + "</option>";
						});
						$("#S_DEPTCODE").append(sTemp);
					},
					error:function(e) {  
						alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
					}  
				});
			}
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
		// 그리드 초기화
		init.setGrid = function() {
			var url = "/home/selectListSA012011.do"
					+ "?S_BUYDATE_FR="+ $("#S_BUYDATE_FR").val()
					+ "&S_BUYDATE_TO="+ $("#S_BUYDATE_TO").val()
					+ "&S_BRANCHCODE="+ $("#S_BRANCHCODE").val()
					+ "&S_DEPTCODE="+ $("#S_DEPTCODE").val()
					+ "&S_KNAME="+ encodeURI(encodeURIComponent($.trim($("#S_KNAME").val())))
					+ "&S_SALEGUBUN="+ $("#S_SALEGUBUN").val();
			
	        // prepare the data
	        var source = {
	            datatype: "json",
	            datafields: [
					{name: "SALEID", type: "string"},
					{name: "SALEGUBUNNAME", type: "string"},
					{name: "BRANCHNAME", type: "string"},
					{name: "SALEDATE", type: "string"},
					{name: "KNAME", type: "string"},
					{name: "MNGRNAME", type: "string"},
					{name: "CONNAME", type: "string"},
					{name: "FULLADDRESS", type: "string"},
					{name: "CONPY", type: "number"},
					{name: "SALEAMT", type: "number"},
					{name: "DCAMT", type: "number"},
					{name: "SELLAMT", type: "number"},
					{name: "AGENCYAMT", type: "number"}
	            ],
	            root: "rows",
	            //record: "records",
	            id: 'BUYID',
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
					{text: "매출구분", datafield: "SALEGUBUNNAME", width: 80, cellsalign: "center", align: "center"},
					{text: "지사", datafield: "BRANCHNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "계약날짜", datafield: "SALEDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "담당", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "실장", datafield: "MNGRNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "고객", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "물건지", datafield: "FULLADDRESS", width: 240, cellsalign: "left", align: "center"},
					{text: "평수", datafield: "CONPY", width: 80, cellsalign: "right", align: "center", cellsformat: "f"},
					{text: "매매가", datafield: "SALEAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "DC금액", datafield: "DCAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "실판매가", datafield: "SELLAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "위탁수수료", datafield: "AGENCYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"}
	            ]
	        });			
		}
		
		init.setDate();
		init.setBranch();
		init.setDept();
		init.setSaleGubun();
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
			$("#grdList").jqxGrid('exportdata', 'xls', 'SA012011_<%=f.format(currDate)%>', true, null, false, null, 'utf-8'); 	
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
					<td colspan="5">
						<input type="text" id="S_BUYDATE_FR" /> -
						<input type="text" id="S_BUYDATE_TO" />
					</td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td width="150">
						<select id="S_BRANCHCODE" style="width:120px"></select>
					</td>
					<th width="120">부서</th>
					<td width="150">
						<select id="S_DEPTCODE" style="width:120px"></select>
					</td>
					<th width="120">담당자명</th>
					<td width="150"><input type="text" id="S_KNAME" /></td>
				</tr>
				<tr>
					<th width="120">검색기준</th>
					<td colspan="5">
						<select id="S_SALEGUBUN" style="width:120px"></select>
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