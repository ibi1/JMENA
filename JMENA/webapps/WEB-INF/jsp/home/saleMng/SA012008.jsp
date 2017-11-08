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
		
		var S_CITYCODE = "";
		var S_BOROUGHCODE = "";
		var S_ADDRESS = "";
		
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
		
		f_selectListEnaCityCode();
		f_selectListEnaBoroughCode();
		
		f_selectListSA012008(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
		
	});
	
	function f_selectListEnaCityCode(){
		$("#S_CITYCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/cityMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				data.cityMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.CITYCODE + "'>" + currentValue.CITYNAME + "</option>\n";
				});
				$("#S_CITYCODE").append(inHtml);
				f_selectListEnaBoroughCode();
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	   	
	}

	$(function(){
		$("#CITYCODE").change(function() {
			f_selectListEnaBoroughCode();
		});
	});
	
	
	function f_selectListEnaBoroughCode(){
		var CITYCODE = $("#S_CITYCODE").val();
		$("#S_BOROUGHCODE").empty().data('options');

	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/cityDtlList.do", 
			dataType : 'json' , 
			data : {
				CITYCODE : CITYCODE,
			},
			success: function(data){
				var inHtml = "";
				data.cityDtlList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.BOROUGHCODE + "'>" + currentValue.BOROUGHNAME + "</option>\n";
				});
				$("#S_BOROUGHCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListSA012008(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS){

		var url = "/home/selectListSA012008.do?S_CITYCODE=" + S_CITYCODE + "&S_BOROUGHCODE=" + S_BOROUGHCODE + "&S_ADDRESS=" + S_ADDRESS;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"BUYGUBUN",		type: 'string' },
				{name:"OWNERNAME",		type: 'string' },
				{name:"OWNERJUMINID",	type: 'string' },
				{name:"ADDRESS",		type: 'string' },
				{name:"BUYM2",			type: 'string' },
				{name:"REGDATE1",		type: 'string' },
				{name:"BUYAMT",			type: 'string' },
				{name:"SELLSEQ",		type: 'string' },
				{name:"CONNAME",		type: 'string' },
				{name:"CONJUMINID",		type: 'string' },
				{name:"CONM2",			type: 'string' },
				{name:"REGDATE2",		type: 'string' },
				{name:"SALEAMT",		type: 'string' },
				{name:"REMNM2",			type: 'string' },
				{name:"REMNAMT",		type: 'string' }
				
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
                      
				{ text: '매입구분',		datafield: "BUYGUBUN",			width: 100, cellsalign: 'center'},
				{ text: '매도자',		datafield: "OWNERNAME",			width: 100, cellsalign: 'center'},
				{ text: '주민번호',		datafield: "OWNERJUMINID",		width: 100, cellsalign: 'center'},
				{ text: '주소/지번',	datafield: "ADDRESS",			width: 100, cellsalign: 'center'},
				{ text: '면적(m2)',		datafield: "BUYM2",				width: 100, cellsalign: 'center'},
				{ text: '등기이전일',	datafield: "REGDATE1",			width: 100, cellsalign: 'center'},
				{ text: '매입금액',		datafield: "BUYAMT",			width: 100, cellsalign: 'center'},
				{ text: '매출순번',		datafield: "SELLSEQ",			width: 100, cellsalign: 'center'},
				{ text: '매수자',		datafield: "CONNAME",			width: 100, cellsalign: 'center'},
				{ text: '주민번호',		datafield: "CONJUMINID",		width: 100, cellsalign: 'center'},
				{ text: '계약면적',		datafield: "CONM2",				width: 100, cellsalign: 'center'},
				{ text: '이전일',		datafield: "REGDATE2",			width: 100, cellsalign: 'center'},
				{ text: '매도금액',		datafield: "SALEAMT",			width: 100, cellsalign: 'center'},
				{ text: '재고면적',		datafield: "REMNM2",			width: 100, cellsalign: 'center'},
				{ text: '재고금액',		datafield: "REMNAMT",			width: 100, cellsalign: 'center'}
				
			]            
        });
	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_CITYCODE = $("#S_CITYCODE").val();
			var S_BOROUGHCODE = $("#S_BOROUGHCODE").val();
			var S_ADDRESS = $("#S_ADDRESS").val();
			
			f_selectListSA012008(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
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
					<th>지역구분</th>
					<td>
						<select id="S_CITYCODE" name="S_CITYCODE">
						</select>
					</td>
					<th>시/도 구분</th>
					<td>
						<select id="S_BOROUGHCODE" name="S_BOROUGHCODE">
						</select>
					</td>
					<th>주소 및 지번</th>
					<td><input type="text" id="S_ADDRESS" name="S_ADDRESS" /></td>
				</tr>
			</table>
			<br/>
			<table id="mainList" width="98%"></table>
			<div id="mainNav"></div>
		</div>
	</div>
</body>
</html>