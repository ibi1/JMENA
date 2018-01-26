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
		
		$("#S_PAYDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, maxLength: 6, minLength: 1});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		
		//f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		
		f_selectListEP012002(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
		
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
	
	function f_selectListEP012002(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME){
		S_KNAME = encodeURI(encodeURIComponent(S_KNAME));
		
		var url = "/home/selectListEP012002.do?S_PAYDATE=" + S_PAYDATE + "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_DEPTCODE=" + S_DEPTCODE + "&S_KNAME=" + S_KNAME;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
				{name: "SALEID", type: "string"},
				{name: "PAYSEQ", type: "string"},
				{name: "PAYDATE", type: "string"},
				{name: "PAYAMT", type: "number"},
				{name: "TAX", type: "number"},
				{name: "TAXLOCAL", type: "number"},
				{name: "DEDUCTAMT", type: "number"},
				{name: "CONNAME", type: "string"},
				{name: "CONPY", type: "number"},
				{name: "ADDRESS", type: "string"},
				{name: "KNAME", type: "string"},
				{name: "JUMINID", type: "string"},
				{name: "NAME_BRANCHCODE", type: "string"},
				{name: "NAME_DEPTCODE", type: "string"},
				{name: "PAYERNAME", type: "string"},
				{name: "PAYERID", type: "string"}				
			],
            root: "rows",
            //record: "records",
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
            columnsresize: true,
            columns: [
				{text: "소속지사", datafield: "NAME_BRANCHCODE", width: 100, cellsalign: "center", align: "center"},
				{text: "부서", datafield: "NAME_DEPTCODE", width: 100, cellsalign: "center", align: "center"},
				{text: "성명", datafield: "KNAME", width: 100, cellsalign: "center", align: "center"},
				{text: "주민번호", datafield: "JUMINID", width: 140, cellsalign: "center", align: "center"},
				{text: "지급일", datafield: "PAYDATE", width: 100, cellsalign: "center", align: "center"},
				{text: "신고인", datafield: "PAYERNAME", width: 100, cellsalign: "center", align: "center"},
				{text: "주민번호", datafield: "PAYERID", width: 140, cellsalign: "center", align: "center"},
				{text: "고객", datafield: "CONNAME", width: 100, cellsalign: "center", align: "center"},
				{text: "물건지", datafield: "ADDRESS", width: 240, cellsalign: "left", align: "center"},
				{text: "평수", datafield: "CONPY", width: 80, cellsalign: "right", align: "center", cellsformat: "f2"},
				{text: "지급액", datafield: "PAYAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "소득세(부가세)", datafield: "TAX", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "주민세", datafield: "TAXLOCAL", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "실지급액", datafield: "DEDUCTAMT", width: 120, cellsalign: "right", align: "center", cellsformat: "n"},
				{text: "판매번호", datafield: "SALEID", width: 100, cellsalign: "center", align: "center", hidden: true},
				{text: "지급순번", datafield: "PAYSEQ", width: 100, cellsalign: "center", align: "center", hidden: true}
            ]
        });
	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_PAYDATE = $("#S_PAYDATE").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			if(S_PAYDATE==""){
				alert("지급년월을 입력하시기 바랍니다.");
				return false;
			}
			if(S_KNAME==""){
				alert("담당자를 입력하시기 바랍니다.");
				return false;
			}
			
			f_selectListEP012002(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
		});
		
		
		$("#excelButton").click(function () {
			
	        $("#mainList").jqxGrid('exportdata', 'xls', 'monthsudang', true, null, false, null, 'utf-8');
	        
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
					<th width="120">지급년월</th>
					<td width="120"><input type="text" id="S_PAYDATE" name="S_PAYDATE" /></td>
					<!-- <th width="120">지사</th>
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
					</td> -->
					<th width="120">담당자명</th>
					<td><input type="text" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
			</table>
			<br/>
			<div align="right">총 건수 : <font color="red"><sapn id="mainListCount"></sapn></font>건</div>
			<div id="mainList"></div>
		</div>
	</div>
</body>
</html>