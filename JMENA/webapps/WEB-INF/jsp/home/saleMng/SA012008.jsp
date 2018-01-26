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
		var date = new Date();
		
		var yyyy = date.getFullYear();
		var mm = date.getMonth() + 1;
		
		var S_BUYGUBUN = "";
		var S_CITYCODE = "";
		var S_BOROUGHCODE = "";
		var S_ADDRESS = "";
		
		var S_BUYYEAR_FR = yyyy;
		var S_BUYYEAR_TO = yyyy;
		var S_BUYMONTH_FR = addZero(mm);
		var S_BUYMONTH_TO = addZero(mm);
		
		$("#S_BUYYEAR_FR").val(S_BUYYEAR_FR);
		$("#S_BUYYEAR_TO").val(S_BUYYEAR_TO);
		$("#S_BUYMONTH_FR").val(S_BUYMONTH_FR);
		$("#S_BUYMONTH_TO").val(S_BUYMONTH_TO);
		
		var auth_p = true;

		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		<%if ("N".equals(session.getAttribute("AUTH_P"))) { %>
			$("#excelButton").hide();
			auth_p = false;
		<% }%>
		
		$("#S_ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 200, minLength: 1});
		
		f_selectListBuyGubun();
		f_selectListEnaCityCode();
		f_selectListEnaBoroughCode();
		f_selectListBuyYear();
		
		f_selectListSA012008(S_BUYYEAR_FR, S_BUYMONTH_FR, S_BUYYEAR_TO, S_BUYMONTH_TO, S_BUYGUBUN, S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
		
	});

	function addZero(n) {
		return n < 10 ? "0" + n : n;
	}
	
	function f_selectListBuyYear(){
		var today = new Date();
		var nowYear = today.getFullYear();		
		var selectedVal = "";
		$("#S_BUYYEAR_FR, #S_BUYYEAR_TO").empty().data('options');
		
		var inHtml = "";
		for (i=(nowYear - 20); i < (nowYear + 20) ; i++) {
			if(i == nowYear){
				selectedVal = "selected";
			}else{
				selectedVal = "";
			}
			inHtml += "<option value='" + i + "' "+selectedVal+" >" + i + " 년</option>\n";
		}
		
		$("#S_BUYYEAR_FR, #S_BUYYEAR_TO").append(inHtml);
	}
	
	function f_selectListBuyGubun() {
		$("#S_BUYGUBUN").empty();
		$("#S_BUYGUBUN").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
		
		$.ajax({ 
			type: "POST",
			url: "/codeCom/dcodeList.do", 
			dataType: "json",
			data: {CCODE : "014"},
			success: function(data) {
				var sTemp = "";
				data.dcodeList.forEach(function(currentValue, index, array) {
					if(currentValue.DCODE != "003") {
						sTemp += "<option value=\"" + currentValue.DCODE + "\">" + currentValue.DCODENAME + "</option>";
					}
				});
				$("#S_BUYGUBUN").append(sTemp);
			},
			error: function(e) {
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}
		});
	}
	
	function f_selectListEnaCityCode(){
		$("#S_CITYCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/cityMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
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
		$("#S_CITYCODE").change(function() {
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
				inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
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
	
	function f_selectListSA012008(S_BUYYEAR_FR, S_BUYMONTH_FR, S_BUYYEAR_TO, S_BUYMONTH_TO, S_BUYGUBUN, S_CITYCODE, S_BOROUGHCODE, S_ADDRESS){
		S_ADDRESS = encodeURI(encodeURIComponent(S_ADDRESS));

		var url = "/home/selectListSA012008.do?S_BUYGUBUN="+ S_BUYGUBUN +"&S_CITYCODE=" + S_CITYCODE + "&S_BOROUGHCODE=" + S_BOROUGHCODE + "&S_ADDRESS=" + S_ADDRESS + "&S_BUYYEAR_FR=" + S_BUYYEAR_FR + "&S_BUYMONTH_FR=" + S_BUYMONTH_FR + "&S_BUYYEAR_TO=" + S_BUYYEAR_TO + "&S_BUYMONTH_TO=" + S_BUYMONTH_TO;
		
        // prepare the data
        var source = {
            datatype: "json",
            datafields: [
                         
				{name:"BUYGUBUN",		type: 'string' },
				{name:"OWNERNAME",		type: 'string' },
				{name:"OWNERJUMINID",	type: 'string' },
				{name:"ADDRESS",		type: 'string' },
				{name:"BUYM2",			type: 'number' },
				{name:"REGDATE1",		type: 'string' },
				{name:"BUYAMT",			type: 'number' },
				{name:"SELLSEQ",		type: 'string' },
				{name:"CONNAME",		type: 'string' },
				{name:"CONJUMINID",		type: 'string' },
				{name:"CONM2",			type: 'number' },
				{name:"REGDATE2",		type: 'string' },
				{name:"SALEAMT",		type: 'number' },
				{name:"REMNM2",			type: 'number' },
				{name:"REMNAMT",		type: 'number' }
				
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
                      
				{ text: '매입구분',		datafield: "BUYGUBUN",			width: 80,  cellsalign: 'center', align: 'center'},
				{ text: '매도자',		datafield: "OWNERNAME",			width: 100, cellsalign: 'center', align: 'center'},
				{ text: '주민번호',		datafield: "OWNERJUMINID",		width: 140, cellsalign: 'center', align: 'center'},
				{ text: '주소/지번',	datafield: "ADDRESS",			width: 240, cellsalign: 'left', align: 'center'},
				{ text: '면적(m2)',		datafield: "BUYM2",				width: 80, cellsalign: 'right', align: 'center', cellsformat: 'f2'},
				{ text: '등기이전일',	datafield: "REGDATE1",			width: 100, cellsalign: 'center', align: 'center'},
				{ text: '매입금액',		datafield: "BUYAMT",			width: 120, cellsalign: 'right', align: 'center', cellsformat: 'n'},
				{ text: '담당자',		datafield: "SELLSEQ",			width: 80,  cellsalign: 'center', align: 'center'},
				{ text: '매수자',		datafield: "CONNAME",			width: 100, cellsalign: 'center', align: 'center'},
				{ text: '주민번호',		datafield: "CONJUMINID",		width: 140, cellsalign: 'center', align: 'center'},
				{ text: '계약면적',		datafield: "CONM2",				width: 80, cellsalign: 'right', align: 'center', cellsformat: 'f2'},
				{ text: '이전일',		datafield: "REGDATE2",			width: 100, cellsalign: 'center', align: 'center'},
				{ text: '실판매가',		datafield: "SALEAMT",			width: 120, cellsalign: 'right', align: 'center', cellsformat: 'n'},
				{ text: '재고면적',		datafield: "REMNM2",			width: 80, cellsalign: 'right', align: 'center', cellsformat: 'f2'},
				{ text: '재고금액',		datafield: "REMNAMT",			width: 120, cellsalign: 'right', align: 'center', cellsformat: 'n'},
				
			]            
        });
	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_BUYGUBUN = $("#S_BUYGUBUN").val();
			var S_CITYCODE = $("#S_CITYCODE").val();
			var S_BOROUGHCODE = $("#S_BOROUGHCODE").val();
			var S_ADDRESS = $("#S_ADDRESS").val();
			var S_BUYYEAR_FR = $("#S_BUYYEAR_FR").val();
			var S_BUYYEAR_TO = $("#S_BUYYEAR_TO").val();
			var S_BUYMONTH_FR = $("#S_BUYMONTH_FR").val();
			var S_BUYMONTH_TO = $("#S_BUYMONTH_TO").val();
			
			f_selectListSA012008(S_BUYYEAR_FR, S_BUYMONTH_FR, S_BUYYEAR_TO, S_BUYMONTH_TO, S_BUYGUBUN, S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
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
					</td>
				</tr>
			</table>
		</div>
		<div id="mainDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">매출 등기이전 년월</th>
					<td colspan="7">
						<select id="S_BUYYEAR_FR" name="S_BUYYEAR_FR"></select>
						<select id="S_BUYMONTH_FR" name="S_BUYMONTH_FR">
							<option value="01" selected="selected">1월</option>
							<option value="02">2월</option>
							<option value="03">3월</option>
							<option value="04">4월</option>
							<option value="05">5월</option>
							<option value="06">6월</option>
							<option value="07">7월</option>
							<option value="08">8월</option>
							<option value="09">9월</option>
							<option value="10">10월</option>
							<option value="11">11월</option>
							<option value="12">12월</option>
						</select> ~
						<select id="S_BUYYEAR_TO" name="S_BUYYEAR_TO"></select>
						<select id="S_BUYMONTH_TO" name="S_BUYMONTH_TO">
							<option value="01" selected="selected">1월</option>
							<option value="02">2월</option>
							<option value="03">3월</option>
							<option value="04">4월</option>
							<option value="05">5월</option>
							<option value="06">6월</option>
							<option value="07">7월</option>
							<option value="08">8월</option>
							<option value="09">9월</option>
							<option value="10">10월</option>
							<option value="11">11월</option>
							<option value="12">12월</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">매입구분</th>
					<td width="150"><select id="S_BUYGUBUN" style="width:120px"></select></td>
					<th width="120">지역구분</th>
					<td width="150">
						<select id="S_CITYCODE" name="S_CITYCODE" style="width:130px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
					<th width="120">시/도 구분</th>
					<td width="150">
						<select id="S_BOROUGHCODE" name="S_BOROUGHCODE" style="width:130px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
					<th width="120">주소 및 지번</th>
					<td width="150"><input type="text" id="S_ADDRESS" name="S_ADDRESS" /></td>
				</tr>
			</table>
			<br/>
			<div align="right">총 건수 : <font color="red"><sapn id="mainListCount"></sapn></font>건</div>
			<div id="mainList"></div>
		</div>
	</div>
</body>
</html>