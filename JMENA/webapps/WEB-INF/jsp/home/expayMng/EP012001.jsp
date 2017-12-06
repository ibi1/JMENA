<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>


<script type="text/javascript">
	$(document).ready(function(){

		var S_PAYDATE = "";
		var S_BRANCHCODE = "";
		var S_DEPTCODE = "";
		var S_KNAME = "";

		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#S_PAYDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, maxLength: 6, minLength: 1});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		
		f_selectListEP012001(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
		f_selectListEP012001_2(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		
		
		$('input:radio[name=TAXGUBUN]:input[value=001]').attr("checked", true);
		
		
		$("#mainList1").show();
		$("#mainList2").hide();
		
		
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
	
	function f_selectListEP012001(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME){
		S_KNAME = encodeURI(encodeURIComponent(S_KNAME));
		
		var url = "/home/selectListEP012001.do?S_PAYDATE=" + S_PAYDATE + "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_DEPTCODE=" + S_DEPTCODE + "&S_KNAME=" + S_KNAME;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{ name:"BRANCHNAME", 	type: 'string' },
				{ name:"DEPTNAME", 		type: 'string' },
				{ name:"PAYDATE", 		type: 'string' },
				{ name:"CONNAME", 		type: 'string' },
				{ name:"ADDRESS", 		type: 'string' },
				{ name:"CONM2", 		type: 'string' },
				{ name:"CONPY", 		type: 'string' },
				{ name:"KNAME", 		type: 'string' },
				{ name:"PAYERNAME", 	type: 'string' },
				{ name:"PAYERID", 		type: 'string' },
				{ name:"PAYAMT", 		type: 'number' },
				{ name:"TAXINCOME", 	type: 'number' },
				{ name:"TAXLOCAL", 		type: 'number' },
				{ name:"TOTTAX", 		type: 'number' },
				{ name:"DEDUCTAMT", 	type: 'number' }
            ],
            root: "rows",
            //record: "records",
            id: 'KNAME',
            url: url
        };

        var dataAdapter = new $.jqx.dataAdapter(source, {
            downloadComplete: function (data, status, xhr) {
            },
            loadComplete: function (data) {
            	var countRow = $('#mainList1').jqxGrid('getrows');
            	$("#mainList1Count").html(countRow.length);
            },
            loadError: function (xhr, status, error) { alert("Error~~!"); }
        });
        
		// initialize jqxGrid
        $("#mainList1").jqxGrid({
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
              { text: '지사',		datafield: 'BRANCHNAME', 	width: 100, cellsalign: 'center', align: 'center' },
              { text: '부서', 		datafield: 'DEPTNAME', 		width: 150, cellsalign: 'center', align: 'center' },
              { text: '지급일', 	datafield: 'PAYDATE', 		width: 160, cellsalign: 'center', align: 'center' },
              { text: '고객', 		datafield: 'CONNAME', 		width: 120, cellsalign: 'center', align: 'center' },
              { text: '물건지', 	datafield: 'ADDRESS', 		width: 200, cellsalign: 'center', align: 'center' },
              { text: '계약면적', 	datafield: 'CONM2', 		width: 100, cellsalign: 'center', align: 'center' },
              { text: '계약평수', 	datafield: 'CONPY', 		width: 100, cellsalign: 'center', align: 'center' },
              { text: '담당자', 	datafield: 'KNAME', 		width: 120, cellsalign: 'center', align: 'center' },
              { text: '소득신고', 	datafield: 'PAYERNAME',	 	width: 120, cellsalign: 'center', align: 'center' },
              { text: '주민번호', 	datafield: 'PAYERID',		width: 120, cellsalign: 'center', align: 'center' },
              { text: '총지금액', 	datafield: 'PAYAMT', 		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
              { text: '소득세', 	datafield: 'TAXINCOME',	 	width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
              { text: '지방세', 	datafield: 'TAXLOCAL', 		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
              { text: '세금 계', 	datafield: 'TOTTAX', 		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
              { text: '실 지급액', 	datafield: 'DEDUCTAMT', 	width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'}
            ]
        });
	
	}
	function f_selectListEP012001_2(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME){
		var url = "/home/selectListEP012001_2.do?S_PAYDATE=" + S_PAYDATE + "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_DEPTCODE=" + S_DEPTCODE + "&S_KNAME=" + S_KNAME;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"BRANCHNAME",		type: 'string' },
				{name:"DEPTNAME",		type: 'string' },
				{name:"PAYDATE",		type: 'string' },
				{name:"CONNAME",		type: 'string' },
				{name:"ADDRESS",		type: 'string' },
				{name:"CONM2",			type: 'string' },
				{name:"CONPY",			type: 'string' },
				{name:"KNAME",			type: 'string' },
				{name:"SAUPOWNER",		type: 'string' },
				{name:"PAYERID",		type: 'string' },
				{name:"PAYAMT",			type: 'string' },
				{name:"SUPPLYAMT",		type: 'string' },
				{name:"SUPPLYTAX",		type: 'string' },
				{name:"SUPPLYTAX2",		type: 'string' },
				{name:"DEDUCTAMT",		type: 'string' }

            ],
            root: "rows",
            //record: "records",
            id: 'KNAME',
            url: url
        };

        var dataAdapter = new $.jqx.dataAdapter(source, {
            downloadComplete: function (data, status, xhr) {
            },
            loadComplete: function (data) {
            	var countRow = $('#mainList2').jqxGrid('getrows');
            	$("#mainList2Count").html(countRow.length);
            },
            loadError: function (xhr, status, error) { alert("Error~~!"); }
        });
        
		// initialize jqxGrid
        $("#mainList2").jqxGrid({
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
				{ text: '지사', 		datafield: 'BRANCHNAME',	width: 100, cellsalign: 'center'},
				{ text: '부서', 		datafield: 'DEPTNAME',		width: 100, cellsalign: 'center'},
				{ text: '지급일', 		datafield: 'PAYDATE',		width: 100, cellsalign: 'center'},
				{ text: '고객', 		datafield: 'CONNAME',		width: 100, cellsalign: 'center'},
				{ text: '물건지', 		datafield: 'ADDRESS',		width: 100, cellsalign: 'center'},
				{ text: '계약면적',		datafield: 'CONM2',			width: 100, cellsalign: 'center'},
				{ text: '계약평수',		datafield: 'CONPY',			width: 100, cellsalign: 'center'},
				{ text: '담당자', 		datafield: 'KNAME',			width: 100, cellsalign: 'center'},
				{ text: '회사명', 		datafield: 'SAUPOWNER',		width: 100, cellsalign: 'center'},
				{ text: '사업자번호',	datafield: 'PAYERID',		width: 100, cellsalign: 'center'},
				{ text: '총지급액',		datafield: 'PAYAMT',		width: 100, cellsalign: 'center'},
				{ text: '공급가',		datafield: 'SUPPLYAMT',		width: 100, cellsalign: 'center'},
				{ text: '부가세',		datafield: 'SUPPLYTAX',		width: 100, cellsalign: 'center'},
				{ text: '미지급금',		datafield: 'SUPPLYTAX2',	width: 100, cellsalign: 'center'},
				{ text: '실 지급액',	datafield: 'DEDUCTAMT',		width: 100, cellsalign: 'center'}
            ]
        });
	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_PAYDATE = $("#S_PAYDATE").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			var temp = $(':radio[name="TAXGUBUN"]:checked').val();
			
			if(temp == '001'){
				f_selectListEP012001(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
				
			}else{
				f_selectListEP012001_2(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
			}
			
		});
		
		
		$("input[name=TAXGUBUN]").change(function() {
			var S_PAYDATE = $("#S_PAYDATE").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			var radioValue = $(this).val();
			
			if (radioValue == "001") {
				f_selectListEP012001(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
				$("#mainList1").show();
				$("#mainList2").hide();
			} else{
				f_selectListEP012001_2(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
				$("#mainList2").show();
				$("#mainList1").hide();
			}
		});
		
		$("#excelButton").click(function () {
			var temp = $(':radio[name="TAXGUBUN"]:checked').val();
			
			if(temp == '001'){
		        $("#mainList1").jqxGrid('exportdata', 'xls', 'EnglishFileName1', true, null, true, null, 'utf-8');           
				
			}else{
		        $("#mainList2").jqxGrid('exportdata', 'xls', 'EnglishFileName2', true, null, true, null, 'utf-8');           
			}
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
					<th width="120">지급년월</th>
					<td width="120"><input type="text" id="S_PAYDATE" name="S_PAYDATE" /></td>
					<th width="120">지사</th>
					<td width="140">
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:120px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
					<th width="120">부서</th>
					<td width="140">
						<select id="S_DEPTCODE" name="S_DEPTCODE" style="width:120px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
					<th width="120">담당자명</th>
					<td><input type="text" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
				<tr>
					<th width="120">신고구분</th>
					<td colspan="7"><input type="radio" id="TAXGUBUN" name="TAXGUBUN" value="001"/> 사업소득세   <input type="radio" id="TAXGUBUN" name="TAXGUBUN" value="002"/> 부가가치세 </td>
				</tr>
			</table><br/>
			<div align="right">총 건수 : <font color="red"><sapn id="mainList1Count"></sapn></font>건</div>
			<div id="mainList1"></div>
			<div align="right">총 건수 : <font color="red"><sapn id="mainList2Count"></sapn></font>건</div>
			<div id="mainList2"></div>
		</div>
	</div>
</body>
</html>