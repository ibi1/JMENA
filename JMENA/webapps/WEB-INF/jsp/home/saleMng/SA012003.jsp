<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

</head>


<script type="text/javascript">
	$(document).ready(function(){
		
		var S_SALEDATE_FR = "";
		var S_SALEDATE_TO = "";
		var S_BRANCHCODE = "";
		var S_DEPTCODE = "";
		var S_DCODE = "";
		var S_KNAME = "";
		var auth_p = true;

		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		<%if ("N".equals(session.getAttribute("AUTH_P"))) { %>
			$("#excelButton").hide();
			auth_p = false;
		<% }%>
		
		$("#S_SALEDATE_FR, #S_SALEDATE_TO").jqxMaskedInput({theme: 'energyblue', width: 90, height: 25, mask: '####-##-##'});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		//f_selectListEnaDCode();
		
		f_selectListSA012003(S_DCODE, S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
	});
	
	function f_selectListEnaBranchCode(){
		$("#S_BRANCHCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/branchMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
				data.branchMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.BRANCHCODE + "'>" + currentValue.BRANCHNAME + "</option>\n";
				});
				$("#S_BRANCHCODE").append(inHtml);
				f_selectListEnaDeptCode();
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	$(function(){
		$("#S_BRANCHCODE").change(function() {
			f_selectListEnaDeptCode();
		});
	});
	
	function f_selectListEnaDeptCode(){
		
		var BRANCHCODE = $("#S_BRANCHCODE").val();
		$("#S_DEPTCODE").empty().data('options');
		
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/deptMstList.do", 
			dataType : 'json' , 
			data : {
				BRANCHCODE : BRANCHCODE,
			},
			success: function(data){
				var inHtml = "";
				inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
				data.deptMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.DEPTCODE + "'>" + currentValue.DEPTNAME + "</option>\n";
				});
				$("#S_DEPTCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	
	function f_selectListEnaDCode(){
		var CCODE = "007";
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/dcodeList.do", 
			dataType : 'json' ,
			data : {
				CCODE : CCODE,
			},
			success: function(data){
				var inHtml = "";
				inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
				data.dcodeList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
				});
				$("#S_DCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListSA012003(S_DCODE, S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME){
		S_KNAME = encodeURI(encodeURIComponent(S_KNAME));
		
		var url = "/home/selectListSA012003.do?S_SALEDATE_FR=" + S_SALEDATE_FR + "&S_SALEDATE_TO=" + S_SALEDATE_TO 
		+ "&S_BRANCHCODE=" + S_BRANCHCODE
		+ "&S_DEPTCODE=" + S_DEPTCODE
		+ "&S_DCODE=" + S_DCODE
		+ "&S_KNAME=" + S_KNAME;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
				{name: "SALEID", type: "string"},
				{name: "SALEDATE", type: "string"},
				{name: "CONNAME", type: "string"},
				{name: "CONJUMINID", type: "string"},
				{name: "CONM2", type: "number"},
				{name: "REMARK", type: "string"},
				{name: "NAME_BRROWTYPE", type: "string"},
				{name: "BRROWAMT", type: "number"},
				{name: "BRROWPERIOD", type: "string"},
				{name: "BRROWDATE", type: "string"},
				{name: "EXPIREDATE", type: "string"},
				{name: "PAYRATE", type: "number"},
				{name: "PAYAMT", type: "number"},
				{name: "TAXINCOME", type: "number"},
				{name: "TAXLOCAL", type: "number"},
				{name: "ACTPAYAMT", type: "number"},
				{name: "PAYACCOUNT", type: "string"},
				{name: "NAME_PAYBANK", type: "string"},
				{name: "EXTENDYN", type: "string"},
				{name: "EXTENDDATE", type: "string"},
				{name: "CANCELYN", type: "string"},
				{name: "CANCELDATE", type: "string"},
				{name: "PAYOWNER", type: "string"},
				{name: "ADDRESS", type: "string"},
				{name: "MNGRNAME", type: "string"},
				{name: "KNAME", type: "string"},
				{name: "BRANCHNAME", type: "string"}
            ],
            root: "rows",
            //record: "records",
            id: 'CITYCODE',
            url: url
        };

        var dataAdapter = new $.jqx.dataAdapter(source, {
            downloadComplete: function (data, status, xhr) {
            },
            loadComplete: function (data) {
            	var countRow = $('#mainList').jqxGrid('getrows');
            	$("#mainListCount").text(countRow.length);
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
				{text: "지사", datafield: "BRANCHNAME", width: 100, cellsalign: "center", align: "center"},
				{text: "실장명", datafield: "MNGRNAME", width: 100, cellsalign: "center", align: "center"},
				{text: "계약일", datafield: "SALEDATE", width: 100, cellsalign: "center", align: "center"},
				{text: "만기일", datafield: "EXPIREDATE", width: 100, cellsalign: "center", align: "center"},
				{text: "담당자", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
				{text: "고객명", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
				{text: "주민번호", datafield: "CONJUMINID", width: 150, cellsalign: "center", align: "center"},
				{text: "구분", datafield: "NAME_BRROWTYPE", width: 80, cellsalign: "center", align: "center"},
				{text: "기간", datafield: "BRROWPERIOD", width: 80, cellsalign: "center", align: "center"},
				{text: "금액", datafield: "BRROWAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "이율", datafield: "PAYRATE", width: 60, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "이자", datafield: "PAYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "갑근세", datafield: "TAXINCOME", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "주민세", datafield: "TAXLOCAL", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "실수령액", datafield: "ACTPAYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "연장여부", datafield: "EXTENDYN", width: 80, cellsalign: "center", align: "center"},
				{text: "연장일", datafield: "EXTENDDATE", width: 100, cellsalign: "center", align: "center"},
				{text: "중도해지", datafield: "CANCELYN", width: 80, cellsalign: "center", align: "center"},
				{text: "중도해지일", datafield: "CANCELDATE", width: 100, cellsalign: "center", align: "center"},
				{text: "담보소재지", datafield: "ADDRESS", width: 240, cellsalign: "left", align: "center"},
				{text: "계약면적", datafield: "CONM2", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
				{text: "입금은행", datafield: "NAME_PAYBANK", width: 100, cellsalign: "center", align: "center"},
				{text: "입금계좌", datafield: "PAYACCOUNT", width: 100, cellsalign: "center", align: "center"},
				{text: "예금주", datafield: "PAYOWNER", width: 100, cellsalign: "center", align: "center"},
				{text: "비고", datafield: "REMARK", width: 200, cellsalign: "left", align: "center"},
				{text: "차입날짜", datafield: "BRROWDATE", width: 100, cellsalign: "center", align: "center", hidden: true},
				{text: "판매번호", datafield: "SALEID", width: 100, cellsalign: "center", align: "center", hidden: true}
            ]
        });

	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_SALEDATE_FR = $("#S_SALEDATE_FR").val().replace(/[^0-9-]/g, "");
			var S_SALEDATE_TO = $("#S_SALEDATE_TO").val().replace(/[^0-9-]/g, "");
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			//var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_DEPTCODE = "";
			var S_DCODE = $("#S_DCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			if (S_SALEDATE_FR.length < 10 || S_SALEDATE_TO.length < 10) {
				alert("계약기간을 입력하셔야합니다.");				
				return false;
			}
			
			f_selectListSA012003(S_DCODE, S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
		});
		
		$("#excelButton").click(function () {
			//dataType String , fileName(optional) String , exportHeader Boolean, rows Array, exportHiddenColumns Boolean, serverURL String, charSet String 
	        //$("#mainList").jqxGrid('exportdata', 'xls', 'EnglishFileName', true, null, true, null, 'utf-8');
			
			if($.trim($("#mainListCount").text()) == "0") {
				alert("엑셀로 내려받을 데이터가 없습니다.");
				return;
			} else {
		        var url = "/home/SA012003_exportToExcel.do";
				var S_SALEDATE_FR = $("#S_SALEDATE_FR").val();
				var S_SALEDATE_TO = $("#S_SALEDATE_TO").val();
				var S_BRANCHCODE = $("#S_BRANCHCODE").val();
				//var S_DEPTCODE = $("#S_DEPTCODE").val();
				var S_DEPTCODE = "";
				var S_DCODE = $("#S_DCODE").val();
				var S_KNAME = $("#S_KNAME").val();
				
				
				var dataParam = "S_SALEDATE_FR=" + S_SALEDATE_FR + "&S_SALEDATE_TO=" + S_SALEDATE_TO + "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_DEPTCODE=" + S_DEPTCODE + "&S_KNAME=" + S_KNAME + "&S_DCODE=" + S_DCODE;
				
				//파일 다운로드 (common.js에 있음)
				$.download(url, dataParam, 'post');
			};
	    });
	})
</script>
<body>

	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<td align="right">
						<input type="button" value="조회" id='selectButton' />
						<input type="button" value="엑셀" id='excelButton' />
					</td>
				</tr>
			</table>
		</div>
		<div id="mainDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">계약기간</th>
					<td><input type="text" id="S_SALEDATE_FR" name="S_SALEDATE_FR" /> ~ <input type="text" id="S_SALEDATE_TO" name="S_SALEDATE_TO" /></td>
					<th width="120">구분</th>
					<td>
						<select id="S_DCODE" name="S_DCODE" style="width:120px">
							<option value="ALL" selected="selected">전체</option>
							<option value="1">만기해약</option>
							<option value="2">만기연장</option>
							<option value="3">중도해지</option>
							<option value="4">계약</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td width="200">
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:120px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
					<!-- <th width="120">부서</th>
					<td width="170">
						<select id="S_DEPTCODE" name="S_DEPTCODE" style="width:120px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td> -->
					<th width="120">담당자명</th>
					<td width="170"><input type="text" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
			</table>
			<br/>
			<div align="right">총 건수 : <font color="red"><sapn id="mainListCount"></sapn></font>건</div>
			<div id="mainList"></div>
		</div>
	</div>
</body>
</html>