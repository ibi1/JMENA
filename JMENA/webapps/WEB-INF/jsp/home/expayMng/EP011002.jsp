<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>급여 관리</title>

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
	var yearMonth = year + "" + month;
	
	$("#S_YEARMONTH").val(yearMonth);
	$("#S_PAYDATE").val(dateInput(0));

	$(document).ready(function(){
		$("#searchButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#S_YEARMONTH").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_PAYDATE").jqxInput({theme: 'energyblue', height: 25, width: 110, minLength: 1});
		
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
			colNames:['지급년월','지급일자','지사', '부서', '직급', '직첵','지사명', '부서명','직급명', '직책명',
			          '사번', '성명', '기본급', '활동비',
			          '일비', '시상금', '총지급액', '신고기준','신고기준코드', '소득세',
			          '지방세', '부가가치세', '차감지급액', '입금은행','은행', '계좌번호', '계좌주'] ,
			colModel:[
				 {name:"YEARMONTH",		index:'YEARMONTH',		width:100,		align:'center',	sortable:false}
				,{name:"PAYDATE",		index:'PAYDATE',		width:100,		align:'center',	sortable:false}				
				,{name:"BRANCHCODE",	index:'BRANCHCODE',		width:100,		align:'center',	sortable:false}
				,{name:"DEPTCODE",		index:'DEPTCODE',		width:100,		align:'center',	sortable:false}
				,{name:"GRADE",			index:'GRADE',			width:100,		align:'center',	sortable:false}
				,{name:"DUTY",			index:'DUTY',			width:100,		align:'center',	sortable:false}
				,{name:"BRANCHNAME",	index:'BRANCHNAME',		width:100,		align:'center',	sortable:false,hidden:true}
				,{name:"DEPTNAME",		index:'DEPTNAME',		width:100,		align:'center',	sortable:false,hidden:true}
				,{name:"GRADENAME",		index:'GRADENAME',		width:100,		align:'center',	sortable:false,hidden:true}
				,{name:"DUTYNAME",		index:'DUTYNAME',		width:100,		align:'center',	sortable:false,hidden:true}
				,{name:"INSACODE",		index:'INSACODE',		width:100,		align:'center',	sortable:false}
				,{name:"KNAME",			index:'KNAME',			width:100,		align:'center',	sortable:false}
				,{name:"BASICAMT",		index:'BASICAMT',		width:120,		align:'right',	sortable:false,formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"ACTAMT",		index:'ACTAMT',			width:120,		align:'right',	sortable:false,formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}	
				,{name:"DAILYAMT",		index:'DAILYAMT',		width:120,		align:'right',	sortable:false,formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"PRIZEAMT",		index:'PRIZEAMT',		width:120,		align:'right',	sortable:false,formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"TOTALAMT",		index:'TOTALAMT',		width:120,		align:'right',	sortable:false,formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"TAXGUBUN",		index:'TAXGUBUN',		width:100,		align:'center',	sortable:false, edittype:'select',  editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=013", buildSelect:selectListEnaCode}}				
				,{name:"TAXGUBUNCODE",	index:'TAXGUBUNCODE',	width:100,		align:'center',	sortable:false,hidden:true}
				,{name:"TAXINCOME",		index:'TAXINCOME',		width:120,		align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"TAXLOCAL",		index:'TAXLOCAL',		width:120,		align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"SUPPLYTAX",		index:'SUPPLYTAX',		width:120,		align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:120,		align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"BANKID",		index:'BANKID',			width:100,		align:'center',	sortable:false,hidden:true}
				,{name:"BANKNAME",		index:'BANKNAME',		width:100,		align:'center',	sortable:false,edittype:'select', editoptions:{dataUrl:"/codeCom/bankList.do", buildSelect:f_selectListEnaBankCode}}
				,{name:"ACCTNO",		index:'ACCTNO',			width:150,		align:'center',	sortable:false}
				,{name:"ACCTOWNER",		index:'ACCTOWNER',		width:100,		align:'center',	sortable:false}
			] ,
			rowNum:10000000,
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
			loadComplete: function(id) {
				//전체 카운트
				var countRow = $("#leftList").jqGrid('getGridParam', 'records');
				$("#leftListCount").html(countRow);
			},
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
				var inHtml = "<option value='ALL'>전체</option>\n";
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
				var inHtml = "<option value='ALL'>전체</option>\n";
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
			if($("#S_BRANCHCODE").val() == "ALL" || $("#S_DEPTCODE").val() == "ALL"){
				alert("지사와 부서를 모두 선택 해 주세요");
				return;
			}
			if(confirm("생성하시겠습니까?") == true) {
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
					colNames:['지급년월','지급일자','지사코드','부서코드', '직급코드','직책코드','지사', '부서', '직급','직책',
					          '사번', '성명', '기본급', '활동비',
					          '일비', '시상금', '총지급액', '신고기준','신고기준코드', '소득세',
					          '지방세', '부가가치세', '차감지급액', '입금은행','은행코드', '계좌번호', '계좌주'] ,
					colModel:[
						 {name:"YEARMONTH",		index:'YEARMONTH',		width:100,		align:'center',	sortable:false}
						,{name:"PAYDATE",		index:'PAYDATE',		width:100,		align:'center',	sortable:false}
						,{name:"BRANCHCODE",	index:'BRANCHCODE',		width:100,		align:'center',	sortable:false,hidden:true}
						,{name:"DEPTCODE",		index:'DEPTCODE',		width:100,		align:'center',	sortable:false,hidden:true}
						,{name:"GRADE",			index:'GRADE',			width:100,		align:'center',	sortable:false,hidden:true}
						,{name:"DUTY",			index:'DUTY',			width:100,		align:'center',	sortable:false,hidden:true}
						,{name:"BRANCHNAME",	index:'BRANCHNAME',		width:100,		align:'center',	sortable:false, edittype:'select', editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaBranchCode1}}
						,{name:"DEPTNAME",		index:'DEPTNAME',		width:100,		align:'center',	sortable:false, edittype:'select', editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaDeptCode1}}
						,{name:"GRADENAME",		index:'GRADENAME',		width:100,		align:'center',	sortable:false, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=003", buildSelect:selectListEnaCode}}
						,{name:"DUTYNAME",		index:'DUTYNAME',		width:100,		align:'center',	sortable:false, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=004", buildSelect:selectListEnaCode}}
						,{name:"INSACODE",		index:'INSACODE',		width:100,		align:'center',	sortable:false}
						,{name:"KNAME",			index:'KNAME',			width:100,		align:'center',	sortable:false}
						,{name:"BASICAMT",		index:'BASICAMT',		width:120,		align:'right',	sortable:false,formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: 0}}
						,{name:"ACTAMT",		index:'ACTAMT',			width:120,		align:'right',	sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: 0},
		 					editoptions:{
		 						dataEvents:[{
		 							type:'change',
		 							fn:function(e){
		 								paycal();
		 							}
								}]
							}}
						,{name:"DAILYAMT",		index:'DAILYAMT',		width:120,		align:'right',	sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: 0},
							editoptions:{
		 						dataEvents:[{
		 							type:'change',
		 							fn:function(e){
		 								paycal();
		 							}
								}]								
								
						}}
						,{name:"PRIZEAMT",		index:'PRIZEAMT',		width:120,		align:'right',	sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: 0},
							editoptions:{
		 						dataEvents:[{
		 							type:'change',
		 							fn:function(e){
		 								paycal();
		 							}
								}]								
								
							}}
						,{name:"TOTALAMT",		index:'TOTALAMT',		width:120,		align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''},
						editoptions:{
	 						dataEvents:[{
	 							type:'change',
	 							fn:function(e){
	 								//paycal();
	 							}
							}]					
						}}
						,{name:"TAXGUBUNCODE",		index:'TAXGUBUN',		width:100,		align:'center',	sortable:false,editable:true
						, edittype:'select',  editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=013", buildSelect:selectListEnaCode
							,dataEvents:[{
								type:'change',
								fn:function(e){
									var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
									$("#leftList").setCell(ids,"TAXGUBUN",this.value);
									paycal();
								}
							}]	
						}}						
						,{name:"TAXGUBUN",		index:'BANKID',			width:150,		align:'center',	sortable:false,hidden:true}
						,{name:"TAXINCOME",		index:'TAXINCOME',		width:120,		align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
						,{name:"TAXLOCAL",		index:'TAXLOCAL',		width:120,		align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
						,{name:"SUPPLYTAX",		index:'SUPPLYTAX',		width:120,		align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
						,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:120,		align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
						,{name:"BANKNAME",		index:'BANKNAME',		width:100,		align:'center',	sortable:false,edittype:'select', editoptions:{dataUrl:"/codeCom/bankList.do", buildSelect:f_selectListEnaBankCode}}
						,{name:"BANKID",		index:'BANKID',			width:150,		align:'center',	sortable:false,hidden:true}
						,{name:"ACCTNO",		index:'ACCTNO',			width:150,		align:'center',	sortable:false}
						,{name:"ACCTOWNER",		index:'ACCTOWNER',		width:100,		align:'center',	sortable:false}
					] ,
					rowNum:10000000,
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
						if( v_rightLastSel != id ){
							$(this).jqGrid('saveRow',v_rightLastSel,false,'clientArray'); //선택된 놈 뷰 모드로 변경
					        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경
	
					        v_rightLastSel = id;
						}
						  	
					} ,
					loadComplete: function(id) {
						//전체 카운트
						var countRow = $("#leftList").jqGrid('getGridParam', 'records');
						$("#leftListCount").html(countRow);
					},	
					hidegrid: false
				});
			}
		});
		
	})	
	
	$(function() {
		$("#saveButton").click(function() {

			var dataIds = $("#leftList").jqGrid('getDataIDs');			

			var len = dataIds.length;
		
			if (len == 0) {
				alert("저장할 데이터가 없습니다.");
			
				return false;
			}
			
			//그리드 데이터를 배열에 저장
			//
			var yearmonthArr = [];
			var paydateArr = [];
			var branchcodeArr = [];
			var deptcodeArr = [];
			var gradeArr = [];
			var dutyArr = [];
			var insacodeArr = [];
			var knameArr = [];
			var basicamtArr = [];
			var actamtArr = [];
			var dailyamtArr = [];
			var prizeamtArr = [];
			var totalamtArr = [];
			var taxgubunArr = [];
			var taxincomeArr = [];
			var taxlocalArr = [];
			var supplytaxArr = [];
			var deductamtArr = [];
			var bankidArr = [];
			var acctnoArr = [];
			var acctownerArr = [];
			
			dataIds.some(function(currentValue, index, array){	 				
				$('#leftList').jqGrid('saveRow',array[index],false,'clientArray'); //선택된 놈 뷰 모드로 변경				
				yearmonthArr.push($("#leftList").jqGrid('getCell', array[index], 'YEARMONTH'));
				paydateArr.push($("#leftList").jqGrid('getCell', array[index], 'PAYDATE'));
				branchcodeArr.push($("#leftList").jqGrid('getCell', array[index], 'BRANCHCODE'));
				deptcodeArr.push($("#leftList").jqGrid('getCell', array[index], 'DEPTCODE'));
				gradeArr.push($("#leftList").jqGrid('getCell', array[index], 'GRADE'));
				dutyArr.push($("#leftList").jqGrid('getCell', array[index], 'DUTY'));
				insacodeArr.push($("#leftList").jqGrid('getCell', array[index], 'INSACODE'));
				knameArr.push($("#leftList").jqGrid('getCell', array[index], 'KNAME'));
				basicamtArr.push($("#leftList").jqGrid('getCell', array[index], 'BASICAMT'));
				actamtArr.push($("#leftList").jqGrid('getCell', array[index], 'ACTAMT'));
				dailyamtArr.push($("#leftList").jqGrid('getCell', array[index], 'DAILYAMT'));
				prizeamtArr.push($("#leftList").jqGrid('getCell', array[index], 'PRIZEAMT'));
				totalamtArr.push($("#leftList").jqGrid('getCell', array[index], 'TOTALAMT'));
				taxgubunArr.push($("#leftList").jqGrid('getCell', array[index], 'TAXGUBUN'));
				taxincomeArr.push($("#leftList").jqGrid('getCell', array[index], 'TAXINCOME'));
				taxlocalArr.push($("#leftList").jqGrid('getCell', array[index], 'TAXLOCAL'));
				supplytaxArr.push($("#leftList").jqGrid('getCell', array[index], 'SUPPLYTAX'));
				deductamtArr.push($("#leftList").jqGrid('getCell', array[index], 'DEDUCTAMT'));
				bankidArr.push($("#leftList").jqGrid('getCell', array[index], 'BANKID'));
				acctnoArr.push($("#leftList").jqGrid('getCell', array[index], 'ACCTNO'));
				acctownerArr.push($("#leftList").jqGrid('getCell', array[index], 'ACCTOWNER'));			
			});  	 		
 	 		 		
	
			if(confirm("이전 데이터는 삭제 됩니다. 저장하시겠습니까?") == true) {
			 	$.ajax({ 
					type: 'POST' ,
					url: "/home/insertEnaMonthPayMst.do", 
					data: {
						'yearmonthArr':yearmonthArr, 
						'paydateArr':paydateArr,
						'branchcodeArr':branchcodeArr,
						'deptcodeArr':deptcodeArr,
						'gradeArr':gradeArr, 
						'dutyArr':dutyArr, 
						'insacodeArr':insacodeArr,
						'knameArr':knameArr,
						'basicamtArr':basicamtArr,
						'actamtArr':actamtArr,
						'dailyamtArr':dailyamtArr,
						'prizeamtArr':prizeamtArr,
						'totalamtArr':totalamtArr,
						'taxgubunArr':taxgubunArr,
						'taxincomeArr':taxincomeArr,
						'taxlocalArr':taxlocalArr,
						'supplytaxArr':supplytaxArr,
						'deductamtArr':deductamtArr,
						'bankidArr':bankidArr,
						'acctnoArr':acctnoArr,
						'acctownerArr':acctownerArr,
						'S_YEARMONTH' :  $("#S_YEARMONTH").val(),
						'S_PAYDATE' :  $("#S_PAYDATE").val(),
						'S_BRANCHCODE' :  $("#S_BRANCHCODE").val(),
						'S_DEPTCODE' :  $("#S_DEPTCODE").val()
					},
					dataType : 'json' , 
					success: function(data){
						if(data.rows[0].MSG == "SUCCESS"){														
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
		

		var taxgubun = $("#leftList [name=TAXGUBUNCODE] option:selected").val();
		
		$('#leftList').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경

		
		var cellData = $("#leftList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기	
		
 		var actamt = cellData.ACTAMT;
 		var dailyamt = cellData.DAILYAMT;
 		var prizeamt = cellData.PRIZEAMT;
 		
		$('#leftList').jqGrid('editRow', ids, true);

		var gijunAmt =  parseInt(actamt) + parseInt(dailyamt) + parseInt(prizeamt) ;

		$("#leftList").setCell(ids,"TOTALAMT",gijunAmt);
		
		if(taxgubun == "001"){			
			gijunAmt =  Math.floor(gijunAmt / 10000) * 10000;
			var taxincome = gijunAmt * 3 / 100;    //사업소득세
			var taxlocal = taxincome * 10 / 100;    //지방세
			taxincome = Math.floor(taxincome/10) * 10;
			taxlocal = Math.floor(taxlocal/10) * 10;
			$("#leftList").setCell(ids,"TAXINCOME",taxincome);
			$("#leftList").setCell(ids,"TAXLOCAL",taxlocal);
			$("#leftList").setCell(ids,"SUPPLYTAX","0");
			var deductamt = gijunAmt - taxincome - taxlocal;
		}else if (taxgubun == "002"){
			var supply = gijunAmt/1.1;
			supply = Math.ceil(supply/10) * 10; //공급가
			var supplytax = supply * 10 / 100;    //부가가치세
			supplytax = Math.floor(supplytax/10) * 10;
			$("#leftList").setCell(ids,"TAXINCOME","0");
			$("#leftList").setCell(ids,"TAXLOCAL","0");
			$("#leftList").setCell(ids,"SUPPLYTAX",supplytax);
			var deductamt = gijunAmt - supplytax;
			
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
			<div align="right">총 건수 : <font color="red"><sapn id="leftListCount"></sapn></font>건</div>			
			<table id="leftList" style="display:inline;"></table>
		</div>
	</div>
	
</body>
</html>