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
		
		var S_IPGUMDATE_FR = "";
		var S_IPGUMDATE_TO = "";
		var S_BRANCHCODE = "";
		var S_SALERCD = "";
		var S_IPGUMGUBUN = "";
		var S_IPGUMPERSON = "";
		var S_IPGUMAMT = "";
		var auth_p = true;

		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		<%if ("N".equals(session.getAttribute("AUTH_P"))) { %>
			$("#excelButton").hide();
			$("#printButton").hide();
			auth_p = false;
		<% }%>
		
		$("#S_IPGUMDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_IPGUMDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_IPGUMPERSON").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#S_IPGUMAMT").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		
		f_selectListEnaBranchCode();
		f_selectListEnaSalerCode();
		f_selectListEnaIpgumGubunCode();
		
		f_selectListSA012004(S_IPGUMDATE_FR, S_IPGUMDATE_TO, S_BRANCHCODE, S_SALERCD, S_IPGUMGUBUN, S_IPGUMPERSON, S_IPGUMAMT);
		
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
				f_selectListEnaSalerCode();
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	$(function(){
		$("#S_BRANCHCODE").change(function() {
			f_selectListEnaSalerCode();
		});
	});
	
	function f_selectListEnaSalerCode(){
		
		var BRANCHCODE = $("#S_BRANCHCODE").val();
		$("#S_SALERCD").empty().data('options');
		
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/insaMstList.do", 
			dataType : 'json' , 
			data : {
				BRANCHCODE : BRANCHCODE,
			},
			success: function(data){
				var inHtml = "";
				inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
				data.insaMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.INSACODE + "'>" + currentValue.KNAME + "</option>\n";
				});
				$("#S_SALERCD").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaIpgumGubunCode(){
		$("#S_IPGUMGUBUN").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
		
		var CCODE = "009";
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/dcodeList.do", 
			dataType : 'json' ,
			data : {
				CCODE : CCODE,
			},
			success: function(data){
				var inHtml = "";
				data.dcodeList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
				});
				$("#S_IPGUMGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListSA012004(S_IPGUMDATE_FR, S_IPGUMDATE_TO, S_BRANCHCODE, S_SALERCD, S_IPGUMGUBUN, S_IPGUMPERSON, S_IPGUMAMT){
		S_IPGUMPERSON = encodeURI(encodeURIComponent(S_IPGUMPERSON));
		
		var url = "/home/selectListSA012004.do?S_IPGUMDATE_FR=" + S_IPGUMDATE_FR + "&S_IPGUMDATE_TO=" + S_IPGUMDATE_TO + "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_SALERCD=" + S_SALERCD + "&S_IPGUMGUBUN=" + S_IPGUMGUBUN + "&S_IPGUMPERSON=" + S_IPGUMPERSON + "&S_IPGUMAMT=" + S_IPGUMAMT;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"IPGUMDATE",	type: 'string' },
				{name:"BRANCHNAME",	type: 'string' },
				{name:"KNAME",		type: 'string' },
				{name:"CONNAME",	type: 'string' },
				{name:"IPGUMGUBUN",	type: 'string' },
				{name:"IPGUMAMT",	type: 'number' },
				{name:"SUGUMAMT",	type: 'number' },
				{name:"JANGUMAMT",	type: 'number' },
				{name:"BANKNAME",	type: 'string' },
				{name:"IPGUMTYPE",	type: 'string' },
				{name:"ADDRESS",	type: 'string' },
				{name:"CONPY",		type: 'number' },
				{name:"REMARK",		type: 'string' }

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
                      
				{ text: '입금일자', 		datafield: "IPGUMDATE",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '지사', 			datafield: "BRANCHNAME",	width: 100, cellsalign: 'center', align: 'center'},
				{ text: '담당자', 			datafield: "KNAME",			width: 150, cellsalign: 'center', align: 'center'},
				{ text: '계약자', 			datafield: "CONNAME",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '입금구분', 		datafield: "IPGUMGUBUN",	width: 100, cellsalign: 'center', align: 'center'},
				{ text: '입금금액', 		datafield: "IPGUMAMT",		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
				{ text: '수금처리금액', 	datafield: "SUGUMAMT",		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
				{ text: '처리잔액', 		datafield: "JANGUMAMT",		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
				{ text: '입금은행', 		datafield: "BANKNAME",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '입금형태', 		datafield: "IPGUMTYPE",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '소재지', 			datafield: "ADDRESS",		width: 200, cellsalign: 'center', align: 'center'},
				{ text: '평수', 			datafield: "CONPY",			width: 100, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
				{ text: '비고', 			datafield: "REMARK",		width: 250, cellsalign: 'center', align: 'center'}
				
			]

        });
	
	}

	$(function(){
		$("#selectButton").click(function(){
			//콤마 remove
			f_commaInputData("remove");
			
			var S_IPGUMDATE_FR = $("#S_IPGUMDATE_FR").val();
			var S_IPGUMDATE_TO = $("#S_IPGUMDATE_TO").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_SALERCD = $("#S_SALERCD").val();
			var S_IPGUMGUBUN = $("#S_IPGUMGUBUN").val();
			var S_IPGUMPERSON = $("#S_IPGUMPERSON").val();
			var S_IPGUMAMT = $("#S_IPGUMAMT").val();

			if (S_IPGUMDATE_FR == "" || S_IPGUMDATE_TO == "") {
				alert("입금기간을 입력하셔야합니다.");
				
				$("#S_SALEDATE").focus();	
				
				//콤마 set
				f_commaInputData("click");
				
				return false;
			}
			
			
			f_selectListSA012004(S_IPGUMDATE_FR, S_IPGUMDATE_TO, S_BRANCHCODE, S_SALERCD, S_IPGUMGUBUN, S_IPGUMPERSON, S_IPGUMAMT);
			
			//콤마 set
			f_commaInputData("click");
		});
		
		$("#excelButton").click(function () {
			//dataType String , fileName(optional) String , exportHeader Boolean, rows Array, exportHiddenColumns Boolean, serverURL String, charSet String 
	        $("#mainList").jqxGrid('exportdata', 'xls', 'EnglishFileName', true, null, true, null, 'utf-8');           
	    });
		
	})
	
		$(function() {
			inputComma("S_IPGUMAMT");
		})
		
		function f_commaInputData(str) {
			if (str == "click") {
				$("#S_IPGUMAMT").click();
			} else if (str == "remove") {
				$("#S_IPGUMAMT").val(removeComma($("#S_IPGUMAMT").val()));

			}
			
		}
	
