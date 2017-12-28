<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>매출잔금현황</title>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<td align="right">
						<input type="button" value="조회" id="selectButton" />
						<input type="button" value="엑셀" id="excelButton" />
						<!-- <input type="button" value="출력" id="printButton" /> -->
					</td>
				</tr>
			</table>
		</div>
		<div id="mainDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">매출기간</th>
					<td width="200">
						<input type="text" id="S_SALEDATE_FR" /> -
						<input type="text" id="S_SALEDATE_TO" />
					</td>
					<th width="120">지사</th>
					<td width="170">
						<select id="S_BRANCHCODE" style="width:120px"></select>
					</td>
					<th width="120">부서</th>
					<td width="150">
						<select id="S_DEPTCODE" style="width:120px"></select>
					</td>
				</tr>
				<tr>
					<th width="120">매출구분</th>
					<td>
						<select id="S_SALEGUBUN" style="width:120px"></select>
					</td>
					<th width="120">담당자명</th>
					<td colspan="3"><input type="text" id="S_KNAME" /></td>
				</tr>
			</table>
			<br/>
			<div align="right">총 건수 : <font color="red"><sapn id="mainListCount"></sapn></font>건</div>
			<div id="mainList"></div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var init = {};
	
	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#S_SALEDATE_FR").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
		$("#S_SALEDATE_TO").jqxMaskedInput({width: '90px', height: '25px', mask: '####-##-##', theme: 'energyblue'});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1, maxLength: 10});
		// 권한설정
		init.setAuth = function() {
			<%if("N".equals(session.getAttribute("AUTH_P"))) {%>
			$("#excelButton").hide();
			<%}%>
		}
		// 기간 초기화 : 잔금입금일
		init.setDate = function() {
			$("#S_SALEDATE_FR").val(dateInput(1));
			$("#S_SALEDATE_TO").val(dateInput(0));
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
			S_KNAME = encodeURI(encodeURIComponent(S_KNAME));
			
			var url = "/home/selectListSA012002.do"
					+ "?S_SALEDATE_FR="+ $("#S_SALEDATE_FR").val()
					+ "&S_SALEDATE_TO="+ $("#S_SALEDATE_TO").val()
					+ "&S_BRANCHCODE="+ $("#S_BRANCHCODE").val()
					+ "&S_DEPTCODE="+ $("#S_DEPTCODE").val()
					+ "&S_SALEGUBUN="+ $("#S_SALEGUBUN").val()
					+ "&S_KNAME="+ encodeURI(encodeURIComponent($.trim($("#S_KNAME").val())));
			
	        // prepare the data
	        var source = {
	            datatype: "json",
	            datafields: [
					{name:"BRANCHNAME",		type: 'string' },
					{name:"MNGRNAME",		type: 'string' },
					{name:"SALEDATE",		type: 'string' },
					{name:"SALEGUBUNNAME",	type: 'string' },
					{name:"DEPOSITDATE",	type: 'string' },
					{name:"KNAME",			type: 'string' },
					{name:"CONNAME",		type: 'string' },
					{name:"ADDRESS",		type: 'string' },
					{name:"CONM2",			type: 'number' },
					{name:"CONPY",			type: 'number' },
					{name:"SALEAMT",		type: 'number' },
					{name:"DCRATE",			type: 'string' },
					{name:"SELLAMT",		type: 'number' },
					{name:"SALEDANGA",		type: 'number' },
					{name:"AGENCYAMT",		type: 'number' },
					{name:"DEPOSITAMT1",	type: 'number' },
					{name:"DEPOSITAMT2",	type: 'number' },
					{name:"DEPOSITAMT3",	type: 'number' },
					{name:"SUGUMAMT1",		type: 'number' },
					{name:"SUGUMAMT2",		type: 'number' },
					{name:"SUGUMAMT3",		type: 'number' },
					{name:"SUGUMAMT",		type: 'number' },
					{name:"REMNAMT",		type: 'number' },
					{name:"IPGUMRATE",		type: 'number' },
					{name:"REMARK",			type: 'string' }
	            ],
	            root: "rows",
	            url: url
	        };
	        var dataAdapter = new $.jqx.dataAdapter(source, {
	            loadComplete: function (data) {
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
	            columnsresize: true,
	            columns: [
					{ text: '지사', datafield: "BRANCHNAME", width: 100, cellsalign: 'center', align: 'center'},
					{ text: '실장명', datafield: "MNGRNAME", width: 100, cellsalign: 'center', align: 'center'},
					{ text: '계약일', datafield: "SALEDATE", width: 100, cellsalign: 'center', align: 'center'},
					{ text: '구분', datafield: "SALEGUBUNNAME", width: 80, cellsalign: 'center', align: 'center'},
					{ text: '잔금일', datafield: "DEPOSITDATE", width: 100, cellsalign: 'center', align: 'center'},
					{ text: '담당자', datafield: "KNAME", width: 100, cellsalign: 'center', align: 'center'},
					{ text: '고객명', datafield: "CONNAME", width: 100, cellsalign: 'center', align: 'center'},
					{ text: '주소', datafield: "ADDRESS", width: 240, cellsalign: 'left', align: 'center'},
					{ text: '면적', datafield: "CONM2", width: 80, cellsalign: 'right', align: 'center', cellsformat: 'f2'},
					{ text: '평수', datafield: "CONPY", width: 80, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '원 판매가', datafield: "SALEAMT", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '(%)', datafield: "DCRATE", width: 80, cellsalign: 'right', align: 'center'},
					{ text: '실판매가', datafield: "SELLAMT", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '평단가', datafield: "SALEDANGA", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '위탁수수료', datafield: "AGENCYAMT", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '계약금', datafield: "DEPOSITAMT1",	width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '중도금', datafield: "DEPOSITAMT2",	width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '잔금', datafield: "DEPOSITAMT3", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '계약입금액', datafield: "SUGUMAMT1", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '중도입금액', datafield: "SUGUMAMT2", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '잔금입금액', datafield: "SUGUMAMT3", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0', hidden: true},
					{ text: '입금총액', datafield: "SUGUMAMT", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '입금잔액', datafield: "REMNAMT", width: 120, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '입금율(%)', datafield: "IPGUMRATE", width: 80, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
					{ text: '비고', datafield: "REMARK", width: 250, cellsalign: 'left', align: 'center'}
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
			//*** 정규식으로 입력값 체크
			init.setGrid();	
		});
		// 엑셀 버튼 클릭 이벤트
		$("#excelButton").click(function() {
			if($.trim($("#mainListCount").html()) == 0) {
	        	alert("다운로드 할 데이터가 없습니다.");
	        	return;	
	        }
			
			var url = "/home/SA012002_exportToExcel.do";
			var dataParam = "S_SALEDATE_FR="+ $("#S_SALEDATE_FR").val()
						  + "&S_SALEDATE_TO="+ $("#S_SALEDATE_TO").val()
						  + "&S_BRANCHCODE="+ $("#S_BRANCHCODE").val()
						  + "&S_DEPTCODE="+ $("#S_DEPTCODE").val()
						  + "&S_SALEGUBUN="+ $("#S_SALEGUBUN").val()
						  + "&S_KNAME="+ encodeURI(encodeURIComponent($.trim($("#S_KNAME").val())));			
			//파일 다운로드 (common.js에 있음)
			$.download(url, dataParam, 'post');	
		});
	})
</script>