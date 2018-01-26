<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>매출현황</title>
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
						<input type="text" id="S_DEPOSITDATE_FR" /> - <input type="text" id="S_DEPOSITDATE_TO" />
					</td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td width="150"><select id="S_BRANCHCODE" style="width:120px"></select></td>
					<th width="120">부서</th>
					<td width="150"><select id="S_DEPTCODE" style="width:120px"></select></td>
					<th width="120">담당자명</th>
					<td width="150"><input type="text" id="S_KNAME" /></td>
				</tr>
				<tr>
					<th width="120">매출구분</th>
					<td colspan="5"><select id="S_SALEGUBUN" style="width:120px"></select></td>
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
		// 기간 초기화 : 잔금입금일
		init.setDate = function() {
			$("#S_DEPOSITDATE_FR").val(dateInput(1));
			$("#S_DEPOSITDATE_TO").val(dateInput(0));
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
	        	S_BRANCHCODE: $("#S_BRANCHCODE").val(),
	        	S_DEPTCODE: $("#S_DEPTCODE").val(),
	        	S_KNAME: $.trim($("#S_KNAME").val()),
	        	S_SALEGUBUN: $("#S_SALEGUBUN").val()
	        };
	        var source = {
        		type: "POST",
	        	url: "/home/SA012011_s1.do",
	        	data: param,
	            datatype: "json",
	            datafields: [
					{name: "SALEID", type: "string"},
					{name: "DEPOSITDATE", type: "string"},
					{name: "SALEDATE", type: "string"},
					{name: "NAME_SALEGUBUN", type: "string"},
					{name: "CONNAME", type: "string"},
					{name: "CONPY", type: "number"},
					{name: "SALEAMT", type: "number"},
					{name: "DCAMT", type: "number"},
					{name: "SELLAMT", type: "number"},
					{name: "AGENCYAMT", type: "number"},
					{name: "FULLADDRESS", type: "string"},
					{name: "KNAME", type: "string"},
					{name: "BRANCHNAME", type: "string"},
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
					{text: "매출구분", datafield: "NAME_SALEGUBUN", width: 80, cellsalign: "center", align: "center"},
					{text: "지사", datafield: "BRANCHNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "계약날짜", datafield: "SALEDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "잔금입금일", datafield: "DEPOSITDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "담당", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "실장", datafield: "MNGRNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "고객", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "물건지", datafield: "FULLADDRESS", width: 240, cellsalign: "left", align: "center"},
					{text: "평수", datafield: "CONPY", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
					{text: "매매가", datafield: "SALEAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "DC금액", datafield: "DCAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "실판매가", datafield: "SELLAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "위탁수수료", datafield: "AGENCYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "판매번호", datafield: "SALEID", width: 100, cellsalign: "center", align: "center", hidden: true}
	            ]
	        });			
		}
		
		init.setAuth();
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
			//$("#mainGrid").jqxGrid('exportdata', 'xls', 'SA012011', true, null, false, null, 'utf-8');
			if($.trim($("#mainGridCount").text()) == "0") {
				alert("엑셀로 내려받을 데이터가 없습니다.");
				return;
			} else {
				var param = {
		        	S_DEPOSITDATE_FR: $("#S_DEPOSITDATE_FR").val().replace(/[^0-9-]/g, ""),
		        	S_DEPOSITDATE_TO: $("#S_DEPOSITDATE_TO").val().replace(/[^0-9-]/g, ""),
		        	S_BRANCHCODE: $("#S_BRANCHCODE").val(),
		        	S_DEPTCODE: $("#S_DEPTCODE").val(),
		        	S_KNAME: $.trim($("#S_KNAME").val()),
		        	S_SALEGUBUN: $("#S_SALEGUBUN").val()
		        };
				$.download("/home/SA012011_e1.do", param, "post");
			};
		});
	});
</script>