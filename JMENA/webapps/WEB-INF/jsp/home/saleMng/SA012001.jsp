<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>매출현황 - 담당자별</title>
</head>

<script type="text/javascript">
	var init = {};
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;

	$(document).ready(function() {
		// 스타일 적용
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#excelButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#printButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1, maxLength: 10});
		// 권한설정
		init.setAuth = function() {
			<%if("N".equals(session.getAttribute("AUTH_P"))) {%>
			$("#excelButton").hide();
			$("#printButton").hide();
			<%}%>
		}
		// 년도 초기화 : 잔금입금일
		init.setYear = function() {
			var sTemp = "";
			sTemp += "<option value=\"\">년도</opton>";	
			for(var y = year + 1; y >= 2013; y--) {
				sTemp += "<option value=\""+ y +"\">"+ y +"년</opton>";	
			}
			$("#S_YEAR").append(sTemp);
		}
		// 월 초기화 : 잔금입금일
		init.setMonth = function() {
			var sTemp = "";
			sTemp += "<option value=\"\">월</opton>";	
			for(var m = 1; m <= 12; m++) {
				sTemp += "<option value=\""+ addZero(m) +"\">"+ m +"월</opton>";	
			}
			$("#S_MONTH").append(sTemp);
		}
		// 지사 초기화
		init.setBranch = function() {
			$("#S_BRANCHCODE").empty();
			$("#S_BRANCHCODE").append("<option value=\"ALL\" selected=\"selected\">전체</option>");
			
			$.ajax({ 
				type: 'POST' ,
				url: "/codeCom/branchMstList.do", 
				dataType : 'json' , 
				success: function(data) {
					var sTemp = "";
					data.branchMstList.forEach(function(currentValue, index, array) {
						sTemp += "<option value=\"" + currentValue.BRANCHCODE + "\">" + currentValue.BRANCHNAME + "</option>";
					});
					$("#S_BRANCHCODE").append(sTemp);
				},
				error:function(e) {  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		// 그리드 초기화
		init.setGrid = function() {
			var sYear = $("#S_YEAR").val();
			var sMonth = $("#S_MONTH").val();
			var sDepositdate = "";
			
			if(sYear != "" && sMonth != "") sDepositdate = sYear +"-"+ sMonth;
			
			var url = "/home/selectListSA012001.do"
					+ "?S_DEPOSITDATE="+ sDepositdate
					+ "&S_BRANCHCODE="+ $("#S_BRANCHCODE").val()
					+ "&S_KNAME="+ encodeURI(encodeURIComponent($.trim($("#S_KNAME").val())));
			
	        // prepare the data
	        var source = {
	            datatype: "json",
	            datafields: [
					{name:"BRANCHNAME", type: 'string'},
					{name:"DEPTNAME", type: 'string'},
					{name:"DUTY", type: 'string'},
					{name:"KNAME", type: 'string'},
					{name:"JOINDATE", type: 'string'},
					{name:"RETIREDATE", type: 'string'},
					{name:"O_BRANCHNAME", type: 'string'},
					{name:"O_JOINDATE", type: 'string'},
					{name:"O_RETIREDATE", type: 'string'},
					{name:"O_EMPLOYGUBUN", type: 'string'},
					{name:"AMT6", type: 'number'},
					{name:"AMT5", type: 'number'},
					{name:"AMT4", type: 'number'},
					{name:"AMT3", type: 'number'},
					{name:"AMT2", type: 'number'},
					{name:"AMT1", type: 'number'},
					{name:"AMT0", type: 'number'},
					{name:"TOTAMT", type: 'number'}
	            ],
	            root: "rows",
	            id: 'CITYCODE',
	            url: url
	        };
	        var dataAdapter = new $.jqx.dataAdapter(source, {
	            loadComplete: function (data) {
	            	var countRow = $('#mainList').jqxGrid('getrows');
	            	$("#mainListCount").html(countRow.length);
	            	$('#mainList').jqxGrid('expandallgroups');
	            },
	            loadError: function (xhr, status, error) { alert("Error~~!"); }
	        });
			// initialize jqxGrid
	        $("#mainList").jqxGrid({
	        	theme: 'energyblue',
	        	sortable: false,
	            width: '100%',
	            source: dataAdapter,        
	            pageable: false,
	            autoheight: false,
	            altrows: true,
	            enabletooltips: true,
	            editable: false,
	            selectionmode: 'singlerow',	            
	            groupable: true,
	            showgroupaggregates: true,
	            showstatusbar: true,
	            showaggregates: true,
	            showgroupsheader : false,
	            statusbarheight: 25,
	            groups: ['DEPTNAME'],
	            columns: [	                      
					{ text: '지사', datafield: 'BRANCHNAME', width: 100, cellsalign: 'center', align: 'center', groupable: true, aggregates: ["count"]},
					{ text: '부서', datafield: 'DEPTNAME',	width: 100, cellsalign: 'center', align: 'center', groupable: true, aggregates: ["count"]},
					{ text: '직급', datafield: 'DUTY',	width: 100, cellsalign: 'center', align: 'center'},
					{ text: '성명', datafield: 'KNAME', width: 100, cellsalign: 'center', align: 'center'},
					{ text: '입사일', datafield: 'JOINDATE', width: 100, cellsalign: 'center', align: 'center'},
					{ text: '퇴사일', datafield: 'RETIREDATE',	width: 100, cellsalign: 'center', align: 'center'},
					{ text: '전근무지', datafield: 'O_BRANCHNAME', width: 100, cellsalign: 'center', align: 'center', columngroup: '전근무현황'},
					{ text: '입사', datafield: 'O_JOINDATE', width: 100, cellsalign: 'center', align: 'center', columngroup: '전근무현황'},
					{ text: '퇴사', datafield: 'O_RETIREDATE', width: 100, cellsalign: 'center', align: 'center', columngroup: '전근무현황'},
					{ text: '고용구분', datafield: 'O_EMPLOYGUBUN', width: 100, cellsalign: 'center', align: 'center', columngroup: '전근무현황'},
					{ text: '6개월 전 실적', datafield: 'AMT6', width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0', aggregates: ["sum"]},
					{ text: '5개월 전 실적', datafield: 'AMT5', width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0', aggregates: ["sum"]},
					{ text: '4개월 전 실적', datafield: 'AMT4', width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0', aggregates: ["sum"]},
					{ text: '3개월 전 실적', datafield: 'AMT3', width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0', aggregates: ["sum"]},
					{ text: '2개월 전 실적', datafield: 'AMT2', width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0', aggregates: ["sum"]},
					{ text: '1개월 전 실적', datafield: 'AMT1', width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0', aggregates: ["sum"]},
					{ text: '당월 실적', datafield: 'AMT0', width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0', aggregates: ["sum"]},
					{ text: '합계', datafield: 'TOTAMT', width: 150, cellsalign: 'right', align: 'center', cellsformat: 'f0', aggregates: ["sum"],
						cellsrenderer: function (row, column, value, defaultRender, column, rowData) {
	                        if (value.toString().indexOf("Sum") >= 0) {
	                            return defaultRender.replace("Sum", "Total");
	                        }
	                    },
	                    aggregatesrenderer: function (aggregates, column, element) {
	                        var renderstring = '<div style="position: relative; margin-top: 4px; margin-right:5px; text-align: right; overflow: hidden;">' + "Total" + ': ' + aggregates.sum + '</div>';
	                        return renderstring;
	                    }					
					}					
				],
	            columngroups: [
					{ text: '전근무현황', align: 'center', name: '전근무현황' }
				]            
	        });
		}
		
		init.setYear();
		init.setMonth();
		init.setBranch();
		init.setGrid();
		
		// 조회 버튼 클릭 이벤트
		$("#selectButton").click(function() {
			if($("#S_YEAR").val() == "" || $("#S_MONTH").val() == "") {
				alert("기준월을 선택해주세요.");
				return;
			}
			init.setGrid();
		});
		// 엑셀 버튼 클릭 이벤트
		$("#excelButton").click(function() {
			//dataType String , fileName(optional) String , exportHeader Boolean, rows Array, exportHiddenColumns Boolean, serverURL String, charSet String 
	        //$("#mainList").jqxGrid('exportdata', 'xls', 'EnglishFileName', true, null, true, null, 'utf-8');
	        
			if($.trim($("#mainListCount").html()) == 0) {
	        	alert("다운로드 할 데이터가 없습니다.");
	        	return;	
	        }
	        	
	        var sYear = $("#S_YEAR").val();
			var sMonth = $("#S_MONTH").val();
			var sDepositdate = "";
			
			if(sYear != "" && sMonth != "") sDepositdate = sYear +"-"+ sMonth;
	        
			var url = "/home/SA012001_exportToExcel.do";
	        var dataParam = "S_DEPOSITDATE="+ sDepositdate
						  + "&S_BRANCHCODE="+ $("#S_BRANCHCODE").val()
						  + "&S_KNAME="+ encodeURI(encodeURIComponent($.trim($("#S_KNAME").val())));
			//파일 다운로드 (common.js에 있음)
			$.download(url, dataParam, 'post');	
	    });
	});
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
					<th width="120">기준월</th>
					<td colspan="3">
						<select id="S_YEAR"></select>
						<select id="S_MONTH"></select>
					</td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td width="150">
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:100px">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
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
