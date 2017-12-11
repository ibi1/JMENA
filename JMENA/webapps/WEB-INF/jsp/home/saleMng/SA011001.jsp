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
		var v_rightLastSel_3 = 0;		//오른쪽 그리드 선택 tab3
		var auth_i = true;
		var auth_d = true;
		
		$(document).ready(function(){
			$("#S_FLAG_L").val("I");
			$("#S_FLAG_R_2").val("I");
			
			$("#SL_SALEDATE_FR").val(dateInput(1));
			$("#SL_SALEDATE_TO").val(dateInput(0));
			
			$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#deleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
	
			$("#tab1InsertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#tab1DeleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#tab1SaveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			
			$("#tab2InsertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#tab2DeleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#tab2SaveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			
			$("#tab3InsertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#tab3DeleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			$("#tab3SaveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
			
			$("#SL_SALEDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#SL_SALEDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#SL_ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
	
			$('#bottomTabs').jqxTabs({theme: 'bootstrap', autoHeight: false, width: 1200});
			
			$("#searchPopButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
			$("#searchManageNoPopButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });

			<%if ("N".equals(session.getAttribute("AUTH_I"))) { %>
				$("#insertButton").hide();
				$("#saveButton").hide();
				$("#tab1InsertButton").hide();
				$("#tab1SaveButton").hide();
				$("#tab2InsertButton").hide();
				$("#tab2SaveButton").hide();
				$("#tab3InsertButton").hide();
				$("#tab3SaveButton").hide();
				auth_i = false;
			<% }%>
			<%if ("N".equals(session.getAttribute("AUTH_D"))) { %>
				$("#deleteButton").hide();
				$("#tab1DeleteButton").hide();
				$("#tab2DeleteButton").hide();
				$("#tab3DeleteButton").hide();
				auth_d = false;
			<% }%>

			
			$("#SALEDATE").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
			$("#SALEID").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1, disabled: true});
			$("#MANAGENO").jqxInput({theme: 'energyblue', height: 25, width: 190, minLength: 1, disabled: true });
			$("#ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1, disabled: true});
			$("#OWNERNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1, disabled: true});
			$("#OWNERJUMINID").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1, disabled: true});
			$("#CONBM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1, disabled: true});
			$("#CONJM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1, disabled: true});
			$("#CONBPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1, disabled: true});
			$("#CONJPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1, disabled: true});
			$("#CONNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#CONJUMINID").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#CONADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
			$("#CONTELNO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#CONM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
			$("#CONPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
			$("#SALEAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#SALEDANGA").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#AGENCYAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
			$("#DCAMT").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#DCRATE").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
			$("#SELLAMT").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
			$("#REMARK").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
			$("#REGDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});	
			
			
			$("#SALERCD").jqxInput({theme: 'energyblue', height: 25, width: 93, minLength: 1, disabled: true });
            $("#SALERNAME").jqxInput({theme: 'energyblue',  height: 25, width: 93, minLength: 1 });
         
			$("#SUGUMTOTAL").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1, disabled: true});
			
			$("#CITYCODE").attr("disabled", true);
			$("#BRANCHNAME").attr("disabled", true);
			
			f_selectListEnaDCode();
			f_selectListEnaCityCode();
			f_selectListEnaSalerCode();
			f_selectListEnaBranchCode();
			f_selectListEnaDcGubun();
			
			f_selectListEnaSaleMst();
		   	
			f_selectListEnaIpgumScheduleTb();
			f_selectListEnaJointNameTb();
			f_selectListEnaSaleHistoryTb();
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
					inHtml += "<option value=''></option>\n";
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
	
		function f_selectListEnaSalerCode(){
			$.ajax({ 
				type: 'POST' ,
				url: "/codeCom/insaMstList.do", 
				dataType : 'json' , 
				success: function(data){
					var inHtml = "";
					data.insaMstList.forEach(function(currentValue, index, array){
						inHtml += "<option value='" + currentValue.INSACODE + "'>" + currentValue.KNAME + "</option>\n";
					});
					//$("#SALERCD").append(inHtml);
					$("#SL_SALERNAME").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		//부서
		function f_selectListEnaBranchCode(){
			$("#BRANCHNAME").empty().data('options');
		   	$.ajax({ 
				type: 'POST' ,
				url: "/codeCom/branchMstList.do", 
				dataType : 'json' , 
				success: function(data){
					var inHtml = "";
					inHtml += "<option value=''></option>\n";
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
		
		//매출구분
		function f_selectListEnaDCode(){
			var CCODE = "007";
			$("#SALEGUBUN").empty().data('options');
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
					$("#SALEGUBUN").append(inHtml);
					
					$("#SALEGUBUN").change();
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
		//DC사항
		function f_selectListEnaDcGubun(){
			var CCODE = "008";
			$("#DCGUBUN").empty().data('options');
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
					$("#DCGUBUN").append(inHtml);
				},
				error:function(e){  
					alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
	
		//매출관리 메인 그리드
		function f_selectListEnaSaleMst(){
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListEanSaleMst.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					SL_SALEDATE_FR : $("#SL_SALEDATE_FR").val(),
					SL_SALEDATE_TO : $("#SL_SALEDATE_TO").val(),
					SL_SALERNAME : $("#SL_SALERNAME").val(),
					SL_ADDRESS : $("#SL_ADDRESS").val()
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['담당자코드', '담당자', '계약자', '계약면적', '원지주성명', '계약일자', '주소', '계약평수', '매매금액',
				          '계약번호', '관리번호', '지역구분', '지사구분', '주민번호', '분양면적', '잔여면적', '분양평수', '잔여평수', 
				          '매출구분', '매입번호', '계약자주민번호', '계약자주소', 
				          '계약자연락처',  '비고',  '매매단가', '할인구분', '할인율', '할인금액', '실판매가', '위탁수수료', 
				          '공동명의구분', '등기여부', '등기일자', '해약여부', '해약일자', '매입단가'],
				colModel:[
					{name:"SALERCD",		index:'SALERCD',		width:100,	align:'center',	sortable:false, hidden:true},
					{name:"SALERNAME",		index:'SALERNAME',		width:100,	align:'center',	sortable:false},
					{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center',	sortable:false},
					{name:"CONM2",			index:'CONM2',			width:100,	align:'center',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}},
					{name:"OWNERNAME",		index:'OWNERNAME',		width:100,	align:'center',	sortable:false},
					{name:"SALEDATE",		index:'SALEDATE',		width:100,	align:'center',	sortable:false},
					{name:"ADDRESS",		index:'ADDRESS',		width:100,	align:'center',	sortable:false},
					{name:"CONPY",			index:'CONPY',			width:100,	align:'center',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}},
					{name:"SALEAMT",		index:'SALEAMT',		width:100,	align:'right',	sortable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}},
					{name:"SALEID",			index:'SALEID',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"MANAGENO",		index:'MANAGENO',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CITYCODE",		index:'CITYCODE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"OWNERJUMINID",	index:'OWNERJUMINID',	width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONBM2",			index:'CONBM2',			width:100,	align:'center',	sortable:false,	formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}, hidden:true},
					{name:"CONJM2",			index:'CONJM2',			width:100,	align:'center',	sortable:false,	formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}, hidden:true},
					{name:"CONBPY",			index:'CONBPY',			width:100,	align:'center',	sortable:false,	formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}, hidden:true},
					{name:"CONJPY",			index:'CONJPY',			width:100,	align:'center',	sortable:false,	formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}, hidden:true},
					{name:"SALEGUBUN",		index:'SALEGUBUN',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"BUYID",			index:'BUYID',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONJUMINID",		index:'CONJUMINID',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONADDRESS",		index:'CONADDRESS',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CONTELNO",		index:'CONTELNO',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"REMARK",			index:'REMARK',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"SALEDANGA",		index:'SALEDANGA',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"DCGUBUN",		index:'DCGUBUN',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"DCRATE",			index:'DCRATE',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"DCAMT",			index:'DCAMT',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"SELLAMT",		index:'SELLAMT',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"AGENCYAMT",		index:'AGENCYAMT',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"JOINYN",			index:'JOINYN',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"REGYN",			index:'REGYN',			width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"REGDATE",		index:'REGDATE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CANCELYN",		index:'CANCELYN',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"CANCELDATE",		index:'CANCELDATE',		width:100,	align:'center',	sortable:false,	hidden:true},
					{name:"BUYDANGA",		index:'BUYDANGA',		width:100,	align:'center',	sortable:false,	hidden:true}
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
					v_rightLastSel_1 = 0;
					v_rightLastSel_2 = 0;
					v_rightLastSel_3 = 0;
					
					$("#S_FLAG_L").val("U");
					
					var selRowData = $(this).jqGrid('getRowData', ids);
					
					//값 채우기 넣기
					$("#SALEDATE").val(selRowData.SALEDATE);
					$("#SALEID").val(selRowData.SALEID);
					$("#SALEGUBUN").val(selRowData.SALEGUBUN);
					$("#SALERCD").val(selRowData.SALERCD);
					$("#SALERNAME").val(selRowData.SALERNAME);
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
					$("#SALEAMT").val(selRowData.SALEAMT);
					$("#SALEDANGA").val(selRowData.SALEDANGA);
					$("#AGENCYAMT").val(selRowData.AGENCYAMT);
					$("#DCGUBUN").val(selRowData.DCGUBUN);
					$("#DCRATE").val(selRowData.DCRATE);
					$("#DCAMT").val(selRowData.DCAMT);
					$("#SELLAMT").val(selRowData.SELLAMT);
					$("#REMARK").val(selRowData.REMARK);
					$("#BUYDANGA").val(selRowData.BUYDANGA);
					
					if (selRowData.SALEGUBUN == "001") {	//일반
						$("#AGENCYAMT").jqxInput({ disabled: true });
					} else { //위탁
						$("#AGENCYAMT").jqxInput({ disabled: false });
					}
					
					f_selectListEnaIpgumScheduleTb(selRowData.SALEID);
					f_selectListEnaJointNameTb(selRowData.SALEID);
					//공동명의 여부
					selRowData.JOINYN == "Y" ? $("#JOINYN").attr("checked", true) : $("#JOINYN").attr("checked", false);
					//등기여부
					$("input:radio[name=REGYN]:input[value=" + selRowData.REGYN + "]").attr("checked", true);
					//등기일자
					$("#REGDATE").val(selRowData.REGDATE);
					
					f_selectListEnaSaleHistoryTb(selRowData.SALEID);
					
					//해약여부 확인
					$.ajax({ 
						type: 'POST' ,
						url: "/home/selectDataSaleHistoryTb004.do", 
						dataType : 'json' ,
						data : {
							SALEID : selRowData.SALEID
						},
						success: function(data){
							var flag = (data.resultMsg == "Y") ? true : false;
							
							$("#insertButton").jqxButton({ disabled: flag });
							$("#deleteButton").jqxButton({ disabled: flag });
							$("#saveButton").jqxButton({ disabled: flag });
					
							$("#tab1InsertButton").jqxButton({ disabled: flag });
							$("#tab1DeleteButton").jqxButton({ disabled: flag });
							$("#tab1SaveButton").jqxButton({ disabled: flag });
							
							$("#tab2InsertButton").jqxButton({ disabled: flag });
							$("#tab2DeleteButton").jqxButton({ disabled: flag });
							$("#tab2SaveButton").jqxButton({ disabled: flag });
							
							$("#tab3InsertButton").jqxButton({ disabled: flag });
							$("#tab3DeleteButton").jqxButton({ disabled: flag });
							$("#tab3SaveButton").jqxButton({ disabled: flag });
						},
						error:function(e){  
							alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
						}  
					});
			
					//콤마 set
					f_commaInputData("click");
				} ,
				loadComplete: function(ids) {
					//전체 카운트
					var countRow = $("#leftList").jqGrid('getGridParam', 'records');
					$("#leftListCount").html(countRow);
					
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
		
		//입금 스케줄 관리
		function f_selectListEnaIpgumScheduleTb(SALEID){
			$('#bottomList1').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			$('#bottomList1').jqGrid({
				url:"/home/selectListEnaIpgumScheduleTb.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					SALEID : SALEID
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['판매번호', '입급순번', '입급구분', '입금일자', '입급예정금액', '입금처리금액', '입금여부', '비고', '입금번호', '처리순번'],
				colModel:[
					{name:"SALEID",				index:'SALEID',			width:100,	align:'center', sortable:false, editable:true, hidden:true}
					, {name:"IPGUMSEQ",			index:'IPGUMSEQ',		width:100,	align:'center', sortable:false, editable:true, hidden:true}
					, {name:"DEPOSITGUBUN",		index:'DEPOSITGUBUN',	width:100,	align:'center', sortable:false, editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=009", buildSelect:f_selectListEnaIpgumGubunCode} }
					, {name:"DEPOSITDATE",		index:'DEPOSITDATE',	width:100,	align:'center', sortable:false, editable:true}
					, {name:"DEPOSITAMT",		index:'DEPOSITAMT',		width:100,	align:'right', sortable:false, editable:true, formatter:'currency', formatoptions:{decimalSeparator:",", thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					, {name:"SUGUMAMT",			index:'SUGUMAMT',		width:100,	align:'right', sortable:false, editable:false, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					, {name:"DEPOSITYN",		index:'DEPOSITYN',		width:100,	align:'center', sortable:false, editable:false, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"REMARK",			index:'REMARK',			width:100,	align:'center', sortable:false, editable:true}
					, {name:"IPGUMID",			index:'IPGUMID',		width:100,	align:'center', sortable:false, editable:false, hidden:true}
					, {name:"SEQ",				index:'SEQ',			width:100,	align:'center', sortable:false, editable:false, hidden:true}
				],
				rowNum:10000000,
				autowidth: true,
				shrinkToFit: false,
				rowList:[10,20,30],
				sortname: 'IPGUMSEQ',
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
					//전체 카운트
					var countRow = $("#bottomList1").jqGrid('getGridParam', 'records');
					$("#bottomList1Count").html(countRow);
					
					var tot = 0;
					
					var ids = $(this).jqGrid('getDataIDs');
					
					ids.some(function(currentValue, index, array){
						var depositYn = $("#bottomList1").jqGrid('getCell', ids[index], 'DEPOSITYN');
						
						if (depositYn == "Y") {
							tot += eval($("#bottomList1").jqGrid('getCell', ids[index], 'SUGUMAMT'));
			        	}        
					});
					
					$("#SUGUMTOTAL").val(tot);
				},
				hidegrid: false
			});
		}
		
		function f_selectListEnaIpgumGubunCode(data){
			var jsonValue = $.parseJSON(data).dcodeList;
			
			var result = "<select>";
			
			jsonValue.some(function(currentValue, index, array){
				result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
			});
			
			result +="</select>";
			return result;
					
		}
		
		//등기 관리
		function f_selectListEnaJointNameTb(SALEID){
			$('#bottomList2').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			$('#bottomList2').jqGrid({
				url:"/home/selectListEnaJointNameTb.do" ,
				datatype:"json" ,
				mtype: 'POST',
				postData : {
					SALEID : SALEID
				},
				loadError:function(){alert("Error~!!");} ,
				colNames:['판매번호', '공동명의 순번', '명의자', '주민번호', '연락처', '점유면적', '점유평수', '매매대금', '매매단가', 'DC사항', 'DC율', '실 매매가', '등본제출여부', '비고'] ,
				colModel:[
					{name:"SALEID",				index:'SALEID',			width:100,	align:'center', sortable:false, editable:true, hidden:true}
					, {name:"JOINTSEQ",			index:'JOINTSEQ',		width:100,	align:'center', sortable:false, editable:true, hidden:true}
					, {name:"JOINTNAME",		index:'JOINTNAME',		width:100,	align:'center', sortable:false, editable:true}
					, {name:"JOINTJUMINID",		index:'JOINTJUMINID',	width:100,	align:'center', sortable:false, editable:true}
					, {name:"JOINTTELNO",		index:'JOINTTELNO',		width:100,	align:'center', sortable:false, editable:true}
					, {name:"OCCUM2",			index:'OCCUM2',			width:100,	align:'center', sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"OCCUPY",			index:'OCCUPY',			width:100,	align:'center', sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"SALEAMT",			index:'SALEAMT',		width:100,	align:'right', sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					, {name:"SELLDANGA",		index:'SELLDANGA',		width:100,	align:'right', sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					, {name:"DCGUBUN",			index:'DCGUBUN',		width:100,	align:'center', sortable:false, editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=008", buildSelect:f_selectListEnaDcGubunCode} }
					, {name:"DCRATE",			index:'DCRATE',			width:100,	align:'center', sortable:false, editable:true}
					, {name:"SELLAMT",			index:'SELLAMT',		width:100,	align:'right', sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
					, {name:"PAPERREGYN",		index:'PAPERREGYN',		width:100,	align:'center', sortable:false, editable:true, formatter:'checkbox', edittype:'checkbox', editoptions:{value:"Y:N"}}
					, {name:"REMARK",			index:'REMARK',			width:100,	align:'center', sortable:false, editable:true}
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
						$("#S_FLAG_R_2").val("U");
					} else {
						$("#S_FLAG_R_2").val("I");
					}
					
					if( v_rightLastSel_2 != id ){
				        $(this).jqGrid('restoreRow',v_rightLastSel_2,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
				        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

				        v_rightLastSel_2 = id;
					}
				} ,
				loadComplete: function(id) {
					//전체 카운트
					var countRow = $("#bottomList2").jqGrid('getGridParam', 'records');
					$("#bottomList2Count").html(countRow);
				},
				hidegrid: false
			});
		}
		
		function f_selectListEnaDcGubunCode(data){
			var jsonValue = $.parseJSON(data).dcodeList;
			
			var result = "<select>";
			
			jsonValue.some(function(currentValue, index, array){
				result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
			});
			
			result +="</select>";
			return result;
					
		}
	
		//계약변동관리
		function f_selectListEnaSaleHistoryTb(SALEID) {
			$('#bottomList3').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			$('#bottomList3').jqGrid({
				url:"/home/selectListEnaSaleHistoryTb.do" ,
				datatype:"json" ,
				mtype: 'POST',
				postData : {
					SALEID : SALEID
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");} ,
				colNames:['판매번호', '이력순번', '변동일자', '변동구분', '직전 계약면적', '직전 계약평수', '변경면적', '변경평수', '비고'] ,
				colModel:[
					{name:"SALEID",		index:'SALEID',		width:100,	align:'center', sortable:false, editable:true, hidden:true}
					, {name:"SALESEQ",	index:'SALESEQ',	width:100,	align:'center', sortable:false, editable:true, hidden:true}
					, {name:"CHGDATE",	index:'CHGDATE',	width:100,	align:'center', sortable:false, editable:true}
					, {name:"CHGGUBUN",	index:'CHGGUBUN',	width:100,	align:'center', sortable:false, editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=010", buildSelect:f_selectListEnaChgGubunCode} }
					, {name:"PREM2",	index:'PREM2',		width:100,	align:'center', sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"PREPY",	index:'PREPY',		width:100,	align:'center', sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"CHGM2",	index:'CHGM2',		width:100,	align:'center', sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"CHGPY",	index:'CHGPY',		width:100,	align:'center', sortable:false, editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 2,defaultValue: ''}}
					, {name:"REMARK",	index:'REMARK',		width:100,	align:'center', sortable:false, editable:true}
				] ,
				rowNum:10000000,
				autowidth: true ,
				rowList:[10,20,30] ,
				//pager: $('#leftNav') ,
				sortname: 'SALESEQ' ,
				viewrecords: true ,
				sortorder:'asc' ,
				width: "96%" ,
				jsonReader: {
					repeatitems: false
				},
				//height: '100%' ,
				onSelectRow: function(id){
					if (id > 0) {
						$("#S_FLAG_R_3").val("U");
					} else {
						$("#S_FLAG_R_3").val("I");
					}
					
					if( v_rightLastSel_3 != id ){
				        $(this).jqGrid('restoreRow',v_rightLastSel_3,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
				        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

				        v_rightLastSel_3 = id;
					}
				} ,
				loadComplete: function(id) {
					//전체 카운트
					var countRow = $("#bottomList3").jqGrid('getGridParam', 'records');
					$("#bottomList3Count").html(countRow);
				},
				hidegrid: false ,
			});
		}

		function f_selectListEnaChgGubunCode(data){
			var jsonValue = $.parseJSON(data).dcodeList;
			
			var result = "<select>";
			
			jsonValue.some(function(currentValue, index, array){
				result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
			});
			
			result +="</select>";
			return result;
					
		}
		
		function f_clear(dF) {
			if (dF == "Y") $("#SALEDATE").val("");

			$("#SALEID").val("");
			$("#SALEGUBUN").val("");
			$("#SALERCD").val("");
			$("#SALERNAME").val("");
			$("#BRANCHNAME").val("");
			$("#MANAGENO").val("");
			$("#CITYCODE").val("");
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
			$("#SALEAMT").val("");
			$("#SALEDANGA").val("");
			$("#AGENCYAMT").val("");
			$("#DCGUBUN").val("");
			$("#DCRATE").val("");
			$("#DCAMT").val("");
			$("#SELLAMT").val("");
			$("#REMARK").val("");
			$("#BUYDANGA").val("");
			
			$('#bottomList1').jqGrid('clearGridData');
			$('#bottomList2').jqGrid('clearGridData');
			$('#bottomList3').jqGrid('clearGridData');
		}
		
		$(function() {
			$("#selectButton").click(function(){
				$("#S_FLAG_L").val("U");
				
				f_clear("Y");
				
				f_selectListEnaSaleMst();
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
				
				f_selectListEnaSaleMst();
				
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
						url: "/home/deleteDataSaleMst.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							$("#selectButton").click();
						},
						error:function(e){  
							alert("[ERROR]매출관리 삭제  중 오류가 발생하였습니다.");
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
				
				if ($("#SALERCD").val() == "") {
					alert("담당자를 입력하셔야 합니다.");
					
					$("#SALERNAME").focus();
					return false;
				}

				if ($("#CONNAME").val() == "") {
					alert("계약자 성명을 입력하셔야 합니다.");
					
					$("#CONNAME").focus();
					return false;
				}
				
				if ($("#CONJUMINID").val() == "") {
					alert("계약자 주민번호를 입력하셔야 합니다.");
					
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
				
				if ($("#SALEAMT").val() == "") {
					alert("매매대금을 입력하셔야 합니다.");
					
					$("#SALEAMT").focus();
					return false;
				}
				
				if ($("#SALEDANGA").val() == "") {
					alert("매매단가를 입력하셔야 합니다.");
					
					$("#SALEDANGA").focus();
					return false;
				}
				
				//매출구분이 위탁일 경우
				if ($("#SALEGUBUN").val() == "002") {
					if ($("#AGENCYAMT").val() == "") {
						alert("위탁수수료를 입력하셔야 합니다.");
						
						$("#AGENCYAMT").focus();
						return false;
					}
				}
				
				if($("#DCGUBUN").val() != "000") {
					if ($("#DCRATE").val() == "") {
						alert("DC율을 입력하셔야 합니다.");
						
						$("#DCRATE").focus();
						return false;
					}
					
					if ($("#DCAMT").val() == "") {
						alert("DC금액을 입력하셔야 합니다.");
						
						$("#DCAMT").focus();
						return false;
					}
				} else {
					alert("DC사항이 'DC없음'일 경우 'DC율 및 DC금액'은 저장되지 않습니다.");
				}
				
				if ($("#SELLAMT").val() == "") {
					alert("실 판매가를 입력하셔야 합니다.");
					
					$("#SELLAMT").focus();
					return false;
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
					$('#SALERCD').jqxInput({disabled: false });
					
					//저장전 콤마 삭제
					f_commaInputData("remove");
					
					$.ajax({ 
						type: 'POST' ,
						data: $("#SA011001").serialize(),
						url: "/home/insertDataSaleMst.do", 
						dataType : 'json' , 
						success: function(data){
							$('#SALEID').jqxInput({disabled: true });
							$("#MANAGENO").jqxInput({disabled: true});
							$("#SALERCD").jqxInput({disabled: true});
							
							alert(data.resultMsg);
							
							if (data.resultCode == "SUCCESS") {
								$("#SALEID").val(data.SALEID);
								f_selectListEnaSaleMst();
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
				var popUrl = "/home/SA011001_searchPopup.do";	//팝업창에 출력될 페이지 UR
				var popOption = "width=1300, height=600, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"매출관리",popOption);
			});
		})
		
		$(function() {
			$("#searchManageNoPopButton").click(function() {
				if ($("#S_FLAG_L").val() != "I") {
					alert("추가 시에만 검색할 수 있습니다.");
					
					return false;
				}
				
				//팝업
				var popUrl = "/home/SA011001_searchManagePopup.do";	//팝업창에 출력될 페이지 UR
				var popOption = "width=1300, height=600, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"매출관리",popOption);
			});
		})
		
		$(function() {
			$('#bottomTabs').on('tabclick', function (event) {
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				if (ids != null && ids != "") {
					$("#bottomList1").trigger("reloadGrid");
					$("#bottomList2").trigger("reloadGrid");
					$("#bottomList3").trigger("reloadGrid");
				}
			}); 
		}) 
		
		$(function() {
			$("#tab1InsertButton").click(function() {
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				if (ids == null || ids == "") {
					alert("선택된 매출정보가 없습니다.");
					
					return false;
				}
				
				$("#S_FLAG_R_1").val("I");
				
				$("#bottomList1").jqGrid("addRow", 0);
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
				
				$('#bottomList1').jqGrid('saveRow',v_rightLastSel_1,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#bottomList1").jqGrid('getRowData', v_rightLastSel_1); //셀 전체 데이터 가져오기

				if (confirm("삭제하시겠습니까?") == true) {
					$.ajax({ 
						type: 'POST' ,
						data: "SALEID=" + cellData.SALEID + "&IPGUMSEQ=" + cellData.IPGUMSEQ,
						url: "/home/deleteDataEnaIpgumScheduleTb.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							v_rightLastSel_1 = 0;
							
							f_selectListEnaIpgumScheduleTb($("#SALEID").val());
						},
						error:function(e){  
							alert("[ERROR]입금스케줄관리 삭제  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_1 = 0;
					f_selectListEnaIpgumScheduleTb($("#SALEID").val());
				}
			});
		})
		
		$(function() {
			$("#tab1SaveButton").click(function() {
				var ids = $("#bottomList1").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				var depositGubun =  $("#bottomList1 [name=DEPOSITGUBUN] option:selected").val();

				$('#bottomList1').jqGrid('saveRow',v_rightLastSel_1,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#bottomList1").jqGrid('getRowData', v_rightLastSel_1); //셀 전체 데이터 가져오기
				
				if (v_rightLastSel_1 == 0 || v_rightLastSel_1 == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				if (cellData.DEPOSITDATE == "") {
					alert("입금일자를 입력하셔야 합니다.");
					
					$('#bottomList1').jqGrid('editRow', v_rightLastSel_1, true);
					$("#"+ids+"_DEPOSITDATE").focus();
					
					return false;
				}
				
				if (cellData.DEPOSITAMT == "") {
					alert("입금예정금액을 입력하셔야 합니다.");
					
					$('#bottomList1').jqGrid('editRow', v_rightLastSel_1, true);
					$("#"+ids+"_DEPOSITAMT").focus();
					
					return false;
				}
				
				if (cellData.DEPOSITYN == "Y") {
					if (cellData.SUGUMAMT == "") {
						alert("입금처리된 금액이 없습니다.");
						
						$('#bottomList1').jqGrid('editRow', v_rightLastSel_1, true);
						$("#"+ids+"_DEPOSITYN").focus();
						
						return false;
					}
				}

				var msg = "";
				if ($("#S_FLAG_R_1").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					
					var formData = "S_FLAG_R_1=" + $("#S_FLAG_R_1").val() + 
					"&SALEID=" + $("#SALEID").val() + 
					"&IPGUMSEQ=" + cellData.IPGUMSEQ + 
					"&DEPOSITGUBUN=" + depositGubun + 
					"&DEPOSITDATE=" + cellData.DEPOSITDATE + 
					"&DEPOSITAMT=" + cellData.DEPOSITAMT + 
					"&DEPOSITYN=" + cellData.DEPOSITYN + 
					"&REMARK=" + cellData.REMARK;
					
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/insertDataEnaIpgumScheduleTb.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG_R_1").val("U");
							
							v_rightLastSel_1 = 0;
							
							alert(data.resultMsg);
							
							f_selectListEnaIpgumScheduleTb($("#SALEID").val());
						},
						error:function(e){  
							alert("[ERROR]입금 스케줄 관리 저장  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_1 = 0;
					f_selectListEnaIpgumScheduleTb($("#SALEID").val());
				}
			});
		})
		
		$(function() {
			$("#tab2InsertButton").click(function() {
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				if (ids == null || ids == "") {
					alert("선택된 매출정보가 없습니다.");
					
					return false;
				}
				
				$("#S_FLAG_R_2").val("I");
				
				$("#bottomList2").jqGrid("addRow", 0);
			});
		})
		
		$(function() {
			$("#tab2DeleteButton").click(function() {
				if ($("#S_FLAG_R_2").val() == "I") {
					alert("추가 시 일 경우 삭제할 수 없습니다.");
					
					return false;
				}
				
				if (v_rightLastSel_2 == 0 || v_rightLastSel_2 == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				$('#bottomList2').jqGrid('saveRow',v_rightLastSel_2,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#bottomList2").jqGrid('getRowData', v_rightLastSel_2); //셀 전체 데이터 가져오기

				if (confirm("삭제하시겠습니까?") == true) {
					$.ajax({ 
						type: 'POST' ,
						data: "SALEID=" + cellData.SALEID + "&JOINTSEQ=" + cellData.JOINTSEQ,
						url: "/home/deleteDataEnaJointNameTb.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							v_rightLastSel_2 = 0;
							
							f_selectListEnaJointNameTb($("#SALEID").val());
						},
						error:function(e){  
							alert("[ERROR]등기 관리 삭제  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_2 = 0;
					f_selectListEnaJointNameTb($("#SALEID").val());
				}
			});
		})
		
		$(function() {
			$("#tab2SaveButton").click(function() {
				if ($("#SALEID").val() == "") {
					alert("선택된 매출정보가 없습니다.");
					
					return false;
				}
				
				var gridAddFlag = "";
				
				if (v_rightLastSel_2 == 0 || v_rightLastSel_2 == "") {
					//그리드에 데이터 추가 없이 저장
					 gridAddFlag = "N";
					
				} else {
					//그리드에 데이터 추가 후 저장
					gridAddFlag = "Y";
					
					var ids = $("#bottomList2").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
					 
					var dcGubun =  $("#bottomList2 [name=DCGUBUN] option:selected").val();

					$('#bottomList2').jqGrid('saveRow',v_rightLastSel_2,false,'clientArray'); //선택된 놈 뷰 모드로 변경

					var cellData = $("#bottomList2").jqGrid('getRowData', v_rightLastSel_2); //셀 전체 데이터 가져오기
					
					if (cellData.JOINTNAME == "") {
						alert("명의자를 입력하셔야 합니다.");
						
						$('#bottomList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_JOINTNAME").focus();
						
						return false;
					}
					
					if (cellData.JOINTJUMINID == "") {
						alert("주민번호를 입력하셔야 합니다.");
						
						$('#bottomList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_JOINTJUMINID").focus();
						
						return false;
					}
					
					if (cellData.OCCUM2 == "") {
						alert("점유면적을 입력하셔야 합니다.");
						
						$('#bottomList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_OCCUM2").focus();
						
						return false;
					}
					
					if (cellData.OCCUPY == "") {
						alert("점유평수를 입력하셔야 합니다.");
						
						$('#bottomList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_OCCUPY").focus();
						
						return false;
					}
					
					if (cellData.SALEAMT == "") {
						alert("매매대금을 입력하셔야 합니다.");
						
						$('#bottomList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_SALEAMT").focus();
						
						return false;
					}
					
					if (cellData.SELLDANGA == "") {
						alert("매매단가를 입력하셔야 합니다.");
						
						$('#bottomList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_SELLDANGA").focus();
						
						return false;
					}
					
					if (cellData.DCRATE == "") {
						alert("DC 율을 입력하셔야 합니다.");
						
						$('#bottomList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_DCRATE").focus();
						
						return false;
					}
					
					if (cellData.SELLAMT == "") {
						alert("실 매매가를 입력하셔야 합니다.");
						
						$('#bottomList2').jqGrid('editRow', v_rightLastSel_2, true);
						$("#"+ids+"_SELLAMT").focus();
						
						return false;
					}
				}
				
				var joinYn = $('#JOINYN').is(':checked') ? "Y" : "N";
				
				var msg = "";
				if ($("#S_FLAG_R_2").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					var formData = "S_FLAG_R_2=" + $("#S_FLAG_R_2").val() + 
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
						"&SALEAMT=" + cellData.SALEAMT +
						"&SELLDANGA=" + cellData.SELLDANGA +
						"&DCGUBUN=" + dcGubun +
						"&DCRATE=" + cellData.DCRATE +
						"&SELLAMT=" + cellData.SELLAMT +
						"&PAPERREGYN=" + cellData.PAPERREGYN +
						"&REMARK=" + cellData.REMARK;
					}
					
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/insertDataEnaJointNameTb.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG_R_2").val("I");
							
							v_rightLastSel_2 = 0;
							
							alert(data.resultMsg);
							
							f_selectListEnaSaleMst();
							f_selectListEnaJointNameTb($("#SALEID").val());
						},
						error:function(e){  
							alert("[ERROR-script]등기 관리 저장  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_2 = 0;
					f_selectListEnaSaleMst();
					f_selectListEnaJointNameTb($("#SALEID").val());
				}
			});
		})
		
		$(function() {
			$("#tab3InsertButton").click(function() {
				var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				if (ids == null || ids == "") {
					alert("선택된 매출정보가 없습니다.");
					
					return false;
				}
				
				$("#S_FLAG_R_3").val("I");
				
				$("#bottomList3").jqGrid("addRow", 0);
			});
		})
		
		$(function() {
			$("#tab3DeleteButton").click(function() {
				if ($("#S_FLAG_R_3").val() == "I") {
					alert("추가 시 일 경우 삭제할 수 없습니다.");
					
					return false;
				}
				
				if (v_rightLastSel_3 == 0 || v_rightLastSel_3 == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				$('#bottomList3').jqGrid('saveRow',v_rightLastSel_3,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#bottomList3").jqGrid('getRowData', v_rightLastSel_3); //셀 전체 데이터 가져오기

				if (confirm("삭제하시겠습니까?") == true) {
					$.ajax({ 
						type: 'POST' ,
						data: "SALEID=" + cellData.SALEID + "&SALESEQ=" + cellData.SALESEQ,
						url: "/home/deleteDataEnaSaleHistoryTb.do", 
						dataType : 'json' , 
						success: function(data){
							alert(data.resultMsg);
							
							v_rightLastSel_3 = 0;
							
							f_selectListEnaSaleHistoryTb($("#SALEID").val());
						},
						error:function(e){  
							alert("[ERROR-SCRIPT]게약변동관리 삭제  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_3 = 0;
					f_selectListEnaSaleHistoryTb($("#SALEID").val());
				}
			});
		})
		
		$(function() {
			$("#tab3SaveButton").click(function() {
				var ids = $("#bottomList3").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				var chgGubun =  $("#bottomList3 [name=CHGGUBUN] option:selected").val();

				$('#bottomList3').jqGrid('saveRow',v_rightLastSel_3,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#bottomList3").jqGrid('getRowData', v_rightLastSel_3); //셀 전체 데이터 가져오기
				
				if (v_rightLastSel_3 == 0 || v_rightLastSel_3 == "") {
					alert("그리드를 선택하셔야 합니다.");
					
					return false;
				}
				
				if (cellData.CHGDATE == "") {
					alert("변동일자를 입력하셔야 합니다.");
					
					$('#bottomList3').jqGrid('editRow', v_rightLastSel_3, true);
					$("#"+ids+"_CHGDATE").focus();
					
					return false;
				}
				
				if (chgGubun == "004") {	//해약					
				} else if (chgGubun == "003") {	//명의변경
					if (cellData.REMARK == "") {
						alert("비고를 입력하셔야 합니다.");
						
						$('#bottomList3').jqGrid('editRow', v_rightLastSel_3, true);
						$("#"+ids+"_REMARK").focus();
						
						return false;
					}
				} else {
					if (cellData.PREM2 == "") {
						alert("직전 계약면적을 입력하셔야 합니다.");
						
						$('#bottomList3').jqGrid('editRow', v_rightLastSel_3, true);
						$("#"+ids+"_PREM2").focus();
						
						return false;
					}
					
					if (cellData.PREPY == "") {
						alert("직전 계약평수를 입력하셔야 합니다.");
						
						$('#bottomList3').jqGrid('editRow', v_rightLastSel_3, true);
						$("#"+ids+"_PREPY").focus();
						
						return false;
					}
					
					if (cellData.CHGM2 == "") {
						alert("변경면적을 입력하셔야 합니다.");
						
						$('#bottomList3').jqGrid('editRow', v_rightLastSel_3, true);
						$("#"+ids+"_CHGM2").focus();
						
						return false;
					}
					
					if (cellData.CHGPY == "") {
						alert("변경평수를 입력하셔야 합니다.");
						
						$('#bottomList3').jqGrid('editRow', v_rightLastSel_3, true);
						$("#"+ids+"_CHGPY").focus();
						
						return false;
					}
				}
				
				var msg = "";
				if ($("#S_FLAG_R_3").val() == "I") {
					msg = "저장하시겠습니까?";
				} else {
					msg = "수정하시겠습니까?"
				}
				if (confirm(msg) == true) {
					var formData = "S_FLAG_R_3=" + $("#S_FLAG_R_3").val() + 
					"&SALEID=" + $("#SALEID").val() + 
					"&SALESEQ=" + cellData.SALESEQ + 
					"&CHGGUBUN=" + chgGubun + 
					"&CHGDATE=" + cellData.CHGDATE + 
					"&PREM2=" + cellData.PREM2 + 
					"&PREPY=" + cellData.PREPY + 
					"&CHGM2=" + cellData.CHGM2 + 
					"&CHGPY=" + cellData.CHGPY +
					"&REMARK=" + cellData.REMARK;
					
					$.ajax({ 
						type: 'POST' ,
						data: formData,
						url: "/home/insertDataEnaSaleHistoryTb.do", 
						dataType : 'json' , 
						success: function(data){
							$("#S_FLAG_R_3").val("U");
							
							v_rightLastSel_3 = 0;
							
							alert(data.resultMsg);
							
							f_selectListEnaSaleMst();
							f_selectListEnaSaleHistoryTb($("#SALEID").val());
						},
						error:function(e){  
							alert("[ERROR-SCRIPT]게약변동관리 저장  중 오류가 발생하였습니다.");
						}  
					});
				} else {
					v_rightLastSel_3 = 0;
					f_selectListEnaSaleMst();
					f_selectListEnaSaleHistoryTb($("#SALEID").val());
				}
			});
		})
		
		$(function() {
			$("#SALEGUBUN").change(function() {
				if ($(this).val() == "001") {	//일반
					$("#AGENCYAMT").jqxInput({ disabled: true });
				} else { //위탁
					$("#AGENCYAMT").jqxInput({ disabled: false });
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
			inputComma("SALEAMT");
			inputComma("SALEDANGA");
			inputComma("DCAMT");
			inputComma("SELLAMT");
			inputComma("AGENCYAMT");
		})
		
		function f_commaInputData(str) {
			if (str == "click") {
				$("#CONBM2").click();
				$("#CONJM2").click();
				$("#CONBPY").click();
				$("#CONJPY").click();
				$("#CONM2").click();
				$("#CONPY").click();
				$("#SALEAMT").click();
				$("#SALEDANGA").click();
				$("#DCAMT").click();
				$("#SELLAMT").click();
				$("#AGENCYAMT").click();
			} else if (str == "remove") {
				$("#CONBM2").val(removeComma($("#CONBM2").val()));
				$("#CONJM2").val(removeComma($("#CONJM2").val()));
				$("#CONBPY").val(removeComma($("#CONBPY").val()));
				$("#CONJPY").val(removeComma($("#CONJPY").val()));
				$("#CONM2").val(removeComma($("#CONM2").val()));
				$("#CONPY").val(removeComma($("#CONPY").val()));
				$("#SALEAMT").val(removeComma($("#SALEAMT").val()));
				$("#SALEDANGA").val(removeComma($("#SALEDANGA").val()));
				$("#DCAMT").val(removeComma($("#DCAMT").val()));
				$("#SELLAMT").val(removeComma($("#SELLAMT").val()));
				$("#AGENCYAMT").val(removeComma($("#AGENCYAMT").val()));
			}
			
		}
		
		//단가 계산(dc금액 , 실 판매가)
		function f_dangaRule() {
			f_commaInputData("remove");
			
			var dcamt;
			var saleamt = parseFloat($("#SALEAMT").val());
			var dcrate = isNaN(parseFloat($("#DCRATE").val())) == true ? 0 : parseFloat($("#DCRATE").val());
			
			if($("#DCGUBUN").val() != "000") {	//dc 있음
				
				dcamt = saleamt.toFixed(0) * (dcrate / 100);
				$("#DCAMT").val(dcamt.toFixed(0));
				
				$("#SELLAMT").val(saleamt.toFixed(0) - dcamt.toFixed(0));
			} else {	//dc없음
				$("#SELLAMT").val(saleamt.toFixed(0));
			}
			
			f_commaInputData("click");
		}
		
		$(function() {
			$("#SALEAMT").keydown(function() {
				var keyCode = window.event.keyCode;
				if(keyCode==13 || keyCode==9) {
					f_dangaRule();
				}
			});
			
			$("#DCRATE").keydown(function() {
				var keyCode = window.event.keyCode;
				if(keyCode==13 || keyCode==9) {
					f_dangaRule();
				}
			});
		})
		
		//위탁일 경우 위탁 수수료 계산
		function f_agencyAmtRule() {
			f_commaInputData("remove");
			
			//위탁일 경우
			if($("#SALEGUBUN").val() == "002") {
				//(((매입단가 -매출단가) * 0.8) * 평수) - DC 금액
				var agencyAmt = 0;
				
				var buydanga = ($("#BUYDANGA").val() == "") ? 0 : parseFloat($("#BUYDANGA").val());	//매입단가
				var saledanga = ($("#SALEDANGA").val() == "") ? 0 : parseFloat($("#SALEDANGA").val());	//매출단가
				var conpy = ($("#CONPY").val() == "") ? 0 : parseFloat($("#CONPY").val());
				
				agencyAmt = (((saledanga.toFixed(0) - buydanga.toFixed(0)) * 0.8) * conpy.toFixed(2));
				
				if($("#DCGUBUN").val() != "000") {	//dc 있음
					var dcamt = ($("#DCAMT").val() == "") ? 0 :parseFloat($("#DCAMT").val());
				
					agencyAmt -= dcamt.toFixed(0);
				}
				
				$("#AGENCYAMT").val(agencyAmt);
			}
			
			f_commaInputData("click");
		}
		
		$(function() {
			$("#SALEDANGA").keydown(function() {
				var keyCode = window.event.keyCode;
				if(keyCode==13 || keyCode==9) {
					f_agencyAmtRule();
				}
			});
			
			$("#CONPY").keydown(function() {
				var keyCode = window.event.keyCode;
				if(keyCode==13 || keyCode==9) {
					f_agencyAmtRule();
				}
			});
			
			$("#DCAMT").keydown(function() {
				var keyCode = window.event.keyCode;
				if(keyCode==13 || keyCode==9) {
					f_agencyAmtRule();
				}
			});
		})
		
		$(function() {
			$("#CONM2").keydown(function() {
				var keyCode = window.event.keyCode;
				if(keyCode==13 || keyCode==9) {
					//저장전 콤마 삭제
					f_commaInputData("remove");
					
					var reBuyPy = parseFloat($("#CONM2").val()) * 0.3025;
					
					$("#CONPY").val(reBuyPy.toFixed(0));
					
					//콤마 추가
					f_commaInputData("click");
				}
			});
		})
		
		function f_saleAmtRule() {
			//저장전 콤마 삭제
			f_commaInputData("remove");
			
			var buyAmt = parseFloat($("#SALEDANGA").val()) * parseFloat($("#CONPY").val());
			
			$("#SALEAMT").val(buyAmt.toFixed(0));
			
			//콤마 추가
			f_commaInputData("click");
		}
		
		$(function() {
			$("#SALEDANGA").keydown(function() {
				var keyCode = window.event.keyCode;
				if(keyCode==13 || keyCode==9) {
					f_saleAmtRule();
				}
			});
		})
		
		$(function() {
			$("#SALERNAME").keydown(function() {
				var keyCode = window.event.keyCode;
				if(keyCode==13 || keyCode==9) {
					if ($("#SALERNAME").val() == "") {
						alert("담당자를 입력하셔야 합니다.");
						
						$("#SALERNAME").focus();
						
						return false;	
					}
					
					$.ajax({ 
						type: 'POST' ,
						url: "/home/selectHRInsamstBranchCode.do", 
						data : {
							SALERNAME : $("#SALERNAME").val(),
						},dataType : 'json' , 
						success: function(data){
							if (data.RESULT == "EMPTY") {
								alert("조회된 담당자가 없습니다.");
								$("#SALERCD").val("");
								$("#BRANCHNAME").val("");
							} else {
								$("#SALERCD").val(data.SALERCD);
								$("#BRANCHNAME").val(data.BRANCHCODE);
							}
						},
						error:function(e){  
							alert("[ERROR-SCRIPT]게약변동관리 저장  중 오류가 발생하였습니다.");
						}  
					});
				}
			});
		})
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
					<th width="120">매출기간</th>
					<td><input type="text" id="SL_SALEDATE_FR" name="SL_SALEDATE_FR" /> ~ <input type="text" id="SL_SALEDATE_TO" name="SL_SALEDATE_TO" /></td>
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
					<td><input type="text" id="SL_ADDRESS" name="SL_ADDRESS" onkeydown="f_selectButton();"/></td>
				</tr>
			</table>
			<div align="right">총 건수 : <font color="red"><sapn id="leftListCount"></sapn></font>건</div>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:58%; float:left; padding: 10px" align="left">
			<form id="SA011001">
			<input type="hidden" id="S_FLAG_L" name="S_FLAG_L" />
			<table width="98%">
				<tr>
					<th width="120">* 계약일자/번호</th>
					<td colspan="2"><input type="text" id="SALEDATE" name="SALEDATE" /><input type="text" id="SALEID" name="SALEID" /></td>
					<td colspan="2"><input type="button" id="searchPopButton"/></td>
				</tr>
				<tr>
					<th width="120">* 매출구분</th>
					<td colspan="4">
						<select id="SALEGUBUN" name="SALEGUBUN">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">* 담당자</th>
					<td colspan="2">
						<input type="text" id="SALERNAME" name="SALERNAME" /> <input type="text" id="SALERCD" name="SALERCD" />
					</td>
					<th width="120">계약지사</th>
					<td>
						<select id="BRANCHNAME" name="BRANCHNAME">
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
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">주소</th>
					<td colspan="4"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
				</tr>
				<tr>
					<th width="120">원지주 성명</th>
					<td colspan="2"><input type="text" id="OWNERNAME" name="OWNERNAME" /></td>
					<th width="120">주민번호</th>
					<td colspan="2"><input type="text" id="OWNERJUMINID" name="OWNERJUMINID" /></td>
				</tr>
				<tr>
					<th width="120">분양/잔여면적</th>
					<td colspan="2"><input type="text" id="CONBM2" name="CONBM2" /> / <input type="text" id="CONJM2" name="CONJM2" /></td>
					<th width="120">분양/잔여평수</th>
					<td><input type="text" id="CONBPY" name="CONBPY" /> / <input type="text" id="CONJPY" name="CONJPY" /></td>
				</tr>
				<tr>
					<th width="120">계약자 성명</th>
					<td colspan="2"><input type="text" id="CONNAME" name="CONNAME" /></td>
					<th width="120">계약자주민번호</th>
					<td><input type="text" id="CONJUMINID" name="CONJUMINID" /></td>
				</tr>
				<tr>
					<th width="120">계약자 주소</th>
					<td colspan="4"><input type="text" id="CONADDRESS" name="CONADDRESS" /></td>
				</tr>
				<tr>
					<th width="120">계약자 연락처</th>
					<td colspan="4"><input type="text" id="CONTELNO" name="CONTELNO" /></td>
				</tr>
				<tr>
					<th width="120">계약면적</th>
					<td colspan="2"><input type="text" id="CONM2" name="CONM2" /></td>
					<th width="120">계약평수</th>
					<td><input type="text" id="CONPY" name="CONPY" /></td>
				</tr>
				<tr>
					<th width="120">매매대금</th>
					<td colspan="2"><input type="text" id="SALEAMT" name="SALEAMT"/></td>
					<th width="120">매매단가</th>
					<td><input type="text" id="SALEDANGA" name="SALEDANGA" /></td>
				</tr>
				<tr>
					<th width="120">위탁수수료</th>
					<td colspan="4"><input type="text" id="AGENCYAMT" name="AGENCYAMT" /></td>
				</tr>
				<tr>
					<th width="120">DC사항</th>
					<td colspan="2">
						<select id="DCGUBUN" name="DCGUBUN">
							<option></option>
						</select>
					</td>
					<th width="120">DC율</th>
					<td><input type="text" id="DCRATE" name="DCRATE" /> % </td>
				</tr>
				<tr>
					<th width="120">DC금액</th>
					<td colspan="2"><input type="text" id="DCAMT" name="DCAMT" /></td>
					<th width="120">실 판매가</th>
					<td><input type="text" id="SELLAMT" name="SELLAMT" /></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="4"><input type="text" id="REMARK" name="REMARK" onkeydown="f_saveButton();"/></td>
				</tr>
			</table>
		</div>
		</form>
		<input type="hidden" id="BUYDANGA" name="BUYDANGA" />
		<div id="bottomDiv" style="width:98%; float:left; padding: 10px" align="left">
			<input type="hidden" id="S_FLAG_R_1" name="S_FLAG_R_1" />
			<input type="hidden" id="S_FLAG_R_2" name="S_FLAG_R_2" />
			<input type="hidden" id="S_FLAG_R_3" name="S_FLAG_R_3" />
				
			<div id="bottomTabs">
				<ul>
					<li>입금 스케줄관리</li>
					<li>등기 관리</li>
					<li>계약 변동 관리</li>
				</ul>
				<div>
					<div id="bottom1Div">
						<div align="right">총 건수 : <font color="red"><sapn id="bottomList1Count"></sapn></font>건</div>
						<table id="bottomList1"></table>
						<table >
							<tr>
								<th width="120">입금합계</th>
								<td><input type="text" id="SUGUMTOTAL" name="SUGUMTOTAL" /></td>
								<td><input type="button" value="추가" id='tab1InsertButton' /></td>
								<td><input type="button" value="삭제" id='tab1DeleteButton' /></td>
								<td><input type="button" value="저장" id='tab1SaveButton' /></td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div id="bottom2Div">
						<table >
							<tr>
								<th width="120">공동명의 여부</th>
								<td colspan="3"><input type="checkbox" id="JOINYN" name="JOINYN" /></td>
							</tr>
							<tr>
								<th width="120">등기여부</th>
								<td><input type="radio" id="REGYN" name="REGYN" value="Y"/> 등기완료  <input type="radio" id="REGYN" name="REGYN" value="N"/> 미등기</td>
								<th width="120">등기일자</th>
								<td><input type="text" id="REGDATE" name="REGDATE" /></td>
							</tr>
						</table>
						<div align="right">총 건수 : <font color="red"><sapn id="bottomList2Count"></sapn></font>건</div>
						<table id="bottomList2"></table>
						<table align="right">
							<tr>
								<td><input type="button" value="추가" id='tab2InsertButton' /></td>
								<td><input type="button" value="삭제" id='tab2DeleteButton' /></td>
								<td><input type="button" value="저장" id='tab2SaveButton' /></td>
							</tr>
						</table>
					</div>
				</div>
				<div>
					<div id="bottom3Div">
						<div align="right">총 건수 : <font color="red"><sapn id="bottomList3Count"></sapn></font>건</div>
						<table id="bottomList3"></table>
						<table align="right">
							<tr>
								<td><input type="button" value="추가" id='tab3InsertButton' /></td>
								<td><input type="button" value="삭제" id='tab3DeleteButton' /></td>
								<td><input type="button" value="저장" id='tab3SaveButton' /></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>