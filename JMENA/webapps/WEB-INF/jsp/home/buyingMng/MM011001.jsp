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
		var v_rightLastSel_1 = 0;		//오른쪽 그리드 선택 tab1
		var v_rightLastSel_2 = 0;		//오른쪽 그리드 선택 tab2
	
		$(document).ready(function(){
			$("#S_FLAG_L").val("I");
			
			var dt = new Date();

			// Display the month, day, and year. getMonth() returns a 0-based number.
			var month = dt.getMonth()+1;
			var day = dt.getDate();
			var year = dt.getFullYear();
			var today = year + "-" + month + "-" + day;
			
			$("#LS_BUYDATE_FR").val(year + "-01-01");
			$("#LS_BUYDATE_TO").val(today);
			
			$('#contents').jqxSplitter({ theme: 'bootstrap', width: 1330, height: 800,  orientation: 'horizontal', resizable: false, splitBarSize: 0, showSplitBar: false, panels: [{ size: 40, collapsible: false }] });
			$('#middleLayout').jqxSplitter({ theme: 'bootstrap',orientation: 'vertical', resizable: false, splitBarSize: 0, showSplitBar: false, panels: [{ size: 632, collapsible: false}] });  
			$('#bottomDiv').jqxSplitter({ theme: 'bootstrap', width: 990, height: 650, orientation: 'horizontal', resizable: false, splitBarSize: 0, showSplitBar: false, panels: [{ size: 400, collapsible: false}] });  
			
			$('#bottomTabs').jqxTabs({theme: 'bootstrap', autoHeight: false, width: 680});
			
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#insertButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#deleteButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#saveButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			
			$("#searchButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
			
			$("#tab1InsertButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#tab1DeleteButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#tab1SaveButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			
			$("#tab2InsertButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#tab2DeleteButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			$("#tab2SaveButton").jqxButton({ theme: 'energyblue', width: 100, height: 25 });
			
			$("#LS_BUYDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#LS_BUYDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#LS_ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			
			$("#BUYDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#BUYID").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1, disabled: true});
			$("#MANAGENO").jqxInput({theme: 'energyblue', height: 25, width: 200, minLength: 1});
			$("#ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 500, minLength: 1});
			$("#OWNERNAME").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#OWNERJUMINID").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		
			$("#BUYM2").jqxInput({theme: 'energyblue', height: 23, width: 50});
			$("#BUYPY").jqxInput({theme: 'energyblue', height: 23, width: 50});
			$("#BUNYM2").jqxInput({theme: 'energyblue', height: 23, width: 50});
			$("#BUNJANM2").jqxInput({theme: 'energyblue', height: 23, width: 50});
			$("#BUNYPY").jqxInput({theme: 'energyblue', height: 23, width: 50});
			$("#BUNJANPY").jqxInput({theme: 'energyblue', height: 23, width: 50});
			$("#BUYAMT").jqxInput({theme: 'energyblue', height: 23, width: 50});
			$("#BUYDANGA").jqxInput({theme: 'energyblue', height: 23, width: 50});
			
			$("#REGDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#REMARK").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
	
			$("#PAYTOTAL").jqxInput({theme: 'energyblue', height: 25, width: 200, minLength: 1, disabled: true});
	
			f_selectListEnaBuyMst();
			f_selectListEnaPayScheduleTb();
			f_selectListEnaSalesOpenTb();
	
			//공통코드 가져오기
			f_selectListEnaBuyGubnCode();	//매입구분
			f_selectListEnaCityCode();		//시/도코드
			f_selectListEnaBoroughCode();	//구/군코드
			f_selectListEnaUseTypeCode(); 	//지목
			//공통코드 가져오기 끝
			
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
						inHtml += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
					});
					$("#BUYGUBUN").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
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
			var CITYCODE = $("#CITYCODE").val();
			$("#BOROUGHCODE").empty().data('options');
	
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
					$("#BOROUGHCODE").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		function f_selectListEnaUseTypeCode(){
			var CCODE = "006";	//지목
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
					$("#USETYPE").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		function f_selectListEnaBuyMst(){
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				//caption: '매입관리'
				url:"/home/selectListEnaBuyMst.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					LS_BUYDATE_FR : $("#LS_BUYDATE_FR").val(),
					LS_BUYDATE_TO : $("#LS_BUYDATE_TO").val(),
					//LS_INSERTUSER : LS_INSERTUSER,
					LS_ADDRESS : $("#LS_ADDRESS").val()
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['매입번호', '매입일자', '매입구분', '관리번호', '지역코드',
				          '지역구분', '시/도코드', '시/도구분',  '지목', '주소',
				          '원지주 성명', '주민번호', '계약면적', '계약평수', '잔여면적',
				          '잔여평수', '매매대금', '매매단가', '등기여부', '등기일자',
				          '비고'],
				colModel:[
					{name:"BUYID",				index:'BUYID',			width:100,	align:'center', sortable:false, hidden:true}
					, {name:"BUYDATE",			index:'BUYDATE',		width:100,	align:'center', sortable:false}
					, {name:"BUYGUBUN",			index:'BUYGUBUN',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"MANAGENO",			index:'MANAGENO',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"CITYCODE",			index:'CITYCODE',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"CITYNAME",			index:'CITYNAME',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"BOROUGHCODE",		index:'BOROUGHCODE',	width:100,	align:'center', sortable:false, hidden:true}
					, {name:"BOROUGHNAME",		index:'BOROUGHNAME',	width:100,	align:'center', sortable:false, hidden:true}
					, {name:"USETYPE",			index:'USETYPE',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"ADDRESS",			index:'ADDRESS',		width:100,	align:'center', sortable:false}
					, {name:"OWNERNAME",		index:'OWNERNAME',		width:100,	align:'center', sortable:false}
					, {name:"OWNERJUMINID",		index:'OWNERJUMINID',	width:100,	align:'center', sortable:false, hidden:true}
					, {name:"BUYM2",			index:'BUYM2',			width:100,	align:'center', sortable:false}
					, {name:"BUYPY",			index:'BUYPY',			width:100,	align:'center', sortable:false}
					, {name:"BUNJANM2",			index:'BUNJANM2',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"BUNJANPY",			index:'BUNJANPY',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"BUYAMT",			index:'BUYAMT',			width:100,	align:'center', sortable:false}
					, {name:"BUYDANGA",			index:'BUYDANGA',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"REGYN",			index:'REGYN',			width:100,	align:'center', sortable:false, hidden:true}
					, {name:"REGDATE",			index:'REGDATE',		width:100,	align:'center', sortable:false, hidden:true}
					, {name:"REMARK",			index:'REMARK',			width:100,	align:'center', sortable:false, hidden:true}
					
				],
				rowNum:1000,
				autowidth: true,
				shrinkToFit: false,
				rowList:[10,20,30],
				sortname: 'BUYDATE',
				viewrecords: true,
				sortorder:'asc',
				width: "96%",
				jsonReader: {
					repeatitems: false
				},
				height: '500px',
				onSelectRow: function(ids){
					v_rightLastSel_1 = 0;
					v_rightLastSel_2 = 0;
					
					$("#S_FLAG_L").val("U");
					
					var selRowData = $(this).jqGrid('getRowData', ids);
					$("#BUYDATE").val(selRowData.BUYDATE);
					$("#BUYID").val(selRowData.BUYID);
					$("#BUYGUBUN").val(selRowData.BUYGUBUN);
					$("#MANAGENO").val(selRowData.MANAGENO);
					$("#CITYCODE").val(selRowData.CITYCODE);
					$("#BOROUGHCODE").val(selRowData.BOROUGHCODE);
					$("#USETYPE").val(selRowData.USETYPE);
					$("#ADDRESS").val(selRowData.ADDRESS);
					$("#OWNERNAME").val(selRowData.OWNERNAME);
					$("#OWNERJUMINID").val(selRowData.OWNERJUMINID);
					$("#BUYM2").val(selRowData.BUYM2);
					$("#BUYPY").val(selRowData.BUYPY);
					$("#BUNYM2").val(selRowData.BUNYM2);
					$("#BUNJANM2").val(selRowData.BUNJANM2);
					$("#BUNYPY").val(selRowData.BUNYPY);
					$("#BUNJANPY").val(selRowData.BUNJANPY);
					$("#BUYAMT").val(selRowData.BUYAMT);
					$("#BUYDANGA").val(selRowData.BUYDANGA);
					$("input:radio[name=REGYN]:input[value=" + selRowData.REGYN + "]").attr("checked", true);
					$("#REGDATE").val(selRowData.REGDATE);
					$("#REMARK").val(selRowData.REMARK);
					
					if (selRowData.BUYGUBUN == "001") {	//일반
						$("#mm_div1").text("매매대금");
						$("#mm_div2").text("매매단가");
						
						//일반일 경우만 지급 스케줄 관리 사용
						$("#tab1InsertButton").jqxButton({disabled: false});
						$("#tab1DeleteButton").jqxButton({disabled: false});
						$("#tab1SaveButton").jqxButton({disabled: false});
					} else { //위탁
						$("#mm_div1").text("위탁수수료");
						$("#mm_div2").text("수수료단가");
						
						//위탁일 경우만 지급 스케줄 관리 미 사용
						$("#tab1InsertButton").jqxButton({disabled: true});
						$("#tab1DeleteButton").jqxButton({disabled: true});
						$("#tab1SaveButton").jqxButton({disabled: true});
					}
					f_selectListEnaPayScheduleTb(selRowData.BUYID);
					f_selectListEnaSalesOpenTb(selRowData.BUYID);
	
					f_selectListEnaBoroughCode();
				} ,
				loadComplete: function(ids) {
					var buyId = $("#BUYID").val();
					
					var ids = jQuery("#leftList").jqGrid('getDataIDs');
					
					ids.some(function(currentValue, index, array){
						var cellData = $("#leftList").jqGrid('getCell', ids[index], 'BUYID');
						if (cellData == buyId) {
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
		
		function f_selectListEnaPayScheduleTb(BUYID){
			$('#rightList1').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			$('#rightList1').jqGrid({
				//caption: '매입관리'
				url:"/home/selectListEnaPayScheduleTb.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					BUYID : BUYID
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['구매번호', '지급순번', '지급구분', '지급일자', '지급금액', '지급여부', '비고'],
				colModel:[
					{name:"BUYID",	index:'BUYID',		width:100,	align:'center', sortable:false, editable:true, hidden: true}
					, {name:"BUYSEQ",	index:'BUYSEQ',		width:100,	align:'center', sortable:false, editable:true, hidden: true}
					, {name:"PAYGUBUN",	index:'PAYGUBUN',	width:100,	align:'center', sortable:false, editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=005", buildSelect:f_selectListEnaPayGubunCode} }
					, {name:"PAYDATE",	index:'PAYDATE',	width:100,	align:'center', sortable:false, editable:true}
					, {name:"PAYAMT",	index:'PAYAMT',		width:100,	align:'center', sortable:false, editable:true}
					, {name:"PAYYN",	index:'PAYYN',		width:100,	align:'center', sortable:false, editable: true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"REMARK",	index:'REMARK',		width:100,	align:'center', sortable:false, editable:true}
				],
				rowNum:1000,
				autowidth: true,
				shrinkToFit: false,
				rowList:[10,20,30],
				sortname: 'PAYDATE',
				viewrecords: true,
				sortorder:'desc',
				width: "96%",
				jsonReader: {
					repeatitems: false
				},
				onSelectRow : function(id) {
					if (id > 0) {
						$("#S_FLAG_R_1").val("U");
					} else {
						$("#S_FLAG_R_1").val("I");
					}
					
					if( v_rightLastSel_1 != id ){
				        $(this).jqGrid('restoreRow',v_rightLastSel_1,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
				        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

				        v_rightLastSel_1 = id;
					}
				},
				loadComplete: function() {
					var tot = 0;
					
					var ids = $(this).jqGrid('getDataIDs');
					
					ids.some(function(currentValue, index, array){
						var payYn = $("#rightList1").jqGrid('getCell', ids[index], 'PAYYN');
						
						if (payYn == "Y") {
							tot += eval($("#rightList1").jqGrid('getCell', ids[index], 'PAYAMT'));
			        	}        
					});
					
					$("#PAYTOTAL").val(tot);
				},
				hidegrid: false
			});
		}
		
		function f_selectListEnaPayGubunCode(data){
			var jsonValue = $.parseJSON(data).dcodeList;
			
			var result = "<select>";
			
			jsonValue.some(function(currentValue, index, array){
				result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
			});
			
			result +="</select>";
			return result;
					
		}
		
		function f_selectListEnaSalesOpenTb(BUYID){
			$('#rightList2').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			$('#rightList2').jqGrid({
				//caption: '매입관리'
				url:"/home/selectListEnaSalesOpenTb.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					BUYID : BUYID
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['구매번호', '지사', '오픈여부', '홀딩여부', '홀딩면적', '홀딩평수', '홀딩일자', '비고'],
				colModel:[
					{name:"BUYID",	index:'BUYID',		width:100,	align:'center', sortable:false, editable:true, hidden: true}
					, {name:"BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center', sortable:false, editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaBranchCode}}
					, {name:"OPENYN",		index:'OPENYN',			width:100,	align:'center', sortable:false, editable: true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"HOLDINGYN",	index:'HOLDINGYN',		width:100,	align:'center', sortable:false, editable: true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"HOLDINGM2",	index:'HOLDINGM2',		width:100,	align:'center', sortable:false, editable:true}
					, {name:"HOLDINGPY",	index:'HOLDINGPY',		width:100,	align:'center', sortable:false, editable:true}
					, {name:"HOLDINGDATE",	index:'HOLDINGDATE',	width:100,	align:'center', sortable:false, editable:true}
					, {name:"REMARK",		index:'REMARK',			width:100,	align:'center', sortable:false, editable:true}
				],
				rowNum:100,
				autowidth: true,
				shrinkToFit: false,
				rowList:[10,20,30],
				sortname: 'branchCode',
				viewrecords: true,
				sortorder:'asc',
				width: "96%",
				jsonReader: {
					repeatitems: false
				},
				//height: '100%',
				onSelectRow: function(id){
					if (id > 0) {
						$("#S_FLAG_R_2").val("U");
					} else {
						$("#S_FLAG_R_2").val("I");
					}
					
					if( v_rightLastSel_2 != id ){
				        $(this).jqGrid('restoreRow',v_rightLastSel_2,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
				        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

				        v_rightLastSel_2 = id;
					}
				},
				hidegrid: false
			});
		}
		
		function f_selectListEnaBranchCode(data){
			var jsonValue = $.parseJSON(data).branchMstList;
			
			var result = "<select>";
			
			jsonValue.some(function(currentValue, index, array){
				result += "<option value='" + currentValue.BRANCHCODE + "'>" + currentValue.BRANCHNAME + "</option>\n";
			});
			
			result +="</select>";
			return result;
		}
		
		function f_clear(dF) {
			if (dF == "Y") $("#BUYDATE").val("");
			$("#BUYID").val("");
			$("#BUYGUBUN").val("");
			$("#MANAGENO").val("");
			$("#CITYCODE").val("");
			$("#CITYCODE").change();
			$("#BOROUGHCODE").val("");
			$("#USETYPE").val("");
			$("#ADDRESS").val("");
			$("#OWNERNAME").val("");
			$("#OWNERJUMINID").val("");
			$("#BUYM2").val("");
			$("#BUYPY").val("");
			$("#BUNYM2").val("");
			$("#BUNJANM2").val("");
			$("#BUNYPY").val("");
			$("#BUNJANPY").val("");
			$("#BUYAMT").val("");
			$("#BUYDANGA").val("");
			$("input:radio[name=REGYN]:input[value=Y]").attr("checked", true);
			$("#REGDATE").val("");
			$("#REMARK").val("");
			
			$('#rightList1').jqGrid('clearGridData');
			$('#rightList2').jqGrid('clearGridData');
		}
		
		$(function() {
			$("#selectButton").click(function(){
				$("#S_FLAG_L").val("U");
				
				f_clear("Y");
				
				f_selectListEnaBuyMst();
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
				
				f_selectListEnaBuyMst();
				
				$("#BUYDATE").focus();
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
						data: "BUYID=" + $("#BUYID").val(),
						url: "/home/deleteDataBuyMst.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							$("#selectButton").click();
						},
						error:function(e){  
							alert("[ERROR]선택 매입 데이터 삭제  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
		
		$(function() {
			$("#saveButton").click(function() {
				if ($("#BUYDATE").val() == "") {
					alert("계약일자를 입력하셔야 합니다.");
					
					$("#BUYDATE").focus();
					return false;
				}

				if ($("#ADDRESS").val() == "") {
					alert("주소를 입력하셔야 합니다.");
					
					$("#ADDRESS").focus();
					return false;
				}
				
				if ($("#OWNERNAME").val() == "") {
					alert("원지주 성명을 입력하셔야 합니다.");
					
					$("#OWNERNAME").focus();
					return false;
				}
				
				if ($("#OWNERJUMINID").val() == "") {
					alert("주민번호를 입력하셔야 합니다.");
					
					$("#OWNERJUMINID").focus();
					return false;
				}
				
				if ($("#BUYM2").val() == "") {
					alert("계약면적을 입력하셔야 합니다.");
					$('#BUYM2').focus();
					return false;
				}
				
				if ($("#BUYPY").val() == "") {
					alert("계약면적을 입력하셔야 합니다.");
					
					$("#BUYPY").focus();
					return false;
				}
				
				if ($("#BUYAMT").val() == "") {
					alert("매매대금을 입력하셔야 합니다.");
					
					$("#BUYAMT").focus();
					return false;
				}
				
				if ($("#BUYDANGA").val() == "") {
					alert("매매단가를 입력하셔야 합니다.");
					
					$("#BUYDANGA").focus();
					return false;
				}
				
				var msg = "";
				if ($("#S_FLAG_L").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					$('#BUYID').jqxInput({disabled: false });
					
					$.ajax({ 
						type: 'POST' ,
						data: $("#MM011001").serialize(),
						url: "/home/insertDataBuyMst.do", 
						dataType : 'json' , 
						success: function(data){
							$('#BUYID').jqxInput({disabled: true });
							alert(data.resultMsg);
							
							if (data.resultCode == "SUCCESS") {
								f_selectListEnaBuyMst();
							} else {
								$("#BUYDATE").focus();
							}
						},
						error:function(e){  
							alert("[ERROR]매입관리 저장  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
		
		$(function() {
			$("#searchButton").click(function() {
				var buyDate = $("#BUYDATE").val();
				
				if (buyDate == "") {
					alert("계약일자를 입력하셔야 합니다.");
					
					$("#BUYDATE").focus();
					return false;
				}
				
				var buyDate = $("#BUYDATE").val();
				$("#LS_BUYDATE_FR").val(buyDate);
				$("#LS_BUYDATE_TO").val(buyDate);
				
				f_selectListEnaBuyMst();
			});
		})
		
		function f_getBuyId() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) {
				var buyDate = $("#BUYDATE").val();
				
				if (buyDate == "") {
					alert("계약일자를 입력하셔야 합니다.");
					
					$("#BUYDATE").focus();
					return false;
				}
				
				f_clear("N");
				
				f_selectListEnaBuyMst();
				
				$("#MANAGENO").focus();
			}
		}
		
		$(function() {
			$('#bottomTabs').on('tabclick', function (event) { 
				$("#rightList1").trigger("reloadGrid");
				$("#rightList2").trigger("reloadGrid");
			}); 
		}) 
		
		$(function() {
			$("#tab1InsertButton").click(function() {
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				if (ids == null || ids == "") {
					alert("선택된 매입정보가 없습니다.");
					
					return false;
				}
				
				$("#S_FLAG_R_1").val("I");
				
				$("#rightList1").jqGrid("addRow", 0);
			});
		})
		
		$(function() {
			$("#tab1DeleteButton").click(function() {
				if ($("#S_FLAG_R_1").val() == "I") {
					alert("추가 시 일 경우 삭제할 수 없습니다.");
					
					return false;
				}
				
				if (v_rightLastSel_1 == 0 || v_rightLastSel_1 == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				$('#rightList1').jqGrid('saveRow',v_rightLastSel_1,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#rightList1").jqGrid('getRowData', v_rightLastSel_1); //셀 전체 데이터 가져오기

				if (confirm("삭제하시겠습니까?") == true) {
					$.ajax({ 
						type: 'POST' ,
						data: "BUYID=" + cellData.BUYID + "&BUYSEQ=" + cellData.BUYSEQ,
						url: "/home/deleteDataPayScheduleTb.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							v_rightLastSel_1 = 0;
							
							f_selectListEnaPayScheduleTb(cellData.BUYID);
						},
						error:function(e){  
							alert("[ERROR]지급스케줄관리 삭제  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_1 = 0;
					f_selectListEnaPayScheduleTb(cellData.BUYID);
				}
			});
		})
		
		$(function() {
			$("#tab1SaveButton").click(function() {
				var payGubun =  $("#rightList1 [name=PAYGUBUN] option:selected").val();

				$('#rightList1').jqGrid('saveRow',v_rightLastSel_1,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#rightList1").jqGrid('getRowData', v_rightLastSel_1); //셀 전체 데이터 가져오기
				
				if (v_rightLastSel_1 == 0 || v_rightLastSel_1 == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				if (cellData.PAYDATE == "") {
					alert("지급일을 입력하셔야 합니다.");
					
					$('#rightList1').jqGrid('editRow', v_rightLastSel_1, true);
					$("#"+ids+"_PAYDATE").focus();
					
					return false;
				}
				
				if (cellData.PAYAMT == "") {
					alert("지급금액를 입력하셔야 합니다.");
					
					$('#rightList1').jqGrid('editRow', v_rightLastSel_1, true);
					$("#"+ids+"_PAYAMT").focus();
					
					return false;
				}
				
				var msg = "";
				if ($("#S_FLAG_R_1").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					var formData = "S_FLAG_R_1=" + $("#S_FLAG_R_1").val() + 
					"&BUYID=" + $("#BUYID").val() + 
					"&BUYSEQ=" + cellData.BUYSEQ + 
					"&PAYGUBUN=" + payGubun + 
					"&PAYDATE=" + cellData.PAYDATE + 
					"&PAYAMT=" + cellData.PAYAMT + 
					"&PAYYN=" + cellData.PAYYN + 
					"&REMARK=" + cellData.REMARK;
					
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/insertDataPayScheduleTb.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG_R_1").val("U");
							
							v_rightLastSel_1 = 0;
							
							alert(data.resultMsg);
							
							f_selectListEnaPayScheduleTb($("#BUYID").val());
						},
						error:function(e){  
							alert("[ERROR]지급 스케줄 관리 저장  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_1 = 0;
					f_selectListEnaPayScheduleTb($("#BUYID").val());
				}
			});
		})
		
		$(function() {
			$("#tab2InsertButton").click(function() {
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				if (ids == null || ids == "") {
					alert("선택된 매입정보가 없습니다.");
					
					return false;
				}
				
				$("#S_FLAG_R_2").val("I");
				
				$("#rightList2").jqGrid("addRow", 0);
			});
		})
		
		$(function() {
			$("#tab2DeleteButton").click(function() {
				if ($("#S_FLAG_R_2").val() == "I") {
					alert("추가 시 일 경우 삭제할 수 없습니다.");
					
					return false;
				}
				
				//jqGrid SelectBox 는 뷰 모드 전에 값을 가져옴.
				var branchCode = $("#rightList2 [name=BRANCHCODE] option:selected").val();
				
				if (v_rightLastSel_2 == 0 || v_rightLastSel_2 == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				$('#rightList2').jqGrid('saveRow',v_rightLastSel_2,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#rightList2").jqGrid('getRowData', v_rightLastSel_2); //셀 전체 데이터 가져오기
				
				if (confirm("삭제하시겠습니까?") == true) {
					$.ajax({ 
						type: 'POST' ,
						data: "BUYID=" + cellData.BUYID + "&BRANCHCODE=" + branchCode,
						url: "/home/deleteDataSalesopenTb.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							v_rightLastSel_2 = 0;
							
							f_selectListEnaSalesOpenTb(cellData.BUYID);
						},
						error:function(e){  
							alert("[ERROR]지사오픈관리 삭제  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_2 = 0;
					f_selectListEnaSalesOpenTb(cellData.BUYID);
				}
			});
		})
		
		$(function() {
			$("#tab2SaveButton").click(function() {
				var branchCode =  $("#rightList2 [name=BRANCHCODE] option:selected").val();
				
				$('#rightList2').jqGrid('saveRow',v_rightLastSel_2,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#rightList2").jqGrid('getRowData', v_rightLastSel_2); //셀 전체 데이터 가져오기
				
				if (v_rightLastSel_2 == 0 || v_rightLastSel_2 == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				if (cellData.HOLDINGYN == "Y") {
					if (cellData.HOLDINGM2 == "") {
						alert("홀딩면적을 입력하셔야 합니다.");
						
						$('#rightList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_HOLDINGM2").focus();
						
						return false;
					}
					
					if (cellData.HOLDINGPY == "") {
						alert("홀딩평수를 입력하셔야 합니다.");
						
						$('#rightList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_HOLDINGPY").focus();
						
						return false;
					}
					
					if (cellData.HOLDINGDATE == "") {
						alert("홀딩일자를 입력하셔야 합니다.");
						
						$('#rightList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_HOLDINGDATE").focus();
						
						return false;
					}
				}
				
				var msg = "";
				if ($("#S_FLAG_R_2").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					var formData = "S_FLAG_R_2=" + $("#S_FLAG_R_2").val() + 
					"&BUYID=" + $("#BUYID").val() + 
					"&BRANCHCODE=" + branchCode + 
					"&OPENYN=" + cellData.OPENYN + 
					"&HOLDINGYN=" + cellData.HOLDINGYN + 
					"&HOLDINGM2=" + cellData.HOLDINGM2 + 
					"&HOLDINGPY=" + cellData.HOLDINGPY + 
					"&HOLDINGDATE=" + cellData.HOLDINGDATE +
					"&REMARK=" + cellData.REMARK;
					
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/insertDataSalesopenTb.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG_R_2").val("U");
							
							v_rightLastSel_2 = 0;
							
							alert(data.resultMsg);
							
							f_selectListEnaSalesOpenTb($("#BUYID").val());
						},
						error:function(e){  
							alert("[ERROR]지사 오픈관리 저장  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_2 = 0;
					f_selectListEnaSalesOpenTb($("#BUYID").val());
				}
			});
		})
	</script>
</head>
<body>
	<div style="padding: 10px;">
		<div id="contents">
			<div>
				<div id="topLayout">
					<div>
						<span>
							<div>
								<table align="right">
									<tr>
										<td><input type="button" value="조회" id='selectButton' /></td>
										<td><input type="button" value="추가" id='insertButton' /></td>
										<td><input type="button" value="삭제" id='deleteButton' /></td>
										<td><input type="button" value="저장" id='saveButton' /></td>
									</tr>
								</table>
							</div>
						</span>
					</div>
				</div>
			</div>
			<div>
				<div id="middleLayout">
					<div>
						<span>
							<div id="leftDiv">
								<table>
									<tr>
										<th>매입기간</th>
										<td><input type="text" id="LS_BUYDATE_FR" name="LS_BUYDATE_FR" /> - <input type="text" id="LS_BUYDATE_TO" name="LS_BUYDATE_TO" /></td>
									</tr>
									<tr>
										<th>담당자 (필드에 없는 내용)</th>
										<td>
										</td>
									</tr>
									<tr>
										<th>지번(주소)</th>
										<td><input type="text" id="LS_ADDRESS" name="LS_ADDRESS" onkeydown="f_selectButton();" /></td>
									</tr>
								</table>
								<table id="leftList"></table>
							</div>
						</span>
					</div>
					<div style="padding: 10px;">
						<span>
							<div id="bottomDiv" style="border: none;">
								<div>
									<sapn>
										<div>
											<form id="MM011001">
											<input type="hidden" id="S_FLAG_L" name="S_FLAG_L" />
											<table width="680px">
												<tr>
													<th width="100">* 계약일자 / 번호</th>
													<td colspan="6"><input type="text" id="BUYDATE" name="BUYDATE" onkeydown="f_getBuyId();" />&nbsp;<input type="text" id="BUYID" name="BUYID" /></td>
													<td><input type="button" id="searchButton"/></td>
												</tr>
												<tr>
													<th>* 매입구분</th>
													<td colspan="7">
														<select id="BUYGUBUN" name="BUYGUBUN">
														</select>
													</td>
												</tr>
												<tr>
													<th>* 관리번호</th>
													<td colspan="7"><input type="text" id="MANAGENO" name="MANAGENO" /></td>
												</tr>
												<tr height="10px">
												</tr>
												<tr>
													<th>지역구분</th>
													<td colspan="3">
														<select id="CITYCODE" name="CITYCODE">
														</select>
													</td>
													<th width="100">시/도구분</th>
													<td colspan="3">
														<select id="BOROUGHCODE" name="BOROUGHCODE">
														</select>
													</td>
												</tr>
												<tr>
													<th>지목</th>
													<td colspan="7">
														<select id="USETYPE" name="USETYPE">
														</select>
													</td>	
												</tr>
												<tr>
													<th>주소</th>
													<td colspan="7"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
												</tr>
												<tr>
													<th>원지주성명</th>
													<td colspan="3"><input type="text" id="OWNERNAME" name="OWNERNAME" /></td>
													<th>주민번호</th>
													<td colspan="3"><input type="text" id="OWNERJUMINID" name="OWNERJUMINID" /></td>
												</tr>
												<tr>
													<th>계약면적</th>
													<td colspan="3"><input type="text" id="BUYM2" name="BUYM2" /></td>
													<th>계약평수</th>
													<td colspan="3"><input type="text" id="BUYPY" name="BUYPY" /></td>
												</tr>
												<tr>
													<th>분양/잔여면적</th>
													<td><input type="text" id="BUNYM2" name="BUNYM2" /></td>
													<td> / </td>
													<td><input type="text" id="BUNJANM2" name="BUNJANM2" /></td>
													<th>분양/잔여평수</th>
													<td><input type="text" id="BUNYPY" name="BUNYPY" /></td>
													<td> / </td>
													<td><input type="text" id="BUNJANPY" name="BUNJANPY" /></td>
												</tr>
												<tr>
													<th><div id="mm_div1">매매대금</div></th>
													<td colspan="3"><input type="text" id="BUYAMT" name="BUYAMT" /></td>
													<th><div id="mm_div2">매매단가</div></th>
													<td colspan="3"><input type="text" id="BUYDANGA" name="BUYDANGA" /></td>
												</tr>
												<tr>
													<th>등기여부</th>
													<td colspan="7">
														<input type="radio" id="REGYN" name="REGYN" value="Y">등기완료
														<input type="radio" id="REGYN" name="REGYN" value="N">미등기
													</td>
												</tr>
												<tr>
													<th>등기일자</th>
													<td colspan="7"><input type="text" id="REGDATE" name="REGDATE" /></td>
												</tr>
												<tr>
													<th>비고</th>
													<td colspan="7"><input type="text" id="REMARK" name="REMARK" /></td>
												</tr>
											</table>
											</form>
										</div>
									</sapn>
								</div>
								<div>
									<span>
										<div id="rightDiv2">
											<input type="hidden" id="S_FLAG_R_1" name="S_FLAG_R_1" />
											<input type="hidden" id="S_FLAG_R_2" name="S_FLAG_R_2" />
											<div id="bottomTabs">
												<ul>
               										<li>지급 스케줄 관리</li>
													<li>지사 오픈관리</li>
												</ul>
												<div>
													<div id="right1Div">
														<table id="rightList1"></table>
														<table width="100%">
															<tr>
																<td width="30%">지급합계</td>
																<td width="70%" align="left"><input type="text" id="PAYTOTAL" name="PAYTOTAL" /></td>
																<td align="right"><input type="button" value="추가" id='tab1InsertButton' /></td>
																<td align="right"><input type="button" value="삭제" id='tab1DeleteButton' /></td>
																<td align="right"><input type="button" value="저장" id='tab1SaveButton' /></td>
															</tr>
														</table>
													</div>
												</div>
												<div>
													<div id="right2Div">
														<table id="rightList2"></table>
														<table align="right">
															<tr>
																<td width="100%" align="right"><input type="button" value="추가" id='tab2InsertButton' /></td>
																<td><input type="button" value="삭제" id='tab2DeleteButton' /></td>
																<td><input type="button" value="저장" id='tab2SaveButton' /></td>
															</tr>
														</table>
													</div>
												</div>
											</div>
										</div>
									</span>
								</div>
							</div>
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>