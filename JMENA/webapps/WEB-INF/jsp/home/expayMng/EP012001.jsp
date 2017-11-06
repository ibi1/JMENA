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
		
		f_selectListEP012001();
		f_selectListEP012001_2();
		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		
		$("#mainList1Div").show();
		$("#mainList2Div").hide();
		
		$('input:radio[name=TAXGUBUN]:input[value=001]').attr("checked", true);

		var S_PAYDATE = "";
		var S_BRANCHCODE = "";
		var S_DEPTCODE = "";
		var S_KNAME = "";
		
		f_selectListEP012001(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
		
	});

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
	
	$(function(){
		$("#S_BRANCHCODE").change(function() {
			f_selectListEnaDeptCode();
		});
	});
	
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
	
	function f_selectListEP012001(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME){
		$('#mainList1').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList1').jqGrid({
			//caption: '월 소득세신고 내역 - 사업소득세', 
			url:"/home/selectListEP012001.do" ,
			datatype:"json",
			postData : {
				S_PAYDATE : S_PAYDATE
				,S_BRANCHCODE : S_BRANCHCODE
				,S_DEPTCODE : S_DEPTCODE
				,S_KNAME : S_KNAME
			},
			loadError:function(){alert("Error~!!");},
			colNames:['지사', '부서', '지급일', '고객', '물건지',
			          '계약면적', '계약평수', '담당자', '소득신고', '주민번호',
			          '총지금액', '소득세', '지방세', '세금 계', '실 지급액'],
			colModel:[
						{name:"BRANCHNAME",		index:'BRANCHNAME',		width:100,	align:'center'}
						,{name:"DEPTNAME",		index:'DEPTNAME',		width:100,	align:'center'}
						,{name:"PAYDATE",		index:'PAYDATE',		width:100,	align:'center'}
						,{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center'}
						,{name:"ADDRESS",		index:'ADDRESS',		width:100,	align:'center'}
						,{name:"CONM2",			index:'CONM2',			width:100,	align:'center'}
						,{name:"CONPY",			index:'CONPY',			width:100,	align:'center'}
						,{name:"KNAME",			index:'KNAME',			width:100,	align:'center'}
						,{name:"PAYERNAME",		index:'PAYERNAME',		width:100,	align:'center'}
						,{name:"PAYERID",		index:'PAYERID',		width:100,	align:'center'}
						,{name:"PAYAMT",		index:'PAYAMT',			width:100,	align:'center'}
						,{name:"TAXINCOME",		index:'TAXINCOME',		width:100,	align:'center'}
						,{name:"TAXLOCAL",		index:'TAXLOCAL',		width:100,	align:'center'}
						,{name:"TOTTAX",		index:'TOTTAX',			width:100,	align:'center'}
						,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:100,	align:'center'}
			],
			rowNum:100,
			autowidth: true,
			shrinkToFit: false,
			rowList:[10,20,30],
			sortname: 'kName',
			viewrecords: true,
			sortorder:'asc',
			width: '96%',
			jsonReader: {
				repeatitems: false
			},
			//height: '100%',
			onSelectRow: function(id){
				alert(id);
			},
			hidegrid: false
		});
	
	}
	function f_selectListEP012001_2(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME){
		$('#mainList2').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList2').jqGrid({
			//caption: '월 소득세신고 내역 - 부가가치세', 
			url:"/home/selectListEP012001_2.do" ,
			datatype:"json",
			postData : {
				S_PAYDATE : S_PAYDATE
				,S_BRANCHCODE : S_BRANCHCODE
				,S_DEPTCODE : S_DEPTCODE
				,S_KNAME : S_KNAME
			},
			loadError:function(){alert("Error~!!");},
			colNames:['지사', '부서', '지급일', '고객', '물건지',
			          '계약면적', '계약평수', '담당자', '회사명', '사업자번호',
			          '총지급액', '공급가', '부가세', '미지급금', '실 지급액'],
			colModel:[
						{name:"BRANCHNAME",		index:'BRANCHNAME',		width:100,	align:'center'}
						,{name:"DEPTNAME",		index:'DEPTNAME',		width:100,	align:'center'}
						,{name:"PAYDATE",		index:'PAYDATE',		width:100,	align:'center'}
						,{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center'}
						,{name:"ADDRESS",		index:'ADDRESS',		width:100,	align:'center'}
						,{name:"CONM2",			index:'CONM2',			width:100,	align:'center'}
						,{name:"CONPY",			index:'CONPY',			width:100,	align:'center'}
						,{name:"KNAME",			index:'KNAME',			width:100,	align:'center'}
						,{name:"SAUPOWNER",		index:'SAUPOWNER',		width:100,	align:'center'}
						,{name:"PAYERID",		index:'PAYERID',		width:100,	align:'center'}
						,{name:"PAYAMT",		index:'PAYAMT',			width:100,	align:'center'}
						,{name:"SUPPLYAMT",		index:'SUPPLYAMT',		width:100,	align:'center'}
						,{name:"SUPPLYTAX",		index:'SUPPLYTAX',		width:100,	align:'center'}
						,{name:"SUPPLYTAX",		index:'SUPPLYTAX',		width:100,	align:'center'}
						,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:100,	align:'center'}
						
			],
			rowNum:100,
			autowidth: true,
			shrinkToFit: false,
			rowList:[10,20,30],
			sortname: 'kName',
			viewrecords: true,
			sortorder:'asc',
			width: '96%',
			jsonReader: {
				repeatitems: false
			},
			//height: '100%',
			onSelectRow: function(id){
				alert(id);
			},
			hidegrid: false
		});
	}
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_PAYDATE = $("#S_PAYDATE").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			var temp = $(':radio[name="TAXGUBUN"]:checked').val();
			
			if(temp == '001'){
				f_selectListEP012001(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
				
			}else{
				f_selectListEP012001_2(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
			}
			
		})
	})

	
	$(function(){
		$("input[name=TAXGUBUN]").change(function() {
			var S_PAYDATE = $("#S_PAYDATE").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			var radioValue = $(this).val();
			
			alert(radioValue);
			
			if (radioValue == "001") {
				$("#mainList1Div").show();
				$("#mainList2Div").hide();
				f_selectListEP012001(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
			} else{
				$("#mainList2Div").show();
				$("#mainList1Div").hide();
				f_selectListEP012001_2(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
			}
		});		
	})
	
	
	
</script>
<body>

	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<td align="right">
						<a class="ui-button ui-widget ui-corner-all" id="selectButton" name="selectButton">조회</a>
						<a class="ui-button ui-widget ui-corner-all" id="excelButton" name="excelButton">엑셀</a>
						<a class="ui-button ui-widget ui-corner-all" id="printButton" name="printButton">출력</a>
					</td>
				</tr>
			</table>
		</div>
		<div id="mainDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<th>지급년월</th>
					<td><input type="text" id="S_PAYDATE" name="S_PAYDATE" /></td>
					<th>지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE">
						</select>
					</td>
					<th>부서</th>
					<td>
						<select id="S_DEPTCODE" name="S_DEPTCODE">
						</select>
					</td>
					<th>담당자명</th>
					<td><input type="text" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
				<tr>
					<th>신고구분</th>
					<td colspan="7"><input type="radio" id="TAXGUBUN" name="TAXGUBUN" value="001"/> 사업소득세   <input type="radio" id="TAXGUBUN" name="TAXGUBUN" value="002"/> 부가가치세 </td>
				</tr>
			</table><br/>
			<div id="mainList1Div" style="width:98%;">
				<table id="mainList1" style="width:98%;"></table>
			</div>
			<div id="mainList2Div" style="width:98%;">
				<table id="mainList2" style="width:98%;"></table>
			</div>
		</div>
	</div>
</body>
</html>