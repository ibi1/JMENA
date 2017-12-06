<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
		var auth_p = true;
	
		$(document).ready(function(){
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#printButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			
			<%if ("N".equals(session.getAttribute("AUTH_P"))) { %>
				$("#excelButton").hide();
				$("#printButton").hide();
				auth_p = false;
			<% }%>
			
			$("#LS_BUYDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#LS_BUYDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			
			f_selectListMM012001();
			f_selectListEnaBuyGubnCode();
		});
	
	
		function f_selectListEnaBuyGubnCode(){
			var CCODE = "014";	//매입구분
			$("#BUYGUBUN").empty().data('options');
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
						if (currentValue.DCODE != '003') {
							inHtml += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
						}
					});
					$("#S_BUYGUBUN").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		function f_selectListMM012001(){
			var url = "/home/selectListMM012001.do?LS_BUYDATE_FR=" + $("#LS_BUYDATE_FR").val() + "&LS_BUYDATE_TO=" + $("#LS_BUYDATE_TO").val() + "&S_BUYGUBUN=" + $("#S_BUYGUBUN").val();
			
	        // prepare the data
	        var source = {
	            datatype: "json",
	            datafields: [
	                         
	                { name: 'CITYCODE', 	type: 'string' },
	                { name: 'CITYNAME', 	type: 'string' },
	                { name: 'BOROUGHCODE', 	type: 'string' },
	                { name: 'BOROUGHNAME', 	type: 'string' },
	                { name: 'ADDRESS', 		type: 'string' },
	                { name: 'OWNERNAME', 	type: 'string' },
	                { name: 'BUYM2', 		type: 'number' },
	                { name: 'BUYPY', 		type: 'number' },
	                { name: 'BUNBUYPY', 	type: 'number' },
	                { name: 'JANBUYPY', 	type: 'number' },
	                { name: 'BUYAMT',	 	type: 'number' },
	                { name: 'PAYAMT1', 		type: 'number' },
	                { name: 'PAYDATE1', 	type: 'string' },
	                { name: 'PAYAMT2', 		type: 'number' },
	                { name: 'PAYDATE2', 	type: 'string' },
	                { name: 'PAYAMT3', 		type: 'number' },
	                { name: 'PAYDATE3', 	type: 'string' },
	                { name: 'PAYAMT4', 		type: 'number' },
	                { name: 'PAYDATE4', 	type: 'string' },
	                { name: 'JANPAYAMT', 	type: 'number' },
	                { name: 'OPENYN', 		type: 'string' },
	                { name: 'REMARK', 		type: 'string' }
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
	              { text: '지역코드',	datafield: 'CITYCODE', 		width: 100, cellsalign: 'center', hidden: true, align: 'center' },
	              { text: '지역',		datafield: 'CITYNAME', 		width: 130, cellsalign: 'center', align: 'center' },
	              { text: '시/도코드',	datafield: 'BOROUGHCODE', 	width: 100, cellsalign: 'center', hidden: true, align: 'center' },
	              { text: '시/도',		datafield: 'BOROUGHNAME', 	width: 130, cellsalign: 'center', align: 'center' },
	              { text: '주소/지번',	datafield: 'ADDRESS', 		width: 200, cellsalign: 'center', align: 'center' },
	              { text: '원지주',		datafield: 'OWNERNAME', 	width: 150, cellsalign: 'center', align: 'center' },
	              { text: '면적(m2)',	datafield: 'BUYM2', 		width: 100, cellsalign: 'right', align: 'center', cellsformat: 'f2'},
	              { text: '평수',		datafield: 'BUYPY', 		width: 100, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
	              { text: '분양평수',	datafield: 'BUNBUYPY', 		width: 100, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
	              { text: '잔여평수',	datafield: 'JANBUYPY', 		width: 100, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
	              { text: '매매대금',	datafield: 'BUYAMT', 		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
	              { text: '계약금',		datafield: 'PAYAMT1', 		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
	              { text: '계약일',		datafield: 'PAYDATE1', 		width: 150, cellsalign: 'center', align: 'center' },
	              { text: '중도금1',	datafield: 'PAYAMT2', 		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
	              { text: '중도일1',	datafield: 'PAYDATE2', 		width: 150, cellsalign: 'center', align: 'center' },
	              { text: '중도금2',	datafield: 'PAYAMT3', 		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
	              { text: '중도일2',	datafield: 'PAYDATE3', 		width: 150, cellsalign: 'center', align: 'center' },
	              { text: '잔금액',		datafield: 'PAYAMT4', 		width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
	              { text: '잔금일', 	datafield: 'PAYDATE4', 		width: 150, cellsalign: 'center', align: 'center' },
	              { text: '잔금누계', 	datafield: 'JANPAYAMT', 	width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0'},
	              { text: '오픈여부', 	datafield: 'OPENYN', 		width: 100, cellsalign: 'center', align: 'center' },
	              { text: '비고', 		datafield: 'REMARK', 		width: 250, cellsalign: 'center', align: 'center' }
	            ]
	        });
		}
	
		$(function(){
			$("#selectButton").click(function(){
				f_selectListMM012001();
			});
				
			$("#excelButton").click(function () {
				//dataType String , fileName(optional) String , exportHeader Boolean, rows Array, exportHiddenColumns Boolean, serverURL String, charSet String 
		        $("#mainList").jqxGrid('exportdata', 'xls', 'EnglishFileName', true, null, true, null, 'utf-8');           
		    });
		})
	</script>
</head>
<body class='default'>

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
			<form name="MM012001">
				<table  width="99%">
					<tr>
						<th width="120">잔금일</th>
						<td width="250"><input type="text" id="LS_BUYDATE_FR" name="LS_BUYDATE_FR" /> - <input type="text" id="LS_BUYDATE_TO" name="LS_BUYDATE_TO" /></td>
						<th width="120">매입구분</th>
						<td>
							<select id="S_BUYGUBUN" name="S_BUYGUBUN" style="width:130px">
								<option value="ALL" selected="selected">전체</option>
							</select>
						</td>
					</tr>
				</table>
			</form>
			<br/>
			<div align="right">총 건수 : <font color="red"><sapn id="mainListCount"></sapn></font>건</div>
			<div id="mainList"></div>
		</div>
	</div>
</body>
</html>