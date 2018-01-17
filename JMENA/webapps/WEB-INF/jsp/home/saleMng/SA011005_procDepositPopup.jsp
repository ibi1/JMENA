<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<title>입금처리</title>	
	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.base.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.light.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.energyblue.css" type="text/css" />
	<style>
        html, body
        {
            width: 100%;
            height: 100%;
            box-sizing: border-box;
            margin: 0;
            font-size : 13px;
        }
        th
        {
        	height : 22px;
			text-align: center;
			font-weight: bold;
			border: 1px solid #CCC;
			background-color: #ffffff;
        }
        select
        {
		    min-height: 25px;
		    min-width: 16px;
		    margin: 0px;
		    border-width: 1px;
		    border-style: solid;
		    font-size: 13px;
		    padding: 0px;
		    padding-left: 3px;
		    padding-right: 3px;
		    border-color: #a4bed4;
		    -webkit-border-radius: 3px;
		}
    </style>	
	<script type="text/javascript" src="/resource/js/jquery.js"></script>
	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcore.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxnotification.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxtabs.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxsplitter.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttons.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttongroup.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxinput.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxmaskedinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxformattedinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxnumberinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxlistbox.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcombobox.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxtree.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.pager.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.edit.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.export.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.grouping.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.aggregates.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.columnsresize.js"></script> 
	<script type="text/javascript" src="/resource/js/common.js"></script>
	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:93%; float:left;padding: 10px; margin: 5px; border:1px solid #CCC; border-radius: 5px;" align="left">
			<div><strong>[매출 건별 입금처리 현황]</strong></div>
			<table width="100%" style="padding-top:10px; padding-bottom:3px">
				<tr>
					<td align="left">총 건수 : <font color="red"><sapn id="topGridCount"></sapn></font>건</td>
					<td align="right"><input type="button" value="취소" id="deleteButton" /></td>
				</tr>
			</table>
			<table id="topGrid"></table>
			<div align="right" style="padding-top:3px">
				<strong>입금 계</strong> <input type="text" id="txtIpgumSum">
			</div>
		</div>
		<div id="leftDiv" style="width:45%; float:left; padding: 10px; margin: 5px; border: 1px solid #CCC; border-radius: 5px;" align="left">
			<div><strong>[입금 현황]</strong></div>
			<table width="100%">
				<tr>
					<td colspan="4">
						<div style="float:right;"><input type="button" value="조회" id="selectButton" /></div>
					</td>
				</tr>				
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
			</table>
			<div align="right" style="padding-top:10px; padding-bottom:3px">
				총 건수 : <font color="red"><sapn id="leftGridCount"></sapn></font>건
			</div>
			<table id="leftGrid"></table>
		</div>
		<div id="rightDiv" style="width:45%; float:left; padding: 10px; margin: 5px; border: 1px solid #CCC; border-radius: 5px;" align="left">
			<div><strong>[입금 처리]</strong></div>
			<table width="100%">
				<tr>
					<td colspan="4">
						<div style="float:right;"><input type="button" value="저장" id="saveButton" /></div>
					</td>
				</tr>
				<tr>
					<th width="120">입금일자/번호</th>
					<td colspan="3">
						<div style="float:left; padding-right:3px;"><input type="text" id="IPGUMDATE" /></div>
						<div style="float:left; padding-right:3px;"><input type="text" id="IPGUMID" /></div>
					</td>
				</tr>
				<tr>
					<th width="120">입금형태</th>
					<td colspan="3"><input type="text" id="NAME_IPGUMTYPE" /></select></td>
				</tr>
				<tr>
					<th width="120">입금구분</th>
					<td colspan="3">
						<input type="text" id="NAME_IPGUMGUBUN" /></select>
						<input type="hidden" id="IPGUMGUBUN" />
					</td>
				</tr>
				<tr>
					<th width="120">금융기관</th>
					<td colspan="3"><input type="text" id="NAME_BANKGUBUN" /></select></td>
				</tr>
				<tr>
					<th width="120">입금인</th>
					<td colspan="3"><input type="text" id="IPGUMPERSON" /></td>
				</tr>
				<tr>
					<th width="120">입금금액</th>
					<td colspan="3"><input type="text" id="IPGUMAMT" /></td>
				</tr>
				<tr>
					<th width="120">입금처리금액</th>
					<td><input type="text" id="SUM_SUGUMAMT" /></td>
					<th width="120">미처리잔액</th>
					<td><input type="text" id="REM_IPGUMAMT" /></td>
				</tr>
			</table>
			<div style="margin-top: 10px; border: 1px solid #CCC; border-radius: 5px; background-color:#F2F5F7">
				<table>
					<tr>
						<th width="120">처리금액</th>
						<td><input type="text" id="SUGUMAMT" /></td>
					</tr>
					<tr>
						<th>비고</th>
						<td><input type="text" id="REMARK" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var init = {};
	var leftGridData = {};
	var gSALEID = $("#hdnSALEID", opener.document).val();
	var gIPGUMSEQ = $("#hdnIPGUMSEQ", opener.document).val();
	var gCANCELYN = $("#hdnCANCELYN", opener.document).val();
	
	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton, #deleteButton, #saveButton").jqxButton({theme: 'energyblue', width: 80, height: 25});
		$("#S_IPGUMDATE_FR, #S_IPGUMDATE_TO").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##'});
		$("#S_KNAME").jqxInput({theme: 'energyblue', width: 150, height: 25});
		$("#S_IPGUMAMT").jqxInput({theme: 'energyblue', width: 150, height: 25, rtl: true});
		$("#IPGUMDATE").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##', disabled: true});
		$("#NAME_IPGUMTYPE, #NAME_IPGUMGUBUN, #NAME_BANKGUBUN").jqxInput({theme: 'energyblue', width: 120, height: 25, disabled: true});
		$("#IPGUMID, #IPGUMPERSON").jqxInput({theme: 'energyblue', width: 100, height: 25, disabled: true});
		$("#IPGUMAMT, #SUM_SUGUMAMT, #REM_IPGUMAMT, #txtIpgumSum").jqxInput({theme: 'energyblue', width: 120, height: 25, rtl: true, disabled: true});
		$("#SUGUMAMT").jqxInput({theme: 'energyblue', width: 120, height: 25, rtl: true});
		$("#REMARK").jqxInput({theme: 'energyblue', width: 300, height: 25});
		// 버튼권한 설정
		init.setAuth = function() {
			<%if("N".equals(session.getAttribute("AUTH_I"))) {%>
			$("#saveButton").hide();
			<%}%>
			<%if("N".equals(session.getAttribute("AUTH_D"))) {%>
			$("#deleteButton").hide();
			<%}%>
			<%if("N".equals(session.getAttribute("AUTH_P"))) {%>
			<%}%>
			
			if(gCANCELYN == "Y") {		// 해약 매출일 경우
				$("#deleteButton, #saveButton").jqxButton({disabled: true});		
			}
		}
		// 입금기간 초기화
		init.setDate = function() {
			$("#S_IPGUMDATE_FR").val(dateInput(1));
			$("#S_IPGUMDATE_TO").val(dateInput(0));
		}
		// 입금구분 초기화
		init.setIpgumGubun = function() {
			$("#S_IPGUMGUBUN").empty();
			$("#S_IPGUMGUBUN").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			
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
					$("#S_IPGUMGUBUN").append(sTemp);
				},
				error:function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 금융기관 초기화
		init.setBankGubun = function() {
			$("#S_BANKGUBUN").empty();
			$("#S_BANKGUBUN").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			
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
					$("#S_BANKGUBUN").append(sTemp);
				},
				error: function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 상단 그리드 초기화
		init.setTopGrid = function() {
			var param = {
				SALEID: gSALEID,
				IPGUMSEQ : gIPGUMSEQ
			};
			$("#topGrid").jqGrid("GridUnload");
			$("#topGrid").jqGrid({
				mtype: "POST",
				url: "/home/SA011005_s1.do",
				postData : JSON.stringify(param),
				ajaxGridOptions : {contentType: "application/json;charset=UTF-8"},
				datatype: "json",
			   	colModel:[			   	    
					{label: "입금일자", name: "IPGUMDATE", sortable: false, width: 80, align: "center"},
					{label: "입금인", name: "IPGUMPERSON", sortable: false, width: 60, align: "center"},
					{label: "입금금액", name: "IPGUMAMT", sortable: false, width: 80, align: "right", formatter: "number", formatoptions: {thousandsSeparator: ",", defaulValue: ""}},
					{label: "입금은행", name: "NAME_BANKGUBUN", sortable: false, width: 100, align: "center"},
					{label: "입금구분", name: "NAME_IPGUMGUBUN", sortable: false, width: 60, align: "center"},
					{label: "비고", name: "MST_REMARK", sortable: false, width: 200, align: "left"},
					{label: "입금처리일", name: "DEPOSITDATE", sortable: false, width: 80, align: "center"},
					{label: "처리금액", name: "SUGUMAMT", sortable: false, width: 80, align: "right", formatter: "number", formatoptions: {thousandsSeparator: ",", defaulValue: ""}},
					{label: "비고", name: "DTL_REMARK", sortable: false, width: 200, align: "left"},
					{label: "입금번호", name: "IPGUMID", sortable: false, hidden: true},
					{label: "처리순번", name: "SEQ", sortable: false, hidden: true},
					{label: "매출번호", name: "SALEID", sortable: false, hidden: true},
			   		{label: "입금스케줄순번", name: "IPGUMSEQ", sortable: false, hidden: true},
			   		{label: "입금형태(코드)", name: "IPGUMTYPE", sortable: false, hidden: true},
			   		{label: "입금형태", name: "NAME_IPGUMTYPE", sortable: false, hidden: true},
			   		{label: "입금구분(코드)", name: "IPGUMGUBUN", sortable: false, hidden: true},
			   		{label: "입금은행(코드)", name: "BANKGUBUN", sortable: false, hidden: true},
			   		{label: "입금여부", name: "DEPOSITYN", sortable: false, hidden: true}
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
					var rCount = $("#topGrid").jqGrid("getGridParam", "records");
					$("#topGridCount").text(rCount);
				},
				gridComplete: function() {
					var ids = $("#topGrid").jqGrid("getDataIDs");
					var iSugumSum = 0;
					var sSugumSum = "";
					
					for(var i = 0; i < ids.length; i++) {
						var aRowData = $("#topGrid").jqGrid("getRowData", ids[i]);
						iSugumSum += parseInt(aRowData.SUGUMAMT);
					}
					
					sSugumSum = iSugumSum.toString();
					$("#txtIpgumSum").val(setComma(sSugumSum));
				}
			});			
		};
		// 좌측 그리드 초기화
		init.setLeftGrid = function() {
			var param = {
				"S_IPGUMDATE_FR": $("#S_IPGUMDATE_FR").val().replace(/[^0-9-]/g, ""),
				"S_IPGUMDATE_TO": $("#S_IPGUMDATE_TO").val().replace(/[^0-9-]/g, ""),
				"S_KNAME": $.trim($("#S_KNAME").val()),
				"S_IPGUMGUBUN" : $("#S_IPGUMGUBUN").val(),
				"S_BANKGUBUN": $("#S_BANKGUBUN").val(),
				"S_IPGUMAMT": removeComma($("#S_IPGUMAMT").val())
			};
			$("#leftGrid").jqGrid("GridUnload");
			$("#leftGrid").jqGrid({
				mtype: "POST",
				url: "/home/SA011005_s2.do",
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
					$("#NAME_IPGUMTYPE").val(leftGridData.NAME_IPGUMTYPE);
					$("#NAME_IPGUMGUBUN").val(leftGridData.NAME_IPGUMGUBUN);
					$("#IPGUMGUBUN").val(leftGridData.IPGUMGUBUN);
					$("#NAME_BANKGUBUN").val(leftGridData.NAME_BANKGUBUN);
					$("#IPGUMPERSON").val(leftGridData.IPGUMPERSON);
					$("#IPGUMAMT").val(setComma(leftGridData.IPGUMAMT));
					$("#SUM_SUGUMAMT").val(setComma(leftGridData.SUM_SUGUMAMT));
					$("#REM_IPGUMAMT").val(setComma(leftGridData.REM_IPGUMAMT));
					
					$("#SUGUMAMT").focus();
				}
			});
		}
		
		init.setAuth();
		init.setDate();		
		init.setIpgumGubun();
		init.setBankGubun();
		init.setTopGrid();
		init.setLeftGrid();
		
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
		});
		// 취소(삭제) 버튼 클릭 이벤트
		$("#deleteButton").click(function() {
			var id = $("#topGrid").jqGrid("getGridParam", "selrow");
			
			if(id == null) {
				alert("취소할 데이터를 그리드에서 선택해주세요.");
			} else {
				var pData = $("#topGrid").jqGrid("getRowData", id);
				fnDelete(pData);
			}
		});
		// 저장 버튼 클릭 이벤트
		$("#saveButton").click(function() {
			if(fnSaveValidation()) fnSave();
		});
		// 숫자 입력 키 이벤트
		inputComma("S_IPGUMAMT");
		inputComma("SUGUMAMT");
		// 비고 입력 키 이벤트
		$("#REMARK").on("keydown", function(e) {
			if(e.keyCode == 13) {
				if(!$("#saveButton").prop("disabled")) $("#saveButton").trigger("click");
			}
		});
	});
	
	// 입력 값 리셋
	function fnReset(callback) {
		$("#rightDiv input[type='text'], #rightDiv select").each(function(idx) {
			if($(this).attr("id") == "IPGUMDATE") $("#IPGUMDATE").jqxMaskedInput("clear");
			else $(this).val("");
		});
		
		$("#leftGrid").resetSelection();
		leftGridData = {};
		
		if(typeof callback == "function") callback();
	}
	// 저장 유효성 체크
	function fnSaveValidation() {
		if(!leftGridData.IPGUMID) {
			alert("입금 처리할 데이터를 그리드에서 선택해주세요.");
			return false;
		}
		if(removeComma($("#SUGUMAMT").val()) == "") {
			alert("처리금액을 입력해주세요.");
			$("#SUGUMAMT").focus();
			return false;
		}
		if(removeComma($("#SUGUMAMT").val()) > removeComma($("#REM_IPGUMAMT").val())) {
			alert("처리금액이 미처리잔액을 초과하였습니다.\n다시 입력해주세요.");
			$("#SUGUMAMT").val("");
			$("#SUGUMAMT").focus();
			return false;
		}
		return true;
	}
	// 저장
	function fnSave() {
		if(confirm("저장하시겠습니까?")) {
			var param = {
					IPGUMID: $("#IPGUMID").val(),
					SALEID: gSALEID,
					IPGUMSEQ: gIPGUMSEQ,
					SUGUMAMT: removeComma($("#SUGUMAMT").val()),
					REMARK: $.trim($("#REMARK").val()),
					PAYGUBUN: $("#IPGUMGUBUN").val()
			};
			$.ajax({ 
				type: "POST",
				url: "/home/SA011005_u1.do",
				data : JSON.stringify(param),
				contentType : "application/json;charset=UTF-8",
				dataType : "json", 
				success: function(data) {				
					var receiveData = data.rows;
					
					if(receiveData.MSG == "success") {
						alert("저장이 완료되었습니다.");
						$("#selectButton").trigger("click");
						init.setTopGrid();
						window.opener.f_selectListEnaIpgumScheduleTb(gSALEID);
					} else {
						alert("저장 중 오류가 발생했습니다.");	
					}
				},
				error: function(x, s, e) {
					alert("[ERROR]"+ e);
				}  
			});
		}
	}
	// 삭제
	function fnDelete(pData) {
		if(confirm("취소하시겠습니까?")) {
			var param = pData;
			$.ajax({
				type: "POST",
				url: "/home/SA011005_u2.do",	
				data : JSON.stringify(param),
				contentType : "application/json;charset=UTF-8",
				dataType : "json", 
				success: function(data) {				
					var receiveData = data.rows;
					
					if(receiveData.MSG == "success") {
						alert("취소가 완료되었습니다.");						
						$("#selectButton").trigger("click");
						init.setTopGrid();
						$(opener.location).attr("href", "javascript:f_selectListEnaIpgumScheduleTb(\""+ gSALEID +"\")");
					} else {
						alert("취소 중 오류가 발생했습니다.");	
					}
				},
				error: function(x, s, e) {  
					alert("[ERROR]"+ e);
				}  
			});
		}
	}
</script>