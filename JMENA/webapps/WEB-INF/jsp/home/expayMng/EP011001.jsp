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
		var dt = new Date();
		// Display the month, day, and year. getMonth() returns a 0-based number.
		var month = dt.getMonth()+1;
		var year = dt.getFullYear();
		var today = year + "-" + month;

		$("#searchButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });

// 		$("#insertB1Button").jqxButton({ theme: 'energyblue', width: 120, height: 25 });
// 		$("#deleteB1Button").jqxButton({ theme: 'energyblue', width: 120, height: 25 });
// 		$("#saveB1Button").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#payerButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		
		$("#popupButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
		$("#insaButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
		
		
		$("#S_SALEDATESYM").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_SALEDATEEYM").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_SALERCD").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SALEDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#SALEID").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#SALERCD").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#SALERNM").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#MANAGENO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 230, minLength: 1});
		$("#CONNAME").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#CONM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#CONPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SALEAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#SALEDANGA").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#DCGUBUN").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#DCRATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#DCAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#SELLAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#PAYDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#INSACODE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#KNAME").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#SUDANGRATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#ADDRATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#PAYAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#TAXGUBUN").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
		$("#TAXINCOME").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#TAXLOCAL").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SUPPLYTAX").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#DEDUCTAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#PAYSEQ").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#REMARK").jqxInput({theme: 'energyblue', height: 25, width: 550, minLength: 1});
		
		
		$('#S_SALEDATESYM').val(today);
		$('#S_SALEDATEEYM').val(today);
		
		//공통코드 가져오기
		f_selectListEnaCityCode();		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		f_selectEnaCode("007");
		f_selectEnaCode("008");
		f_selectEnaCode("013");
		//공통코드 가져오기 끝		
		selectListEnaSudangMst();
		searchbottomList();
		
	});

	function selectListEnaSudangMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '수당관리'
			url:"/home/selectListEnaSudangMst.do" ,
			mtype: 'POST',
			postData : {
				S_SALEID : $("#S_SALEID").val(),
				S_SALEDATESYM : $("#S_SALEDATESYM").val(),
				S_SALEDATEEYM : $("#S_SALEDATEEYM").val(),
				S_BRANCHCODE : $("#S_BRANCHCODE").val(),
				S_DEPTCODE : $("#S_DEPTCODE").val(),
				S_SALERCD : $("#S_SALERCD").val()
			},				
			datatype:"json" ,			
			loadError:function(){alert("Error~!!");} ,
			colNames:['지급일','지급순번','담당자','담당자성명', '매출금액', '지급금액', '세액', '차감지급액','계약일자','번호','매출구분','계약지사','관리자번호',
			          '지역구분','주소','계약자성명','계약면적','계약평수','매매대금','매매단가','DC사항','DC율','DC금액', //'실판매가' ,
			          '수당지급율','추가지급율','신고기준','사업소득세','지방세','부가가치세','비고','매출담당자','매출담당자성명','신고인수'],
			colModel:[
				 {name:"PAYDATE",		index:'PAYDATE',		width:80,		align:'center'}
				,{name:"PAYSEQ",		index:'PAYSEQ',			width:80,		align:'center', hidden:true}
				,{name:"INSACODE",		index:'INSACODE',		width:80,		align:'center', hidden:true}
				,{name:"KNAME",			index:'KNAME',			width:80,		align:'center'}
				,{name:"SELLAMT",		index:'SELLAMT',		width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"PAYAMT",		index:'PAYAMT',			width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"TAXAMT",		index:'TAXAMT',			width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				,{name:"SALEDATE",		index:'SALEDATE',		width:80,		align:'center'}
				,{name:"SALEID",		index:'SALEID',			width:60,		align:'center', hidden:true}
				,{name:"SALEGUBUN",		index:'SALEGUBUN',		width:60,		align:'center', hidden:true}
				,{name:"BRANCHCODE",	index:'BRANCHCODE',		width:60,		align:'center', hidden:true}
				,{name:"MANAGENO",		index:'MANAGENO',		width:60,		align:'center', hidden:true}
				,{name:"CITYCODE",		index:'CITYCODE',		width:60,		align:'center', hidden:true}
				,{name:"ADDRESS",		index:'ADDRESS',		width:60,		align:'center', hidden:true}
				,{name:"CONNAME",		index:'CONNAME',		width:60,		align:'center', hidden:true}
				,{name:"CONM2",			index:'CONM2',			width:60,		align:'center', hidden:true}
				,{name:"CONPY",			index:'CONPY',			width:60,		align:'center', hidden:true}
				,{name:"SALEAMT",		index:'SALEAMT',		width:60,		align:'center', hidden:true}
				,{name:"SALEDANGA",		index:'SALEDANGA',		width:60,		align:'center', hidden:true}
				,{name:"DCGUBUN",		index:'DCGUBUN',		width:60,		align:'center', hidden:true}
				,{name:"DCRATE",		index:'DCRATE',			width:60,		align:'center', hidden:true}
				,{name:"DCAMT",			index:'DCAMT',			width:60,		align:'center', hidden:true}			
				,{name:"SUDANGRATE",	index:'SUDANGRATE',		width:60,		align:'center', hidden:true}
				,{name:"ADDRATE",		index:'ADDRATE',		width:60,		align:'center', hidden:true}
				,{name:"TAXGUBUN",		index:'TAXGUBUN',		width:60,		align:'center', hidden:true}
				,{name:"TAXINCOME",		index:'TAXINCOME',		width:60,		align:'center', hidden:true}
				,{name:"TAXLOCAL",		index:'TAXLOCAL',		width:60,		align:'center', hidden:true}
				,{name:"SUPPLYTAX",		index:'SUPPLYTAX',		width:60,		align:'center', hidden:true}
				,{name:"REMARK",		index:'REMARK',			width:60,		align:'center', hidden:true}	
				,{name:"SALERCD",		index:'SALERCD',		width:60,		align:'center', hidden:true}
				,{name:"SALERNM",		index:'SALERNM',		width:60,		align:'center', hidden:true}
				,{name:"REGISTERNUM",	index:'REGISTERNUM',	width:60,		align:'center', hidden:true}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'sortKey' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			loadtext : "조회 중",
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
				$("#PAYDATE").val(selRowData.PAYDATE);
//				$("#SALERCD").val(selRowData.SALERCD);
				$("#SALERNM").val(selRowData.SALERNM);
				$("#SALEDATE").val(selRowData.SALEDATE);
				$("#SALEID").val(selRowData.SALEID);
				$("#SALEGUBUN").val(selRowData.SALEGUBUN);
				$("#BRANCHCODE").val(selRowData.BRANCHCODE);
				$("#MANAGENO").val(selRowData.MANAGENO);
				$("#CITYCODE").val(selRowData.CITYCODE);
				$("#ADDRESS").val(selRowData.ADDRESS);
				$("#CONNAME").val(selRowData.CONNAME);
				$("#CONM2").val(selRowData.CONM2);
				$("#CONPY").val(selRowData.CONPY);
				$("#SALEAMT").val(selRowData.SALEAMT);
				$("#SALEDANGA").val(selRowData.SALEDANGA);
				$("#DCGUBUN").val(selRowData.DCGUBUN);
				$("#DCRATE").val(selRowData.DCRATE);
				$("#DCAMT").val(selRowData.DCAMT);
				$("#SELLAMT").val(selRowData.SELLAMT);
				$("#SUDANGRATE").val(selRowData.SUDANGRATE);
				$("#ADDRATE").val(selRowData.ADDRATE);
				$("#TAXGUBUN").val(selRowData.TAXGUBUN);
				$("#TAXINCOME").val(selRowData.TAXINCOME);
				$("#TAXLOCAL").val(selRowData.TAXLOCAL);
				$("#SUPPLYTAX").val(selRowData.SUPPLYTAX);
				$("#PAYAMT").val(selRowData.PAYAMT);
				$("#DEDUCTAMT").val(selRowData.DEDUCTAMT);
				$("#REMARK").val(selRowData.REMARK);
				$("#INSACODE").val(selRowData.INSACODE);
				$("#KNAME").val(selRowData.KNAME);
				$("#S_SALEID").val(selRowData.SALEID);
				$("#PAYSEQ").val(selRowData.PAYSEQ);
				searchbottomList();
			} ,
			
			loadComplete: function(ids) {
				searchbottomList();
			},			
			hidegrid: false
		});
	
	}
	
	
	
	function searchbottomList(){
		$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList').jqGrid({
			//caption: '수당지급관리'
			url:"/home/selectListEnaSudangMst.do" ,
			mtype: 'POST',
			postData : {
				S_SALEID : $("#S_SALEID").val()
			},					
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['직책', '직급', '성명', '수당지급율(%)', '추가지급율(%)', '지급금액', '신고기준', '사업소득세', '지방세', '부가가치세', '차감지급액', '신고인 수', '비고','판매번호','순번','사번'],
			colModel:[  	
				  {name:"GRADE",		index:'GRADE',		width:80,		align:'center'}
				, {name:"DUTY",			index:'DUTY',		width:80,		align:'center'}
				, {name:"KNAME",		index:'KNAME',		width:80,		align:'center'}
				, {name:"SUDANGRATE",	index:'SUDANGRATE',	width:80,		align:'center'}
				, {name:"ADDRATE",		index:'ADDRATE',	width:60,		align:'center'}
				, {name:"PAYAMT",		index:'PAYAMT',		width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				, {name:"TAXGUBUN",		index:'TAXGUBUN',	width:80,		align:'center', edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=013", buildSelect:f_selectEnaCode}}
				, {name:"TAXINCOME",	index:'TAXINCOME',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				, {name:"TAXLOCAL",		index:'TAXLOCAL',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				, {name:"SUPPLYTAX",	index:'SUPPLYTAX',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				, {name:"DEDUCTAMT",	index:'DEDUCTAMT',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				, {name:"REGISTERNUM",	index:'REGISTERNUM',width:60,		align:'center'}
				, {name:"REMARK",		index:'REMARK',		width:60,		align:'center'}
				, {name:"SALEID",		index:'SALEID',		width:60,		align:'center', hidden:true}
				, {name:"PAYSEQ",		index:'PAYSEQ',		width:60,		align:'center', hidden:true}
				, {name:"INSACODE",		index:'PAYERID',	width:60,		align:'center', hidden:true}
//				{name:"SYSID",			index:'SYSID',		width:60,		align:'center',  editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaBranchCode}}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'SORTKEY' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			loadtext : "조회 중",
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
//				$("#PAYSEQ").val(selRowData.PAYSEQ);
			} ,
			loadComplete: function(ids) {
				$("#S_SALEID").val("");
			},					
			hidegrid: false
		});
	}
	
	
	
	function f_selectListEnaCityCode(){
		$("#CITYCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/cityMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				data.cityMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.CITYCODE + "'>" + currentValue.CITYNAME + "</option>\n";
				});
				$("#CITYCODE").append(inHtml);				
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
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
				$("#BRANCHCODE").append(inHtml);
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
	
	
	function f_selectEnaCode(CCODE){
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
					inHtml += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
				});
				if(CCODE == "007"){
					$("#SALEGUBUN").append(inHtml);					
				}else if(CCODE == "008"){
					$("#DCGUBUN").append(inHtml);	
				}else if(CCODE == "013"){
					$("#TAXGUBUN").append(inHtml);	
				}
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}	
	


	$(function(){
		$("#popupButton").click(function(){
			var popUrl = "/home/EP011001_1.do";
			var popOption = "width=700, height=240, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"인사정보 관리",popOption);
		}); 
	});
	
	$(function(){
		$("#payerButton").click(function(){
			if($("#SALEID").val() == ""){
				alert("매출을 선택해 주세요");
				return;
			}
			
			var popUrl = "/home/EP011001_2.do";
			var popOption = "width=1120, height=540, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"신고인 관리",popOption);
		}); 
	});
	
	
	$("#SUDANGRATE").change(function() {
		paycal();
	});
	
	
	$("#ADDRATE").change(function() {
		paycal();
	});
	
	$("#TAXGUBUN").change(function() {
		paycal();
	});
	
	
	function paycal(){
		$("#PAYAMT").val("0");
		$("#TAXINCOME").val("0");
		$("#TAXLOCAL").val("0");
		$("#SUPPLYTAX").val("0");
		$("#DEDUCTAMT").val("0");
		
		var deductamt = "0";
		
		
		var sellAmt = parseInt($("#SELLAMT").val());
		var sudangrate = parseFloat($("#SUDANGRATE").val());
		var addrate = parseFloat($("#ADDRATE").val());
		var gijunAmt = sellAmt * (sudangrate + addrate) / 100;    //지급금액(기준금액)
		
		var taxgubun =$("#TAXGUBUN").val()
		
		
		$("#PAYAMT").val(gijunAmt);
		
		if(taxgubun == "001"){
			gijunAmt =  Math.floor(gijunAmt / 10000) * 10000;
			$("#PAYAMT").val(gijunAmt);
			var taxincome = gijunAmt * 3 / 100;    //사업소득세
			var taxlocal = taxincome * 10 / 100;    //지방세
			taxincome = Math.floor(taxincome/10) * 10;
			taxlocal = Math.floor(taxlocal/10) * 10;
			$("#TAXINCOME").val(taxincome);
			$("#TAXLOCAL").val(taxlocal);
			deductamt = gijunAmt - taxincome - taxlocal;
		}else if (taxgubun == "002"){
			
			var supply = gijunAmt/1.1;
			supply = Math.ceil(supply/10) * 10; //공급가
			var supplytax = supply * 10 / 100;    //부가가치세
			supplytax = Math.floor(supplytax/10) * 10;
			$("#SUPPLYTAX").val(supplytax);
			deductamt = gijunAmt - supplytax;
			
		}
		$("#DEDUCTAMT").val(deductamt);
	}
	
	
	$(function(){
		$("#searchButton").click(function() {
			selectListEnaSudangMst();
		}); 
	});	
	
	$(function(){
		$("#insertButton").click(function() {
			$("#PAYDATE").val("");
			$("#INSACODE").val("");
			$("#KNAME").val("");
			$("#SUDANGRATE").val("");
			$("#ADDRATE").val("");
			$("#TAXGUBUN").val("");
			$("#TAXINCOME").val("");
			$("#TAXLOCAL").val("");
			$("#SUPPLYTAX").val("");
			$("#PAYAMT").val("");
			$("#DEDUCTAMT").val("");
			$("#REMARK").val("");
		}); 
	});	
	
	
	
	$(function(){
		$("#saveButton").click(function(){
			var saleId =  $("#SALEID").val();
			var formData = $("#EP011001").serialize()+"&SALEID=" + saleId;
			var msg = "저장하시겠습니까?";
			if (confirm(msg) == true) {	
			   	$.ajax({ 
					type: 'POST' ,
					url: "/home/updateEnaSudangMst.do", 
					//dataType : 'json' , 
					data : formData,
					//contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
					success: function(data){
						if(data.rows[0].MSG == "success")
						{
							alert("저장이 완료되었습니다.");
							$("#S_SALEID").val(saleId);
							selectListEnaSudangMst();
						}else{
							alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
						}
						
					},
					error:function(e){  
						alert("수당 정보를 저장하는 중 오류가 발생하였습니다.");
					}  
				});
			}
		}) 
	})	
		
	
	$(function() {
		$("#deleteButton").click(function() {
			
			var msg = "삭제하시겠습니까?";
			var insacode = $("#INSACODE").val();
			if (confirm(msg) == true) {
				var formData = "SALEID=" + $("#SALEID").val()+
								"PAYSEQ=" + $("#PAYSEQ").val() ;
				
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/deleteEnaSudangMst.do", 
					dataType : 'json' , 
					success: function(data){
						if(data.rows[0].MSG == "SUCCESS"){
							$("#S_FLAG_B1").val("U");							
							v_rightLastSel = 0;
							alert("삭제가 완료되었습니다.");
							selectListEnaAppointItem(insacode);
						}else{
							alert("삭제 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
							
						}
						
					},
					error:function(e){  
						alert("발령 사항을 삭제하는 중 오류가 발생하였습니다.");
					}  	
				});
			} else {
				v_rightLastSel = 0;
				selectListEnaAppointItem(insacode);
			}
		});
	})		
	
	$(function(){	
		$("#insaButton").click(function(){
			var popUrl = "/home/HR011001_1.do";	//팝업창에 출력될 페이지 UR
			var popOption = "width=1100, height=540, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"인사정보 관리",popOption);
		}); 		
	})		
</script>
<body>

	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id='searchButton' /></td>
					<td><input type="button" value="추가" id='insertButton' /></td>
					<td><input type="button" value="삭제" id='deleteButton' /></td>
					<td><input type="button" value="저장" id='saveButton' /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; padding: 10px" align="left">
			<table width="99%" >
				<tr>
					<th width="120">지급년월</th>
					<td colspan="3"><input type="text" id="S_SALEDATESYM" name="S_SALEDATESYM" /> ~ <input type="text" id="S_SALEDATEEYM" name="S_SALEDATEEYM" /></td>
				</tr>
				<tr>
					<th width="120">지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" >
							<option></option>
						</select>
					</td>
					<th width="120">부서</th>
					<td>
						<select id="S_DEPTCODE" name="S_DEPTCODE">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td colspan="3">
						<input type="text" id="S_SALERCD" name="S_SALERCD" />
						<input type="hidden" id="S_SALEID" name="S_SALEID"/> 
					</td>
						
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; padding: 10px" align="left">
			<table >
				<tr>
					<th width="120">계약일자/번호</th>
					<td colspan="2">
						<input type="text" id="SALEDATE" name="SALEDATE" />
						<input type="text" id="SALEID" name="SALEID" />
					</td>
					<td><input type="button" id='popupButton'/></td>
				</tr>
				<tr>
					<th width="120">매출구분</th>
					<td colspan="3">
						<select id="SALEGUBUN" name="SALEGUBUN" style="background-color: #e2e2e2;" readonly >
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td><input type="hidden" id="SALERCD" name="SALERCD" style="background-color: #e2e2e2;" readonly />
					<input type="text" id="SALERNM" name="SALERNM" style="background-color: #e2e2e2;" readonly/></td>
					<th width="120">계약지사</th>
					<td>
						<select id="BRANCHCODE" name="BRANCHCODE" style="background-color: #e2e2e2;" readonly >
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">관리번호</th>
					<td ><input type="text" id="MANAGENO" name="MANAGENO" style="background-color: #e2e2e2;" readonly/></td>
					<th width="120">지역구분</th>
					<td>
						<select id="CITYCODE" name="CITYCODE" style="background-color: #e2e2e2;" readonly >
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">주소</th>
					<td colspan="3"><input type="text" id="ADDRESS" name="ADDRESS" style="background-color: #e2e2e2;" readonly/></td>
				</tr>
				<tr>
					<th width="120">계약자 성명</th>
					<td colspan="3"><input type="text" id="CONNAME" name="CONNAME" style="background-color: #e2e2e2;" readonly/></td>
				</tr>
				<tr>
					<th width="120">계약면적</th>
					<td><input type="text" id="CONM2" name="CONM2" style="text-align:right; background-color: #e2e2e2;" readonly/></td>
					<th width="120">계약평수</th>
					<td><input type="text" id="CONPY" name="CONPY" style="text-align:right; background-color: #e2e2e2;" readonly/></td>
				</tr>
				<tr>
					<th width="120">매매대금</th>
					<td width="120"><input type="text" id="SALEAMT" name="SALEAMT" style="text-align:right; background-color: #e2e2e2;" readonly/></td>
					<th width="120">매매단가</th>
					<td><input type="text" id="SALEDANGA" name="SALEDANGA" style="text-align:right; background-color: #e2e2e2;" readonly/></td>
				</tr>
				<tr>
					<th width="120">DC사항</th>
					<td>
						<select id="DCGUBUN" name="DCGUBUN" style="background-color: #e2e2e2;" readonly  >
						</select>
					</td>
					<th width="120">DC 율</th>
					<td><input type="text" id="DCRATE" name="DCRATE" style="text-align:right; background-color: #e2e2e2;" readonly/> % </td>
				</tr>
				<tr>
					<th width="120">DC금액</th>
					<td><input type="text" id="DCAMT" name="DCAMT" style="text-align:right; background-color: #e2e2e2;" readonly/></td>
					<th width="120">실 판매가</th>
					<td><input type="text" id="SELLAMT" name="SELLAMT" style="text-align:right; background-color: #e2e2e2;" readonly/></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; padding: 10px" align="left">
			<form id="EP011001">
			<table>
				<tr>
					<th width="120">지급일자</th>
					<td width="120"><input type="text" id="PAYDATE" name="PAYDATE"> </td>
					<th width="120">담당자 성명</th>
					<td colspan="2">
						<input type="text" id="INSACODE" name="INSACODE"/>
						<input type="text" id="KNAME" name="KNAME"/>
					</td>
					<td colspan="5">
						<input type="button" id='insaButton'/>
					</td>
				</tr>
				<tr>
					<th width="120">수당지급율(%)</th>
					<td width="120"><input type="text" id="SUDANGRATE" name="SUDANGRATE" style="text-align:right;"/></td>
					<th width="120">추가지급율(%)</th>
					<td width="120"><input type="text" id="ADDRATE" name="ADDRATE" style="text-align:right;"/></td>
					<th width="120">지급금액</th>
					<td colspan="5"><input type="text" id="PAYAMT" name="PAYAMT" style="text-align:right; background-color: #e2e2e2;" readonly /></td>
				</tr>
				<tr>
					<th width="120">신고기준</th>				
					<td width="120">
						<select id="TAXGUBUN" name="TAXGUBUN"></select>
					</td>
					<th width="120">사업소득세</th>
					<td width="130"><input type="text" id="TAXINCOME" name="TAXINCOME" style="text-align:right; background-color: #e2e2e2;" readonly /></td>
					<th width="120">지방세</th>
					<td width="130"><input type="text" id="TAXLOCAL" name="TAXLOCAL" style="text-align:right; background-color: #e2e2e2;" readonly /></td>
					<th width="120">부가가치세</th>
					<td width="130"><input type="text" id="SUPPLYTAX" name="SUPPLYTAX" style="text-align:right; background-color: #e2e2e2;" readonly /></td>
					<th width="120">차감지급액</th>
					<td width="130"><input type="text" id="DEDUCTAMT" name="DEDUCTAMT" style="text-align:right; background-color: #e2e2e2;" readonly /></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="9"><input type="text" id="REMARK" name="REMARK"/>
					<input type="hidden" id= "PAYSEQ" name="PAYSEQ"></td>
				</tr>
			</table>
			</form>
			<br />			
			<br />			
			<table id="bottomList"></table>
			<table align="right">
				<tr>
					<td><input type="button" value="신고인 관리" id='payerButton' /></td>
				</tr>
			</table>			
		</div>
	</div>
</body>
</html>