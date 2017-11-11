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
		
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		
		$("#S_SALEDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_SALEDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		f_selectListEnaDCode();
		
		
		f_selectListSA012002(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_DCODE, S_KNAME);
	});

	function f_selectListEnaBranchCode(){
		$("#S_BRANCHCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/branchMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
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
	
	
	function f_selectListSA012002(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_DCODE, S_KNAME){

		var url = "/home/selectListSA012002.do?S_SALEDATE_FR=" + S_SALEDATE_FR + "&S_SALEDATE_TO=" + S_SALEDATE_TO 	+ "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_DEPTCODE=" + S_DEPTCODE	+ "&S_DCODE=" + S_DCODE	+ "&S_KNAME=" + S_KNAME;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"BRANCHCODE",		type: 'string' },
				{name:"BRANCHNAME",		type: 'string' },
				{name:"DEPTCODE",		type: 'string' },
				{name:"DEPTNAME",		type: 'string' },
				{name:"SALEDATE",		type: 'string' },
				{name:"DCODENAME",		type: 'string' },
				{name:"SALEID",			type: 'string' },
				{name:"KNAME",			type: 'string' },
				{name:"CONNAME",		type: 'string' },
				{name:"ADDRESS",		type: 'string' },
				{name:"CONM2",			type: 'string' },
				{name:"CONPY",			type: 'string' },
				{name:"SALEAMT",		type: 'string' },
				{name:"DCRATE",			type: 'string' },
				{name:"SELLAMT",		type: 'string' },
				{name:"SALEDANGA",		type: 'string' },
				{name:"AGENCYAMT",		type: 'string' },
				{name:"DEPOSITAMT1",	type: 'string' },
				{name:"DEPOSITAMT2",	type: 'string' },
				{name:"DEPOSITAMT3",	type: 'string' },
				{name:"SUGUMAMT1",		type: 'string' },
				{name:"SUGUMAMT2",		type: 'string' },
				{name:"SUGUMAMT3",		type: 'string' },
				{name:"SUGUMAMT",		type: 'string' },
				{name:"REMNAMT",		type: 'string' },
				{name:"IPGUMRATE",		type: 'string' },
				{name:"REMARK",			type: 'string' }
				
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
                      
				{ text: '지사코드', 		datafield: "BRANCHCODE",	width: 100, cellsalign: 'center', hidden:true},
				{ text: '지사', 			datafield: "BRANCHNAME",	width: 100, cellsalign: 'center', align: 'center'},
				{ text: '부서코드', 		datafield: "DEPTCODE",		width: 100, cellsalign: 'center', hidden:true},
				{ text: '부서', 			datafield: "DEPTNAME",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '계약일', 			datafield: "SALEDATE",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '매출구분', 		datafield: "DCODENAME",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '계약번호', 		datafield: "SALEID",		width: 100, cellsalign: 'center', align: 'center'},
				{ text: '담당자', 			datafield: "KNAME",			width: 150, cellsalign: 'center', align: 'center'},
				{ text: '고객명', 			datafield: "CONNAME",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '주소', 			datafield: "ADDRESS",		width: 250, cellsalign: 'center', align: 'center'},
				{ text: '계약면적', 		datafield: "CONM2",			width: 100, cellsalign: 'center', align: 'center'},
				{ text: '계약평수', 		datafield: "CONPY",			width: 100, cellsalign: 'center', align: 'center'},
				{ text: '원 판매가', 		datafield: "SALEAMT",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '할인율(%)', 		datafield: "DCRATE",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '실판매가', 		datafield: "SELLAMT",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '평단가', 			datafield: "SALEDANGA",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '위탁수수료', 		datafield: "AGENCYAMT",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '계약금', 			datafield: "DEPOSITAMT1",	width: 150, cellsalign: 'center', align: 'center'},
				{ text: '중도금', 			datafield: "DEPOSITAMT2",	width: 150, cellsalign: 'center', align: 'center'},
				{ text: '잔금', 			datafield: "DEPOSITAMT3",	width: 150, cellsalign: 'center', align: 'center'},
				{ text: '계약입금액', 		datafield: "SUGUMAMT1",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '중도입금액', 		datafield: "SUGUMAMT2",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '잔금입금액', 		datafield: "SUGUMAMT3",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '입금총액', 		datafield: "SUGUMAMT",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '입금잔액', 		datafield: "REMNAMT",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '입금율(%)', 		datafield: "IPGUMRATE",		width: 150, cellsalign: 'center', align: 'center'},
				{ text: '비고', 			datafield: "REMARK",		width: 250, cellsalign: 'center', align: 'center'}
				
			]
        
        
        });

	
	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_SALEDATE_FR = $("#S_SALEDATE_FR").val();
			var S_SALEDATE_TO = $("#S_SALEDATE_TO").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_DCODE = $("#S_DCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			f_selectListSA012002(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_DCODE, S_KNAME);
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
					<td><input type="text" id="S_SALEDATE_FR" name="S_SALEDATE_FR" /> ~ <input type="text" id="S_SALEDATE_TO" name="S_SALEDATE_TO" /></td>
					<th width="120">지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:80px">
						</select>
					</td>
					<th width="120">부서</th>
					<td>
						<select id="S_DEPTCODE" name="S_DEPTCODE" style="width:120px">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">매출구분</th>
					<td>
						<select id="S_DCODE" name="S_DCODE">
						</select>
					</td>
					<th width="120">담당자명</th>
					<td colspan="3"><input type="text" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
			</table>
			<br/>
			<div id="mainList" width="98%"></div>
		</div>
	</div>
</body>
</html>