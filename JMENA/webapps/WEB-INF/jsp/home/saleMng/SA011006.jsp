<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<title>해약관리</title>
	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left;padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id="selectButton" /></td>
					<td><input type="button" value="삭제" id="deleteButton" /></td>
					<td><input type="button" value="저장" id="saveButton" /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">해약기간</th>
					<td>
						<input type="text" id="S_CHGDATE_FR" /> - <input type="text" id="S_CHGDATE_TO" />
					</td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td><input type="text" id="S_KNAME" /></td>
				</tr>
				<tr>
					<th width="120">환불구분</th>
					<td>
						<div style="float:left; padding-right:20px;"><input type="radio" name="S_REFUNDYN" id="radio1" value="" /><label for="radio1">전체</label></div>
						<div style="float:left; padding-right:20px;"><input type="radio" name="S_REFUNDYN" id="radio2" value="Y" /><label for="radio2">환불</label></div>
						<div style="float:left;"><input type="radio" name="S_REFUNDYN" id="radio3" value="N" checked /><label for="radio3">미환불</label></div>
					</td>
				</tr>
			</table>
			<div align="right" style="padding-top:10px; padding-bottom:3px">
				총 건수 : <font color="red"><sapn id="leftGridCount"></sapn></font>건
			</div>
			<table id="leftGrid"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; padding: 10px" align="left">
			<div><strong>[계약 사항]</strong></div>
			<table width="98%">
				<tr>
					<th width="120">계약일자/번호</th>
					<td colspan="3">
						<div style="float:left; padding-right:3px;"><input type="text" id="SALEDATE" /></div>
						<div style="float:left"><input type="text" id="SALEID" /></div>
					</td>
				</tr>
				<tr>
					<th width="120">매출구분</th>
					<td colspan="3"><input type="text" id="NAME_SALEGUBUN" /></td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td width="140">
						<input type="text" id="KNAME" />
						<input type="text" id="SALERCD" disabled="disabled" style="display:none" />
					</td>
					<th width="120">계약지사</th>
					<td width="140">
						<input type="text" id="NAME_BRANCHCODE" />
						<input type="text" id="BRANCHCODE" disabled="disabled" style="display:none" />
					</td>
				</tr>
				<tr>
					<th width="120">계약자 성명</th>
					<td><input type="text" id="CONNAME" /></td>
					<th width="120">계약자 주민번호</th>
					<td><input type="text" id="CONJUMINID" /></td>
				</tr>
				<tr>
					<th width="120">계약자 주소</th>
					<td colspan="3"><input type="text" id="CONADDRESS" /></td>
				</tr>
				<tr>
					<th width="120">계약자 연락처</th>
					<td colspan="3"><input type="text" id="CONTELNO" /></td>
				</tr>
				<tr>
					<th width="120">계약면적</th>
					<td><input type="text" id="CONM2" /></td>
					<th width="120">계약평수</th>
					<td><input type="text" id="CONPY" /></td>
				</tr>
				<tr>
					<th width="120">매매대금</th>
					<td><input type="text" id="SALEAMT" /></td>
					<th width="120">매매단가</th>
					<td><input type="text" id="SALEDANGA" /></td>
				</tr>
				<tr>
					<th width="120">DC 사항</th>
					<td><input type="text" id="NAME_DCGUBUN" /></td>
					<th width="120">DC 율</th>
					<td><input type="text" id="DCRATE" />&nbsp;&#37;</td>
				</tr>
				<tr>
					<th width="120">DC 금액</th>
					<td><input type="text" id="DCAMT" /></td>
					<th width="120">실 판매가</th>
					<td><input type="text" id="SELLAMT" /></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="3"><input type="text" id="SALE_REMARK" /></td>
				</tr>
			</table><br />
			<div><strong>[환불 및 보관 관리]</strong></div>
			<table width="98%">
				<tr>
					<th width="120">계약금 입금액</th>
					<td colspan="3"><input type="text" id="SUGUMAMT1" /></td>
				</tr>
				<tr>
					<th width="120">중도금 입금액</th>
					<td colspan="3"><input type="text" id="SUGUMAMT2" /></td>
				</tr>
				<tr>
					<th width="120">잔금 입금액</th>
					<td width="140"><input type="text" id="SUGUMAMT3" /></td>
					<th width="120">입금 총액</th>
					<td width="140"><input type="text" id="SUM_SUGUMAMT" /></td>
				</tr>
				<tr>
					<th width="120">환불 금액</th>
					<td>
						<input type="text" id="REFUNDAMT" />
						<input type="text" id="REFUND_SALEID" disabled="disabled" style="display:none" />
					</td>
					<th width="120">환불일자/여부</th>
					<td>
						<input type="text" id="REFUNDDATE" />
						<input type="checkbox" id="REFUNDYN" />
					</td>
				</tr>
				<tr>
					<th width="120">환불 은행</th>
					<td><select id="BANKGUBUN" style="width:120px"></select></td>
					<th width="120">계좌주</th>
					<td><input type="text" id="ACCTOWNER" /></td>
				</tr>
				<tr>
					<th width="120">환불 계좌</th>
					<td colspan="3"><input type="text" id="ACCTNO" /></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="3"><input type="text" id="REFUND_REMARK" /></td>
				</tr>
			</table>
			<table width="98%" style="border-radius: 5px; background-color:#F2F5F7; margin-top: 5px">
				<tr>
					<th width="120">보관 금액</th>
					<td width="140"><input type="text" id="KEEPAMT" /></td>
					<th width="120">보관액 대체일</th>
					<td width="140">
						<input type="text" id="EXPORTDATE" />
						<input type="button" id="exportButton" value="처리" />
						<input type="text" id="EXPORTYN" disabled="disabled" style="display:none" />
					</td>
				</tr>
				<tr>
					<th width="120">입금대체 번호</th>
					<td colspan="3"><input type="text" id="IPGUMID" /></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var init = {};
	var leftGridData = {};
	
	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton, #deleteButton, #saveButton").jqxButton({theme: 'energyblue', width: 80, height: 25});
		$("#S_CHGDATE_FR, #S_CHGDATE_TO").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##'});
		$("#S_KNAME").jqxInput({theme: 'energyblue', width: 150, height: 25});
		$("#SALEDATE").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##', disabled: true});
		$("#SALEID").jqxInput({theme: 'energyblue', width: 100, height: 25, disabled: true});
		$("#NAME_SALEGUBUN").jqxInput({theme: 'energyblue', width: 80, height: 25, disabled: true});
		$("#KNAME, #CONNAME").jqxInput({theme: 'energyblue', width: 100, height: 25, disabled: true});
		$("#NAME_BRANCHCODE").jqxInput({theme: 'energyblue', width: 100, height: 25, disabled: true});
		$("#CONJUMINID, #CONTELNO").jqxInput({theme: 'energyblue', width: 120, height: 25, disabled: true});
		$("#CONADDRESS, #SALE_REMARK").jqxInput({theme: 'energyblue', width: 400, height: 25, disabled: true});
		$("#CONM2, #CONPY").jqxInput({theme: 'energyblue', width: 80, height: 25, rtl: true, disabled: true});
		$("#SALEAMT, #SALEDANGA, #DCAMT, #SELLAMT, #SUGUMAMT1, #SUGUMAMT2, #SUGUMAMT3, #SUM_SUGUMAMT, #KEEPAMT").jqxInput({theme: 'energyblue', width: 120, height: 25, rtl: true, disabled: true});
		$("#NAME_DCGUBUN").jqxInput({theme: 'energyblue', width: 100, height: 25, disabled: true});
		$("#DCRATE").jqxInput({theme: 'energyblue', width: 40, height: 25, rtl: true, disabled: true});
		$("#REFUNDAMT").jqxInput({theme: 'energyblue', width: 120, height: 25, rtl: true});
		$("#REFUNDDATE, #EXPORTDATE").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##'});
		$("#ACCTOWNER").jqxInput({theme: 'energyblue', width: 100, height: 25});
		$("#ACCTNO").jqxInput({theme: 'energyblue', width: 200, height: 25});
		$("#exportButton").jqxButton({width: 40, height: 25});
		$("#IPGUMID").jqxInput({theme: 'energyblue', width: 100, height: 25, disabled: true});
		$("#REFUND_REMARK").jqxInput({theme: 'energyblue', width: 400, height: 25});
		// 버튼권한 설정
		init.setAuth = function() {
			<%if("N".equals(session.getAttribute("AUTH_I"))) {%>
			$("#insertButton, #saveButton").hide();
			<%}%>
			<%if("N".equals(session.getAttribute("AUTH_D"))) {%>
			$("#deleteButton").hide();
			<%}%>
			<%if("N".equals(session.getAttribute("AUTH_P"))) {%>
			<%}%>
		}
		// 해약기간 초기화
		init.setDate = function() {
			$("#S_CHGDATE_FR").val(dateInput(1));
			$("#S_CHGDATE_TO").val(dateInput(0));
		}
		// 환불은행 초기화
		init.setBankGubun = function() {
			$("#BANKGUBUN").empty();
			$("#BANKGUBUN").append("<option value=\"\" selected=\"selected\">선택</option>");
			
			$.ajax({ 
				type: "POST" ,
				url: "/codeCom/dcodeList.do", 
				dataType : "json",
				data : {CCODE : "015"},
				success: function(data) {
					var sTemp = "";
					data.dcodeList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.DCODE + "\">" + currentValue.DCODENAME + "</option>";
					});
					$("#BANKGUBUN").append(sTemp);
				},
				error: function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 좌측 그리드 초기화
		init.setLeftGrid = function() {
			var param = {
				"S_CHGDATE_FR": $("#S_CHGDATE_FR").val().replace(/[^0-9-]/g, ""),
				"S_CHGDATE_TO": $("#S_CHGDATE_TO").val().replace(/[^0-9-]/g, ""),
				"S_KNAME": $.trim($("#S_KNAME").val()),
				"S_REFUNDYN": $("input[name='S_REFUNDYN']:checked").val()
			};
			$("#leftGrid").jqGrid("GridUnload");
			$("#leftGrid").jqGrid({
				mtype: "POST",
				url: "/home/SA011006_s1.do",
				postData : JSON.stringify(param),
				ajaxGridOptions : {contentType: "application/json;charset=UTF-8"},
				datatype: "json",
			   	colModel:[
					{label: "계약일자", name: "SALEDATE", sortable: false, width: 80, align: "center"},
					{label: "계약번호", name: "SALEID", sortable: false, width: 80, align: "center"},
					{label: "계약자", name: "CONNAME", sortable: false, width: 80, align: "center"},
					{label: "해약일자", name: "CHGDATE", sortable: false, width: 80, align: "center"},
					{label: "입금금액", name: "SUM_SUGUMAMT", sortable: false, width: 80, align: "right", formatter: "currency", formatoptions: {thousandsSeparator: ",", defaulValue: ""}},
					{label: "환불금액", name: "REFUNDAMT", sortable: false, width: 80, align: "right", formatter: "currency", formatoptions:{thousandsSeparator:",", defaultValue: ""}},
					{label: "보관금액", name: "KEEPAMT", sortable: false, width: 80, align: "right", formatter: "currency", formatoptions:{thousandsSeparator:",", defaultValue: ""}},
					{label: "담당자(코드)", name: "SALERCD", sortable: false, hidden: true},
					{label: "매출구분(코드)", name: "SALEGUBUN", sortable: false, hidden: true},
					{label: "매출구분", name: "NAME_SALEGUBUN", sortable: false, hidden: true},
					{label: "계약자 주민번호", name: "CONJUMINID", sortable: false, hidden: true},
					{label: "계약자 주소", name: "CONADDRESS", sortable: false, hidden: true},
					{label: "계약자 연락처", name: "CONTELNO", sortable: false, hidden: true},
					{label: "계약면적", name: "CONM2", sortable: false, formatter: "number", formatoptions: {decimalPlaces: 2, defaulValue: ""}, hidden: true},
					{label: "계약평수", name: "CONPY", sortable: false, formatter: "number", formatoptions: {decimalPlaces: 2, defaulValue: ""}, hidden: true},
					{label: "비고", name: "SALE_REMARK", sortable: false, hidden: true},
					{label: "매매금액", name: "SALEAMT", sortable: false, hidden: true},
					{label: "매매단가", name: "SALEDANGA", sortable: false, hidden: true},
					{label: "할인구분(코드)", name: "DCGUBUN", sortable: false, hidden: true},
					{label: "할인구분", name: "NAME_DCGUBUN", sortable: false, hidden: true},
					{label: "할인율", name: "DCRATE", sortable: false, hidden: true},
					{label: "할인금액", name: "DCAMT", sortable: false, hidden: true},
					{label: "실판매가", name: "SELLAMT", sortable: false, hidden: true},
					{label: "계약금", name: "SUGUMAMT1", sortable: false, hidden: true},
					{label: "중도금", name: "SUGUMAMT2", sortable: false, hidden: true},
					{label: "잔금", name: "SUGUMAMT3", sortable: false, hidden: true},
					{label: "계약번호", name: "REFUND_SALEID", sortable: false, hidden: true},
					{label: "환불일자", name: "REFUNDDATE", sortable: false, hidden: true},
					{label: "환불여부", name: "REFUNDYN", sortable: false, hidden: true},
					{label: "환불은행(코드)", name: "BANKGUBUN", sortable: false, hidden: true},
					{label: "환불은행", name: "NAME_BANKGUBUN", sortable: false, hidden: true},
					{label: "계좌주", name: "ACCTOWNER", sortable: false, hidden: true},
					{label: "환불계좌", name: "ACCTNO", sortable: false, hidden: true},
					{label: "보관대체일", name: "EXPORTDATE", sortable: false, hidden: true},
					{label: "대체처리여부", name: "EXPORTYN", sortable: false, hidden: true},
					{label: "입금번호", name: "IPGUMID", sortable: false, hidden: true},
					{label: "비고", name: "REFUND_REMARK", sortable: false, hidden: true},
					{label: "담당자", name: "KNAME", sortable: false, hidden: true},
					{label: "지사(코드)", name: "BRANCHCODE", sortable: false, hidden: true},
					{label: "지사", name: "NAME_BRANCHCODE", sortable: false, hidden: true}
			   	],
			   	rowNum: -1,
			   	autowidth: true,
			   	height: "495px",
			   	gridview: true,
				jsonReader: {
					root: "rows",
					repeatitems: false
				},
				loadtext: "로딩중...",
				loadError: function(x, s, e) {
					alert("[ERROR]"+ e);
				},
				loadComplete: function(data) {
					var rCount = $("#leftGrid").jqGrid("getGridParam", "records");
					$("#leftGridCount").text(rCount);
				},
				onSelectRow: function(rowid, status, e) {
					leftGridData = $(this).jqGrid("getRowData", rowid);
					
					$("#rightDiv input[type='text'], #rightDiv select").each(function(idx) {
						if($(this).attr("id") == "REFUNDDATE") $(this).val(dateInput(0));
						else if($(this).attr("id") == "EXPORTDATE") $(this).jqxMaskedInput("clear");
						else $(this).val("");
					});
					
					$("#SALEDATE").val(leftGridData.SALEDATE);
					$("#SALEID").val(leftGridData.SALEID);
					$("#NAME_SALEGUBUN").val(leftGridData.NAME_SALEGUBUN);
					$("#KNAME").val(leftGridData.KNAME);
					$("#SALERCD").val(leftGridData.SALERCD);
					$("#NAME_BRANCHCODE").val(leftGridData.NAME_BRANCHCODE);
					$("#BRANCHCODE").val(leftGridData.BRANCHCODE);
					$("#CONNAME").val(leftGridData.CONNAME);
					$("#CONJUMINID").val(leftGridData.CONJUMINID);
					$("#CONADDRESS").val(leftGridData.CONADDRESS);
					$("#CONTELNO").val(leftGridData.CONTELNO);
					$("#CONM2").val(leftGridData.CONM2);
					$("#CONPY").val(leftGridData.CONPY);
					$("#SALEAMT").val(setComma(leftGridData.SALEAMT));
					$("#SALEDANGA").val(setComma(leftGridData.SALEDANGA));
					$("#NAME_DCGUBUN").val(leftGridData.NAME_DCGUBUN);
					$("#DCRATE").val(leftGridData.DCRATE);
					$("#DCAMT").val(setComma(leftGridData.DCAMT));					
					$("#SELLAMT").val(setComma(leftGridData.SELLAMT));
					$("#SALE_REMARK").val(leftGridData.SALE_REMARK);
					$("#SUGUMAMT1").val(setComma(leftGridData.SUGUMAMT1));
					$("#SUGUMAMT2").val(setComma(leftGridData.SUGUMAMT2));
					$("#SUGUMAMT3").val(setComma(leftGridData.SUGUMAMT3));
					$("#SUM_SUGUMAMT").val(setComma(leftGridData.SUM_SUGUMAMT));
					
					$("#REFUNDAMT").val(setComma(leftGridData.REFUNDAMT));
					$("#REFUND_SALEID").val(leftGridData.REFUND_SALEID);
					$("#REFUNDDATE").val(leftGridData.REFUNDDATE);
					$("#REFUNDYN").prop("checked", leftGridData.REFUNDYN == "Y" ? true : false);
					$("#BANKGUBUN").val(leftGridData.BANKGUBUN);
					$("#ACCTOWNER").val(leftGridData.ACCTOWNER);
					$("#ACCTNO").val(leftGridData.ACCTNO);
					$("#KEEPAMT").val(setComma(leftGridData.KEEPAMT));
					$("#EXPORTDATE").val(leftGridData.EXPORTDATE);
					$("#EXPORTYN").val(leftGridData.EXPORTYN);
					$("#IPGUMID").val(leftGridData.IPGUMID);
					$("#REFUND_REMARK").val(leftGridData.REFUND_REMARK);
					
					if(leftGridData.EXPORTYN == "Y") {
						$("#exportButton").val("취소");
					} else {
						$("#exportButton").val("처리");
					}
				}
			});
		}
		
		init.setAuth();
		init.setDate();
		init.setBankGubun();
		init.setLeftGrid();
		
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
			fnReset(init.setLeftGrid);
		});
		// 삭제 버튼 클릭 이벤트
		$("#deleteButton").click(function() {
			if(fnDeleteValidation()) fnDelete();
		});
		// 저장 버튼 클릭 이벤트
		$("#saveButton").click(function() {
			if(fnSaveValidation()) fnSave();
		});
		// 처리 및 취소 버튼 클릭 이벤트
		$("#exportButton").click(function() {
			if(fnExportValidation()) fnExport();
		});
		// 숫자 입력 키 이벤트
		inputComma("REFUNDAMT");		
		// 환불 금액 입력 키 이벤트
		$("#REFUNDAMT").on("keydown", function(e) {
			var iRefundAmt = 0;
			
			if($(this).val() != "") iRefundAmt = parseInt(removeComma($(this).val()));
			
			var iSumSugumAmt = parseInt(removeComma($("#SUM_SUGUMAMT").val()));
			var iKeepAmt = iSumSugumAmt - iRefundAmt;
			
			if(e.keyCode == 13 || e.keyCode == 9) {
				$("#KEEPAMT").val(setComma(iKeepAmt.toString()));
			}
		});
		// 비고 입력 키 이벤트
		$("#REFUND_REMARK").on("keydown", function(e) {
			if(e.keyCode == 13) $("#saveButton").trigger("click");
		});
	});
	
	// 입력 값 리셋
	function fnReset(callback) {
		$("#rightDiv input[type='text'], #rightDiv select").each(function(idx) {
			if($(this).attr("id") == "REFUNDDATE") $(this).val(dateInput(0));
			else if($(this).attr("id") == "EXPORTDATE") $(this).jqxMaskedInput("clear");
			else $(this).val("");
		});
		$("#rightDiv input[type='checkbox']").each(function(idx) {
			$(this).prop("checked", false);
		});
		
		$("#leftGrid").resetSelection();
		leftGridData = {};
		
		if(typeof callback == "function") callback();
	}
	// 저장 유효성 체크
	function fnSaveValidation() {
		var sumSugumAmt = removeComma($("#SUM_SUGUMAMT").val());
		var refundAmt = removeComma($("#REFUNDAMT").val());
		
		if(!leftGridData.SALEID) {
			alert("저장할 데이터를 그리드에서 선택해주세요.");
			return false;
		}
		
		if(leftGridData.REFUND_SALEID) {		// 환불 계약번호가 있을 경우(수정)
			if(leftGridData.REFUNDYN == "Y") {
				alert("환불 처리가 완료되어 수정이 불가합니다.");
				return false;
			}
			if(leftGridData.EXPORTYN == "Y") {
				alert("보관대체 내역이 있어 수정이 불가합니다.");
				return false;
			}
		}
		
		if(sumSugumAmt == "0") {
			alert("환불 처리할 입금액이 없습니다.");
			return false;
		}
		if(refundAmt == "" || refundAmt == "0") {
			alert("환불 금액을 입력해주세요.");
			$("#REFUNDAMT").focus();
			return false;
		}	
		if($("#REFUNDDATE").val().replace(/[^0-9]/g, "").length < 8) {
			alert("환불일자를 입력해주세요.");
			$("#REFUNDDATE").focus();
			return false;
		}
		if($("#BANKGUBUN").val() == "") {
			alert("환불 은행을 선택해주세요.");
			$("#BANKGUBUN").focus();
			return false;
		}
		if($("#ACCTOWNER").val() == "") {
			alert("계좌주를 입력해주세요.");
			$("#ACCTOWNER").focus();
			return false;
		}
		if($("#ACCTNO").val() == "") {
			alert("환불 계좌를 입력해주세요.");
			$("#ACCTNO").focus();
			return false;
		}
		if(parseInt(sumSugumAmt) < parseInt(refundAmt)) {
			alert("환불 금액이 입금 총액을 초과할 수 없습니다.");
			$("#REFUNDAMT").select();
			return false;
		}
		
		return true;
	}
	// 저장
	function fnSave() {
		var url = "/home/SA011006_u1.do";
		var action = "저장";
		
		if(leftGridData.REFUND_SALEID) {		// 환불 계약번호가 있을 경우(수정)
			url = "/home/SA011006_u2.do";
			action = "수정";
		}
		
		if(confirm(action +"하시겠습니까?")) {
			var param = {
				SALEID: $("#SALEID").val(),
				REFUNDAMT: removeComma($("#REFUNDAMT").val()),
				REFUNDDATE: $("#REFUNDDATE").val(),
				REFUNDYN: $("#REFUNDYN").is(":checked") ? "Y" : "N",
				BANKGUBUN: $("#BANKGUBUN").val(),
				ACCTNO: $.trim($("#ACCTNO").val()),
				ACCTOWNER: $.trim($("#ACCTOWNER").val()),
				REMARK: $.trim($("#REMARK").val())
			};
			
			$.ajax({ 
				type: "POST",
				url: url,
				data : JSON.stringify(param),
				contentType : "application/json;charset=UTF-8",
				dataType : "json", 
				success: function(data) {				
					var receiveData = data.rows;
					
					if(receiveData.MSG == "success") {
						alert(action +"이 완료되었습니다.");
						$("#selectButton").trigger("click");
					} else {
						alert(action +" 중 오류가 발생했습니다.");	
					}
				},
				error: function(x, s, e) {
					alert("[ERROR]"+ e);
				}  
			});
		}
	}
	// 처리 및 취소 유효성 체크
	function fnExportValidation() {
		var sumSugumAmt = removeComma($("#SUM_SUGUMAMT").val());
		var refundAmt = removeComma($("#REFUNDAMT").val());
		var keepAmt = removeComma($("#KEEPAMT").val());
		
		if(!leftGridData.SALEID) {
			alert("처리(또는 취소)할 데이터를 그리드에서 선택해주세요.");
			return false;
		}
		if(leftGridData.EXPORTYN != "Y") {		// 대체처리여부가 Y가 아닐 경우 (처리)		
			if(keepAmt == "0") {
				alert("대체 처리할 보관 금액이 없습니다.");
				return false;
			}			
			if(!leftGridData.REFUND_SALEID) {		// 환불 계약번호가 없을 경우
				if(parseInt(sumSugumAmt) != parseInt(keepAmt)) {
					alert("입금 전액을 보관액으로 대체하시려면, 입금 총액과 보관 금액은 동일해야합니다.");
					return false;
				}	
			} else {
				if(parseInt(sumSugumAmt) != (parseInt(refundAmt) + parseInt(keepAmt))) {
					alert("환불 금액 또는 보관 금액을 확인해주세요.");					
					return false;
				}
			}		
			if($("#EXPORTDATE").val().replace(/[^0-9]/g, "").length < 8) {
				alert("보관액 대체일을 입력해주세요.");
				$("#EXPORTDATE").focus();
				return false;
			}
		}
		
		return true;
	}
	// 처리 및 취소
	function fnExport() {
		var action = "처리";
		var url = "/home/SA011006_u4.do";
		var param = {
			SALEID: $("#SALEID").val(),
			REFUND_SALEID: $("#REFUND_SALEID").val(),
			KEEPAMT: removeComma($("#KEEPAMT").val()),
			EXPORTDATE: $("#EXPORTDATE").val(),
			EXPORTYN: "Y",
			IPGUMID: $("#IPGUMID").val(),
			IPGUMDATE: $("#EXPORTDATE").val(),
			IPGUMTYPE: "005",
			IPGUMGUBUN: "001",
			BANKGUBUN: "999",
			REMARK: "매출번호 "+ $("#SALEID").val() +" 보관금액 대체 처리",
			IPGUMPERSON: $("#CONNAME").val(),
			BRANCHCODE: $("#BRANCHCODE").val(),
			SALERCD: $("#SALERCD").val()
		};
		
		if(leftGridData.EXPORTYN == "Y") {		// 대체처리여부가 Y 일 경우 (취소)
			action = "취소";	
			url = "/home/SA011006_u5.do";
			var param = {
				SALEID: $("#SALEID").val(),
				REFUNDAMT: leftGridData.REFUNDAMT,
				KEEPAMT: null,
				EXPORTDATE: null,
				EXPORTYN: "N",
				IPGUMID: $("#IPGUMID").val()
			};
		}
		
		if(confirm(action +"하시겠습니까?")) {
			$.ajax({ 
				type: "POST",
				url: url,
				data : JSON.stringify(param),
				contentType : "application/json;charset=UTF-8",
				dataType : "json", 
				success: function(data) {				
					var receiveData = data.rows;
					
					if(receiveData.MSG == "success") {
						alert(action +"가 완료되었습니다.");
						$("#selectButton").trigger("click");
					} else if(receiveData.MSG == "abort") {
						alert("입금처리 내역이 존재합니다.");	
					} else {
						alert(action +" 중 오류가 발생했습니다.");	
					}
				},
				error: function(x, s, e) {
					alert("[ERROR]"+ e);
				}  
			});
		}		
	}
	// 삭제 유효성 체크
	function fnDeleteValidation() {
		if(!leftGridData.SALEID) {
			alert("삭제할 데이터를 그리드에서 선택해주세요.");
			return false;
		}
		if(!leftGridData.REFUND_SALEID) {
			alert("삭제할 내역이 없습니다.");
			return false;	
		}
		if(leftGridData.REFUNDYN == "Y") {
			alert("환불 처리가 완료되어 삭제가 불가합니다.");
			return false;
		}
		if(leftGridData.EXPORTYN == "Y") {
			alert("보관대체 내역이 있어 삭제가 불가합니다.");
			return false;
		}	
		
		return true;			
	}	
	// 삭제
	function fnDelete() {
		if(confirm("삭제하시겠습니까?")) {
			var param = {SALEID: $("#REFUND_SALEID").val()};
			$.ajax({
				type: "POST",
				url: "/home/SA011006_u3.do",
				data : JSON.stringify(param),
				contentType : "application/json;charset=UTF-8",
				dataType : "json", 
				success: function(data) {				
					var receiveData = data.rows;
					
					if(receiveData.MSG == "success") {
						alert("삭제가 완료되었습니다.");
						$("#selectButton").trigger("click");
					} else {
						alert("삭제 중 오류가 발생했습니다.");	
					}
				},
				error: function(x, s, e) {
					alert("[ERROR]"+ e);
				}  
			});
		}
	}
</script>