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
		
		var S_JOINDATE = "";
		var S_BRANCHCODE = "";
		var S_DEPTCODE = "";
		
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		
		$("#S_JOINDATE").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SALEDATE").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();

		f_selectListHR012003(S_JOINDATE, S_BRANCHCODE, S_DEPTCODE);
		
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
	
	function f_selectListHR012003(S_JOINDATE, S_BRANCHCODE, S_DEPTCODE){
		var url = "/home/selectListHR012003.do?S_JOINDATE=" + S_JOINDATE + "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_DEPTCODE=" + S_DEPTCODE;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"BRANCHCODE",			type: 'string' },
				{name:"BRANCHNAME",			type: 'string' },
				{name:"DEPTCODE",			type: 'string' },
				{name:"DEPTNAME",			type: 'string' },
				{name:"DUTY",				type: 'string' },
				{name:"INSACODE",			type: 'string' },
				{name:"KNAME",				type: 'string' },
				{name:"RECOID",				type: 'string' },
				{name:"RECONAME",			type: 'string' },
				{name:"JOINDATE",			type: 'string' },
				{name:"O_BRANCHNAME",		type: 'string' },
				{name:"O_JOINDATE",			type: 'string' },
				{name:"O_RETIREDATE",		type: 'string' },
				{name:"O_EMPLOYGUBUN",		type: 'string' },
				{name:"MOBILENO",			type: 'string' },
				{name:"JUMINID",			type: 'string' },
				{name:"BIRTHDAYGUBUN",		type: 'string' },
				{name:"ACCTOWNER",			type: 'string' },
				{name:"BANKNAME",			type: 'string' },
				{name:"ACCTNO",				type: 'string' },
				{name:"PAYERNAME",			type: 'string' },
				{name:"PAYERID",			type: 'string' },
				{name:"ADDRESS",			type: 'string' }

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
				{ text: '지사코드', 	datafield: 'BRANCHCODE',		width: 100, cellsalign: 'center', hidden:true},
				{ text: '지사', 		datafield: 'BRANCHNAME',		width: 100, cellsalign: 'center', align:"center"},
				{ text: '부서코드', 	datafield: 'DEPTCODE',			width: 100, cellsalign: 'center', hidden:true},
				{ text: '부서', 		datafield: 'DEPTNAME',			width: 100, cellsalign: 'center', align:"center"},
				{ text: '직급', 		datafield: 'DUTY',				width: 100, cellsalign: 'center', align:"center"},
				{ text: '사번', 		datafield: 'INSACODE',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '성명', 		datafield: 'KNAME',				width: 150, cellsalign: 'center', align:"center"},
				{ text: '추천인사번',	datafield: 'RECOID',			width: 150, cellsalign: 'center', hidden:true},
				{ text: '추천인', 		datafield: 'RECONAME',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '입사일', 		datafield: 'JOINDATE',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '전근무지', 	columngroup: '전근무현황',		datafield: 'O_BRANCHNAME',		width: 150, cellsalign: 'center', align:"center"},
				{ text: '입사', 		columngroup: '전근무현황',		datafield: 'O_JOINDATE',		width: 150, cellsalign: 'center', align:"center"},
				{ text: '퇴사', 		columngroup: '전근무현황',		datafield: 'O_RETIREDATE',		width: 150, cellsalign: 'center', align:"center"},
				{ text: '고용구분', 	columngroup: '전근무현황',		datafield: 'O_EMPLOYGUBUN',		width: 80, cellsalign: 'center', align:"center"},
				{ text: '연락처', 		datafield: 'MOBILENO',			width: 100, cellsalign: 'center', align:"center"},
				{ text: '주민번호', 	datafield: 'JUMINID',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '생일구분', 	datafield: 'BIRTHDAYGUBUN',		width: 80, cellsalign: 'center', align:"center"},
				{ text: '입금자명', 	datafield: 'ACCTOWNER',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '은행명', 		datafield: 'BANKNAME',			width: 100, cellsalign: 'center', align:"center"},
				{ text: '계좌번호', 	datafield: 'ACCTNO',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '성명', 		columngroup: '소득신고',		datafield: 'PAYERNAME',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '주민번호', 	columngroup: '소득신고',		datafield: 'PAYERID',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '주소', 		datafield: 'ADDRESS',			width: 250, cellsalign: 'center', align:"center"}
			],
            columngroups: [
         		{ text: '전근무현황', align: 'center', name: '전근무현황' },
				{ text: '소득신고', align: 'center', name: '소득신고' }
			]            
        });
	}


	$(function(){
		$("#selectButton").click(function(){
			
			var S_JOINDATE = $("#S_JOINDATE").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			
			f_selectListHR012003(S_JOINDATE, S_BRANCHCODE, S_DEPTCODE);
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
			<table style="width:100%;">
				<tr>
					<td width="40%" align="left">
						<table>
							<tr>
								<th width="120">기준일</th>
								<td colspan="3"><input type="text" id="S_JOINDATE" name="S_JOINDATE" /></td>
							</tr>
							<tr>
								<th width="120">지사</th>
								<td>
									<select id="S_BRANCHCODE" name="S_BRANCHCODE">
									</select>
								</td>
								<th width="120">부서</th>
								<td>
									<select id="S_DEPTCODE" name="S_DEPTCODE">
									</select>
								</td>
							</tr>
						</table>
					</td>
					<td align="right">
						<table style="border:1px solid #333; padding: 10px;">
							<tr>
								<td align="center">임원</td>
								<td align="center">실장</td>
								<td align="center">사원</td>
								<td align="center">총무여직원</td>
								<td align="center">지사 총 원</td>
							</tr>
							<tr>
								<td><input type="text" id="SALEDATE" name="SALEDATE" style="width:70px" /></td>
								<td><input type="text" id="SALEDATE" name="SALEDATE" style="width:70px" /></td>
								<td><input type="text" id="SALEDATE" name="SALEDATE" style="width:70px" /></td>
								<td><input type="text" id="SALEDATE" name="SALEDATE" style="width:70px" /></td>
								<td><input type="text" id="SALEDATE" name="SALEDATE" style="width:70px" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br/>
			<div id="mainList" width="98%"></div>
		</div>
	</div>
</body>
</html>