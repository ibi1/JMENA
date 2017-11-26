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
		var S_KNAME = "";
		var auth_p = true;

		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		<%if ("N".equals(session.getAttribute("AUTH_P"))) { %>
			$("#excelButton").hide();
			$("#printButton").hide();
			auth_p = false;
		<% }%>
		
		$("#S_SALEDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_SALEDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		
		f_selectListSA012003(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
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

	
	function f_selectListSA012003(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME){
		var url = "/home/selectListSA012003.do?S_SALEDATE_FR=" + S_SALEDATE_FR + "&S_SALEDATE_TO=" + S_SALEDATE_TO 
		+ "&S_BRANCHCODE=" + S_BRANCHCODE
		+ "&S_DEPTCODE=" + S_DEPTCODE
		+ "&S_KNAME=" + S_KNAME;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"BRANCHNAME",	type: 'string' },
				{name:"DEPTNAME",	type: 'string' },
				{name:"SALEDATE",	type: 'string' },
				{name:"SALEID",		type: 'string' },
				{name:"KNAME",		type: 'string' },
				{name:"CONNAME",	type: 'string' },
				{name:"CONJUMINID",	type: 'string' },
				{name:"BRROWTYPE",	type: 'string' },
				{name:"BRROWTERM",	type: 'string' },
				{name:"BRROWAMT",	type: 'number' },
				{name:"PAYRATE",	type: 'string' },
				{name:"PAYAMT",		type: 'number' },
				{name:"TAXAMT",		type: 'number' },
				{name:"JIGUEBAMT",	type: 'number' },
				{name:"EXPIREDATE",	type: 'string' },
				{name:"EXTENDYN",	type: 'string' },
				{name:"EXTENDDATE",	type: 'string' },
				{name:"CANCELYN",	type: 'string' },
				{name:"CANCELDATE",	type: 'string' },
				{name:"ADDRESS",	type: 'string' },
				{name:"BANKNAME",	type: 'string' },
				{name:"PAYACCOUNT",	type: 'string' },
				{name:"PAYOWNER",	type: 'string' },
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
            },
            loadError: function (xhr, status, error) { alert("Error~~!"); }
        });
        
		// initialize jqxGrid
        $("#mainList").jqxGrid({
        	theme: 'energyblue',
        	sorttogglestates: 0,
        	sortable: false,
            width: '98%',
            source: dataAdapter,                
            pageable: false,
            autoheight: false,
            altrows: true,
            enabletooltips: true,
            editable: false,
            selectionmode: 'singlerow',
            columns: [
                      
				{ text: '지사', 		datafield: "BRANCHNAME",	width: 100, cellsalign: 'center', align: 'center'},
				{ text: '부서', 		datafield: "DEPTNAME",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '계약일', 		datafield: "SALEDATE",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '계약번호', 	datafield: "SALEID",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '담당자', 		datafield: "KNAME",			width: 150, cellsalign: 'center', align: 'center'},
				{ text: '고객명', 		datafield: "CONNAME",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '주민번호', 	datafield: "CONJUMINID",	width: 150, cellsalign: 'center', align: 'center'},
				{ text: '지급구분', 	datafield: "BRROWTYPE",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '차용기간', 	datafield: "BRROWTERM",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '차입금액', 	datafield: "BRROWAMT",		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'c3'},
				{ text: '지급이율(%)', 	datafield: "PAYRATE",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '지급이자', 	datafield: "PAYAMT",		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'c3'},
				{ text: '이자소득세', 	datafield: "TAXAMT",		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'c3'},
				{ text: '실 수령액', 	datafield: "JIGUEBAMT",		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'c3'},
				{ text: '만기일', 		datafield: "EXPIREDATE",	width: 150, cellsalign: 'center', align: 'center'},
				{ text: '연장여부', 	datafield: "EXTENDYN",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '연장일', 		datafield: "EXTENDDATE",	width: 150, cellsalign: 'center', align: 'center'},
				{ text: '중도해지', 	datafield: "CANCELYN",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '중도해지일', 	datafield: "CANCELDATE",	width: 150, cellsalign: 'center', align: 'center'},
				{ text: '담보소재지', 	datafield: "ADDRESS",		width: 200, cellsalign: 'center', align: 'center'},
				{ text: '입금은행', 	datafield: "BANKNAME",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '입금계좌', 	datafield: "PAYACCOUNT",	width: 150, cellsalign: 'center', align: 'center'},
				{ text: '예금주', 		datafield: "PAYOWNER",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '비고', 		datafield: "REMARK",		width: 250, cellsalign: 'center', align: 'center'}

            ]
          
        });

	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_SALEDATE_FR = $("#S_SALEDATE_FR").val();
			var S_SALEDATE_TO = $("#S_SALEDATE_TO").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			if (S_SALEDATE_FR == "" || S_SALEDATE_TO == "") {
				alert("매출기간을 입력하셔야합니다.");
				
				$("#S_SALEDATE_FR").focus();				
				return false;
			}
			
			f_selectListSA012003(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
		});
		
		$("#excelButton").click(function () {
			//dataType String , fileName(optional) String , exportHeader Boolean, rows Array, exportHiddenColumns Boolean, serverURL String, charSet String 
	        $("#mainList").jqxGrid('exportdata', 'xls', 'EnglishFileName', true, null, true, null, 'utf-8');           
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
						<input type="button" value="출력" id='printButton' />
					</td>
				</tr>
			</table>
		</div>
		<div id="mainDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">매출기간</th>
					<td colspan="5"><input type="text" id="S_SALEDATE_FR" name="S_SALEDATE_FR" /> ~ <input type="text" id="S_SALEDATE_TO" name="S_SALEDATE_TO" /></td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td width="190">
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:80px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
					<th width="120">부서</th>
					<td width="130">
						<select id="S_DEPTCODE" name="S_DEPTCODE" style="width:120px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
					<th width="120">담당자명</th>
					<td><input type="text" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
			</table>
			<br/>
			<div id="mainList" width="98%"></div>
		</div>
	</div>
</body>
</html>