</script>
<body>

	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<td align="right">
						<input type="button" value="조회" id='selectButton' />
						<input type="button" value="엑셀" id='excelButton' />
						<input type="button" value="출력" id='printButton' />
					</td>
				</tr>
			</table>
		</div>
		<div id="mainDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">입금기간</th>
					<td width="190"><input type="text" id="S_IPGUMDATE_FR" name="S_IPGUMDATE_FR" /> ~ <input type="text" id="S_IPGUMDATE_TO" name="S_IPGUMDATE_TO" /></td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:90px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
					<th width="120">담당자</th>
					<td>
						<select id="S_SALERCD" name="S_SALERCD">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">입금구분</th>
					<td>
						<select id="S_IPGUMGUBUN" name="S_IPGUMGUBUN" style="width:90px">
						</select>
					</td>
					<th width="120">입금인</th>
					<td width="170"><input type="text" id="S_IPGUMPERSON" name="S_IPGUMPERSON" /></td>
					<th width="120">입금금액</th>
					<td><input type="text" id="S_IPGUMAMT" name="S_IPGUMAMT" /></td>
				</tr>
			</table>
			<br/>
			<div align="right">총 건수 : <font color="red"><sapn id="mainListCount"></sapn></font>건</div>
			<div id="mainList"></div>
		</div>
	</div>
</body>
</html>