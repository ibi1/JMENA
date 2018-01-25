<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>소득세 및 부가가치세 신고 현황</title>
<script type="text/javascript">
	var init = {};

	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton, #excelButton").jqxButton({width: 80, height: 25, theme: 'energyblue'});
		$("#S_PAYDATE_FR, #S_PAYDATE_TO").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1, maxLength: 10});
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
		init.setMainGrid = function() {
			var param = {
				S_PAYDATE_FR: $("#S_PAYDATE_FR").val().replace(/[^0-9-]/g, ""),
				S_PAYDATE_TO: $("#S_PAYDATE_TO").val().replace(/[^0-9-]/g, ""),
				S_TAXGUBUN: $("#S_TAXGUBUN").val(),
				S_BRANCHCODE: $("#S_BRANCHCODE").val(),
				S_DEPTCODE: $("#S_DEPTCODE").val(),
				S_KNAME: $.trim($("#S_KNAME").val())
			};
			var source = {
	        	type: "POST",
	        	url: "/home/EP012004_s1.do",
	        	data: param,
	        	datatype: "json",
	            datafields: [
					{name: "SALEID", type: "string"},
					{name: "PAYSEQ", type: "string"},
					{name: "PAYDATE", type: "string"},
					{name: "REGISTERSEQ", type: "string"},
					{name: "PAYERNAME", type: "string"},
					{name: "PAYERID", type: "string"},
					{name: "PAYAMT", type: "number"},
					{name: "TAXINCOME", type: "number"},
					{name: "TAXLOCAL", type: "number"},
					{name: "SUPPLYTAX", type: "number"},
					{name: "DEDUCTAMT", type: "number"},
					{name: "CONNAME", type: "string"},
					{name: "CONPY", type: "number"},
					{name: "FULLADDRESS", type: "string"},
					{name: "KNAME", type: "string"}
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
					{text: "담당", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "소득신고인", datafield: "PAYERNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "주민번호", datafield: "PAYERID", width: 140, cellsalign: "center", align: "center"},
					{text: "지급일", datafield: "PAYDATE", width: 100, cellsalign: "center", align: "center"},
					{text: "물건지", datafield: "FULLADDRESS", width: 240, cellsalign: "left", align: "center"},
					{text: "고객", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
					{text: "평수", datafield: "CONPY", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
					{text: "지급액", datafield: "PAYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "부가세", datafield: "SUPPLYTAX", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "소득세", datafield: "TAXINCOME", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "주민세", datafield: "TAXLOCAL", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "실지급액", datafield: "DEDUCTAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
					{text: "판매번호", datafield: "SALEID", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "지급순번", datafield: "PAYSEQ", width: 100, cellsalign: "center", align: "center", hidden: true},
					{text: "신고인순번", datafield: "REGISTERSEQ", width: 100, cellsalign: "center", align: "center", hidden: true}
	            ]
	        });		
		}
		
		init.setAuth();
		init.setDate();
		init.setBranch();
		init.setDept();
		init.setTaxGubun();
		init.setMainGrid();
		
		// 지사 콤보 체인지 이벤트
		$("#S_BRANCHCODE").change(function() {
			init.setDept($(this).val());
		});
		// 조회 버튼 클릭 이벤트
		$("#selectButton").click(function() {
			if($("#S_PAYDATE_FR").val().replace(/[^0-9]/g, "").length < 8) {
				alert("기간을 입력해주세요.");
				$("#S_PAYDATE_FR").focus();
				return;
			}
			if($("#S_PAYDATE_TO").val().replace(/[^0-9]/g, "").length < 8) {
				alert("기간을 입력해주세요.");
				$("#S_PAYDATE_TO").focus();
				return;
			}
			init.setMainGrid();	
		});
		// 엑셀 버튼 클릭 이벤트
		$("#excelButton").click(function() {
			//$("#mainGrid").jqxGrid('exportdata', 'xls', 'EP012004', true, null, false, null, 'utf-8');
			if($.trim($("#mainGridCount").text()) == "0") {
				alert("엑셀로 내려받을 데이터가 없습니다.");
				return;
			} else {
				var param = {
					S_PAYDATE_FR: $("#S_PAYDATE_FR").val().replace(/[^0-9-]/g, ""),
					S_PAYDATE_TO: $("#S_PAYDATE_TO").val().replace(/[^0-9-]/g, ""),
					S_TAXGUBUN: $("#S_TAXGUBUN").val(),
					S_BRANCHCODE: $("#S_BRANCHCODE").val(),
					S_DEPTCODE: $("#S_DEPTCODE").val(),
					S_KNAME: $.trim($("#S_KNAME").val())
				};
				$.download("/home/EP012004_e1.do", param, "post");
			};
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
			<div align="right" style="padding-top:10px; padding-bottom:3px">
				총 건수 : <font color="red"><sapn id="mainGridCount"></sapn></font>건
			</div>
			<div id="mainGrid"></div>
		</div>
	</div>
</body>
</html>