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

	var v_bottomCellId = 0;
	var auth_i = true;
	var auth_d = true;
	
	$(document).ready(function(){
		$("#dtlData").hide();
		
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });

		$("#addButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteButton2").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton2").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#searchButton").jqxButton({ theme: 'energyblue', width: 25, height: 25, imgPosition: "center", imgSrc: "/resource/jqwidgets-ver5.4.0/jqwidgets/styles/images/icon-right.png", textImageRelation: "overlay" });
		<%if ("N".equals(session.getAttribute("AUTH_I"))) { %>
			$("#insertButton").hide();
			$("#saveButton").hide();
			$("#addButton").hide();
			$("#saveButton2").hide();
			auth_i = false;
		<% }%>
		<%if ("N".equals(session.getAttribute("AUTH_D"))) { %>
			$("#deleteButton").hide();
			$("#deleteButton2").hide();
			auth_d = false;
		<% }%>
		
		
		$("#SL_IPGUMDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SL_IPGUMDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SL_IPGUMAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		
		$("#IPGUMDATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#IPGUMID").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#IPGUMPERSON").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#IPGUMAMT").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#SUGUMAMT").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#JANAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		$("#CONNAME").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
		$("#CONPY").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#REMARK").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		
		$("#IPGUMID").attr("readonly","readonly");		
		
		$("#S_FLAG_L").val("I");
		$("#S_FLAG_D").val("I");
		
		f_selectListEnaIpgumTypeCode();
		f_selectListEnaIpgumGubunCode();
		f_selectListEnaBankGubunCode();
		
		f_selectListEnaSalerCode();

		f_selectListEnaBranchCode();
		f_selectListEnaKnameCode();
		
		f_selectListEnaSIpgumGubunCode();
		f_selectListEnaSBankGubunCode();
		
		f_selectListEnaIpgumMst();
		f_selectListEnaIpgumDtl();
		
	});
	
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
				f_selectListEnaKnameCode();
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	$(function(){
		$("#BRANCHNAME").change(function() {
			f_selectListEnaKnameCode();
		});
	});
	
	function f_selectListEnaKnameCode(){
		
		var BRANCHCODE = $("#BRANCHNAME").val();
		$("#KNAME").empty().data('options');
		
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
				$("#KNAME").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	
	function f_selectListEnaSalerCode(){
		var BRANCHCODE = "";
		
		$("#SL_KNAME").empty().data('options');
		
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/insaMstList.do", 
			dataType : 'json' , 
			data : {
				BRANCHCODE : BRANCHCODE,
			},
			success: function(data){
				var inHtml = "";
				inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
				data.insaMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.INSACODE + "'>" + currentValue.KNAME + "</option>\n";
				});
				$("#SL_KNAME").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	
	function f_selectListEnaIpgumTypeCode(){
		var CCODE = "012";
		$("#IPGUMTYPE").empty().data('options');
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
				$("#IPGUMTYPE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaIpgumGubunCode(){
		var CCODE = "009";
		$("#IPGUMGUBUN").empty().data('options');
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
				$("#IPGUMGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaBankGubunCode(){
		$("#BANKGUBUN").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/bankList.do", 
			dataType : 'json' ,
			success: function(data){
				var inHtml = "";
				data.bankList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.bankCode + "'>" + currentValue.bankName + "</option>\n";
				});
				$("#BANKGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaSIpgumGubunCode(){
		var CCODE = "009";
		$("#SL_IPGUMGUBUN").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/dcodeList.do", 
			dataType : 'json' ,
			data : {
				CCODE : CCODE,
			},
			success: function(data){
				var inHtml = "";
				inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
				data.dcodeList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
				});
				$("#SL_IPGUMGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaSBankGubunCode(){
		$("#SL_BANKGUBUN").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/bankList.do", 
			dataType : 'json' ,
			success: function(data){
				var inHtml = "";
				inHtml += "<option value='ALL' selected='selected'>전체</option>\n";
				data.bankList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.bankCode + "'>" + currentValue.bankName + "</option>\n";
				});
				$("#SL_BANKGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	
	function f_selectListEnaIpgumMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '입금관리'
			url:"/home/selectListEnaIpgumMst.do" ,
			datatype:"json" ,
			postData : {
				
				SL_IPGUMDATE_FR : $("#SL_IPGUMDATE_FR").val(),
				SL_IPGUMDATE_TO : $("#SL_IPGUMDATE_TO").val(),
				SL_KNAME : $("#SL_KNAME").val(),
				SL_IPGUMGUBUN : $("#SL_IPGUMGUBUN").val(),
				SL_BANKGUBUN : $("#SL_BANKGUBUN").val(),
				SL_IPGUMAMT : $("#SL_IPGUMAMT").val()
			},
			loadError:function(){alert("Error~!!");} ,
			colNames:['입금번호', '입금일자', '입금인', '입금금액', '입금구분',
			          '입금처리금액', '미처리잔액',
			          '입금형태', '입금은행', '지사', '담당자', '소재지', '계약자', '평수', '비고'
			          ] ,
			colModel:[
				{name:"IPGUMID",		index:'IPGUMID',		width:100,		align:'center', hidden:true}
				,{name:"IPGUMDATE",		index:'IPGUMDATE',		width:100,		align:'center'}
				,{name:"IPGUMPERSON",	index:'IPGUMPERSON',	width:100,		align:'center'}
				,{name:"IPGUMAMT",		index:'IPGUMAMT',		width:100,		align:'center'}
				,{name:"IPGUMGUBUN",	index:'IPGUMGUBUN',		width:100,		align:'center'}
				,{name:"SUGUMAMT",		index:'SUGUMAMT',		width:100,		align:'center'}
				,{name:"JANAMT",		index:'JANAMT',			width:100,		align:'center'}
				
				,{name:"IPGUMTYPE",		index:'IPGUMTYPE',	width:100,	align:'center', hidden:true}
				,{name:"BANKGUBUN",		index:'BANKGUBUN',	width:100,	align:'center', hidden:true}
				,{name:"BRANCHNAME",	index:'BRANCHNAME',	width:100,	align:'center', hidden:true}
				,{name:"KNAME",			index:'KNAME',		width:100,	align:'center', hidden:true}
				,{name:"ADDRESS",		index:'ADDRESS',	width:100,	align:'center', hidden:true}
				,{name:"CONNAME",		index:'CONNAME',	width:100,	align:'center', hidden:true}
				,{name:"CONPY",			index:'CONPY',		width:100,	align:'center', hidden:true}
				,{name:"REMARK",		index:'REMARK',		width:100,	align:'center', hidden:true}

			] ,
			rowNum:100,
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
			onSelectRow: function(ids){
				v_bottomCellId = 0;
				$("#S_FLAG_L").val("U");
				var selRowData = $(this).jqGrid('getRowData', ids);
				var IPGUMID = selRowData.IPGUMID;
				
				$("#IPGUMDATE").val(selRowData.IPGUMDATE);
				$("#IPGUMID").val(selRowData.IPGUMID);
				
				$("#IPGUMTYPE").val(selRowData.IPGUMTYPE);
				$("#IPGUMGUBUN").val(selRowData.IPGUMGUBUN);
				
				$("#BANKGUBUN").val(selRowData.BANKGUBUN);
				
				$("#IPGUMPERSON").val(selRowData.IPGUMPERSON);
				$("#IPGUMAMT").val(selRowData.IPGUMAMT);
				$("#SUGUMAMT").val(selRowData.SUGUMAMT);
				$("#JANAMT").val(selRowData.JANAMT);
				
				$("#BRANCHNAME").val(selRowData.BRANCHNAME);
				
				$("#KNAME").val(selRowData.KNAME);
				
				$("#ADDRESS").val(selRowData.ADDRESS);
				$("#CONNAME").val(selRowData.CONNAME);
				$("#CONPY").val(selRowData.CONPY);
				$("#REMARK").val(selRowData.REMARK);
				
				f_selectListEnaIpgumDtl();
			} ,
			/*
			loadComplete: function(ids) {
				var ipgumid = $("#IPGUMID").val();
				
				var ids = jQuery("#leftList").jqGrid('getDataIDs');
				
				ids.some(function(currentValue, index, array){
					var cellData = $("#leftList").jqGrid('getCell', ids[index], 'IPGUMID');
					if (cellData == ipgumid) {
						$("#S_FLAG_L").val("U");
		        		$("#leftList").jqGrid('setSelection', ids[index]);
		    			return true;
		        	} else {
		        		$("#S_FLAG_L").val("I");
		        	}	        
				});
			},
			*/
			hidegrid: false
		});
	}
	
	function f_selectListEnaIpgumDtl(){
		$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList').jqGrid({
			//caption: '입금 스케쥴 관리'
			url:"/home/selectListEnaIpgumDtl.do" ,
			datatype:"json" ,
			postData : {
				IPGUMID : $("#IPGUMID").val()
			},
			loadError:function(){alert("Error~!!");} ,
			colNames:['계약번호', '계약일자', '계약구분', '계약자', '계약자 연락처',
			          '계약자 주소', '계약면적', '계약평수', '계약대금(실판매가)', '입금구분',
			          '입금예정일', '입금예정금액', '처리금액', '처리순번', '입금순번'] ,
			colModel:[  
				{name:"SALEID",			index:'SALEID',			width:100,		align:'center', editable:false}
				, {name:"SALEDATE",		index:'SALEDATE',		width:100,		align:'center', editable:false}
				, {name:"SALEGUBUN",	index:'SALEGUBUN',		width:100,		align:'center', editable:false}
				, {name:"CONNAME",		index:'CONNAME',		width:100,		align:'center', editable:false}
				, {name:"CONTELNO",		index:'CONTELNO',		width:100,		align:'center', editable:false}
				, {name:"CONADDRESS",	index:'CONADDRESS',		width:100,		align:'center', editable:false}
				, {name:"CONM2",		index:'CONM2',			width:100,		align:'center', editable:false}
				, {name:"CONPY",		index:'CONPY',			width:100,		align:'center', editable:false}
				, {name:"SELLAMT",		index:'SELLAMT',		width:100,		align:'center', editable:false}
				, {name:"DEPOSITGUBUN",	index:'DEPOSITGUBUN',	width:100,		align:'center', editable:false}
				, {name:"DEPOSITDATE",	index:'DEPOSITDATE',	width:100,		align:'center', editable:false}
				, {name:"DEPOSITAMT",	index:'DEPOSITAMT',		width:100,		align:'center', editable:false}
				, {name:"SUGUMAMT",		index:'SUGUMAMT',		width:100,		align:'center', editable:true}
				, {name:"SEQ",			index:'SEQ',			width:100,		align:'center', editable:false, hidden:true}
				, {name:"IPGUMSEQ",		index:'IPGUMSEQ',		width:100,		align:'center', editable:false, hidden:true}
			] ,
			rowNum:100 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'SORTKEY' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(id){
				if (id > 0) {
					$("#S_FLAG_D").val("U");
				} else {
					$("#S_FLAG_D").val("I");
				}
				
				if( v_bottomCellId != id ){
					$(this).jqGrid('restoreRow',v_bottomCellId,true);    //해당 row 가 수정모드에서 뷰모드(?)로 변경
			        $(this).jqGrid('editRow',id,false);  //해당 row가 수정모드(?)로 변경

			        v_bottomCellId = id;
				}
				
			} ,
			hidegrid: false
		});
	}


	$(function() {
		$("#selectButton").click(function() {
			
			
			var txtEle = $("#SA011003 input[type=text], select");
			  
			for(var i = 0; i < txtEle.length; i ++){
				$(txtEle[i]).val("");
			}

			$("#S_FLAG_L").val("I");
			$("#S_FLAG_D").val("I");
			f_selectListEnaIpgumMst();
			f_selectListEnaIpgumDtl();
			
		});

		$("#saveButton").click(function() {
			var formData = $("#SA011003").serialize();
			
		   	$.ajax({ 
				type: 'POST' ,
				url: "/home/updateEnaIpgumMst.do", 
				dataType : 'json' ,
				data : formData,
				success: function(data){
					if(data.rows[0].MSG == "success")
					{
						alert("저장이 완료되었습니다.");
						f_selectListEnaIpgumMst();
					}else{
						alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
					}
				},
				error:function(e){  
					alert("입금 정보를 저장하는 중 오류가 발생하였습니다.");
				}  
			});
			
		});
		
		$("#deleteButton").click(function() {
			if ($("#S_FLAG_L").val() == "I") {
				alert("데이터를 추가 중 일 경우 삭제 할 수 없습니다.");
				
				return false;
			}
			
			if (confirm("삭제하시겠습니까?") == true) {
				$.ajax({ 
					type: 'POST' ,
					data: "IPGUMID=" + $("#IPGUMID").val(),
					url: "/home/deleteEnaIpgumMst.do", 
					dataType : 'json' , 
					success: function(data){
						alert(data.resultMsg);
						
						$("#selectButton").click();
					},
					error:function(e){  
						alert("[ERROR]선택 입금관리 데이터 삭제  중 오류가 발생하였습니다.");
					}  
				});
			}
		});
		
		$("#searchButton").click(function() {
			var ipgumdate = $("#IPGUMDATE").val();
			//alert("ipgumdate==>"+ipgumdate);
			
			if (ipgumdate == "") {
				alert("입금일자를 입력하셔야 합니다.");
				
				$("#IPGUMDATE").focus();
				return false;
			}
			
			$("#SL_IPGUMDATE_FR").val(ipgumdate);
			$("#SL_IPGUMDATE_TO").val(ipgumdate);
			
			$("#S_FLAG_L").val("I");
			$("#S_FLAG_D").val("I");
			
			f_selectListEnaIpgumMst();
			f_selectListEnaIpgumDtl();
		});
		
		$("#addButton").click(function() {
			if($("#S_FLAG_D").val() == "U"){
				alert("추가 작업 중입니다.");
				return false;
			}
			var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("선택된 입금정보가 없습니다.");
				
				return false;
			}
			
			
			//팝업
			var popUrl = "/home/SA011003_salePopup.do";	//팝업창에 출력될 페이지 UR
			var popOption = "width=730, height=440, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"매출조회",popOption);
			
		});

		$("#deleteButton2").click(function() {

			//alert("v_bottomCellId==>"+v_bottomCellId+":S_FLAG_D=>"+$("#S_FLAG_D").val());
			if($("#IPGUMID").val() == ""){
				alert("입금일자 조회 후 삭제 할 수 없습니다.");
				
				return false;
			}
			
			if(v_bottomCellId == 0 || v_bottomCellId == ""){
				alert("그리드를 선택하셔야 합니다.");
				
				return false;
			}
			if ($("#S_FLAG_D").val() == "I") {
				alert("데이터를 추가 중 일 경우 삭제 할 수 없습니다.");
				
				return false;
			}
			
			if (confirm("삭제하시겠습니까?") == true) {
				var ids = $("#bottomList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
				
				$('#bottomList').jqGrid('saveRow',v_bottomCellId,false,'clientArray'); //선택된 놈 뷰 모드로 변경

				var cellData = $("#bottomList").jqGrid('getRowData', v_bottomCellId); //셀 전체 데이터 가져오기
				
				var formData = "IPGUMID=" + $("#IPGUMID").val() + 
				"&SEQ=" + cellData.SEQ + 
				"&SALEID=" + cellData.SALEID + 
				"&IPGUMSEQ=" + cellData.IPGUMSEQ + 
				"&SUGUMAMT=" + cellData.SUGUMAMT;
				alert(formData);
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/deleteEnaIpgumDtl.do", 
					dataType : 'json' , 
					success: function(data){
						alert(data.resultMsg);
						
						f_selectListEnaIpgumMst();

						$("#selectButton").click();
					},
					error:function(e){  
						alert("[ERROR]선택 입금관리 데이터 삭제  중 오류가 발생하였습니다.");
					}  
				});
			}
		});

		$("#saveButton2").click(function() {
			var ids = $("#bottomList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			$('#bottomList').jqGrid('saveRow',v_bottomCellId,false,'clientArray'); //선택된 놈 뷰 모드로 변경

			var cellData = $("#bottomList").jqGrid('getRowData', v_bottomCellId); //셀 전체 데이터 가져오기
			
			if (v_bottomCellId == 0 || v_bottomCellId == "") {
				alert("그리드를 선택하셔야 합니다.");
				
				return false;
			}
			
/* 			if (cellData.PAYAMT == "") {
				alert("지급금액를 입력하셔야 합니다.");
				
				$('#rightList1').jqGrid('editRow', v_rightLastSel_1, true);
				$("#"+ids+"_PAYAMT").focus();
				
				return false;
			}
 */			
			var msg = "";
			msg = "저장하시겠습니까?";
			if (confirm(msg) == true) {
				var formData = "IPGUMID=" + $("#IPGUMID").val() + 
				"&SALEID=" + cellData.SALEID + 
				"&IPGUMSEQ=" + cellData.IPGUMSEQ + 
				"&SUGUMAMT=" + cellData.SUGUMAMT;
				
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/updateEnaIpgumDtl.do", 
					dataType : 'json' , 
					success: function(data){
						$("#S_FLAG_R_1").val("U");
						
						v_bottomCellId = 0;
						
						if(data.rows[0].MSG == "success"){
							alert('저장되었습니다.');
						}
						
						f_selectListEnaIpgumMst();
						
					},
					error:function(e){  
						alert("[ERROR]입금상세 관리 저장 중 오류가 발생하였습니다.");
					}  
				});
			} else {
				v_bottomCellId = 0;
				f_selectListEnaIpgumMst();
			}
		});
		
		
	})
	
	function onEnterSubmit() {
		var keyCode = window.event.keyCode;
		var msg = "저장 하시겠습니까?";
		if(keyCode==13){
			if (confirm(msg) == true) {
				$("#saveButton").click();
			}
		}

	}

	function bottomListAdd() {
		
		$("#S_FLAG_D").val("I");
		
		var data = {SALEID:$("#dtl_SALEID").val()
			,SALEDATE:$("#dtl_SALEDATE").val()
			,SALEGUBUN:$("#dtl_SALEGUBUN").val()
			,CONNAME:$("#dtl_CONNAME").val()
			,CONTELNO:$("#dtl_CONTELNO").val()
			,CONADDRESS:$("#dtl_CONADDRESS").val()
			,CONM2:$("#dtl_CONM2").val()
			,CONPY:$("#dtl_CONPY").val()
			,SELLAMT:$("#dtl_SELLAMT").val()
			,DEPOSITGUBUN:$("#dtl_DEPOSITGUBUN").val()
			,DEPOSITDATE:$("#dtl_DEPOSITDATE").val()
			,DEPOSITAMT:$("#dtl_DEPOSITAMT").val()
			,SUGUMAMT:""
			,SEQ:""
			,IPGUMSEQ:$("#dtl_IPGUMSEQ").val()}; 
		
		$("#bottomList").jqGrid("addRow", 0);
		
		var ids = $("#bottomList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
		
		v_bottomCellId = ids;
		
		$("#bottomList").jqGrid("setRowData", ids, data);
		$('#bottomList').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경

		$("#bottomList").jqGrid('editRow', ids, true);
		
	
	}
	
</script>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left;padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id='selectButton' /></td>
					<td><input type="button" value="추가" id='insertButton' /></td>
					<td><input type="button" value="삭제" id='deleteButton' /></td>
					<td><input type="button" value="저장" id='saveButton' /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">입금기간</th>
					<td colspan="3"><input type="text" id="SL_IPGUMDATE_FR" name="SL_IPGUMDATE_FR" /> ~ <input type="text" id="SL_IPGUMDATE_TO" name="SL_IPGUMDATE_TO" /></td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td>
						<select id="SL_KNAME" name="SL_KNAME">
							<option value="ALL">전체</option>
						</select>
					</td>
					<th width="120">입금구분</th>
					<td>
						<select id="SL_IPGUMGUBUN" name="SL_IPGUMGUBUN">
							<option value="ALL">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">금융기관</th>
					<td>
						<select id="SL_BANKGUBUN" name="SL_BANKGUBUN">
							<option value="ALL">전체</option>
						</select>
					</td>
					<th width="120">입금금액</th>
					<td><input type="text" id="SL_IPGUMAMT" name="SL_IPGUMAMT" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; padding: 10px" align="left">
			<form id="SA011003">
			<input type="hidden" id="S_FLAG_L" name="S_FLAG_L" />
			<input type="hidden" id="S_FLAG_D" name="S_FLAG_D" />
			<table width="98%" >
				<tr>
					<th width="120">입금일자/번호</th>
					<td><input type="text" id="IPGUMDATE" name="IPGUMDATE" /><input type="text" id="IPGUMID" name="IPGUMID" readonly/></td>
					<td colspan="2"><input type="button" id='searchButton' /></td>
					
				</tr>
				<tr>
					<th width="120">입금형태</th>
					<td colspan="3">
						<select id="IPGUMTYPE" name="IPGUMTYPE">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">입금구분</th>
					<td colspan="3">
						<select id="IPGUMGUBUN" name="IPGUMGUBUN">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">금융기관</th>
					<td>
						<select id="BANKGUBUN" name="BANKGUBUN">
						</select>
					</td>
					<th width="120">입금인</th>
					<td width="120"><input type="text" id="IPGUMPERSON" name="IPGUMPERSON" /></td>
				</tr>
				<tr>
					<th width="120">입금금액</th>
					<td colspan="3"><input type="text" id="IPGUMAMT" name="IPGUMAMT" /></td>
				</tr>
				<tr>
					<th width="120">처리금액</th>
					<td><input type="text" id="SUGUMAMT" name="SUGUMAMT" readonly/></td>
					<th width="120">미처리금액</th>
					<td><input type="text" id="JANAMT" name="JANAMT" readonly/></td>
				</tr>
				<tr>
					<th width="120">담당지사</th>
					<td>
						<select id="BRANCHNAME" name="BRANCHNAME">
						</select>
					</td>
					<th width="120">담당자</th>
					<td>
						<select id="KNAME" name="KNAME">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">소재지</th>
					<td colspan="3"><input type="text" id="ADDRESS" name="ADDRESS"/></td>
				</tr>
				<tr>
					<th width="120">계약자</th>
					<td><input type="text" id="CONNAME" name="CONNAME"/></td>
					<th width="120">평수</th>
					<td><input type="text" id="CONPY" name="CONPY"/></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="3"><input type="text" id="REMARK" name="REMARK" onkeydown="onEnterSubmit();"/></td>
				</tr>
			</table>
			</form>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="추가" id='addButton' /></td>
					<td><input type="button" value="삭제" id='deleteButton2' /></td>
					<td><input type="button" value="저장" id='saveButton2' /></td>
				</tr>
			</table>
			<br />
			<br />
			<table id="bottomList"></table>
			<table id="dtlData">
				<tr>
					<td><input type="text" id="dtl_SALEID" 			name="dtl_SALEID"/></td>
					<td><input type="text" id="dtl_SALEDATE" 		name="dtl_SALEDATE"/></td>
					<td><input type="text" id="dtl_SALEGUBUN" 		name="dtl_SALEGUBUN"/></td>
					<td><input type="text" id="dtl_CONNAME" 		name="dtl_CONNAME"/></td>
					<td><input type="text" id="dtl_CONTELNO" 		name="dtl_CONTELNO"/></td>
					<td><input type="text" id="dtl_CONADDRESS" 		name="dtl_CONADDRESS"/></td>
					<td><input type="text" id="dtl_CONM2" 			name="dtl_CONM2"/></td>
					<td><input type="text" id="dtl_CONPY" 			name="dtl_CONPY"/></td>
					<td><input type="text" id="dtl_SELLAMT" 		name="dtl_SELLAMT"/></td>
					<td><input type="text" id="dtl_DEPOSITGUBUN" 	name="dtl_DEPOSITGUBUN"/></td>
					<td><input type="text" id="dtl_DEPOSITDATE" 	name="dtl_DEPOSITDATE"/></td>
					<td><input type="text" id="dtl_DEPOSITAMT" 		name="dtl_DEPOSITAMT"/></td>
					<td><input type="text" id="dtl_SEQ" 			name="dtl_SEQ"/></td>
					<td><input type="text" id="dtl_IPGUMSEQ" 		name="dtl_IPGUMSEQ"/></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>