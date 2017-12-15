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
<script type="text/javascript">
	var init = {};
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;

	$(document).ready(function() {
		
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		
		// 매출기간-년도 초기화
		init.setYear = function() {
			var sTemp = "";
			for(var y = year; y >= 2017; y--) {
				sTemp += "<option value=\""+ y +"\">"+ y +"년</opton>";	
			}
			$("#S_YEAR").append(sTemp);
		}
		// 매출기간-월 초기화
		init.setMonth = function() {
			var sTemp = "";
			for(var m = 1; m <= 12; m++) {
				sTemp += "<option value=\""+ m +"\"";
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
				type: 'POST' ,
				url: "/codeCom/branchMstList.do", 
				dataType : 'json' , 
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
					type: 'POST' ,
					url: "/codeCom/deptMstList.do", 
					dataType : 'json' , 
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
		// 그리드 초기화
		init.setGrid = function() {
			var sMonth = $("#S_MONTH").val();
			if(sMonth.length == 1) sMonth = "0"+ sMonth;
			
			var url = "/home/selectListSA012010.do"
					+ "?S_SALEDATE="+ $("#S_YEAR").val() +"-"+ sMonth
					+ "&S_BRANCHCODE="+ $("#S_BRANCHCODE").val()
					+ "&S_DEPTCODE="+ $("#S_DEPTCODE").val()
					+ "&S_KNAME="+ encodeURI(encodeURIComponent($.trim($("#S_KNAME").val())));
			
	        // prepare the data
	        var source = {
	            datatype: "json",
	            datafields: [
					{name: "OWNERNAME", type: "string"},
					{name: "BRANCHNAME", type: "string"},
					{name: "KNAME", type: "string"},
					{name: "MNGRNAME", type: "string"},
					{name: "FULLADDRESS", type: "string"},
					{name: "CONNAME", type: "string"},
					{name: "CONM2", type: "number"},
					{name: "SALEAMT", type: "number"},
					{name: "AGENCYAMT", type: "number"}
	            ],
	            root: "rows",
	            //record: "records",
	            id: 'SALEID',
	            url: url
	        };

	        var dataAdapter = new $.jqx.dataAdapter(source, {
	            downloadComplete: function (data, status, xhr) {
	            },
	            loadComplete: function(data) {
	            	var countRow = $('#mainList').jqxGrid('getrows');
	            	$("#mainListCount").html(countRow.length);
	            },
	            loadError: function (xhr, status, error) { alert("Error~~!"); }
	        });
	        
			// initialize jqxGrid
	        $("#mainList").jqxGrid({
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
					{text: "원지주", datafield: "OWNERNAME", width: 110, cellsalign: "center", align: "center"},
					{text: "지사", datafield: "BRANCHNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "담당", datafield: "KNAME", width: 110, cellsalign: "center", align: "center"},
					{text: "실장", datafield: "MNGRNAME", width: 110, cellsalign: "center", align: "center"},
					{text: "주소", datafield: "FULLADDRESS", width: 240, cellsalign: "center", align: "center"},
					{text: "계약자", datafield: "CONNAME", width: 110, cellsalign: "center", align: "center"},
					{text: "면적", datafield: "CONM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f0"},
					{text: "매매대금", datafield: "SALEAMT", width: 140, cellsalign: "right", align: "center", cellsformat: "f0"},
					{text: "수수료", datafield: "AGENCYAMT", width: 140, cellsalign: "right", align: "center", cellsformat: "f0"}
	            ]
	          
	        });			
		}
		
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
			$("#mainList").jqxGrid('exportdata', 'xls', 'SA012010_<%=f.format(currDate)%>', true, null, true, null, 'utf-8'); 	
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
					<th width="120">매출기간</th>
					<td colspan="5">
						<select id="S_YEAR"></select>
						<select id="S_MONTH"></select>
					</td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td width="150">
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:100px"></select>
					</td>
					<th width="120">부서</th>
					<td width="150">
						<select id="S_DEPTCODE" name="S_DEPTCODE" style="width:120px"></select>
					</td>
					<th width="120">담당자명</th>
					<td><input type="text" id="S_KNAME" name="S_KNAME" maxlength="10" /></td>
				</tr>
			</table>
			<br/>
			<div align="right">총 건수 : <font color="red"><sapn id="mainListCount"></sapn></font>건</div>
			<div id="mainList"></div>
		</div>
	</div>
</body>
</html>