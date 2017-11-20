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
		$("#searchButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#S_SALEYM").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#S_SALEDATE").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});

		
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
	
		$('#leftList').jqGrid({
			//caption: '급여관리'
			url:"/home/selectListEnaMonthPayMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['지급일자','판매번호','지사', '부서', '직급', 
			          '직책', '사번', '성명', '기본급', '활동비',
			          '일비', '시상금', '총지급액', '신고기준', '소득세',
			          '지방세', '부가가치세', '차감지급액', '입금은행', '계좌번호', '계좌주'] ,
			colModel:[
				 {name:"PAYDATE",		index:'PAYDATE',		width:100,		align:'center', editable:true}
				,{name:"YEARMONTH",		index:'YEARMONTH',		width:100,		align:'center', editable:true}
				,{name:"BRANCHCODE",	index:'BRANCHCODE',		width:100,		align:'center', editable:true}
				,{name:"DEPTCODE",		index:'DEPTCODE',		width:100,		align:'center', editable:true}
				,{name:"GRADE",			index:'GRADE',			width:100,		align:'center', editable:true}
				,{name:"DUTY",			index:'DUTY',			width:100,		align:'center', editable:true}
				,{name:"INSACODE",		index:'INSACODE',		width:100,		align:'center', editable:true}
				,{name:"KNAME",			index:'KNAME',			width:100,		align:'center', editable:true}
				,{name:"BASICAMT",		index:'BASICAMT',		width:120,		align:'center', editable:true}
				,{name:"ACTAMT",		index:'ACTAMT',			width:120,		align:'center', editable:true}
				,{name:"PRIZEAMT",		index:'PRIZEAMT',		width:120,		align:'center', editable:true}
				,{name:"DAILYAMT",		index:'DAILYAMT',		width:120,		align:'center', editable:true}
				,{name:"TOTALAMT",		index:'TOTALAMT',		width:120,		align:'center', editable:true}
				,{name:"TAXGUBUN",		index:'TAXGUBUN',		width:100,		align:'center', editable:true}
				,{name:"TAXINCOME",		index:'TAXINCOME',		width:120,		align:'center', editable:true}
				,{name:"TAXLOCAL",		index:'TAXLOCAL',		width:120,		align:'center', editable:true}
				,{name:"SUPPLYTAX",		index:'SUPPLYTAX',		width:120,		align:'center', editable:true}
				,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:120,		align:'center', editable:true}
				,{name:"BANKID",		index:'BANKID',			width:100,		align:'center', editable:true}
				,{name:"ACCTNO",		index:'ACCTNO',			width:150,		align:'center', editable:true}
				,{name:"ACCTOWNER",		index:'ACCTOWNER',		width:100,		align:'center', editable:true}
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
	
	$(function() {
		$("#insertButton").click(function() {
			
			$("#S_FLAG_B1").val("I");
				
	 		$("#leftList").jqGrid("addRow", 0); 				
				
		});
	})	
	
	$(function() {
		$("#saveButton").click(function() {
			var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("그리드를 선택하셔야 합니다.");
				
				return false;
			}
			
			//jqGrid SelectBox 는 뷰 모드 전에 값을 가져옴.
//			var appointGubun = $("#bottomList1 [name=APPOINTGUBUN] option:selected").val();
			
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
			if ($("#S_FLAG_B1").val() == "I") {
				msg = "저장하시겠습니까?";
			} else {
				msg = "수정하시겠습니까?"
			}
	
			if (confirm(msg) == true) {
				var formData = "S_FLAG_B1=" + $("#S_FLAG_B1").val() +  
							   "&PAYDATE=" + cellData.PAYDATE + 
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
					url: "/home/updateEnaMonthPayMst.do", 
					dataType : 'json' , 
					success: function(data){
						if(data.rows[0].MSG == "success"){
							$("#S_FLAG_B1").val("U");							
							v_rightLastSel = 0;
							alert("저장이 완료되었습니다.");
							selectListEnaMonthPayMst();
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
				selectListEnaMonthPayMst();
			}
		});
	})
		
	
	//	$(function() {
	//		$("#deleteB2Button").click(function() {
	//			var ids = $("#bottomList1").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
	//			if (ids == null || ids == "") {
	//				alert("그리드를 선택하셔야 합니다.");
				
	//				return false;
	//			}
			
	//			$('#bottomList1').jqGrid('saveRow',ids,false,'clientArray'); //선택된 놈 뷰 모드로 변경
	
	//			var cellData = $("#bottomList1").jqGrid('getRowData', ids); //셀 전체 데이터 가져오기
	//			var msg = "삭제하시겠습니까?";
	//			if (confirm(msg) == true) {
	//				var formData = "INSACODE=" + $("#INSACODE").val() + 
	//							   "&APPOINTSEQ=" + cellData.APPOINTSEQ ;
				
	//				$.ajax({ 
	//					type: 'POST' ,
	//					data: formData,
	//					url: "/home/updateEnaAppointItem.do", 
	//					dataType : 'json' , 
	//					success: function(data){
	//						if(data.rows[0].MSG == "success"){
	//							$("#S_FLAG_B1").val("U");							
	//							v_rightLastSel = 0;
	//							alert("저장이 완료되었습니다.");
	//							selectListInsaMst();
	//						}else{
	//							alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
	//						}
						
	//					},
	//					error:function(e){  
	//						alert("발령 사항을 저장하는 중 오류가 발생하였습니다.");
	//					}  	
	//				});
	//			} else {
	//				v_rightLastSel = 0;
	//				$("#searchButton").click();
	//			}
	//		});
	//	})		
		
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
		<div id="bottomDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<th width="120">지급년월</th>
					<td width="100"><input type="text" id="S_SALEYM" name="S_SALEYM" /></td>
					<th width="120">지급일자</th>
					<td width="100"><input type="text" id="S_SALEDATE" name="S_SALEDATE" /></td>
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
			<input type="hidden" id="S_FLAG_B1" name="S_FLAG_B1" />
			<table id="leftList"></table>
		</div>
	</div>
	
</body>
</html>