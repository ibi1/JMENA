<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수당 수령인별 신고관리</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>


</head>

<script type="text/javascript">
	var v_rightLastSel = 0;
	$(function(){
		var SALEID = "";
		var PAYSEQ = "";
		var SALEDATE = $("#SALEDATE",opener.document).val();
		var SALEID = $("#SALEID",opener.document).val();
		
		$("#S_SALEDATE").val(SALEDATE);
		$("#S_SALEID").val(SALEID);
		searchLeftList();
		searchbottomList(SALEID,PAYSEQ);
	})


	
	function searchLeftList(){
		$('#leftList').jqGrid({
			caption: '수당지급 현황',
			url:"/home/selectListEnaSudangMst.do" ,
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
				, {name:"TAXGUBUN",		index:'TAXGUBUN',	width:80,		align:'center'}
				, {name:"TAXINCOME",	index:'TAXINCOME',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
				, {name:"TAXLOCAL",		index:'TAXLOCAL',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
				, {name:"SUPPLYTAX",	index:'SUPPLYTAX',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:","}}
				, {name:"DEDUCTAMT",	index:'DEDUCTAMT',	width:80,		align:'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
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
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(id){
				$("#SALEID").val(selRowData.SALEID);
				$("#PAYSEQ").val(selRowData.PAYSEQ);
				$("#REGISTERSEQ").val(selRowData.REGISTERSEQ);
				searchbottomList(SALEID,PAYSEQ);
				
			} ,
			hidegrid: false
		});
	}
	
	function searchbottomList(SALEID,PAYSEQ){
		$('#bottomList').jqGrid({
			caption: '신고인 관리',
			url:"/home/selectListEnaSudangPTb.do" ,
			postData : {
				SALEID : SALEID,
				PAYSEQ : PAYSEQ
			},	
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['성명', '주민번호', '지급금액', '신고기준', '사업소득세', '지방세', '부가가치세', '차감지급액', '거래은행', '계좌번호','계좌주','판매번호','순번','신고인순번','비고'],
			colModel:[  	
				  {name:"PAYERNAME",	index:'PAYERNAME',		width:80,		align:'center', editable:true}
				, {name:"PAYERID",		index:'PAYERID',		width:80,		align:'center', editable:true}
				, {name:"PAYAMT",		index:'PAYAMT',		width:80,		align:'right' , editable:true, formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: '0'}}
				, {name:"TAXGUBUN",		index:'TAXGUBUN',	width:80,		align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=013", buildSelect:f_selectEnaCode}}
				, {name:"TAXINCOME",	index:'TAXINCOME',	width:80,		align:'right' , formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: '0'}}
				, {name:"TAXLOCAL",		index:'TAXLOCAL',	width:80,		align:'right' , formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: '0'}}
				, {name:"SUPPLYTAX",	index:'SUPPLYTAX',	width:80,		align:'right' , formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: '0'}}
				, {name:"DEDUCTAMT",	index:'DEDUCTAMT',	width:80,		align:'right' , formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0,defaultValue: '0'}}
				, {name:"BANKID",		index:'BANKID',		width:80,		align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=005", buildSelect:f_selectEnaCode}}
				, {name:"ACCTNO",		index:'ACCTNO',		width:80,		align:'center', editable:true}
				, {name:"ACCTOWNER",	index:'ACCTOWNER',	width:80,		align:'center', editable:true}
				, {name:"SALEID",		index:'SALEID',		width:60,		align:'center'}
				, {name:"PAYSEQ",		index:'PAYSEQ',		width:60,		align:'center'}
				, {name:"REGISTERSEQ",	index:'REGISTERSEQ',width:60,		align:'center'}
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
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(id){
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
			editoptions: {
                dataEvents: [{type: 'change', fn: function(e){
                   	alert("a");
                   }
                }]

            },			
			hidegrid: false
		});
	}	
		
		
		
	function f_selectEnaCode(data){
		
		var jsonValue = $.parseJSON(data).dcodeList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
		});
		
		result +="</select>";

		return result;		
		
		
// 		var jsonValue = $.parseJSON(data).bankList;
		
// 		var result = "<select>";
		
// 		jsonValue.some(function(currentValue, index, array){
// 			result += "<option value='" + currentValue.bankCode + "'>" + currentValue.bankName + "</option>\n";
// 		});
		
// 		result +="</select>";
// 		return result;
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
			//jqGrid SelectBox 는 뷰 모드 전에 값을 가져옴.
//			var appointGubun = $("#bottomList1 [name=APPOINTGUBUN] option:selected").val();
			
			
			var taxGubun = $("#bottomList [name=TAXGUBUN] option:selected").val();
			var bankId = $("#bottomList [name=BANKID] option:selected").val();
			
			$('#bottomList2').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경
	
			var cellData = $("#bottomList2").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
			
			var payerId = cellData.PAYERID.replace("-","");
			
			
			var msg = "저장하시겠습니까?";
	
			if (confirm(msg) == true) {
				var formData = "S_FLAG=" + $("#S_FLAG").val() +  				
							   "&SALEID=" +  $("#SALEID").val() +  
							   "&PAYSEQ=" +  $("#PAYSEQ").val() +  
							   "&REGISTERSEQ=" +  $("#REGISTERSEQ").val() +  
				               "&PAYERNAME=" + cellData.PAYERNAME + 
				               "&PAYERID=" + payerId + 
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
							$("#S_FLAG_B2").val("U");							
							v_rightLastSel = 0;
							alert("저장이 완료되었습니다.");
							selectListInsaMst();
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
			
			
</script>
<body>	
	<div id="contents" style="width:100%;" align="center">
		<div id="leftDiv" style="width:95%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%">
				<tr>			
				</tr>
			</table>
			<table id="leftList" width="98%"></table>
		</div>
		<table width="99%">
		<tr >
			<td align="right">
				<a class="ui-button ui-widget ui-corner-all" id="insertButton" name="insertButton">수당수령인 추가</a>
				<a class="ui-button ui-widget ui-corner-all" id="deleteB2Button"   name="deleteB1Button">수당수령인 삭제</a>
				<a class="ui-button ui-widget ui-corner-all" id="saveButton"   name="saveButton">저장 </a>
				
			</td>
		</tr>
	</table>		
		<div id=bottomDiv style="width:95%; float:left; border:1px solid #333; padding: 10px" align="left">
		<input type="hidden" id="S_FLAG" name="S_FLAG" />
		<input type="hidden" id="SALEID" name="SALEID" />
		<input type="hidden" id="PAYSEQ" name="PAYSEQ" />
		<input type="hidden" id="REGISTERSEQ" name="REGISTERSEQ" />
			<table width="99%">
				<tr>			
				</tr>
			</table>
			<table id="bottomList" width="98%"></table>
		</div>				
	</div>
</body>
</html>