<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<style type="text/css">
.ui-jqgrid .ui-jqgrid-bdiv{ overflow-x:auto; }
</style>

<script type="text/javascript">

	$(document).ready(function(){

		var S_RETIREDATE_FR = "";
		var S_RETIREDATE_TO = "";
		var S_BRANCHCODE = "";
		var S_DEPTCODE = "";
		var S_KNAME = "";
		var S_JUMINID = "";
		
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#S_RETIREDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 80, maxLength: 8, minLength: 1});
		$("#S_RETIREDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 80, maxLength: 8, minLength: 1});
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#S_JUMINID").jqxInput({theme: 'energyblue', height: 25, width: 150, maxLength: 13, minLength: 1});
		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		
		f_selectListHR012002(S_RETIREDATE_FR, S_RETIREDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME, S_JUMINID);
		
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

	function f_selectListHR012002(S_RETIREDATE_FR, S_RETIREDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME, S_JUMINID){
		var url = "/home/selectListHR012002.do?S_RETIREDATE_FR=" + S_RETIREDATE_FR + "&S_RETIREDATE_TO=" + S_RETIREDATE_TO + "&S_BRANCHCODE=" + S_BRANCHCODE + "&S_DEPTCODE=" + S_DEPTCODE + "&S_KNAME=" + S_KNAME + "&S_JUMINID=" + S_JUMINID;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"BRANCHCODE",			type: 'string' },
				{name:"BRANCHNAME",			type: 'string' },
				{name:"DEPTCODE",			type: 'string' },
				{name:"DEPTNAME",			type: 'string' },
				{name:"DUTY",				type: 'string' },
				{name:"GRADE",				type: 'string' },
				{name:"EMPLOYGUBUN",		type: 'string' },
				{name:"INSACODE",			type: 'string' },
				{name:"KNAME",				type: 'string' },
				{name:"RECONAME",			type: 'string' },
				{name:"JOINDATE",			type: 'string' },
				{name:"RETIREDATE",			type: 'string' },
				{name:"SELLAMT",			type: 'number' },
				{name:"O_BRANCHCODE",		type: 'string' },
				{name:"O_BRANCHNAME",		type: 'string' },
				{name:"O_JOINDATE",			type: 'string' },
				{name:"O_RETIREDATE",		type: 'string' },
				{name:"O_SELLAMT",			type: 'number' },
				{name:"O_REMARK",			type: 'string' },
				{name:"REMARK",				type: 'string' }
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
				{ text: '지사', 			datafield: 'BRANCHNAME',		width: 100, cellsalign: 'center', align:"center"},
				{ text: '부서코드', 		datafield: 'DEPTCODE',			width: 100, cellsalign: 'center', hidden:true},
				{ text: '부서', 			datafield: 'DEPTNAME',			width: 100, cellsalign: 'center', align:"center"},
				{ text: '직위', 			datafield: 'DUTY',				width: 100, cellsalign: 'center', align:"center"},
				{ text: '직급', 			datafield: 'GRADE',				width: 100, cellsalign: 'center', align:"center"},
				{ text: '고용구분', 		datafield: 'EMPLOYGUBUN',		width: 80, cellsalign: 'center', align:"center"},
				{ text: '사번', 			datafield: 'INSACODE',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '성명', 			datafield: 'KNAME',				width: 150, cellsalign: 'center', align:"center"},
				{ text: '추천인', 			datafield: 'RECONAME',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '입사일', 			datafield: 'JOINDATE',			width: 150, cellsalign: 'center', align:"center"},
				{ text: '퇴사일', 			datafield: 'RETIREDATE',		width: 150, cellsalign: 'center', align:"center"},
				{ text: '직전지사실적', 	datafield: 'SELLAMT',			width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
				{ text: '지사코드', 		columngroup: '전근무현황',	datafield: 'O_BRANCHCODE',		width: 100, cellsalign: 'center', hidden:true},
				{ text: '지사', 			columngroup: '전근무현황',	datafield: 'O_BRANCHNAME',		width: 100, cellsalign: 'center', align:"center"},
				{ text: '입사', 			columngroup: '전근무현황',	datafield: 'O_JOINDATE',		width: 150, cellsalign: 'center', align:"center"},
				{ text: '퇴사', 			columngroup: '전근무현황',	datafield: 'O_RETIREDATE',		width: 150, cellsalign: 'center', align:"center"},
				{ text: '실적', 			columngroup: '전근무현황',	datafield: 'O_SELLAMT',			width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
				{ text: '비고', 			columngroup: '전근무현황',	datafield: 'O_REMARK',			width: 250, cellsalign: 'center', align:"center"},
				{ text: '비고', 			datafield: 'REMARK',			width: 250, cellsalign: 'center', align:"center"}
            ],
            columngroups: [
				{ text: '전근무현황', align: 'center', name: '전근무현황' }
			]            
        });

		
	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_RETIREDATE_FR = $("#S_RETIREDATE_FR").val();
			var S_RETIREDATE_TO = $("#S_RETIREDATE_TO").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			var S_JUMINID = $("#S_JUMINID").val();
			
			f_selectListHR012002(S_RETIREDATE_FR, S_RETIREDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME, S_JUMINID);
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
					<th width="120">퇴사기간</th>
					<td colspan="7"><input type="text" id="S_RETIREDATE_FR" name="S_RETIREDATE_FR" /> ~ <input type="text" id="S_RETIREDATE_TO" name="S_RETIREDATE_TO" /></td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td width="140">
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:120px">
						</select>
					</td>
					<th width="120">부서</th>
					<td width="140">
						<select id="S_DEPTCODE" name="S_DEPTCODE" style="width:120px">
						</select>
					</td>
					<th width="120">성명</th>
					<td width="170"><input type="text" class="inputName" id="S_KNAME" name="S_KNAME" /></td>
					<th width="120">주민번호</th>
					<td><input type="text" id="S_JUMINID" name="S_JUMINID" /></td>
				</tr>
			</table>
			<br/>
			<div id="mainList" width="98%"></div>
		</div>
	</div>
</body>
</html>