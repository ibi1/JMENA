<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수당 수령인별 신고관리</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.base.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.light.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.energyblue.css" type="text/css" />

	<style>
        html, body
        {
            width: 100%;
            height: 100%;
            padding: 3px;
            box-sizing: border-box;
            margin: 0;
        }
        th
        {
        	height : 22px;
			text-align: center;
			font-weight: bold;
			border: 1px solid #CCC;
        }
        select
        {
		    min-height: 25px;
		    min-width: 16px;
		    margin: 0px;
		    border-width: 1px;
		    border-style: solid;
		    font-size: 13px;
		    padding: 0px;
		    padding-left: 3px;
		    padding-right: 3px;
		    border-color: #a4bed4;
		    -webkit-border-radius: 3px;
		}
        
    </style>

	<script type="text/javascript" src="/resource/js/jquery.js"></script>
	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcore.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxnotification.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxtabs.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxsplitter.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttons.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttongroup.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxformattedinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxnumberinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxlistbox.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcombobox.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxtree.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.pager.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.edit.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.export.js"></script> 
	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>


</head>

<script type="text/javascript">
	var v_rightLastSel = 0;
	$(document).ready(function(){
		
		$("#SALEID").val($("#SALEID",opener.document).val());
		$("#PAYSEQ").val($("#PAYSEQ",opener.document).val());
		$("#S_PAYSEQ").val($("#PAYSEQ",opener.document).val());
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 150, height: 25 });
		$("#deleteButton").jqxButton({ theme: 'energyblue', width: 150, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		var SALEID = $("#SALEID",opener.document).val();
		var PAYSEQ = $("#PAYSEQ",opener.document).val();
		
		searchLeftList();
		searchbottomList();
	})


	
	function searchLeftList(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			caption: '수당지급 현황',
			url:"/home/selectListEnaSudangMst.do" ,
			mtype: 'POST',
			postData : {
				S_SALEID : $("#SALEID").val(),
//				S_PAYSEQ : $("#S_PAYSEQ").val()
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
				, {name:"PAYAMT",		index:'PAYAMT',		width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
				, {name:"TAXGUBUN",		index:'TAXGUBUN',	width:80,		align:'center', edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=013", buildSelect:f_selectEnaCode}}
				, {name:"TAXINCOME",	index:'TAXINCOME',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
				, {name:"TAXLOCAL",		index:'TAXLOCAL',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
				, {name:"SUPPLYTAX",	index:'SUPPLYTAX',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:","}}
				, {name:"DEDUCTAMT",	index:'DEDUCTAMT',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
				, {name:"REGISTERNUM",	index:'REGISTERNUM',width:60,		align:'center'}
				, {name:"REMARK",		index:'REMARK',		width:60,		align:'center'}
				, {name:"SALEID",		index:'SALEID',		width:60,		align:'center'}
				, {name:"PAYSEQ",		index:'PAYSEQ',		width:60,		align:'center'}
				, {name:"INSACODE",		index:'PAYERID',	width:60,		align:'center'}
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
			emptyrecords : "Data가 없습니다.",
			jsonReader: {
				repeatitems: false
			},
			onSelectRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
				$("#SALEID").val(selRowData.SALEID);
				$("#PAYSEQ").val(selRowData.PAYSEQ);								
				searchbottomList(selRowData.SALEID,selRowData.PAYSEQ);
				
			} ,
			loadComplete: function(ids) {
				
			},	
			hidegrid: false
		});
	}
	
	function searchbottomList(SALEID,PAYSEQ){
		$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList').jqGrid({	
			caption: '신고인 관리',
			url:"/home/selectListEnaSudangPTb.do" ,
			mtype: 'POST',
			postData : {
				SALEID : SALEID,
				PAYSEQ : PAYSEQ
// 				SALEID : $("#SALEID").val(),
// 				PAYSEQ : $("#PAYSEQ").val()
			},			
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['성명', '주민번호','대표자명', '지급금액', '신고기준', '사업소득세', '지방세', '부가가치세', '차감지급액', '거래은행', '계좌번호','계좌주','판매번호','순번','신고인순번','비고'],
			colModel:[  	
				  {name:"PAYERNAME",	index:'PAYERNAME',		width:80,		align:'center', editable:true}
				, {name:"PAYERID",		index:'PAYERID',		width:80,		align:'center', editable:true}
				, {name:"SAUPOWNER",	index:'SAUPOWNER',		width:80,		align:'center', editable:true}
				, {name:"PAYAMT",		index:'PAYAMT',			width:80,		align:'right' ,  editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''},
 					editoptions:{
 						dataEvents:[{
 							type:'change',
 							fn:function(e){
 								paycal();
 							}
						}]
					}}					
				, {name:"TAXGUBUN",		index:'TAXGUBUN',	width:80,		align:'center', editable:true
					, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=013", buildSelect:f_selectEnaCode,
						dataEvents:[{
							type:'change',
							fn:function(e){
								if(this.value == ""){
									alert("지급 금액을 입력 해 주세요.");
									return;
								}else{
									paycal();								
								}
							}
						}]
					}}
				, {name:"TAXINCOME",	index:'TAXINCOME',	width:80,		align:'right' , formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				, {name:"TAXLOCAL",		index:'TAXLOCAL',	width:80,		align:'right' , formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				, {name:"SUPPLYTAX",	index:'SUPPLYTAX',	width:80,		align:'right' , formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				, {name:"DEDUCTAMT",	index:'DEDUCTAMT',	width:80,		align:'right' , formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: ''}}
				, {name:"BANKID",		index:'BANKID',		width:80,		align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/bankList.do", buildSelect:f_selectEnaBankCode}}
				, {name:"ACCTNO",		index:'ACCTNO',		width:80,		align:'center', editable:true}
				, {name:"ACCTOWNER",	index:'ACCTOWNER',	width:80,		align:'center', editable:true}
				, {name:"SALEID",		index:'SALEID',		width:60,		align:'center', hidden:true}
				, {name:"PAYSEQ",		index:'PAYSEQ',		width:60,		align:'center', hidden:true}
				, {name:"REGISTERSEQ",	index:'REGISTERSEQ',width:60,		align:'center', hidden:true}
				, {name:"REMARK",		index:'REMARK',		width:60,		align:'center', editable:true}
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
			emptyrecords : "Data가 없습니다.",
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(id){
				var selRowData = $(this).jqGrid('getRowData', id);
				$("#REGISTERSEQ").val(selRowData.REGISTERSEQ);
				if (id > 0) {
					$("#S_FLAG").val("U");
				} else {
					$("#S_FLAG").val("I");
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
				
	function f_selectEnaCode(data){
		
		var jsonValue = $.parseJSON(data).dcodeList;
		
		var result = "<select>";
			result += "<option value=''>선택</option>\n";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
		});
		
		result +="</select>";

		return result;		
	}
		
	function f_selectEnaBankCode(data){
		var jsonValue = $.parseJSON(data).bankList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.bankCode + "'>" + currentValue.bankName + "</option>\n";
		});
		
		result +="</select>";
		return result;
	}		
	
	
	function paycal(){
		var ids = $("#bottomList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
		var cellData = $("#bottomList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
		
		
		var gijunAmt = $("#bottomList [name=PAYAMT] ").val();
		var taxgubun = $("#bottomList [name=TAXGUBUN] ").val();
		
		
		
		if(taxgubun == "001"){
			gijunAmt =  Math.floor(gijunAmt / 10000) * 10000;
			var taxincome = gijunAmt * 3 / 100;    //사업소득세
			var taxlocal = taxincome * 10 / 100;    //지방세
			taxincome = Math.floor(taxincome/10) * 10;
			taxlocal = Math.floor(taxlocal/10) * 10;
			$("#bottomList").setCell(ids,"TAXINCOME",taxincome);
			$("#bottomList").setCell(ids,"TAXLOCAL",taxlocal);
			$("#bottomList").setCell(ids,"SUPPLYTAX","0");
			deductamt = gijunAmt - taxincome - taxlocal;
		}else if (taxgubun == "002"){
			
			var supply = gijunAmt/1.1;
			supply = Math.ceil(supply/10) * 10; //공급가
			var supplytax = supply * 10 / 100;    //부가가치세
			supplytax = Math.floor(supplytax/10) * 10;
			$("#bottomList").setCell(ids,"TAXINCOME","0");
			$("#bottomList").setCell(ids,"TAXLOCAL","0");
			$("#bottomList").setCell(ids,"SUPPLYTAX",supplytax);
			deductamt = gijunAmt - supplytax;
			
		}
		$("#bottomList").setCell(ids,"DEDUCTAMT",deductamt);
	}
				
		
	
	
	$(function() {
		$("#insertButton").click(function() {
			var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
		
			if (ids == null || ids == "") {
				alert("선택된 사원이 없습니다.");
			
				return false;
			}		
			
	 		$("#bottomList").jqGrid("addRow", 0);
				
		});
	})
	
	$(function() {
		$("#saveButton").click(function() {
			var ids = $("#bottomList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("그리드를 선택하셔야 합니다.");
				
				return false;
			}	
			
			var taxGubun = $("#bottomList [name=TAXGUBUN] option:selected").val();
			var bankId = $("#bottomList [name=BANKID] option:selected").val();
			
			$('#bottomList').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경
	
			var cellData = $("#bottomList").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
			
			var payerId = cellData.PAYERID.replace("-","");
			
			if (cellData.PAYERNAME == "") {
				alert("성명을 입력하셔야 합니다.");
			
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"PAYERNAME").focus();
			
				return false;
			}
			
			if (payerId == "") {
				alert("주민번호를 입력하셔야 합니다.");
			
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"PAYERID").focus();
			
				return false;
			}

			if (cellData.SAUPOWNER == "") {
				alert("대표자명을 입력하셔야 합니다.");
			
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"SAUPOWNER").focus();
			
				return false;
			}
			if (cellData.PAYAMT == "") {
				alert("지급금액을 입력하셔야 합니다.");
			
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"PAYAMT").focus();
			
				return false;
			}
			
			if (taxGubun == "") {
				alert("신고기준을 선택하셔야 합니다.");
			
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"PAYAMT").focus();
			
				return false;
			}
			
			if (bankId == "") {
				alert("거래은행을 선택하셔야 합니다.");
			
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"BANKID").focus();
			
				return false;
			}
			
			if (cellData.ACCTNO == "") {
				alert("계좌번호를 입력하셔야 합니다.");
			
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"ACCTNO").focus();
			
				return false;
			}
			
			if (cellData.ACCTOWNER == "") {
				alert("계좌주를 입력하셔야 합니다.");
			
				$('#rightList').jqGrid('editRow', ids, true);
				$("#"+ids+"ACCTOWNER").focus();
			
				return false;
			}
					
			var msg = "저장하시겠습니까?";
			if (confirm(msg) == true) {				
				var formData = "S_FLAG=" + $("#S_FLAG").val() +  				
							   "&SALEID=" +  $("#SALEID").val() +  
							   "&PAYSEQ=" +  $("#PAYSEQ").val() +  
							   "&REGISTERSEQ=" +  $("#REGISTERSEQ").val() +  
				               "&PAYERNAME=" + cellData.PAYERNAME + 
				               "&PAYERID=" + payerId + 
				               "&SAUPOWNER=" + cellData.SAUPOWNER + 
				               "&PAYAMT=" + cellData.PAYAMT + 
				               "&TAXGUBUN=" + taxGubun + 
				               "&TAXINCOME=" + cellData.TAXINCOME + 
				               "&TAXLOCAL=" + cellData.TAXLOCAL + 
				               "&SUPPLYTAX=" + cellData.SUPPLYTAX + 
				               "&DEDUCTAMT=" + cellData.DEDUCTAMT + 
				               "&BANKID=" + bankId+
				               "&ACCTNO=" + cellData.ACCTNO+
				               "&ACCTOWNER=" + cellData.ACCTOWNER+
				               "&REMARK=" + cellData.REMARK;								
				
				$.ajax({ 
					type: 'POST' ,
					data: formData,
					url: "/home/updateEnaSudangPTb.do", 
					dataType : 'json' , 
					success: function(data){
						if(data.rows[0].MSG == "success"){
							$("#S_FLAG").val("U");							
							v_rightLastSel = 0;
							alert("저장이 완료되었습니다.");
							searchbottomList();
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
				selectListInsaMst();
			}
		});
	})
			
	$(function() {
		$("#deleteButton").click(function() {
			
			if ($("#S_FLAG").val() == "I") {
				alert("추가 중 일 경우 삭제할 수 없습니다.");
				return;
			}
			
			var ids = $("#bottomList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("그리드를 선택하셔야 합니다.");
				return;
			}
			
			$('#bottomList').jqGrid('saveRow',v_rightLastSel,false,'clientArray'); //선택된 놈 뷰 모드로 변경

			var cellData = $("#bottomList").jqGrid('getRowData', v_rightLastSel); //셀 전체 데이터 가져오기

			if (confirm("삭제하시겠습니까?") == true) {
				$.ajax({ 
					type: 'POST' ,
					data: "SALEID=" + $("#SALEID").val() + 
						  "&PAYSEQ=" + $("#PAYSEQ").val() +
						  "&REGISTERSEQ=" + $("#REGISTERSEQ").val(),
					url: "/home/deleteEnaSudangPTb.do", 
					dataType : 'json' , 
					success: function(data){
						
						v_rightLastSel = 0;
						
						alert("삭제가 완료되었습니다.");
						searchbottomList();
					},
					error:function(e){  
						alert("[ERROR]신고인 관리 삭제  중 오류가 발생하였습니다.");
					}  
				});
			} else {
				v_rightLastSel = 0;
				searchbottomList();
			}
				
		});
	})
			
</script>
<body>	
	<div id="contents" style="width:100%;" align="center">
		<div id="leftDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table id="leftList" width="98%"></table>
		</div>
		<table align="right">
			<tr >
				<td><input type="button" value="수당수령인 추가" id='insertButton' /></td>
				<td><input type="button" value="수당수령인 삭제" id='deleteButton' /></td>
				<td><input type="button" value="저장" id='saveButton' /></td>
			</tr>
		</table>
		<div id=bottomDiv style="width:98%; float:left; padding: 10px" align="left">
			<input type="hidden" id="S_FLAG" name="S_FLAG" />
			<input type="hidden" id="SALEID" name="SALEID" />
			<input type="hidden" id="PAYSEQ" name="PAYSEQ" />
			<input type="hidden" id="S_PAYSEQ" name="S_PAYSEQ" />
			<input type="hidden" id="REGISTERSEQ" name="REGISTERSEQ" />
			<table id="bottomList" width="98%"></table>
		</div>				
	</div>
</body>
</html>