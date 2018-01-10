<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<title>(신)입금관리</title>
	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left;padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id="selectButton" /></td>
					<td><input type="button" value="추가" id="insertButton" /></td>
					<td><input type="button" value="삭제" id="deleteButton" /></td>
					<td><input type="button" value="저장" id="saveButton" /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">입금기간</th>
					<td colspan="3">
						<input type="text" id="S_IPGUMDATE_FR" /> - <input type="text" id="S_IPGUMDATE_TO" />
					</td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td><input type="text" id="S_KNAME" /></td>
					<th width="120">입금구분</th>
					<td><select id="S_IPGUMGUBUN" style="width:120px"></select></td>
				</tr>
				<tr>
					<th width="120">금융기관</th>
					<td><select id="S_BANKGUBUN" style="width:120px"></select></td>
					<th width="120">입금금액</th>
					<td><input type="text" id="S_IPGUMAMT" /></td>
				</tr>
				<tr>
					<th width="120">처리구분</th>
					<td colspan="3">
						<div style="float:left; padding-right:20px;"><input type="radio" name="S_PROCYN" id="radio1" value="" /><label for="radio1">전체</label></div>
						<div style="float:left; padding-right:20px;"><input type="radio" name="S_PROCYN" id="radio2" value="Y" /><label for="radio2">처리</label></div>
						<div style="float:left;"><input type="radio" name="S_PROCYN" id="radio3" value="N" checked /><label for="radio3">미처리</label></div>
					</td>
				</tr>
			</table>
			<div align="right" style="padding-top:10px; padding-bottom:3px">
				총 건수 : <font color="red"><sapn id="leftGridCount"></sapn></font>건
			</div>
			<table id="leftGrid"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; padding: 10px" align="left">
			<table width="98%">
				<tr>
					<th width="120">입금일자/번호</th>
					<td colspan="3">
						<div style="float:left; padding-right:3px;"><input type="text" id="IPGUMDATE" /></div>
						<div style="float:left; padding-right:3px;"><input type="text" id="IPGUMID" /></div>
						<div style="float:left"><input type="button" id="searchButton" /></div>
					</td>
				</tr>
				<tr>
					<th width="120">입금형태</th>
					<td colspan="3"><select id="IPGUMTYPE" style="width:120px"></select></td>
				</tr>
				<tr>
					<th width="120">입금구분</th>
					<td colspan="3">
						<select id="IPGUMGUBUN" style="width:120px"></select>
						<input type="text" id="R_IPGUMID" disabled="disabled" style="display:none" />
					</td>
				</tr>
				<tr>
					<th width="120">금융기관</th>
					<td width="120"><select id="BANKGUBUN" style="width:120px"></select></td>
					<th width="120">입금인</th>
					<td width="120"><input type="text" id="IPGUMPERSON" /></td>
				</tr>
				<tr>
					<th width="120">입금금액</th>
					<td colspan="3">
						<input type="text" id="IPGUMAMT" />
						<input type="text" id="txtIpgumAmt" disabled="disabled" style="display:none" />
					</td>
				</tr>
				<tr>
					<th width="120">입금처리금액</th>
					<td><input type="text" id="SUM_SUGUMAMT" /></td>
					<th width="120">미처리잔액</th>
					<td><input type="text" id="REM_IPGUMAMT" /></td>
				</tr>
				<tr>					
					<th width="120">담당자</th>
					<td colspan="3">
						<div style="float:left; padding-right:3px;"><input type="text" id="KNAME" /></div>
						<div style="float:left; padding-right:3px;"><input type="text" id="SALERCD" /></div>
					</td>
				</tr>
				<tr>
					<th width="120">담당지사</th>
					<td colspan="3"><select id="BRANCHCODE" style="width:120px" disabled="disabled"></select></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="3"><input type="text" id="REMARK" /></td>
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
		$("#selectButton, #insertButton, #deleteButton, #saveButton").jqxButton({theme: 'energyblue', width: 80, height: 25});
		$("#searchButton").jqxButton({theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay"});
		$("#S_IPGUMDATE_FR, #S_IPGUMDATE_TO, #IPGUMDATE").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##'});
		$("#S_KNAME").jqxInput({theme: 'energyblue', width: 150, height: 25});
		$("#S_IPGUMAMT").jqxInput({theme: 'energyblue', width: 150, height: 25, rtl: true});
		$("#IPGUMID").jqxInput({theme: 'energyblue', width: 100, height: 25, disabled: true});
		$("#IPGUMPERSON, #KNAME, #CONNAME").jqxInput({theme: 'energyblue', width: 100, height: 25});
		$("#IPGUMAMT").jqxInput({theme: 'energyblue', width: 120, height: 25, rtl: true});
		$("#SUM_SUGUMAMT, #REM_IPGUMAMT").jqxInput({theme: 'energyblue', width: 120, height: 25, rtl: true, disabled: true});
		$("#SALERCD").jqxInput({theme: 'energyblue', width: 80, height: 25, disabled: true});
		$("#REMARK").jqxInput({theme: 'energyblue', width: 300, height: 25});
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
		// 입금기간 초기화
		init.setDate = function() {
			$("#S_IPGUMDATE_FR").val(dateInput(1));
			$("#S_IPGUMDATE_TO").val(dateInput(0));
		}
		// 입금구분 초기화
		init.setIpgumGubun = function() {
			$("#S_IPGUMGUBUN, #IPGUMGUBUN").empty();
			$("#S_IPGUMGUBUN").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			$("#IPGUMGUBUN").append("<option value=\"\" selected=\"selected\">선택</option>");
			
			$.ajax({ 
				type: "POST" ,
				url: "/codeCom/dcodeList.do", 
				dataType : "json",
				data : {CCODE : "009"},
				success: function(data) {
					var sTemp = "";
					data.dcodeList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.DCODE + "\">" + currentValue.DCODENAME + "</option>";
					});
					$("#S_IPGUMGUBUN, #IPGUMGUBUN").append(sTemp);
				},
				error:function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 금융기관 초기화
		init.setBankGubun = function() {
			$("#S_BANKGUBUN, #BANKGUBUN").empty();
			$("#S_BANKGUBUN").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
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
					$("#S_BANKGUBUN, #BANKGUBUN").append(sTemp);
				},
				error: function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 입금형태 초기화
		init.setIpgumType = function() {
			$("#IPGUMTYPE").empty();
			$("#IPGUMTYPE").append("<option value=\"\" selected=\"selected\">선택</option>");
			
			$.ajax({ 
				type: "POST" ,
				url: "/codeCom/dcodeList.do", 
				dataType : "json",
				data : {CCODE : "012"},
				success: function(data) {
					var sTemp = "";
					data.dcodeList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.DCODE + "\">" + currentValue.DCODENAME + "</option>";
					});
					$("#IPGUMTYPE").append(sTemp);
				},
				error: function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 담당지사 초기화
		init.setBranch = function() {
			$("#BRANCHCODE").empty();
			$("#BRANCHCODE").append("<option value=\"\" selected=\"selected\"></option>");
			
			$.ajax({ 
				type: "POST",
				url: "/codeCom/branchMstList.do", 
				dataType : "json", 
				success: function(data) {
					var sTemp = "";
					data.branchMstList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.BRANCHCODE + "\">" + currentValue.BRANCHNAME + "</option>";
					});
					$("#BRANCHCODE").append(sTemp);
				},
				error: function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 좌측 그리드 초기화
		init.setLeftGrid = function() {
			var param = {
				"S_IPGUMDATE_FR": $("#S_IPGUMDATE_FR").val().replace(/[^0-9-]/g, ""),
				"S_IPGUMDATE_TO": $("#S_IPGUMDATE_TO").val().replace(/[^0-9-]/g, ""),
				"S_KNAME": $.trim($("#S_KNAME").val()),
				"S_IPGUMGUBUN" : $("#S_IPGUMGUBUN").val(),
				"S_BANKGUBUN": $("#S_BANKGUBUN").val(),
				"S_IPGUMAMT": removeComma($("#S_IPGUMAMT").val()),
				"S_PROCYN": $("input[name='S_PROCYN']:checked").val()
			};
			$("#leftGrid").jqGrid("GridUnload");
			$("#leftGrid").jqGrid({
				mtype: "POST",
				url: "/home/SA011004_s1.do",
				postData : JSON.stringify(param),
				ajaxGridOptions : {contentType: "application/json;charset=UTF-8"},
				datatype: "json",
			   	colModel:[			   	    
			   		{label: "입금일자", name: "IPGUMDATE", sortable: false, width: 80, align: "center"},
			   		{label: "입금인", name: "IPGUMPERSON", sortable: false, width: 60, align: "center"},
			   		{label: "입금금액", name: "IPGUMAMT", sortable: false, width: 80, align: "right", formatter: "number", formatoptions: {thousandsSeparator: ",", defaulValue: ""}},
			   		{label: "입금구분", name: "NAME_IPGUMGUBUN", sortable: false, width: 60, align: "center"},
			   		{label: "입금처리금액", name: "SUM_SUGUMAMT", sortable: false, width: 80, align: "right", formatter: "number", formatoptions: {thousandsSeparator: ",", defaulValue: ""}},		
			   		{label: "미처리잔액", name: "REM_IPGUMAMT", sortable: false, width: 80, align: "right", formatter: "number", formatoptions: {thousandsSeparator: ",", defaulValue: ""}},
			   		{label: "입금번호", name: "IPGUMID", sortable: false, hidden: true},
			   		{label: "입금형태(코드)", name: "IPGUMTYPE", sortable: false, hidden: true},
			   		{label: "입금형태", name: "NAME_IPGUMTYPE", sortable: false, hidden: true},
			   		{label: "입금구분(코드)", name: "IPGUMGUBUN", sortable: false, hidden: true},
			   		{label: "입금은행(코드)", name: "BANKGUBUN", sortable: false, hidden: true},
			   		{label: "입금은행", name: "NAME_BANKGUBUN", sortable: false, hidden: true},
			   		{label: "비고", name: "REMARK", sortable: false, hidden: true},
			   		{label: "입금인", name: "IPGUMPERSON", sortable: false, hidden: true},
			   		{label: "환불 입금번호", name: "R_IPGUMID", sortable: false, hidden: true},
			   		{label: "지사(코드)", name: "BRANCHCODE", sortable: false, hidden: true},
			   		{label: "담당자(코드)", name: "SALERCD", sortable: false, hidden: true},
			   		{label: "담당자", name: "KNAME", sortable: false, hidden: true}
			   	],
			   	rowNum: -1,
			   	autowidth: true,
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
					
					$("#IPGUMDATE").val(leftGridData.IPGUMDATE);
					$("#IPGUMID").val(leftGridData.IPGUMID);
					$("#IPGUMTYPE").val(leftGridData.IPGUMTYPE);
					$("#IPGUMGUBUN").val(leftGridData.IPGUMGUBUN);
					$("#R_IPGUMID").val(leftGridData.R_IPGUMID);
					$("#BANKGUBUN").val(leftGridData.BANKGUBUN);
					$("#IPGUMPERSON").val(leftGridData.IPGUMPERSON);
					$("#IPGUMAMT").val(setComma(leftGridData.IPGUMAMT));
					$("#SUM_SUGUMAMT").val(setComma(leftGridData.SUM_SUGUMAMT));
					$("#REM_IPGUMAMT").val(setComma(leftGridData.REM_IPGUMAMT));
					$("#KNAME").val(leftGridData.KNAME);
					$("#SALERCD").val(leftGridData.SALERCD);
					$("#BRANCHCODE").val(leftGridData.BRANCHCODE);
					$("#REMARK").val(leftGridData.REMARK);
					
					$("#IPGUMTYPE").trigger("change");
				}
			});
		}
		
		init.setAuth();
		init.setDate();
		init.setIpgumGubun();
		init.setBankGubun();
		init.setIpgumType();
		init.setBranch();
		init.setLeftGrid();
		 
		// 입금일자 초기화
		$("#IPGUMDATE").val(dateInput(0));
		
		// 조회 버튼 클릭 이벤트
		$("#selectButton").click(function() {
			if($("#S_IPGUMDATE_FR").val().replace(/[^0-9]/g, "").length < 8) {
				alert("기간을 입력해주세요.");
				$("#S_IPGUMDATE_FR").focus();
				return;
			}
			if($("#S_IPGUMDATE_TO").val().replace(/[^0-9]/g, "").length < 8) {
				alert("기간을 입력해주세요.");
				$("#S_IPGUMDATE_TO").focus();
				return;
			}
			fnReset(init.setLeftGrid);
			$("#IPGUMTYPE").trigger("change");
		});
		// 추가 버튼 클릭 이벤트
		$("#insertButton").click(function() {
			fnReset();
			$("#IPGUMTYPE").trigger("change");
		});
		// 삭제 버튼 클릭 이벤트
		$("#deleteButton").click(function() {
			if(fnDeleteValidation()) fnDelete();
		});
		// 저장 버튼 클릭 이벤트
		$("#saveButton").click(function() {
			if(fnSaveValidation()) fnSave();
		});
		// 찾기 버튼 클릭 이벤트
		$("#searchButton").click(function() {
			if($("#IPGUMDATE").val().replace(/[^0-9]/g, "").length < 8) {
				alert("입금일자를 입력해주세요.");
				$("#IPGUMDATE").focus();
				return;
			}
			//팝업
			var popUrl = "/home/SA011004_v1.do";	//팝업창에 출력될 페이지 UR
			var popOption = "width=600, height=500, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"입금목록",popOption);
		});
		// 입금형태 변경 이벤트
		$("#IPGUMTYPE").on("change", function(e) {
			if(leftGridData.IPGUMTYPE == "005" || $(this).val() == "005") {		// 입금형태가 "보관대체금액"일 경우
				$("#deleteButton, #saveButton").jqxButton({disabled: true});
			} else {
				$("#deleteButton, #saveButton").jqxButton({disabled: false});
			}
		});
		// 숫자 입력 키 이벤트
		inputComma("S_IPGUMAMT");
		inputComma("IPGUMAMT");
		// 담당자 입력 키 이벤트
		$("#KNAME").on("keydown", function(e) {
			var pKname = $.trim($(this).val());
			
			if(e.keyCode == 13 || e.keyCode == 9) {
				$("#SALERCD").val("");
				$("#BRANCHCODE").val("");
				
				if(pKname == "") alert("담당자명을 입력해주세요.");
				else fnSearchSaler(pKname);
			}
		});
		// 비고 입력 키 이벤트
		$("#REMARK").on("keydown", function(e) {
			if(e.keyCode == 13) $("#saveButton").trigger("click");
		});
	});
	
	// 입력 값 리셋
	function fnReset(callback) {
		$("#rightDiv input[type='text'], #rightDiv select").each(function(idx) {
			if($(this).attr("id") == "IPGUMDATE") $(this).val(dateInput(0));
			else $(this).val("");
		});
		
		$("#leftGrid").resetSelection();
		leftGridData = {};
		
		if(typeof callback == "function") callback();
	}
	// 담당자 조회
	function fnSearchSaler(pKname) {
		var param = {S_KNAME: pKname};
		$.ajax({ 
			type: "POST",
			url: "/home/SA011004_s3.do",	
			data : JSON.stringify(param),
			contentType : "application/json;charset=UTF-8",
			dataType : "json", 
			success: function(data) {				
				var receiveData = data.rows;
				
				if(receiveData.length > 0) {
					$("#SALERCD").val(receiveData[0].INSACODE);					
					$("#BRANCHCODE").val(receiveData[0].BRANCHCODE);
				} else {
					alert("해당 담당자명은 존재하지 않습니다.\n다시 입력해주세요.");
					$("#KNAME").val("").focus;
				}
			},
			error: function(x, s, e) {  
				alert("[ERROR]"+ e);
			}  
		});
	}
	// 저장 유효성 체크
	function fnSaveValidation() {
		if(leftGridData.IPGUMID) {		// 입금번호가 있을 경우(수정)
			if(leftGridData.IPGUMGUBUN == "005") {
				alert("환불금으로 등록된 입금정보는 수정이 불가합니다.");
				return false;
			}
			if(leftGridData.R_IPGUMID != "") {
				alert("해당 입금정보는 환불 처리되어 수정이 불가합니다.");
				return false;
			}
			if(parseInt(leftGridData.SUM_SUGUMAMT) > 0) {
				alert("입금처리금액이 있어 수정이 불가합니다.");
				return false;
			}
		}
		
		if($("#IPGUMDATE").val().replace(/[^0-9]/g, "").length < 8) {
			alert("입금일자를 입력해주세요.");
			$("#IPGUMDATE").focus();
			return false;
		}
		if($("#IPGUMTYPE").val() == "") {
			alert("입금형태를 선택해주세요.");
			$("#IPGUMTYPE").focus();
			return false;
		}
		if($("#IPGUMGUBUN").val() == "") {
			alert("입금구분을 선택해주세요.");
			$("#IPGUMGUBUN").focus();
			return false;
		}
		if($("#BANKGUBUN").val() == "") {
			alert("금융기관을 선택해주세요.");
			$("#BANKGUBUN").focus();
			return false;
		}
		if($("#IPGUMPERSON").val() == "") {
			alert("입금인을 입력해주세요.");
			$("#IPGUMPERSON").focus();
			return false;
		}
		if(removeComma($("#IPGUMAMT").val()) == "") {
			alert("입금금액을 입력해주세요.");
			$("#IPGUMAMT").focus();
			return false;
		}
		
		if($("#IPGUMGUBUN").val() == "005") {		// 입금구분이 "환불금"일 경우
			if($("#R_IPGUMID").val() == "") {
				alert("입금구분이 \"환불금\"일 경우, 단축버튼을 클릭하여 환불할 입금정보 선택해주십시오.");
				return false;
			}			
		}
		if($("#R_IPGUMID").val() !== "") {		// 환불 입금번호가 있을 경우
			if($("#IPGUMAMT").val() != $("#txtIpgumAmt").val()) {
				alert("분할 환불이 불가하여 입금금액은 변경할 수 없습니다.");
				$("#IPGUMAMT").val($("#txtIpgumAmt").val());
				return false;
			}
			if($("#SALERCD").val() == "") {
				alert("입금구분이 \"환불금\"일 경우, 담당자는 필수 입력사항입니다.");
				$("#KNAME").focus();
				return false;
			}
		}
		
		return true;
	}
	// 저장
	function fnSave() {
		var url = "/home/SA011004_u1.do";
		var action = "저장";
		
		if(leftGridData.IPGUMID) {		// 입금번호가 있을 경우(수정)
			url = "/home/SA011004_u2.do";
			action = "수정";
		}
		
		if(confirm(action +"하시겠습니까?")) {
			var param = {
					IPGUMID: $("#IPGUMID").val(),
					IPGUMDATE: $("#IPGUMDATE").val(),
					IPGUMTYPE: $("#IPGUMTYPE").val(),
					R_IPGUMID: $("#R_IPGUMID").val(),
					IPGUMGUBUN: $("#IPGUMGUBUN").val(),
					BANKGUBUN: $("#BANKGUBUN").val(),
					IPGUMAMT: removeComma($("#IPGUMAMT").val()),
					REMARK: $.trim($("#REMARK").val()),
					IPGUMPERSON: $("#IPGUMPERSON").val(),
					BRANCHCODE: $("#BRANCHCODE").val(),
					SALERCD: $("#SALERCD").val()
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
	// 삭제 유효성 체크
	function fnDeleteValidation() {
		if(!leftGridData.IPGUMID) {
			alert("삭제할 데이터를 그리드에서 선택해주세요.");
			return false;	
		}
		if(leftGridData.IPGUMGUBUN == "005") {
			alert("환불금으로 등록된 입금정보는 삭제가 불가합니다.");
			return false;
		}
		if(leftGridData.R_IPGUMID != "") {
			alert("해당 입금정보는 환불 처리되어 삭제가 불가합니다.");
			return false;
		}
		if(parseInt(leftGridData.SUM_SUGUMAMT) > 0) {
			alert("입금처리금액이 있어 삭제가 불가합니다.");
			return false;
		}		
		
		return true;			
	}	
	// 삭제
	function fnDelete() {
		if(confirm("삭제하시겠습니까?")) {
			var param = {IPGUMID: $("#IPGUMID").val()};
			$.ajax({
				type: "POST",
				url: "/home/SA011004_u3.do",	
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