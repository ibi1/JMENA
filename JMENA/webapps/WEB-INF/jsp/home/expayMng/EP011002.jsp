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
	var v_rightLastSel = 0;
	
	var dt = new Date();

	// Display the month, day, and year. getMonth() returns a 0-based number.
	var month = dt.getMonth()+1;
	var day = dt.getDate();
	var year = dt.getFullYear();
	var yearMonth = year + "-" + month;
	var today = year + "-" + month + "-" + day;
	
	$("#S_YEARMONTH").val(yearMonth);
	$("#S_PAYDATE").val(today);

	$(document).ready(function(){
		$("#searchButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#S_YEARMONTH").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_PAYDATE").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});

		
		
		
		f_selectListEnaBranchCode();
		
		selectListEnaMonthPayMst();
		
		$("#S_BRANCHCODE").change(function() {
			f_selectListEnaDeptCode();
		});	
		$("#searchButton").click(function(){
			selectListEnaMonthPayMst();
		}); 		
		
	})


	function selectListEnaMonthPayMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '급여관리'
			url:"/home/selectListEnaMonthPayMst.do" ,
			mtype: 'POST',
			postData : {
				S_YEARMONTH : $("#S_YEARMONTH").val(),
				S_PAYDATE : $("#S_PAYDATE").val(),
				S_BRANCHCODE : $("#S_BRANCHCODE").val(),
				S_DEPTCODE : $("#S_DEPTCODE").val()
			},			
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['지급년월','지급일자','지사', '부서', '직급', 
			          '직책', '사번', '성명', '기본급', '활동비',
			          '일비', '시상금', '총지급액', '신고기준', '소득세',
			          '지방세', '부가가치세', '차감지급액', '입금은행', '계좌번호', '계좌주'] ,
			colModel:[
				 {name:"YEARMONTH",		index:'YEARMONTH',		width:100,		align:'center'}
				,{name:"PAYDATE",		index:'PAYDATE',		width:100,		align:'center'}
				,{name:"BRANCHCODE",	index:'BRANCHCODE',		width:100,		align:'center'}
				,{name:"DEPTCODE",		index:'DEPTCODE',		width:100,		align:'center'}
				,{name:"GRADE",			index:'GRADE',			width:100,		align:'center'}
				,{name:"DUTY",			index:'DUTY',			width:100,		align:'center'}
				,{name:"INSACODE",		index:'INSACODE',		width:100,		align:'center'}
				,{name:"KNAME",			index:'KNAME',			width:100,		align:'center'}
				,{name:"BASICAMT",		index:'BASICAMT',		width:120,		align:'right',formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: '0'}}
				,{name:"ACTAMT",		index:'ACTAMT',			width:120,		align:'right',formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"PRIZEAMT",		index:'PRIZEAMT',		width:120,		align:'right',formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"DAILYAMT",		index:'DAILYAMT',		width:120,		align:'right',formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"TOTALAMT",		index:'TOTALAMT',		width:120,		align:'right',formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"TAXGUBUN",		index:'TAXGUBUN',		width:100,		align:'center'}				
				,{name:"TAXINCOME",		index:'TAXINCOME',		width:120,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"TAXLOCAL",		index:'TAXLOCAL',		width:120,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"SUPPLYTAX",		index:'SUPPLYTAX',		width:120,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:120,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"BANKID",		index:'BANKID',			width:100,		align:'center'}
				,{name:"ACCTNO",		index:'ACCTNO',			width:150,		align:'center'}
				,{name:"ACCTOWNER",		index:'ACCTOWNER',		width:100,		align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'sortKey' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(id){
			} ,
			hidegrid: false
		});
	}

	
	
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
	
	
	
	function selectListEnaCode(data){
		var jsonValue = $.parseJSON(data).dcodeList;
		
		var result = "<select>";
		
			result += "<option value=''>선택</option>\n";
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
		});
		
		result +="</select>";

		return result;
	   	
	}	
	
	function f_selectListEnaBranchCode1(data){
		var jsonValue = $.parseJSON(data).branchMstList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.BRANCHCODE + "'>" + currentValue.BRANCHNAME + "</option>\n";
		});
		result +="</select>";
		return result;
	}	
	function f_selectListEnaDeptCode1(data){
		
		var BRANCHCODE = $("#S_BRANCHCODE").val();	
	
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/deptMstList.do", 
			dataType : 'json' , 
			data : {
				BRANCHCODE : BRANCHCODE,
			},
			success: function(data){
				var result = "<select>";
				data.deptMstList.forEach(function(currentValue, index, array){
					result += "<option value='" + currentValue.DEPTCODE + "'>" + currentValue.DEPTNAME + "</option>\n";
				});				
				result +="</select>";
			return result;
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});		
	}
	
	function f_selectListEnaBankCode(data){
		var jsonValue = $.parseJSON(data).bankList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.bankCode + "'>" + currentValue.bankName + "</option>\n";
		});
		
		result +="</select>";
		return result;
	}		
		
	
	$(function() {
		$("#insertButton").click(function() {
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			$('#leftList').jqGrid({
				//caption: '급여관리'
				url:"/home/selectListEnaMonthPayMstCrt.do" ,
				mtype: 'POST',
				postData : {
					S_YEARMONTH : $("#S_YEARMONTH").val(),
					S_PAYDATE : $("#S_PAYDATE").val(),
					S_BRANCHCODE : $("#S_BRANCHCODE").val(),
					S_DEPTCODE : $("#S_DEPTCODE").val()
				},						
				datatype:"json" ,
				loadError:function(){alert("Error~!!");} ,
				colNames:['지급년월','지급일자','지사', '부서', '직급', 
				          '직책', '사번', '성명', '기본급', '활동비',
				          '일비', '시상금', '총지급액', '신고기준', '소득세',
				          '지방세', '부가가치세', '차감지급액', '입금은행', '계좌번호', '계좌주'] ,
				colModel:[
					 {name:"YEARMONTH",		index:'YEARMONTH',		width:100,		align:'center'}
					,{name:"PAYDATE",		index:'PAYDATE',		width:100,		align:'center'}
					,{name:"BRANCHCODE",	index:'BRANCHCODE',		width:100,		align:'center', edittype:'select', editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaBranchCode1}}
					,{name:"DEPTCODE",		index:'DEPTCODE',		width:100,		align:'center', edittype:'select', editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaDeptCode1}}
					,{name:"GRADE",			index:'GRADE',			width:100,		align:'center', edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=003", buildSelect:selectListEnaCode}}
					,{name:"DUTY",			index:'DUTY',			width:100,		align:'center', edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=004", buildSelect:selectListEnaCode}}
					,{name:"INSACODE",		index:'INSACODE',		width:100,		align:'center'}
					,{name:"KNAME",			index:'KNAME',			width:100,		align:'center'}
					,{name:"BASICAMT",		index:'BASICAMT',		width:120,		align:'right', editable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: '0'}}
					,{name:"ACTAMT",		index:'ACTAMT',			width:120,		align:'right', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					,{name:"PRIZEAMT",		index:'PRIZEAMT',		width:120,		align:'right', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					,{name:"DAILYAMT",		index:'DAILYAMT',		width:120,		align:'right', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					,{name:"TOTALAMT",		index:'TOTALAMT',		width:120,		align:'right', editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					,{name:"TAXGUBUN",		index:'TAXGUBUN',		width:100,		align:'center',editable:true,
						edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=013", buildSelect:selectListEnaCode,
						dataEvents:[{
							type:'change',
							fn:function(e){
								if($("#leftList [name=TAXGUBUN] ").val() == ""){
									alert("신고기준을 선택 해 주세요.");
									return;
								}else{
									paycal();								
								}
							}
						}]
					}}				
					,{name:"TAXINCOME",		index:'TAXINCOME',		width:120,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					,{name:"TAXLOCAL",		index:'TAXLOCAL',		width:120,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					,{name:"SUPPLYTAX",		index:'SUPPLYTAX',		width:120,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:120,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					,{name:"BANKID",		index:'BANKID',			width:100,		align:'center', edittype:'select', editoptions:{dataUrl:"/codeCom/bankList.do", buildSelect:f_selectListEnaBankCode}}
					,{name:"ACCTNO",		index:'ACCTNO',			width:150,		align:'center'}
					,{name:"ACCTOWNER",		index:'ACCTOWNER',		width:100,		align:'center'}
				] ,
				rowNum:10 ,
				autowidth: true ,
				shrinkToFit: false,
				rowList:[10,20,30] ,
				sortname: 'sortKey' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(id){
//				        $(this).jqGrid('restoreRow',v_rightLastSel,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
				        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경
				} ,
				hidegrid: false
			});
		});
	})	
	
	$(function() {
		$("#saveButton").click(function() {
			var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			//jqGrid SelectBox 는 뷰 모드 전에 값을 가져옴.
// 			var branchcode = $("#leftList [name=BRANCHCODE] option:selected").val();
// 			var deptcode = $("#leftList [name=DEPTCODE] option:selected").val();
// 			var grade = $("#leftList [name=GRADE] option:selected").val();
// 			var duty = $("#leftList [name=DUTY] option:selected").val();
// 			var bankid = $("#leftList [name=BANKID] option:selected").val();
// 			var taxgubun = $("#leftList [name=TAXGUBUN] option:selected").val();
			
			$('#leftList').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경
	
			var cellData = $("#leftList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
	
	//			if (cellData.DEPTCODE == "") {
	//				alert("부서 코드를 입력하셔야 합니다.");
				
	//				$('#rightList').jqGrid('editRow', ids, true);
	//				$("#"+ids+"_DEPTCODE").focus();
				
	//				return false;
	//			}
			
	//			if (cellData.DEPTNAME == "") {
	//				alert("부서 명을 입력하셔야 합니다.");
				
	//				$('#rightList').jqGrid('editRow', ids, true);

	//				return false;
	//			}
			
	//			if (cellData.SORTKEY == "") {
	//				alert("정렬 순서를 입력하셔야 합니다.");
				
	//				$('#rightList').jqGrid('editRow', ids, true);
	//				$("#"+ids+"_SORTKEY").focus();
				
	//				return false;
	//			}
			
			var msg = "저장하시겠습니까?";
			
			
			if (confirm(msg) == true) {
				var formData = "PAYDATE=" + cellData.PAYDATE + 
							   "&YEARMONTH=" + cellData.YEARMONTH + 
							   "&INSACODE=" + cellData.INSACODE + 
							   "&BRANCHCODE=" + cellData.BRANCHCODE + 
							   "&DEPTCODE=" + cellData.DEPTCODE + 
							   "&GRADE=" + cellData.GRADE + 
							   "&DUTY=" + cellData.DUTY + 
							   "&BASICAMT=" + cellData.BASICAMT + 
							   "&ACTAMT=" + cellData.ACTAMT + 
							   "&PRIZEAMT=" + cellData.PRIZEAMT + 
							   "&DAILYAMT=" + cellData.DAILYAMT + 
							   "&TOTALAMT=" + cellData.TOTALAMT + 
							   "&TAXGUBUN=" + cellData.TAXGUBUN + 
							   "&TAXINCOME=" + cellData.TAXINCOME + 
							   "&TAXLOCAL=" + cellData.TAXLOCAL + 
							   "&SUPPLYTAX=" + cellData.SUPPLYTAX + 
							   "&DEDUCTAMT=" + cellData.DEDUCTAMT + 
							   "&BANKID=" + cellData.BANKID+
				               "&ACCTNO=" + cellData.ACCTNO+
				               "&ACCTOWNER=" + cellData.ACCTOWNER+
				               "&REMARK=" + cellData.REMARK;					
				
				
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/saveEnaMonthPayMst.do", 
					dataType : 'json' , 
					success: function(data){
						if(data.rows[0].MSG == "success"){														
							v_rightLastSel = 0;
							alert("저장이 완료되었습니다.");
							selectListEnaMonthPayMst();
						}else{
							alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
						}
						
					},
					error:function(e){  
						alert("급여관리를 저장하는 중 오류가 발생하였습니다.");
					}  	
				});
			} else {
				v_rightLastSel = 0;
				selectListEnaMonthPayMst();
			}
		});
	})
		


	$(function() {
		$("#deleteButton").click(function() {
			
			var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
		
			if (ids == null || ids == "") {
				alert("그리드를 선택하셔야 합니다.");
			
				return false;
			}
		
			$('#leftList').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경

			var cellData = $("#leftList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
			var msg = "삭제하시겠습니까?";
			if (confirm(msg) == true) {
				var formData = "INSACODE=" + $("#INSACODE").val() + 
							   "&S_YEARMONTH=" + $("#S_YEARMONTH").val() +
							   "&S_BRANCHCODE=" + $("#S_BRANCHCODE").val() +
							   "&S_DEPTCODE=" + $("#S_DEPTCODE").val();
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/deleteEnaMonthPayMst.do", 
					dataType : 'json' , 
					success: function(data){
						if(data.rows[0].MSG == "success"){
							alert("삭제가 완료되었습니다.");
							selectListEnaMonthPayMst();
						}else{
							alert("삭제 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
							selectListEnaMonthPayMst();
						}
					
					},
					error:function(e){  
						alert("급여관리를 저장하는 중 오류가 발생하였습니다.");
					}  	
				});
			} else {
				selectListEnaMonthPayMst();
			}
		});
	})		
	
	function paycal(){
		var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
		var cellData = $("#leftList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
		
		
		var gijunAmt = $("#leftList [name=TOTALAMT] ").val();
		var taxgubun = $("#leftList [name=TAXGUBUN] ").val();
		
		if(taxgubun == "001"){
			gijunAmt =  Math.floor(gijunAmt / 10000) * 10000;
			var taxincome = gijunAmt * 3 / 100;    //사업소득세
			var taxlocal = taxincome * 10 / 100;    //지방세
			taxincome = Math.floor(taxincome/10) * 10;
			taxlocal = Math.floor(taxlocal/10) * 10;
			$("#leftList").setCell(ids,"TAXINCOME",taxincome);
			$("#leftList").setCell(ids,"TAXLOCAL",taxlocal);
			$("#leftList").setCell(ids,"SUPPLYTAX","0");
			deductamt = gijunAmt - taxincome - taxlocal;
		}else if (taxgubun == "002"){
			
			var supply = gijunAmt/1.1;
			supply = Math.ceil(supply/10) * 10; //공급가
			var supplytax = supply * 10 / 100;    //부가가치세
			supplytax = Math.floor(supplytax/10) * 10;
			$("#leftList").setCell(ids,"TAXINCOME","0");
			$("#leftList").setCell(ids,"TAXLOCAL","0");
			$("#leftList").setCell(ids,"SUPPLYTAX",supplytax);
			deductamt = gijunAmt - supplytax;
			
		}
		$("#leftList").setCell(ids,"DEDUCTAMT",deductamt);
	}	
</script>
<body>

	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id='searchButton' /></td>
					<td><input type="button" value="생성" id='insertButton' /></td>
					<td><input type="button" value="삭제" id='deleteButton' /></td>
					<td><input type="button" value="저장" id='saveButton' /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">지급년월</th>
					<td width="100"><input type="text" id="S_YEARMONTH" name="S_YEARMONTH" /></td>
					<th width="120">지급일자</th>
					<td width="100"><input type="text" id="S_PAYDATE" name="S_PAYDATE" /></td>
					<th width="120">지사</th>
					<td width="100">
						<select id="S_BRANCHCODE" name="S_BRANCHCODE">
						</select>
					</td>
					<th width="120">부서</th>
					<td width="100">
						<select id="S_DEPTCODE" name="S_DEPTCODE">
						</select>
					</td>
				</tr>
			</table>			
			<table id="leftList"></table>
		</div>
	</div>
	
</body>
</html>