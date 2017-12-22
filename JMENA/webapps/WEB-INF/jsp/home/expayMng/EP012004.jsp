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
<title>소득세 및 부가가치세 신고 현황</title>
<script type="text/javascript">
	var init = {};

	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton").jqxButton({width: 80, height: 25, theme: 'energyblue'});
		$("#excelButton").jqxButton({width: 80, height: 25, theme: 'energyblue'});
		$("#S_PAYDATE_FR").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
		$("#S_PAYDATE_TO").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1, maxLength: 10});
		// 기간 초기화 : 수당지급일
		init.setDate = function() {
			$("#S_PAYDATE_FR").val(dateInput(1));
			$("#S_PAYDATE_TO").val(dateInput(0));
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
		// 소득구분 초기화
		init.setTaxGubun = function() {
			$("#S_TAXGUBUN").empty();
			$("#S_TAXGUBUN").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			
			$.ajax({ 
				type: "POST" ,
				url: "/codeCom/dcodeList.do", 
				dataType : "json",
				data : {CCODE : "013"},
				success: function(data) {
					var sTemp = "";
					data.dcodeList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.DCODE + "\">" + currentValue.DCODENAME + "</option>";
					});
					$("#S_TAXGUBUN").append(sTemp);
				},
				error:function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 그리드 초기화
		init.setGrid = function() {
			var url = "/home/selectListEP012004.do"
					+ "?S_PAYDATE_FR="+ $("#S_PAYDATE_FR").val()
					+ "&S_PAYDATE_TO="+ $("#S_PAYDATE_TO").val()
					+ "&S_TAXGUBUN="+ $("#S_TAXGUBUN").val()
					+ "&S_BRANCHCODE="+ $("#S_BRANCHCODE").val()
					+ "&S_DEPTCODE="+ $("#S_DEPTCODE").val()
					+ "&S_KNAME="+ encodeURI(encodeURIComponent($.trim($("#S_KNAME").val())));
			
	        // prepare the data
	        var source = {
	            datatype: "json",
	            datafields: [
					{name: "SALEID", type: "string"},
					{name: "PAYSEQ", type: "string"},
					{name: "REGISTERSEQ", type: "string"},
					{name: "KNAME", type: "string"},
					{name: "PAYERNAME", type: "string"},
					{name: "PAYERID", type: "string"},
					{name: "PAYDATE", type: "string"},
					{name: "FULLADDRESS", type: "string"},
					{name: "CONNAME", type: "string"},
					{name: "CONPY", type: "number"},
					{name: "PAYAMT", type: "number"},
					{name: "SUPPLYTAX", type: "number"},
					{name: "TAXINCOME", type: "number"},
					{name: "TAXLOCAL", type: "number"},
					{name: "DEDUCTAMT", type: "number"}
	            ],
	            root: "rows",
	            url: url
	        };
	        var dataAdapter = new $.jqx.dataAdapter(source, {
	            loadComplete: function(data) {	     
	            	console.info(data);
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
					{text: "지급순번", datafield: "PAYSEQ", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "신고인순번", datafield: "REGISTERSEQ", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "담당", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "소득신고인", datafield: "PAYERNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "주민번호", datafield: "PAYERID", width: 140, cellsalign: "center", align: "center"},
					{text: "지급일", datafield: "PAYDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "물건지", datafield: "FULLADDRESS", width: 240, cellsalign: "left", align: "center"},
					{text: "고객", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "평수", datafield: "CONPY", width: 80, cellsalign: "right", align: "center", cellsformat: "f"},
					{text: "지급액", datafield: "PAYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "부가세", datafield: "SUPPLYTAX", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "소득세", datafield: "TAXINCOME", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "주민세", datafield: "TAXLOCAL", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "실지급액", datafield: "DEDUCTAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"}
	            ]
	        });			
		}
		
		init.setDate();
		init.setBranch();
		init.setDept();
		init.setTaxGubun();
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
			$("#grdList").jqxGrid('exportdata', 'xls', 'EP012004_<%=f.format(currDate)%>', true, null, false, null, 'utf-8'); 	
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
						<input type="text" id="S_PAYDATE_FR" /> -
						<input type="text" id="S_PAYDATE_TO" />
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
					<th width="120">소득구분</th>
					<td colspan="5">
						<select id="S_TAXGUBUN" style="width:120px"></select>	
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