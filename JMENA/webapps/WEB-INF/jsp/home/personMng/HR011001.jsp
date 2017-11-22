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
	
	$(document).ready(function(){
		var INSACODE = "";
		var BRANCHCODE = "";
		
		$("#searchButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });

		$("#bottomDiv1").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#bottomDiv2").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#insertB1Button").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteB1Button").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveB1Button").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#insertB2Button").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteB2Button").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveB2Button").jqxButton({ theme: 'energyblue', width: 80, height: 25 });

		$("#insaButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
		
		
		$("#S_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
		$("#S_JUMINID").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#KNAME").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
		$("#INSACODE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#JUMINID1").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#JUMINID2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SAUPID1").jqxInput({theme: 'energyblue', height: 25, width: 50, minLength: 1});
		$("#SAUPID2").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#SAUPID3").jqxInput({theme: 'energyblue', height: 25, width: 50, minLength: 1});
		$("#SAUPOWNER").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
		$("#ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		$("#MOBILENO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#TELNO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#BASICPAY").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
		$("#JOINDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#RETIREDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#REMARK").jqxInput({theme: 'energyblue', height: 25, width: 350, minLength: 1});
		
		
		$("#table1").show();
		$("#table2").hide();
		f_selectListEnaBranchCode();
		f_selectListEnaGradeCode();
		f_selectListEnaDutyCode();	
		selectListInsaMst();
		selectListEnaAppointItem(INSACODE);
		selectListEnaTexPayerItem(INSACODE);
	})


	function selectListInsaMst(){	
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '인사관리', 
			url:"/home/selectListEnaInsaMst.do" ,
			mtype: 'POST',
			postData : {
				S_BRANCHCODE : $("#S_BRANCHCODE").val(),
				S_DEPTCODE : $("#S_DEPTCODE").val(),
				S_KNAME : $("#S_KNAME").val(),
				S_JUMINID : $("#S_JUMINID").val(),
				S_INSACODE : $("#S_INSACODE").val()				 
			},			
			datatype:"json",		
			loadError:function(){alert("Error~!!");},
			colNames:['사번', '성명', '주민번호', '연락처', '지사코드','소속지사','부서코드','소속부서','생일구분'
			          ,'사업자번호','대표자명','주소','기타연락처','월정지급액','고용구분','직급','직책','입사일','재입사여부','퇴사일','추천인사번','비고'],
			colModel:[
				{name:"INSACODE",			index:'INSACODE',		width:100,	align:'center'}
				, {name:"KNAME",			index:'KNAME',			width:100,	align:'center'}
				, {name:"JUMINID",			index:'JUMINID',		width:120,	align:'center'}
				, {name:"MOBILENO",			index:'MOBILENO',		width:100,	align:'center'}
				, {name:"BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center'}
				, {name:"BRANCHNAME",		index:'BRANCHNAME',		width:100,	align:'center'}
	 			, {name:"DEPTCODE",			index:'DEPTCODE',		width:100,	align:'center'} 		
	 			, {name:"DEPTNAME",			index:'DEPTNAME',		width:100,	align:'center'} 		
				, {name:"BIRTHDAYGUBUN",	index:'BIRTHDAYGUBUN',	width:100,	align:'center', hidden:true}
				, {name:"SAUPID",			index:'SAUPID',			width:100,	align:'center', hidden:true}
				, {name:"SAUPOWNER",		index:'SAUPOWNER',		width:100,	align:'center', hidden:true}
				, {name:"ADDRESS",			index:'ADDRESS',		width:100,	align:'center', hidden:true}
				, {name:"TELNO",			index:'TELNO',			width:100,	align:'center', hidden:true}
				, {name:"BASICPAY",			index:'BASICPAY',		width:100,	align:'center', hidden:true}
				, {name:"EMPLOYGUBUN",		index:'EMPLOYGUBUN',	width:100,	align:'center', hidden:true}
				, {name:"GRADE",			index:'GRADE',			width:100,	align:'center', hidden:true}
				, {name:"DUTY",				index:'DUTY',			width:100,	align:'center', hidden:true}
				, {name:"JOINDATE",			index:'JOINDATE',		width:100,	align:'center', hidden:true}
				, {name:"REJOINYN",			index:'REJOINYN',		width:100,	align:'center', hidden:true}
				, {name:"RETIREDATE",		index:'RETIREDATE',		width:100,	align:'center', hidden:true}
				, {name:"RECOID",			index:'RECOID',			width:100,	align:'center', hidden:true}
				, {name:"REMARK",			index:'REMARK',			width:100,	align:'center', hidden:true}
			],
			rowNum:10,
			autowidth: true,
			shrinkToFit: false,
			rowList:[10,20,30],
			sortname: 'kName',
			viewrecords: true,
			sortorder:'asc',
			width: '96%',
			loadtext : "조회 중",
			jsonReader: {
				repeatitems: false
			},
			//height: '100%',
			onSelectRow: function(ids){					
				var selRowData = $(this).jqGrid('getRowData', ids);
				$("#DEPTCODE").val(selRowData.DEPTCODE);
				$("#INSACODE").val(selRowData.INSACODE);
	 			$("#KNAME").val(selRowData.KNAME);
				$("#JUMINID1").val(selRowData.JUMINID.substr(0,6));
				$("#JUMINID2").val(selRowData.JUMINID.substr(7,selRowData.JUMINID.length));
				$("input:radio[name=BIRTHDAYGUBUN]:input[value=" + selRowData.BIRTHDAYGUBUN + "]").attr("checked", true);
				$("#SAUPID1").val(selRowData.SAUPID.substr(0,3));
				$("#SAUPID2").val(selRowData.SAUPID.substr(3,2));
				$("#SAUPID3").val(selRowData.SAUPID.substr(5,5));
				$("#SAUPOWNER").val(selRowData.SAUPOWNER);
				$("#ADDRESS").val(selRowData.ADDRESS);
				$("#MOBILENO").val(selRowData.MOBILENO);
				$("#TELNO").val(selRowData.TELNO);
				$("#BRANCHCODE").val(selRowData.BRANCHCODE);
//				$("#BRANCHCODE").val($("#leftList [name=BRANCHCODE] option:selected").val());
//				$("#DEPTCODE").val($("#leftList [name=DEPTCODE] option:selected").val());
				$("#BASICPAY").val(selRowData.BASICPAY);
				$("input:radio[name=EMPLOYGUBUN]:input[value=" + selRowData.EMPLOYGUBUN + "]").attr("checked", true);
				$("#GRADE").val(selRowData.GRADE);
				$("#DUTY").val(selRowData.DUTY);
				$("#JOINDATE").val(selRowData.JOINDATE);
				if(selRowData.REJOINYN == "Y"){
					$("#REJOINYN").attr('checked', true);					
				}else{
					$("#REJOINYN").attr('checked', false);
				}
				$("#RETIREDATE").val(selRowData.RETIREDATE);
				$("#RECOID").val(selRowData.RECOID);
				$("#REMARK").val(selRowData.REMARK);
				f_selectListEnaDeptCode("2",selRowData.DEPTCODE);				
				selectListEnaAppointItem(selRowData.INSACODE);				
				selectListEnaTexPayerItem(selRowData.INSACODE);
				v_rightLastSel = 0;
			} ,
			loadComplete: function() {
				$("#S_INSACODE").val("");
			},			
			hidegrid: false
		});		
	}

	
	function selectListEnaAppointItem(INSACODE){
		$('#bottomList1').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		
		$('#bottomList1').jqGrid({
		//caption: '발령사항'
		url:"/home/selectListEnaAppointItem.do" ,
		mtype: 'POST',
		postData : {
			INSACODE : INSACODE
		},
		datatype:"json" ,
		loadError:function(){alert("Error~!!!!");} ,
		colNames:['사번','순번', '발령구분', '발령일자', '발령지사', '발령부서','직급', '직책', '고용구분', '월정지급액', '비고'] ,
		colModel:[
			  {name:"INSACODE",			index:'INSACODE',			width:100,		align:'center', hidden:true}
			, {name:"APPOINTSEQ",		index:'APPOINTSEQ',			width:100,		align:'center', hidden:true}
			, {name:"APPOINTGUBUN",		index:'APPOINTGUBUN',		width:100,		align:'center', editable:true
				, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=002", buildSelect:selectListEnaCode,
					dataEvents:[{
						type:'change',
						fn:function(e){
							//여기 수정해야 함.
							var appGu = $("#bottomList1 [name=APPOINTGUBUN] ").val();
							if(appGu == "001"){
								
							}else{
								
							}
							

							//$("#bottomList").setCell(ids,"TAXINCOME",taxincome);
						}
					}]					
				
				}}
			, {name:"APPOINTDATE",		index:'APPOINTDATE',		width:100,		align:'center', editable:true}
			, {name:"APPOINTBRANCH",	index:'APPOINTBRANCH',		width:100,		align:'center', editable:true
				, edittype:'select',  editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaBranchCode1,
					dataEvents:[{
						type:'change',
						fn:function(e){
							//여기 수정해야 함.
//							$("#bottomList1 [name=APPOINTBRANCH] option:selected").val();
							
							//$("#bottomList").setCell(ids,"TAXINCOME",taxincome);
						}
					}]	
				}}
//			, {name:"APPOINTDEPT",		index:'APPOINTDEPT',		width:100,		align:'center', editable:true}			
			, {name:"APPOINTDEPT",		index:'APPOINTDEPT',		width:100,		align:'center', editable:true, edittype:'select',  editoptions:{dataUrl:"/codeCom/deptMstList.do", buildSelect:f_selectListEnaDeptCode1}}
			, {name:"GRADE",			index:'GRADE',				width:100,		align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=003", buildSelect:selectListEnaCode}}
			, {name:"DUTY",				index:'DUTY',				width:100,		align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=004", buildSelect:selectListEnaCode}}
//			, {name:"DUTY",				index:'DUTY',				width:100,		align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=004", buildSelect:selectListEnaCode} }
			, {name:"EMPLOYGUBUN",		index:'EMPLOYGUBUN',		width:100,		align:'center', editable:true, formatter:'select', edittype:'select', editoptions:{value: "R:정규;F:프리"}}
			, {name:"PREBASICPAY",		index:'PREBASICPAY',		width:100,		align:'right' , editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
			, {name:"REMARK",			index:'REMARK',				width:100,		align:'center', editable:true}
		] ,
		rowNum:10 ,
		autowidth: true ,
		shrinkToFit: false,
		rowList:[10,20,30] ,
		sortname: 'appointDate' ,
		viewrecords: true ,
		sortorder:'desc' ,
		width: '96%' ,
		jsonReader: {
			repeatitems: false
		},
		//, height: '100%'
		onSelectRow : function(id) {
			if (id > 0) {
				$("#S_FLAG_B1").val("U");
			} else {
				$("#S_FLAG_B1").val("I");
			}
			
			if( v_rightLastSel != id ){
		        $(this).jqGrid('restoreRow',v_rightLastSel,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
		        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

		        v_rightLastSel = id;
			}
		},		
		hidegrid: false
		});	
		
	}	
	
	
	
	function selectListEnaTexPayerItem(INSACODE){
		$('#bottomList2').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList2').jqGrid({
			//caption: '신고인관리'
			url:"/home/selectListEnaTexPayerItem.do" ,
			postData : {
				INSACODE : INSACODE
			},		
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['사번','순번','소득신고인', '주민번호', '거래은행', '계좌번호', '계좌주', '기본계좌', '비고'] ,
			colModel:[
				 {name:"INSACODE",		index:'INSACODE',		width:100,		align:'center', hidden:true}
				,{name:"ITEMSEQ",		index:'ITEMSEQ',		width:100,		align:'center', hidden:true}
				,{name:"PAYERNAME",		index:'PAYERNAME',		width:100,		align:'center', editable:true}
				,{name:"PAYERID",		index:'PAYERID',		width:120,		align:'center', editable:true}
				,{name:"BANKID",		index:'BANKID',			width:100,		align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/bankList.do", buildSelect:f_selectListEnaBankCode}}
				,{name:"ACCTNO",		index:'ACCTNO',			width:100,		align:'center', editable:true}
				,{name:"ACCTOWNER",		index:'ACCTOWNER',		width:100,		align:'center', editable:true}
				,{name:"BASICACCT",		index:'BASICACCT',		width:100,		align:'center', editable:true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
				,{name:"REMARK",		index:'REMARK',			width:100,		align:'center', editable:true}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'ITEMSEQ' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: '96%' ,
			jsonReader: {
				repeatitems: false
			},
			//, height: '100%'
			onSelectRow: function(id){
				if (id > 0) {
					$("#S_FLAG_B2").val("U");
				} else {
					$("#S_FLAG_B2").val("I");
				}
				
				if( v_rightLastSel != id ){
			        $(this).jqGrid('restoreRow',v_rightLastSel,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
			        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

			        v_rightLastSel = id;
				}
			} ,
			loadComplete: function() {				
				
			},	
			hidegrid: false
		});
	}

	
	
	
	
	$(function(){
		$("#searchButton").click(function(){
			selectListInsaMst();
		}); 
		
		$("#bottomDiv1").click(function(){
			$("#table1").show();
			$("#table2").hide();
			var insacode = $("#INSACODE").val();
			selectListEnaAppointItem(insacode);
			v_rightLastSel = 0;
		});		
		
		$("#bottomDiv2").click(function(){
			$("#table1").hide();
			$("#table2").show();
			var insacode = $("#INSACODE").val();
			selectListEnaTexPayerItem(insacode);
			v_rightLastSel = 0;
		}); 		
		
		$("#insaButton").click(function(){
			var popUrl = "/home/HR011001_1.do";	//팝업창에 출력될 페이지 UR
			var popOption = "width=760, height=240, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"인사정보 관리",popOption);
		}); 	
	
		$("#S_BRANCHCODE").change(function() {
			f_selectListEnaDeptCode("1","");
		});	
		
 		$("#BRANCHCODE").change(function() {
 			f_selectListEnaDeptCode("2","");
 		});
		
	})	



	
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
				f_selectListEnaDeptCode("0","");
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
		
	function f_selectListEnaDeptCode(flag,deptcode){
		var BRANCHCODE = "";		
		if( flag == "0"){
			var BRANCHCODE = $("#S_BRANCHCODE").val();
			$("#S_DEPTCODE").empty().data('options');
		}else if(flag == "1"){
			BRANCHCODE = $("#S_BRANCHCODE").val();
			$("#S_DEPTCODE").empty().data('options');			
		}else if(flag == "2"){
			BRANCHCODE = $("#BRANCHCODE").val();
			$("#DEPTCODE").empty().data('options');
		}else if(flag == "3"){
			BRANCHCODE = $("#S_BRANCHCODE").val();
			$("#DEPTCODE").empty().data('options');
		}else if(flag == "4"){
			BRANCHCODE = $("#BRANCHCODE").val();
			$("#S_DEPTCODE").empty().data('options');
			$("#DEPTCODE").empty().data('options');
		}
		
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
				if(flag == "0"){
					$("#S_DEPTCODE").append(inHtml);
					$("#DEPTCODE").append(inHtml);					
				}else if(flag == "1"){
					$("#S_DEPTCODE").append(inHtml);					
				}else if(flag == "2"){
					$("#DEPTCODE").append(inHtml);	
				}else if(flag == "3"){
					$("#DEPTCODE").append(inHtml);					
				}else if(flag == "4"){
					$("#S_DEPTCODE").append(inHtml);
					$("#DEPTCODE").append(inHtml);
				}
				if(deptcode != ""){
					$("#DEPTCODE").val(deptcode);
					if(flag == "4"){
						$("#S_DEPTCODE").val(deptcode);						
					}
				}
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}	
	
	
	function f_selectListEnaGradeCode(){
		var CCODE = "003";
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
				$("#GRADE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
		
	
	function f_selectListEnaDutyCode(){
		var CCODE = "004";
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
				$("#DUTY").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
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
		var jsonValue = $.parseJSON(data).deptMstList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.DEPTCODE + "'>" + currentValue.DEPTNAME + "</option>\n";
		});
		
		result +="</select>";
		return result;
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
	
	function selectListEnaCode(data){
		var jsonValue = $.parseJSON(data).dcodeList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
		});
		
		result +="</select>";

		return result;
	   	
	}
		
	
	$(function() {
		$("#insertButton").click(function() {
			$("#INSACODE").val("");
			$("#KNAME").val("");
			$("#JUMINID1").val("");
			$("#JUMINID2").val("");
			$("input:radio[name=BIRTHDAYGUBUN]:input[value=S]").attr("checked", true);
			$("#SAUPID1").val("");
			$("#SAUPID2").val("");
			$("#SAUPID3").val("");
			$("#SAUPOWNER").val("");
			$("#ADDRESS").val("");
			$("#MOBILENO").val("");
			$("#TELNO").val("");
			$("#BRANCHCODE").val("");
			$("#DEPTCODE").val("");
			$("#BASICPAY").val("");	
			$("input:radio[name=EMPLOYGUBUN]:input[value=R]").attr("checked", true);
			$("#GRADE").val("");
			$("#DUTY").val("");
			$("#JOINDATE").val("");
			$("#REJOINYN").attr('checked', false);
			$("#RETIREDATE").val("");
			$("#RECOID").val("");
			$("#REMARK").val("");	
			f_selectListEnaDeptCode("2","");
			selectListEnaAppointItem("");				
			selectListEnaTexPayerItem("");
			f_selectListEnaGradeCode();
			f_selectListEnaDutyCode();
		});
	})
	
	$(function(){
		$("#saveButton").click(function(){		
			$("#REJOINYN").is(":checked") ? $("#REJOINYN").val("Y") : $("#REJOINYN").val("N");
			var formData = $("#HR011001").serialize();
		   	$.ajax({ 
				type: 'POST' ,
				url: "/home/updateEnaInsaMst.do", 
				//dataType : 'json' , 
				data : formData,
				//contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
				success: function(data){
					if(data.rows[0].MSG == "SUCCESS")
					{
						alert("저장이 완료되었습니다.");
						selectListInsaMst();
					}else{
						alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
					}
					
				},
				error:function(e){  
					alert("인사 정보를 저장하는 중 오류가 발생하였습니다.");
				}  
			});
		}) 
	})		
	
	
	
	$(function() {
		$("#insertB1Button").click(function() {
 			var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
 			if (ids == null || ids == "") {
 				alert("선택된 사원이 없습니다.");
				
 				return false;
 			}
			
 			$("#S_FLAG_B1").val("I");
 			
	 		$("#bottomList1").jqGrid("addRow", 0); 				
 			
		});
	})
	
	$(function() {
		$("#saveB1Button").click(function() {
			var ids = $("#bottomList1").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("그리드를 선택하셔야 합니다.");
				
				return false;
			}
			
			//jqGrid SelectBox 는 뷰 모드 전에 값을 가져옴.
			var appointGubun = $("#bottomList1 [name=APPOINTGUBUN] option:selected").val();
			var appointBranch = $("#bottomList1 [name=APPOINTBRANCH] option:selected").val();
//			var appointDept = $("#bottomList1 [name=APPOINTDEPT] option:selected").val();
			var grade = $("#bottomList1 [name=GRADE] option:selected").val();
			var duty = $("#bottomList1 [name=DUTY] option:selected").val();
			var employGubun = $("#bottomList1 [name=EMPLOYGUBUN] option:selected").val();
			
			$('#bottomList1').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경

			var cellData = $("#bottomList1").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기

// 			if (cellData.DEPTCODE == "") {
// 				alert("부서 코드를 입력하셔야 합니다.");
				
// 				$('#rightList').jqGrid('editRow', ids, true);
// 				$("#"+ids+"_DEPTCODE").focus();
				
// 				return false;
// 			}
			
// 			if (cellData.DEPTNAME == "") {
// 				alert("부서 명을 입력하셔야 합니다.");
				
// 				$('#rightList').jqGrid('editRow', ids, true);
// 				$("#"+ids+"_DEPTNAME").focus();
				
// 				return false;
// 			}
			
// 			if (cellData.SORTKEY == "") {
// 				alert("정렬 순서를 입력하셔야 합니다.");
				
// 				$('#rightList').jqGrid('editRow', ids, true);
// 				$("#"+ids+"_SORTKEY").focus();
				
// 				return false;
// 			}
			
			var msg = "";
			if ($("#S_FLAG_B1").val() == "I") {
				msg = "저장하시겠습니까?";
			} else {
				msg = "수정하시겠습니까?"
			}
			var insacode = $("#INSACODE").val();
			if (confirm(msg) == true) {
				var formData = "S_FLAG_B1=" + $("#S_FLAG_B1").val() +  
							   "&INSACODE=" + insacode + 
							   "&APPOINTSEQ=" + cellData.APPOINTSEQ + 
							   "&APPOINTGUBUN=" + appointGubun + 
				               "&APPOINTDATE=" + cellData.APPOINTDATE + 
				               "&APPOINTBRANCH=" + cellData.APPOINTBRANCH + 
				               "&APPOINTDEPT=" + cellData.APPOINTDEPT +
//				               "&APPOINTDEPT=" + appointDept +
				               "&GRADE=" + grade + 
				               "&DUTY=" + duty +
				               "&EMPLOYGUBUN=" + employGubun +
				               "&PREBASICPAY=" + cellData.PREBASICPAY+
				               "&REMARK=" + cellData.REMARK;		
				
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/updateEnaAppointItem.do", 
					dataType : 'json' , 
					success: function(data){
						if(data.rows[0].MSG == "SUCCESS"){
							$("#S_FLAG_B1").val("U");							
							v_rightLastSel = 0;
							alert("저장이 완료되었습니다.");
							selectListEnaAppointItem(insacode);
						}else{
							alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
						}
						
					},
					error:function(e){  
						alert("발령 사항을 저장하는 중 오류가 발생하였습니다.");
					}  	
				});
			} else {
				v_rightLastSel = 0;
				selectListEnaAppointItem(insacode);
			}
		});
	})
		
	
	$(function() {
		$("#deleteB1Button").click(function() {
			
			var ids = $("#bottomList1").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("그리드를 선택하셔야 합니다.");
				
				return false;
			}
			
			if ($("#S_FLAG_B1").val() == "I") {
				alert("데이터를 추가 중 일 경우 삭제 할 수 없습니다.");
				
				return false;
			}
			
			$('#bottomList1').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경

			var cellData = $("#bottomList1").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
			var msg = "삭제하시겠습니까?";
			var insacode = $("#INSACODE").val();
			if (confirm(msg) == true) {
				var formData = "INSACODE=" + insacode + 
							   "&APPOINTSEQ=" + cellData.APPOINTSEQ ;
				
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/deleteEnaAppointItem.do", 
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



	$(function() {
		$("#insertB2Button").click(function() {
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
				if (ids == null || ids == "") {
					alert("선택된 사원이 없습니다.");
				
					return false;
				}
			
				$("#S_FLAG_B2").val("I");
				
	 		$("#bottomList2").jqGrid("addRow", 0); 				
				
		});
	})
	
	$(function() {
		$("#saveB2Button").click(function() {
			var ids = $("#bottomList2").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("그리드를 선택하셔야 합니다.");
				
				return false;
			}
			
			//jqGrid SelectBox 는 뷰 모드 전에 값을 가져옴.
//			var appointGubun = $("#bottomList1 [name=APPOINTGUBUN] option:selected").val();
			
			
			var bankId = $("#bottomList2 [name=BANKID] option:selected").val();
			
			$('#bottomList2').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경
	
			var cellData = $("#bottomList2").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
			
			var payerId = cellData.PAYERID.replace("-","");
			
	//			if (cellData.DEPTCODE == "") {
	//				alert("부서 코드를 입력하셔야 합니다.");
				
	//				$('#rightList').jqGrid('editRow', ids, true);
	//				$("#"+ids+"_DEPTCODE").focus();
				
	//				return false;
	//			}
			
	//			if (cellData.DEPTNAME == "") {
	//				alert("부서 명을 입력하셔야 합니다.");
				
	//				$('#rightList').jqGrid('editRow', ids, true);
	//				$("#"+ids+"_DEPTNAME").focus();
				
	//				return false;
	//			}
			
	//			if (cellData.SORTKEY == "") {
	//				alert("정렬 순서를 입력하셔야 합니다.");
				
	//				$('#rightList').jqGrid('editRow', ids, true);
	//				$("#"+ids+"_SORTKEY").focus();
				
	//				return false;
	//			}
			
			var msg = "";
			if ($("#S_FLAG_B2").val() == "I") {
				msg = "저장하시겠습니까?";
			} else {
				msg = "수정하시겠습니까?"
			}
	
			if (confirm(msg) == true) {
				var formData = "S_FLAG_B2=" + $("#S_FLAG_B2").val() +  
							   "&INSACODE=" + $("#INSACODE").val() + 
							   "&ITEMSEQ=" + cellData.ITEMSEQ + 
				               "&PAYERNAME=" + cellData.PAYERNAME + 
				               "&PAYERID=" + payerId + 
				               "&BANKID=" + bankId+
				               "&ACCTNO=" + cellData.ACCTNO+
				               "&ACCTOWNER=" + cellData.ACCTOWNER+
				               "&REMARK=" + cellData.REMARK;	
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/updateEnaTexPayerItem.do", 
					dataType : 'json' , 
					success: function(data){
						if(data.rows[0].MSG == "SUCCESS"){
							$("#S_FLAG_B2").val("U");							
							v_rightLastSel = 0;
							alert("저장이 완료되었습니다.");
							selectListEnaTexPayerItem(insacode);
						}else{
							alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
						}
						
					},
					error:function(e){  
						alert("신고인 관리를 저장하는 중 오류가 발생하였습니다.");
					}  	
				});
			} else {
				v_rightLastSel = 0;
				selectListEnaTexPayerItem(insacode);
			}
		});
	})
		
	
		$(function() {
			$("#deleteB2Button").click(function() {
				var ids = $("#bottomList2").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
				if (ids == null || ids == "") {
					alert("그리드를 선택하셔야 합니다.");
				
					return false;
				}
			
				$('#bottomList2').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경
	
				var cellData = $("#bottomList2").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
				var msg = "삭제하시겠습니까?";
				var insacode = $("#INSACODE").val();
				if (confirm(msg) == true) {
					var formData = "INSACODE=" +insacode + 
								   "&ITEMSEQ=" + cellData.ITEMSEQ ;
				
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/deleteEnaTexPayerItem.do", 
						dataType : 'json' , 
						success: function(data){
							if(data.rows[0].MSG == "SUCCESS"){
								alert("삭제가 완료되었습니다.");
								selectListEnaTexPayerItem(insacode);
								$("#S_FLAG_B2").val("U");							
								v_rightLastSel = 0;
							}else{
								alert("신고인 삭제 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
							}
						
						},
						error:function(e){  
							alert("소득신고인을 저장하는 중 오류가 발생하였습니다.");
						}  	
					});
				} else {
					v_rightLastSel = 0;
					selectListEnaTexPayerItem(insacode);
				}
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
					<td><input type="button" value="저장" id='saveButton' /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:38%; float:left; padding: 10px" align="left">
			<table width="99%">
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
				<tr>
					<th width="120">성명</th>
					<td colspan="3">
						<input type="text" class="inputName" id="S_KNAME" name="S_KNAME" />
					</td>
				</tr>
				<tr>
					<th width="120">주민번호</th>
					<td colspan="3"><input type="text" id="S_JUMINID" name="S_JUMINID" /></td>
				</tr>
			</table>
			<br/>
			<table id="leftList" width="98%"></table>
		</div>
		<div id="rightDiv" style="width:58%;  float:left; padding: 10px" align="left">
			<form id="HR011001">
			<table width="98%">
				<tr>
					<th width="120">성명 / 사번</th>
					<td>
						<input type="text" id="KNAME" name="KNAME" />        
						<input type="text" id="INSACODE" name="INSACODE" style="background-color: #e2e2e2;" maxlength="8" readonly/>
					</td>
					<td colspan="2">
						<input type="button" id='insaButton'/>
					</td>
				</tr>
				<tr>
					<th width="120">주민번호</th>
					<td>
						<input type="text" id="JUMINID1" name="JUMINID1" maxlength="6"  /> - 
						<input type="text" id="JUMINID2" name="JUMINID2" maxlength="7"  />
					</td>
					<th width="120">생일구분</th>
					<td>
						<input type="radio" id="BIRTHDAYGUBUN" name="BIRTHDAYGUBUN" value="S" />양력 
						<input type="radio" id="BIRTHDAYGUBUN" name="BIRTHDAYGUBUN" value="M" />음력
					</td>
				</tr>
				<tr>
					<th width="120">사업자번호</th>
					<td><input type="text" style="width:15%;" id="SAUPID1" name="SAUPID1" maxlength="3" /> - 
						<input type="text" style="width:15%;" id="SAUPID2" name="SAUPID2" maxlength="2" /> -
						<input type="text" style="width:48%;" id="SAUPID3" name="SAUPID3" maxlength="5" /></td>
					<th width="120">대표자명</th>
					<td><input type="text" id="SAUPOWNER" name="SAUPOWNER" /></td>
				</tr>
				<tr>
					<th width="120">주소</th>
					<td colspan="3"><input  type="text" id="ADDRESS" name="ADDRESS"/></td>
				</tr>
				<tr>
					<th width="120">핸드폰번호</th>
					<td><input type="text" id="MOBILENO" name="MOBILENO"/></td>
					<th width="120">기타연락처</th>
					<td><input type="text" id="TELNO" name="TELNO" /></td>
				</tr>
				<tr>
					<th width="120">소속지사</th>
					<td>
						<select id="BRANCHCODE" name="BRANCHCODE">
						</select>
					</td>
					<th width="120">소속부서</th>
					<td>
						<select id="DEPTCODE" name="DEPTCODE">
						</select>
					</td>
				</tr>
				<tr>
					
					<th width="120">월정지급액</th>
					<td><input type="text" id="BASICPAY" name="BASICPAY" /></td>
					
					<th width="120">고용구분</th>
					<td colspan="3"><input type="radio" id="EMPLOYGUBUN" name="EMPLOYGUBUN" value="R" />정규 <input type="radio" id="EMPLOYGUBUN" name="EMPLOYGUBUN" value="F" />프리</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<th width="120">직급</th>
					<td>
						<select id="GRADE" name="GRADE"></select>
					</td>
					<th width="120">직책</th>
					<td>
						<select id="DUTY" name="DUTY"></select>
					</td>
				</tr>
				<tr>
					<th width="120">입사일</th>
					<td><input type="text" id="JOINDATE" name="JOINDATE" /></td>
					<th width="120">재입사여부</th>
					<td><input type="checkbox" id="REJOINYN" name="REJOINYN" /></td>
				</tr>
				<tr>
					<th width="120">퇴사일</th>
					<td colspan="3"><input type="text" id="RETIREDATE" name="RETIREDATE" /></td>
				</tr>
				<tr>
					<th width="120">추천인</th>
					<td colspan="3">
						<select id="RECOID" name="RECOID">
							<option value="recoId">insaCode</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="3"><input type="text" id="REMARK" name="REMARK" /></td>
				</tr>			
			</table>
			</form>
		</div>
		<table style="width:98%">
			<tr>
			
				<td style="width:50%" align="left">
					<input type="button" value="발령사항" id='bottomDiv1' />	
					<input type="button" value="신고인관리" id='bottomDiv2' />
				</td>
				
				<td style="width:50%" align="right">
					<input type="button" value="추가" id='insertB1Button' />
					<input type="button" value="삭제" id='deleteB1Button' />
					<input type="button" value="저장" id='saveB1Button' />
				
					<input type="button" value="추가" id='insertB2Button' />
					<input type="button" value="삭제" id='deleteB2Button' />
					<input type="button" value="저장" id='saveB2Button' />
				</td>
			
				</td>
			</tr>
		</table>
		<div id="bottomDiv" style="width:98%; float:left; padding: 10px" align="left">
			<input type="hidden" id="S_FLAG_B1" name="S_FLAG_B1" />
			<input type="hidden" id="S_FLAG_B2" name="S_FLAG_B2" />
				<div id ="table1">
					<table id="bottomList1"></table>
				</div>
				<div id="table2">
					<table id="bottomList2"></table>
				</div>
		</div>	

	</div>
	
</body>
</html>