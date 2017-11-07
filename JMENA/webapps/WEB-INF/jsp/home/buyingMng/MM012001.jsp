<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
		$(document).ready(function(){
			
			var S_CITYCODE = "";
			var S_BOROUGHCODE = "";
			var S_ADDRESS = "";
	
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#excelButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#printButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			
			f_selectListMM012001(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
			f_selectListEnaCityCode();
			f_selectListEnaBoroughCode();
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
		
		function f_selectListMM012001(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS){
			var url = "/home/selectListMM012001.do?S_CITYCODE=" + S_CITYCODE + "&S_BOROUGHCODE=" + S_BOROUGHCODE + "&S_ADDRESS=" + S_ADDRESS;
			
	        // prepare the data
	        var source = {
	            datatype: "json",
	            datafields: [
	                         
	                { name: 'CITYCODE', type: 'string' },
	                { name: 'CITYNAME', type: 'string' },
	                { name: 'BOROUGHCODE', type: 'string' },
	                { name: 'BOROUGHNAME', type: 'string' },
	                { name: 'ADDRESS', type: 'string' },
	                { name: 'OWNERNAME', type: 'string' },
	                { name: 'BUYM2', type: 'float' },
	                { name: 'BUYPY', type: 'float' },
	                { name: 'BUNBUYPY', type: 'float' },
	                { name: 'JANBUYPY', type: 'float' },
	                { name: 'BUYAMT', type: 'int' },
	                { name: 'PAYAMT1', type: 'int' },
	                { name: 'PAYDATE1', type: 'string' },
	                { name: 'PAYAMT2', type: 'int' },
	                { name: 'PAYDATE2', type: 'string' },
	                { name: 'PAYAMT3', type: 'int' },
	                { name: 'PAYDATE3', type: 'string' },
	                { name: 'PAYAMT4', type: 'int' },
	                { name: 'PAYDATE4', type: 'string' },
	                { name: 'JANPAYAMT', type: 'int' },
	                { name: 'OPENYN', type: 'string' },
	                { name: 'REMARK', type: 'string' }
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
	            sortable: true,
	            altrows: true,
	            enabletooltips: true,
	            editable: false,
	            selectionmode: 'singlerow',
	            columns: [
	              { text: '지역코드', datafield: 'CITYCODE', width: 100, cellsalign: 'center', hidden: true },
	              { text: '지역', datafield: 'CITYNAME', width: 100, cellsalign: 'center' },
	              { text: '시/도코드', datafield: 'BOROUGHCODE', width: 100, cellsalign: 'center' },
	              { text: '시/도', datafield: 'BOROUGHNAME', width: 100, cellsalign: 'center', hidden: true },
	              { text: '주소/지번', datafield: 'ADDRESS', width: 100, cellsalign: 'center' },
	              { text: '원지주', datafield: 'OWNERNAME', width: 100, cellsalign: 'center' },
	              { text: '면적(m2)', datafield: 'BUYM2', width: 100, cellsalign: 'center' },
	              { text: '평수', datafield: 'BUYPY', width: 100, cellsalign: 'center' },
	              { text: '분양평수', datafield: 'BUNBUYPY', width: 100, cellsalign: 'center' },
	              { text: '잔여평수', datafield: 'JANBUYPY', width: 100, cellsalign: 'center' },
	              { text: '매매대금', datafield: 'BUYAMT', width: 100, cellsalign: 'center' },
	              { text: '계약금', datafield: 'PAYAMT1', width: 100, cellsalign: 'center' },
	              { text: '계약일', datafield: 'PAYDATE1', width: 100, cellsalign: 'center' },
	              { text: '중도금1', datafield: 'PAYAMT2', width: 100, cellsalign: 'center' },
	              { text: '중도일1', datafield: 'PAYDATE2', width: 100, cellsalign: 'center' },
	              { text: '중도금2', datafield: 'PAYAMT3', width: 100, cellsalign: 'center' },
	              { text: '중도일2', datafield: 'PAYDATE3', width: 100, cellsalign: 'center' },
	              { text: '잔금액', datafield: 'PAYAMT4', width: 100, cellsalign: 'center' },
	              { text: '잔금일', datafield: 'PAYDATE4', width: 100, cellsalign: 'center' },
	              { text: '잔금누계', datafield: 'JANPAYAMT', width: 100, cellsalign: 'center' },
	              { text: '오픈여부', datafield: 'OPENYN', width: 100, cellsalign: 'center' },
	              { text: '비고', datafield: 'REMARK', width: 100, cellsalign: 'center' }
	            ]
	        });
		}
/*	
		$(function(){
			$("#excelButton").click(function(){
			    $.ajax({ 
					type: 'POST' ,
					data: $("#searchForm").serialize(),
					url: "/home/MM012001_exportToExcel.do" , 
					dataType : 'json' , 
					success: function(data){
						if(data.rows[0].MSG == "success")
						{
							alert("저장이 완료되었습니다.");
							f_reload();
						}else{
							alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
						}
					},
					error:function(e){  
					}  
				}); 
			})
		})
	*/
	
		$(function(){
			$("#selectButton").click(function(){
				var S_CITYCODE = $("#S_CITYCODE").val();
				var S_BOROUGHCODE = $("#S_BOROUGHCODE").val();
				var S_ADDRESS = $("#S_ADDRESS").val();
				
				f_selectListMM012001(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
			});
			
		$("#excelButton").click(function () {
	        $("#mainList").jqxGrid('exportdata', 'xls', '원지주 잔금현황');           
	    });
	    
			$("#printButton").click(function () {
	            var gridContent = $("#mainList").jqxGrid('exportdata', 'html');
	            var newWindow = window.open('', '', 'width=1200, height=500'),
	            document = newWindow.document.open(),
	            pageContent =
	                '<!DOCTYPE html>\n' +
	                '<html>\n' +
	                '<head>\n' +
	                '<meta charset="utf-8" />\n' +
	                '<title>원지주 잔금현황</title>\n' +
	                '</head>\n' +
	                '<body>\n' + gridContent + '\n</body>\n</html>';
	            document.write(pageContent);
	            document.close();
	            newWindow.print();
	        });
		})
	</script>
</head>
<body class='default'>

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
			<form name="searchForm" method="POST" action="" class="" >
				<table class="blueone">
					<tr>
						<th>지역구분</th>
						<td>
							<select id="S_CITYCODE" name="S_CITYCODE" style="width:120px">
							</select>
						</td>
						<th>시/도</th>
						<td>
							<select id="S_BOROUGHCODE" name="S_BOROUGHCODE" style="width:120px">
							</select>
						</td>
						<th>주소 및 지번</th>
						<td><input type="text" id="S_ADDRESS" name="S_ADDRESS" /></td>
					</tr>
				</table>
			</form>
			<br/>
			<div id="mainList" width="98%"></div>
			<div id="mainNav"></div>
		</div>
	</div>
</body>
</html>