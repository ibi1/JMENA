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
		
		var S_SALEDATE = "";
		var S_BRANCHCODE = "";
		var S_KNAME = "";
		
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		
		f_selectListEnaBranchCode();
		
		//f_selectListSA012001(S_SALEDATE, S_BRANCHCODE, S_KNAME);
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
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListSA012001(S_SALEDATE, S_BRANCHCODE, S_KNAME){
		var url = "/home/selectListSA012001.do?S_SALEDATE=" + S_SALEDATE + "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_KNAME=" + S_KNAME;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"BRANCHCODE",			type: 'string' },
				{name:"BRANCHNAME",			type: 'string' },
				{name:"DEPTCODE",			type: 'string' },
				{name:"DEPTNAME",			type: 'string' },
				{name:"GRADE",				type: 'string' },
				{name:"KNAME",				type: 'string' },
				{name:"JOINDATE",			type: 'string' },
				{name:"RETIREDATE",			type: 'string' },
				{name:"O_BRANCHCODE",		type: 'string' },
				{name:"O_BRANCHNAME",		type: 'string' },
				{name:"O_JOINDATE",			type: 'string' },
				{name:"O_RETIREDATE",		type: 'string' },
				{name:"O_EMPLOYGUBUN",		type: 'string' },
				{name:"AMT6",				type: 'string' },
				{name:"AMT5",				type: 'string' },
				{name:"AMT4",				type: 'string' },
				{name:"AMT3",				type: 'string' },
				{name:"AMT2",				type: 'string' },
				{name:"AMT1",				type: 'string' },
				{name:"TOTAMT",				type: 'string' }
				
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
                      
				{ text: '지사코드', 		datafield: 'BRANCHCODE',		width: 100, cellsalign: 'center', hidden:true},
				{ text: '지사', 			datafield: 'BRANCHNAME',		width: 100, cellsalign: 'center'},
				{ text: '부서코드', 		datafield: 'DEPTCODE',			width: 100, cellsalign: 'center', hidden:true},
				{ text: '부서', 			datafield: 'DEPTNAME',			width: 100, cellsalign: 'center'},
				{ text: '직급', 			datafield: 'GRADE',				width: 100, cellsalign: 'center'},
				{ text: '성명', 			datafield: 'KNAME',				width: 100, cellsalign: 'center'},
				{ text: '입사일', 			datafield: 'JOINDATE',			width: 100, cellsalign: 'center'},
				{ text: '퇴사일', 			datafield: 'RETIREDATE',		width: 100, cellsalign: 'center'},
				{ text: '전근무지코드', 	columngroup: '전근무현황',		datafield: 'O_BRANCHCODE',		width: 100, cellsalign: 'center', hidden:true},
				{ text: '전근무지', 		columngroup: '전근무현황',		datafield: 'O_BRANCHNAME',		width: 100, cellsalign: 'center'},
				{ text: '입사', 			columngroup: '전근무현황',		datafield: 'O_JOINDATE',		width: 100, cellsalign: 'center'},
				{ text: '퇴사', 			columngroup: '전근무현황',		datafield: 'O_RETIREDATE',		width: 100, cellsalign: 'center'},
				{ text: '고용구분', 		columngroup: '전근무현황',		datafield: 'O_EMPLOYGUBUN',		width: 100, cellsalign: 'center'},
				{ text: 'M-6', 				datafield: 'AMT6',				width: 100, cellsalign: 'center'},
				{ text: 'M-5', 				datafield: 'AMT5',				width: 100, cellsalign: 'center'},
				{ text: 'M-4', 				datafield: 'AMT4',				width: 100, cellsalign: 'center'},
				{ text: 'M-3', 				datafield: 'AMT3',				width: 100, cellsalign: 'center'},
				{ text: 'M-2', 				datafield: 'AMT2',				width: 100, cellsalign: 'center'},
				{ text: 'M-1', 				datafield: 'AMT1',				width: 100, cellsalign: 'center'},
				{ text: '합계', 			datafield: 'TOTAMT',			width: 100, cellsalign: 'center'}				
				
			],
            columngroups: [
				{ text: '전근무현황', align: 'center', name: '전근무현황' }
			]            
        });
		
	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_SALEDATE = $("#S_SALEDATE").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_KNAME = $("#S_ADDRESS").val();
			
			f_selectListSA012001(S_SALEDATE, S_BRANCHCODE, S_KNAME);
		});
		
		$("#excelButton").click(function () {
			//dataType String , fileName(optional) String , exportHeader Boolean, rows Array, exportHiddenColumns Boolean, serverURL String, charSet String 
	        $("#mainList").jqxGrid('exportdata', 'xls', 'EnglishFileName', true, null, true, null, 'utf-8');           
	    });
		
	})
	
</script>
<body>

	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
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
		<div id="mainDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<th>기준월</th>
					<td colspan="3"><input type="text" id="S_SALEDATE" name="S_SALEDATE" /></td>
				</tr>
				<tr>
					<th>지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:80px">
						</select>
					</td>
					<th>담당자명</th>
					<td><input type="text" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
			</table>
			<br/>
			<div id="mainList" width="98%"></div>
		</div>
	</div>
</body>
</html>