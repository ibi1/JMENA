<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

	<script type="text/javascript">
		var v_rightLastSel = 0;
		var auth_i = true;
		var auth_d = true;

		$(document).ready(function(){
			$("#S_FLAG_L").val("I");
			$("#S_FLAG_R").val("I");
			
			$("#SL_BRROWDATE_FR").val(dateInput(1));
			$("#SL_BRROWDATE_TO").val(dateInput(0));
			
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#deleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
	
			$("#tab1InsertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#tab1DeleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#tab1SaveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
	
			$("#SL_BRROWDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#SL_BRROWDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#SL_CONADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
			
			$("#searchPopButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
			$("#searchManageNoPopButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
			
			<%if ("N".equals(session.getAttribute("AUTH_I"))) { %>
				$("#insertButton").hide();
				$("#saveButton").hide();
				$("#tab1InsertButton").hide();
				$("#tab1SaveButton").hide();
				auth_i = false;
			<% }%>
			<%if ("N".equals(session.getAttribute("AUTH_D"))) { %>
				$("#deleteButton").hide();
				$("#tab1DeleteButton").hide();
				auth_d = false;
			<% }%>
			
			$("#SALEDATE").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
			$("#SALEID").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1, disabled: true});
			$("#MANAGENO").jqxInput({theme: 'energyblue', height: 25, width: 190, minLength: 1, disabled: true});
			$("#ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1, disabled: true});
			$("#CONBM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1, disabled: true});
			$("#CONJM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1, disabled: true});
			$("#CONBPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1, disabled: true});
			$("#CONJPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1, disabled: true});
			$("#CONNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#CONJUMINID").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#CONTELNO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#CONADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
			$("#CONM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
			$("#CONPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
			$("#BRROWAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#BRROWPERIOD").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
			$("#PAYRATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#PAYAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#PAYACCOUNT").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
			$("#PAYOWNER").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#BRROWDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#EXPIREDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#EXTENDDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#CANCELDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#REMARK").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
			$("#REGDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});		
			
			$("#CITYCODE").attr("disabled", true);
			
			$("input:radio[name=BRROWTYPE]:input[value=M]").attr("checked", true);
			
			f_selectListEnaCityCode();
			f_selectListEnaSalerCode();
			f_selectListEnaBranchCode();
			f_selectListEnaBankGubunCode();
			f_selectListEnaPeriodGubunCode();
			
			f_selectListEnaSaleMstBDtl();
			f_selectListEnaJointNameTbBDtl();
		});
	
		//시/도
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
	
		//담당자
		function f_selectListEnaSalerCode(){
			
			var BRANCHCODE = "";
			$("#SALERCD").empty().data('options');
			
		   	$.ajax({ 
				type: 'POST' ,
				url: "/codeCom/insaMstList.do", 
				dataType : 'json' , 
				data : {
					BRANCHCODE : BRANCHCODE,
				},
				success: function(data){
					var inHtml = "";
					data.insaMstList.forEach(function(currentValue, index, array){
						inHtml += "<option value='" + currentValue.INSACODE + "'>" + currentValue.KNAME + "</option>\n";
					});
					$("#SALERCD").append(inHtml);
					$("#SL_SALERNAME").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		//계약지사
		function f_selectListEnaBranchCode(){
			$("#BRANCHNAME").empty().data('options');
		   	$.ajax({ 
				type: 'POST' ,
				url: "/codeCom/branchMstList.do", 
				dataType : 'json' , 
				success: function(data){
					var inHtml = "";
					data.branchMstList.forEach(function(currentValue, index, array){
						inHtml += "<option value='" + currentValue.BRANCHCODE + "'>" + currentValue.BRANCHNAME + "</option>\n";
					});
					$("#BRANCHNAME").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		//지급은행
		function f_selectListEnaBankGubunCode(){
			$("#PAYBANK").empty().data('options');
		   	$.ajax({ 
				type: 'POST' ,
				url: "/codeCom/bankList.do", 
				dataType : 'json' ,
				success: function(data){
					var inHtml = "";
					data.bankList.forEach(function(currentValue, index, array){
						inHtml += "<option value='" + currentValue.bankCode + "'>" + currentValue.bankName + "</option>\n";
					});
					$("#PAYBANK").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		//차입기간구분
		function f_selectListEnaPeriodGubunCode(){
			var CCODE = "011";
			$("#PERIODGUBUN").empty().data('options');
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
					$("#PERIODGUBUN").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		//매출관리 소비대차 메인 그리드
		function f_selectListEnaSaleMstBDtl(){
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListEanSaleMstBDtl.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					SL_BRROWDATE_FR : $("#SL_BRROWDATE_FR").val(),
					SL_BRROWDATE_TO : $("#SL_BRROWDATE_TO").val(),
					SL_SALERNAME : $("#SL_SALERNAME").val(),
					SL_ADDRESS : $("#SL_ADDRESS").val()
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['차입일자', '차입자', '주소', '차입대금', '차입형식', '지급이자금액', 
				          '계약번호', '계약일자', '관리번호', '지역구분', '지사구분', '원지주성명', '주민번호', '분양면적', '잔여면적', '분양평수', '잔여평수', 
				          '매출구분', '담당자', '매입번호', '차입자주민번호', '차입자주소', 
				          '차입자연락처', '계약면적', '계약평수', '비고', 
				          '차입기간', '차입기간구분', '만기일', '지급이율', '지급계좌', '지급은행', '연장여부', '연장일자', '해약여부', '해약일자',
				          '계좌주', '공동명의구분', '등기여부', '등기일자'],
				colModel:[
					{name:"BRROWDATE",		index:'BRROWDATE',		width:100,	align:'center',	sortable:false},
					{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center',	sortable:false},
					{name:"ADDRESS",		index:'ADDRESS',		width:100,	align:'center',	sortable:false},
					{name:"BRROWAMT",		index:'BRROWAMT',		width:100,	align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}},
					{name:"BRROWTYPE",		index:'BRROWTYPE',		width:100,	align:'center',	sortable:false},
					{name:"PAYACCOUNT",		index:'PAYACCOUNT',		width:100,	align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}},
					{name:"SALEID",			index:'SALEID',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"SALEDATE",		index:'SALEDATE',		width:100,	align:'center',	sortable:false, hidden:true},
					{name:"MANAGENO",		index:'MANAGENO',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CITYCODE",		index:'CITYCODE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"OWNERNAME",		index:'OWNERNAME',		width:100,	align:'center',	sortable:false, hidden:true},
					{name:"OWNERJUMINID",	index:'OWNERJUMINID',	width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONBM2",			index:'CONBM2',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONJM2",			index:'CONJM2',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONBPY",			index:'CONBPY',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONJPY",			index:'CONJPY',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"SALEGUBUN",		index:'SALEGUBUN',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"SALERCD",		index:'SALERCD',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"BUYID",			index:'BUYID',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONJUMINID",		index:'CONJUMINID',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONADDRESS",		index:'CONADDRESS',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONTELNO",		index:'CONTELNO',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONM2",			index:'CONM2',			width:100,	align:'center',	sortable:false, hidden:true},
					{name:"CONPY",			index:'CONPY',			width:100,	align:'center',	sortable:false, hidden:true},
					{name:"REMARK",			index:'REMARK',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"BRROWPERIOD",	index:'BRROWPERIOD',	width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"PERIODGUBUN",	index:'PERIODGUBUN',	width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"EXPIREDATE",		index:'EXPIREDATE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"PAYRATE",		index:'PAYRATE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"PAYAMT",			index:'PAYAMT',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"PAYBANK",		index:'PAYBANK',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"EXTENDYN",		index:'EXTENDYN',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"EXTENDDATE",		index:'EXTENDDATE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CANCELYN",		index:'CANCELYN',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CANCELDATE",		index:'CANCELDATE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"PAYOWNER",		index:'PAYOWNER',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"JOINYN",			index:'JOINYN',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"REGYN",			index:'REGYN',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"REGDATE",		index:'REGDATE',		width:100,	align:'center',	sortable:false,	hidden:true}
				],
				rowNum:10000000,
				autowidth: true,
				shrinkToFit: false,
				rowList:[10,20,30],
				sortname: 'SALEDATE',
				viewrecords: true,
				sortorder:'desc',
				width: "96%",
				jsonReader: {
					repeatitems: false
				},
				height: '400px',
				onSelectRow: function(ids){
					v_rightLastSel = 0;
					
					$("#S_FLAG_L").val("U");
					
					var selRowData = $(this).jqGrid('getRowData', ids);
					
					//값 채우기 넣기
					$("#SALEDATE").val(selRowData.SALEDATE);
					$("#SALEID").val(selRowData.SALEID);
					$("#SALERCD").val(selRowData.SALERCD);
					$("#BRANCHNAME").val(selRowData.BRANCHCODE);
					$("#MANAGENO").val(selRowData.MANAGENO);
					$("#CITYCODE").val(selRowData.CITYCODE);
					$("#ADDRESS").val(selRowData.ADDRESS);
					$("#OWNERNAME").val(selRowData.OWNERNAME);
					$("#OWNERJUMINID").val(selRowData.OWNERJUMINID);
					$("#CONBM2").val(selRowData.CONBM2);
					$("#CONJM2").val(selRowData.CONJM2);
					$("#CONBPY").val(selRowData.CONBPY);
					$("#CONJPY").val(selRowData.CONJPY);
					$("#CONNAME").val(selRowData.CONNAME);
					$("#CONJUMINID").val(selRowData.CONJUMINID);
					$("#CONADDRESS").val(selRowData.CONADDRESS);
					$("#CONTELNO").val(selRowData.CONTELNO);
					$("#CONM2").val(selRowData.CONM2);
					$("#CONPY").val(selRowData.CONPY);
			
					$("input:radio[name=BRROWTYPE]:input[value=M]").attr("checked", true);
					$("#BRROWAMT").val(selRowData.BRROWAMT);
					$("#BRROWPERIOD").val(selRowData.BRROWPERIOD);
					$("#PERIODGUBUN").val(selRowData.PERIODGUBUN);
					$("#PAYRATE").val(selRowData.PAYRATE);
					$("#PAYAMT").val(selRowData.PAYAMT);
					$("#PAYACCOUNT").val(selRowData.PAYACCOUNT);
					$("#PAYBANK").val(selRowData.PAYBANK);
					$("#PAYOWNER").val(selRowData.PAYOWNER);
					$("#BRROWDATE").val(selRowData.BRROWDATE);
					$("#EXPIREDATE").val(selRowData.EXPIREDATE);
					selRowData.EXTENDYN == "Y" ? $("#EXTENDYN").attr("checked", true) : $("#EXTENDYN").attr("checked", false);
					$("#EXTENDDATE").val(selRowData.EXTENDDATE);
					selRowData.CANCELYN == "Y" ? $("#CANCELYN").attr("checked", true) : $("#CANCELYN").attr("checked", false);
					$("#CANCELDATE").val(selRowData.CANCELDATE);
					$("#REMARK").val(selRowData.REMARK);
					
					f_selectListEnaJointNameTbBDtl(selRowData.SALEID);
					//공동명의 여부
					selRowData.JOINYN == "Y" ? $("#JOINYN").attr("checked", true) : $("#JOINYN").attr("checked", false);
					//등기여부
					$("input:radio[name=REGYN]:input[value=" + selRowData.REGYN + "]").attr("checked", true);
					//등기일자
					$("#REGDATE").val(selRowData.REGDATE);
					
					//콤마 set
					f_commaInputData("click");
				} ,
				loadComplete: function(ids) {
					var saleId = $("#SALEID").val();
					
					var ids = jQuery("#leftList").jqGrid('getDataIDs');
					
					ids.some(function(currentValue, index, array){
						var cellData = $("#leftList").jqGrid('getCell', ids[index], 'SALEID');
						if (cellData == saleId) {
							$("#S_FLAG_L").val("U");
			        		$("#leftList").jqGrid('setSelection', ids[index]);
			    			return true;
			        	} else {
			        		$("#S_FLAG_L").val("I");
			        	}	        
					});
				},
				hidegrid: false
			});
		}
		
		//등기 관리
		function f_selectListEnaJointNameTbBDtl(SALEID){
			$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			$('#bottomList').jqGrid({
				url:"/home/selectListEnaJointNameTbBDtl.do" ,
				datatype:"json" ,
				mtype: 'POST',
				postData : {
					SALEID : SALEID
				},
				loadError:function(){alert("Error~!!");} ,
				colNames:['판매번호', '공동명의 순번', '명의자', '주민번호', '연락처', '점유면적', '점유평수', '등본제출여부', '비고'] ,
				colModel:[
					{name:"SALEID",	index:'SALEID',		width:100,	align:'center', sortable:false, editable:true, hidden:true}
					, {name:"JOINTSEQ",	index:'JOINTSEQ',		width:100,	align:'center', sortable:false, editable:true, hidden:true}
					, {name:"JOINTNAME",	index:'JOINTNAME',		width:100,	align:'center', sortable:false, editable:true}
					, {name:"JOINTJUMINID",	index:'JOINTJUMINID',	width:100,	align:'center', sortable:false, editable:true}
					, {name:"JOINTTELNO",	index:'JOINTTELNO',	width:100,	align:'center', sortable:false, editable:true}
					, {name:"OCCUM2",	index:'OCCUM2',		width:100,	align:'center', sortable:false, editable:true}
					, {name:"OCCUPY",	index:'OCCUPY',		width:100,	align:'center', sortable:false, editable:true}
					, {name:"PAPERREGYN",	index:'PAPERREGYN',		width:100,	align:'center', sortable:false, editable:true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"REMARK",	index:'REMARK',		width:100,	align:'center', sortable:false, editable:true}
				] ,
				rowNum:10000000,
				autowidth: true ,
				shrinkToFit: false,
				rowList:[10,20,30] ,
				sortname: 'JOINTSEQ' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(id){
					if (id > 0) {
						$("#S_FLAG_R").val("U");
					} else {
						$("#S_FLAG_R").val("I");
					}
					
					if( v_rightLastSel != id ){
				        $(this).jqGrid('restoreRow',v_rightLastSel,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
				        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

				        v_rightLastSel = id;
					}
				} ,
				hidegrid: false
			});
		}
		
		function f_clear(dF) {
			if (dF == "Y") $("#SALEDATE").val("");

			$("#SALEID").val("");
			$("#SALERCD").change();
			$("#BRANCHNAME").change();
			$("#MANAGENO").val("");
			$("#CITYCODE").change();
			$("#ADDRESS").val("");
			$("#OWNERNAME").val("");
			$("#OWNERJUMINID").val("");
			$("#CONBM2").val("");
			$("#CONJM2").val("");
			$("#CONBPY").val("");
			$("#CONJPY").val("");
			$("#CONNAME").val("");
			$("#CONJUMINID").val("");
			$("#CONADDRESS").val("");
			$("#CONTELNO").val("");
			$("#CONM2").val("");
			$("#CONPY").val("");
			
			$("input:radio[name=BRROWTYPE]:input[value=M]").attr("checked", true);
			$("#BRROWAMT").val("");
			$("#BRROWPERIOD").val("");
			$("#PERIODGUBUN").change();
			$("#PAYRATE").val("");
			$("#PAYAMT").val("");
			$("#PAYACCOUNT").val("");
			$("#PAYBANK").change();
			$("#PAYOWNER").val("");
			$("#BRROWDATE").val("");
			$("#EXPIREDATE").val("");
			$("#EXTENDYN").attr("checked", false);
			$("#EXTENDDATE").val("");
			$("#CANCELYN").attr("checked", false);
			$("#CANCELDATE").val("");
			$("#REMARK").val("");
			
			$('#bottomList').jqGrid('clearGridData');
		}
		
		$(function() {
			$("#selectButton").click(function(){
				$("#S_FLAG_L").val("U");
				
				f_clear("Y");
				
				f_selectListEnaSaleMstBDtl();
			});
		})
		
		function f_selectButton() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				$("#selectButton").click();
			}
		}
		
		$(function() {
			$("#insertButton").click(function() {
				$("#S_FLAG_L").val("I");
				
				f_clear("Y");
				
				f_selectListEnaSaleMstBDtl();
				
				$("#SALEDATE").focus();
			});
		})
		
		$(function() {
			$("#deleteButton").click(function() {
				if ($("#S_FLAG_L").val() == "I") {
					alert("데이터를 추가 중 일 경우 삭제 할 수 없습니다.");
					
					return false;
				}
				
				if (confirm("삭제하시겠습니까?") == true) {
					$.ajax({ 
						type: 'POST' ,
						data: "SALEID=" + $("#SALEID").val(),
						url: "/home/deleteDataSaleMstBDtl.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							$("#selectButton").click();
						},
						error:function(e){  
							alert("[ERROR]매출관리-소비대차 삭제  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
		
		$(function() {
			$("#saveButton").click(function() {
				if ($("#SALEDATE").val() == "") {
					alert("계약일자를 입력하셔야 합니다.");
					
					$("#SALEDATE").focus();
					return false;
				}

				if ($("#CONNAME").val() == "") {
					alert("차입자 성명을 입력하셔야 합니다.");
					
					$("#CONNAME").focus();
					return false;
				}
				
				if ($("#CONJUMINID").val() == "") {
					alert("차입자 주민번호를 입력하셔야 합니다.");
					
					$("#CONJUMINID").focus();
					return false;
				}
				
				if ($("#CONM2").val() == "") {
					alert("계약면적을 입력하셔야 합니다.");
					
					$("#CONM2").focus();
					return false;
				}
				
				if ($("#CONPY").val() == "") {
					alert("계약평수를 입력하셔야 합니다.");
					
					$("#CONPY").focus();
					return false;
				}
				
				if ($("#BRROWAMT").val() == "") {
					alert("차입대금을 입력하셔야 합니다.");
					
					$("#BRROWAMT").focus();
					return false;
				}
				
				if ($("#BRROWPERIOD").val() == "") {
					alert("차입기간을 입력하셔야 합니다.");
					
					$("#BRROWPERIOD").focus();
					return false;
				}
				
				if ($("#PAYRATE").val() == "") {
					alert("지급이율을 입력하셔야 합니다.");
					
					$("#PAYRATE").focus();
					return false;
				}
				
				if ($("#PAYAMT").val() == "") {
					alert("지급이자를 입력하셔야 합니다.");
					
					$("#PAYAMT").focus();
					return false;
				}
				
				if ($("#PAYACCOUNT").val() == "") {
					alert("지급계좌를 입력하셔야 합니다.");
					
					$("#PAYACCOUNT").focus();
					return false;
				}
				
				if ($("#PAYOWNER").val() == "") {
					alert("계좌주를 입력하셔야 합니다.");
					
					$("#PAYOWNER").focus();
					return false;
				}
				
				if ($("#BRROWDATE").val() == "") {
					alert("차입날짜를  입력하셔야 합니다.");
					
					$("#BRROWDATE").focus();
					return false;
				}
				
				if ($("#EXPIREDATE").val() == "") {
					alert("만기날짜를  입력하셔야 합니다.");
					
					$("#EXPIREDATE").focus();
					return false;
				}
				
				if ($("#EXTENDYN").is(":checked")) {
					if ($("#EXTENDDATE").val() == "") {
						alert("연장날짜를  입력하셔야 합니다.");
						
						$("#EXTENDDATE").focus();
						return false;
					}
				}
				
				if ($("#CANCELYN").is(":checked")) {
					if ($("#CANCELDATE").val() == "") {
						alert("해지날짜를  입력하셔야 합니다.");
						
						$("#CANCELDATE").focus();
						return false;
					}
				}
				
				if ($("#MANAGENO").val() == "") {
					alert("관리번호를 조회하셔야 합니다.");
					
					return false;
				}
				
				var msg = "";
				if ($("#S_FLAG_L").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					$("#MANAGENO").jqxInput({disabled: false});
					$('#SALEID').jqxInput({disabled: false });
					
					//콤마 remove
					f_commaInputData("remove");

					$.ajax({ 
						type: 'POST' ,
						data: $("#SA011002").serialize(),
						url: "/home/insertDataSaleMstBDtl.do", 
						dataType : 'json' , 
						success: function(data){
							$('#SALEID').jqxInput({disabled: true });
							$("#MANAGENO").jqxInput({disabled: true});
							alert(data.resultMsg);
							
							if (data.resultCode == "SUCCESS") {
								$("#SALEID").val(data.SALEID);
								f_selectListEnaSaleMstBDtl();
							} else {
								$("#SALEDATE").focus();
							}
						},
						error:function(e){
							alert("[ERROR]매출관리 저장  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
		
		function f_saveButton() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				if (auth_i == true) {
					$("#saveButton").click();
				}
			}
		}
		
		$(function() {
			$("#searchPopButton").click(function() {
				var saleDate = $("#SALEDATE").val();
				
				if (saleDate == "") {
					alert("계약일자를 입력하셔야 합니다.");
					
					$("#SALEDATE").focus();
					return false;
				}
				
				//팝업
				var popUrl = "/home/SA011002_searchPopup.do";	//팝업창에 출력될 페이지 UR
				var popOption = "width=1200, height=540, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"매출관리-소비대차",popOption);
			});
		})
		
		$(function() {
			$("#searchManageNoPopButton").click(function() {
				if ($("#S_FLAG_L").val() != "I") {
					alert("추가 시에만 검색할 수 있습니다.");
					
					return false;
				}
				
				//팝업
				var popUrl = "/home/SA011002_searchManagePopup.do";	//팝업창에 출력될 페이지 UR
				var popOption = "width=1200, height=540, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"매출관리-소비대차",popOption);
			});
		})
		
		$(function() {
			$("#tab1InsertButton").click(function() {
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				if (ids == null || ids == "") {
					alert("선택된 매출정보가 없습니다.");
					
					return false;
				}
				
				$("#S_FLAG_R").val("I");
				
				$("#bottomList").jqGrid("addRow", 0);
			});
		})
		
		$(function() {
			$("#tab1DeleteButton").click(function() {
				if ($("#S_FLAG_R").val() == "I") {
					alert("추가 시 일 경우 삭제할 수 없습니다.");
					
					return false;
				}
				
				if (v_rightLastSel == 0 || v_rightLastSel == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				$('#bottomList').jqGrid('saveRow',v_rightLastSel,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#bottomList").jqGrid('getRowData', v_rightLastSel); //셀 전체 데이터 가져오기

				if (confirm("삭제하시겠습니까?") == true) {
					$.ajax({ 
						type: 'POST' ,
						data: "SALEID=" + cellData.SALEID + "&JOINTSEQ=" + cellData.JOINTSEQ,
						url: "/home/deleteDataEnaJointNameTbBDtl.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							v_rightLastSel = 0;
							
							f_selectListEnaJointNameTbBDtl($("#SALEID").val());
						},
						error:function(e){  
							alert("[ERROR]등기 관리 삭제  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel = 0;
					f_selectListEnaJointNameTbBDtl($("#SALEID").val());
				}
			});
		})
		
		$(function() {
			$("#tab1SaveButton").click(function() {
				if ($("#SALEID").val() == "") {
					alert("선택된 매출정보가 없습니다.");
					
					return false;
				}
				
				var gridAddFlag = "";
				
				if (v_rightLastSel == 0 || v_rightLastSel == "") {
					//그리드에 데이터 추가 없이 저장
					 gridAddFlag = "N";
					
				} else {
					//그리드에 데이터 추가 후 저장
					gridAddFlag = "Y";
					
					var ids = $("#bottomList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
					 
					$('#bottomList').jqGrid('saveRow',v_rightLastSel,false,'clientArray'); //선택된 놈 뷰 모드로 변경

					var cellData = $("#bottomList").jqGrid('getRowData', v_rightLastSel); //셀 전체 데이터 가져오기
					
					if (cellData.JOINTNAME == "") {
						alert("명의자를 입력하셔야 합니다.");
						
						$('#bottomList').jqGrid('editRow', v_rightLastSel, true);
						$("#"+ids+"_JOINTNAME").focus();
						
						return false;
					}
					
					if (cellData.JOINTJUMINID == "") {
						alert("주민번호를 입력하셔야 합니다.");
						
						$('#bottomList').jqGrid('editRow', v_rightLastSel, true);
						$("#"+ids+"_JOINTJUMINID").focus();
						
						return false;
					}
					
					if (cellData.OCCUM2 == "") {
						alert("점유면적을 입력하셔야 합니다.");
						
						$('#bottomList').jqGrid('editRow', v_rightLastSel, true);
						$("#"+ids+"_OCCUM2").focus();
						
						return false;
					}
					
					if (cellData.OCCUPY == "") {
						alert("점유평수를 입력하셔야 합니다.");
						
						$('#bottomList').jqGrid('editRow', v_rightLastSel, true);
						$("#"+ids+"_OCCUPY").focus();
						
						return false;
					}
				}
				
				var joinYn = $('#JOINYN').is(':checked') ? "Y" : "N";
				
				var msg = "";
				if ($("#S_FLAG_R").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					var formData = "S_FLAG_R=" + $("#S_FLAG_R").val() + 
					"&SALEID=" + $("#SALEID").val() +
					"&JOINYN=" + joinYn +
					"&REGYN=" + $("input:radio[name=REGYN]:checked").val() +
					"&REGDATE=" + $("#REGDATE").val();
					
					if (gridAddFlag == "N") {	//그리드 선택이 안되었을 경우 처리
						formData += "&JOINTNAME=";
					} else if (gridAddFlag == "Y") {	//그리드 선택되었을 경우만 처리
						formData += "&JOINTNAME=" + cellData.JOINTNAME +
						"&JOINTSEQ=" + cellData.JOINTSEQ + 
						"&JOINTJUMINID=" + cellData.JOINTJUMINID + 
						"&JOINTTELNO=" + cellData.JOINTTELNO + 
						"&OCCUM2=" + cellData.OCCUM2 + 
						"&OCCUPY=" + cellData.OCCUPY +
						"&PAPERREGYN=" + cellData.PAPERREGYN +
						"&REMARK=" + cellData.REMARK;
					}
					
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/insertDataEnaJointNameTbBDtl.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG_R").val("I");
							
							v_rightLastSel = 0;
							
							alert(data.resultMsg);
							
							f_selectListEnaSaleMstBDtl();
							f_selectListEnaJointNameTbBDtl($("#SALEID").val());
						},
						error:function(e){  
							alert("[ERROR-script]등기 관리 저장  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel = 0;
					f_selectListEnaSaleMstBDtl();
					f_selectListEnaJointNameTbBDtl($("#SALEID").val());
				}
			});
		})
		
		$(function() {
			inputComma("CONBM2");
			inputComma("CONJM2");
			inputComma("CONBPY");
			inputComma("CONJPY");
			inputComma("CONM2");
			inputComma("CONPY");
			inputComma("BRROWAMT");
			inputComma("PAYAMT");
		})
		
		function f_commaInputData(str) {
			if (str == "click") {
				$("#CONBM2").click();
				$("#CONJM2").click();
				$("#CONBPY").click();
				$("#CONJPY").click();
				$("#CONM2").click();
				$("#CONPY").click();
				$("#BRROWAMT").click();
				$("#PAYAMT").click();
			} else if (str == "remove") {
				$("#CONBM2").val(removeComma($("#CONBM2").val()));
				$("#CONJM2").val(removeComma($("#CONJM2").val()));
				$("#CONBPY").val(removeComma($("#CONBPY").val()));
				$("#CONJPY").val(removeComma($("#CONJPY").val()));
				$("#CONM2").val(removeComma($("#CONM2").val()));
				$("#CONPY").val(removeComma($("#CONPY").val()));
				$("#BRROWAMT").val(removeComma($("#BRROWAMT").val()));
				$("#PAYAMT").val(removeComma($("#PAYAMT").val()));
			}
			
		}
	</script>
</head>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id='selectButton' /></td>
					<td><input type="button" value="추가" id='insertButton' /></td>
					<td><input type="button" value="삭제" id='deleteButton' /></td>
					<td><input type="button" value="저장" id='saveButton' /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:38%; float:left; padding: 10px" align="left">
			<table >
				<tr>
					<th width="120">차입기간</th>
					<td><input type="text" id="SL_BRROWDATE_FR" name="SL_BRROWDATE_FR" /> ~ <input type="text" id="SL_BRROWDATE_TO" name="SL_BRROWDATE_TO" /></td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td>
						<select id="SL_SALERNAME" name="SL_SALERNAME">
							<option value="ALL" selected="selected">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">지번(주소)</th>
					<td><input type="text" id="SL_CONADDRESS" name="SL_CONADDRESS" onkeydown="f_selectButton();" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:58%; float:left; padding: 10px" align="left">
			<form id="SA011002">
			<input type="hidden" id="S_FLAG_L" name="S_FLAG_L" />
			<input type="hidden" id="SALEGUBUN" name="SALEGUBUN" value="003"/>
			<table width="98%">
				<tr>
					<th width="120">* 계약일자/번호</th>
					<td colspan="2"><input type="text" id="SALEDATE" name="SALEDATE" /><input type="text" id="SALEID" name="SALEID" /></td>
					<td colspan="2"><input type="button" id="searchPopButton"/></td>
				</tr>
				<tr>
					<th width="120">* 담당자</th>
					<td colspan="2">
						<select id="SALERCD" name="SALERCD">
						</select>
					</td>
					<th width="120">계약지사</th>
					<td>
						<select id="BRANCHNAME" name="BRANCHNAME">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">관리번호</th>
					<td><input type="text" id="MANAGENO" name="MANAGENO" /></td>
					<td width="30"><input type="button" id="searchManageNoPopButton"/></td>
					<th width="120">시/도 구분</th>
					<td>
						<select id="CITYCODE" name="CITYCODE">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">주소</th>
					<td colspan="4"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
				</tr>
				<tr>
					<th width="120">분양/잔여면적</th>
					<td colspan="2"><input type="text" id="CONBM2" name="CONBM2" /> / <input type="text" id="CONJM2" name="CONJM2" /></td>
					<th width="120">분양/잔여평수</th>
					<td><input type="text" id="CONBPY" name="CONBPY" /> / <input type="text" id="CONJPY" name="CONJPY" /></td>
				</tr>
				<tr>
					<th width="120">차입자 성명</th>
					<td colspan="2"><input type="text" id="CONNAME" name="CONNAME" /></td>
					<th width="120">차입자주민번호</th>
					<td><input type="text" id="CONJUMINID" name="CONJUMINID" /></td>
				</tr>
				<tr>
					<th width="120">차입자 연락처</th>
					<td colspan="4"><input type="text" id="CONTELNO" name="CONTELNO" /></td>
				</tr>
				<tr>
					<th width="120">차입자 주소</th>
					<td colspan="4"><input type="text" id="CONADDRESS" name="CONADDRESS" /></td>
				</tr>
				<tr>
					<th width="120">계약면적</th>
					<td colspan="2"><input type="text" id="CONM2" name="CONM2" /></td>
					<th width="120">계약평수</th>
					<td><input type="text" id="CONPY" name="CONPY" /></td>
				</tr>
				<tr>
					<th width="120">차입형식</th>
					<td colspan="4"><input type="radio" id="BRROWTYPE" name="BRROWTYPE" value="M"/> 월지급     <input type="radio" id="BRROWTYPE" name="BRROWTYPE"  value="Y"/> 년지급    </td>
				</tr>
				<tr>
					<th width="120">차입대금</th>
					<td colspan="2"><input type="text" id="BRROWAMT" name="BRROWAMT" /></td>
					<th width="120">차입기간</th>
					<td>
						<input type="text" id="BRROWPERIOD" name="BRROWPERIOD" /> 
						<select id="PERIODGUBUN" name="PERIODGUBUN">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">지급이율</th>
					<td colspan="2"><input type="text" id="PAYRATE" name="PAYRATE" /> % </td>
					<th width="120">지급이자</th>
					<td><input type="text" id="PAYAMT" name="PAYAMT" /></td>
				</tr>
				<tr>
					<th width="120">지급계좌</th>
					<td colspan="2"><input type="text" id="PAYACCOUNT" name="PAYACCOUNT" /></td>
					<th width="120">지급은행</th>
					<td>
						<select id="PAYBANK" name="PAYBANK">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">계좌주</th>
					<td colspan="4"><input type="text" id="PAYOWNER" name="PAYOWNER" /></td>
				</tr>
				<tr>
					<th width="120">차입날짜</th>
					<td colspan="2"><input type="text" id="BRROWDATE" name="BRROWDATE" /></td>
					<th width="120">만기날짜</th>
					<td><input type="text" id="EXPIREDATE" name="EXPIREDATE" /></td>
				</tr>
				<tr>
					<th width="120">만기연장</th>
					<td colspan="2"><input type="checkbox" id="EXTENDYN" name="EXTENDYN" /></td>
					<th width="120">연장날짜</th>
					<td><input type="text" id="EXTENDDATE" name="EXTENDDATE" /></td>
				</tr>
				<tr>
					<th width="120">중도해지</th>
					<td colspan="2"><input type="checkbox" id="CANCELYN" name="CANCELYN" /></td>
					<th width="120">해지날짜</th>
					<td><input type="text" id="CANCELDATE" name="CANCELDATE" /></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="4"><input type="text" id="REMARK" name="REMARK" onkeydown="f_saveButton();"/></td>
				</tr>
			</table>
			</form>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; padding: 10px" align="left">
			<input type="hidden" id="S_FLAG_R" name="S_FLAG_R" />
			<table  width="100%">
				<tr>
					<td width="60%" align="left">
						<table width="98%">
							<tr>
								<th width="120">공동명의 여부</th>
								<td colspan="4"><input type="checkbox" id="JOINYN" name="JOINYN" /></td>
							</tr>
							<tr>
								<th width="120">등기여부</th>
								<td><input type="radio" id="REGYN" name="REGYN" value="Y"/> 등기완료  <input type="radio" id="REGYN" name="REGYN" value="N"/> 미등기</td>
								<th width="120">등기일자</th>
								<td><input type="text" id="REGDATE" name="REGDATE" /></td>
							</tr>
						</table>
					</td>
					<td width="40%" align="right">
						<table align="right">
							<tr>
								<td><input type="button" value="추가" id='tab1InsertButton' /></td>
								<td><input type="button" value="삭제" id='tab1DeleteButton' /></td>
								<td><input type="button" value="저장" id='tab1SaveButton' /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table id="bottomList"></table>
		</div>
	</div>	
</body>
</html>