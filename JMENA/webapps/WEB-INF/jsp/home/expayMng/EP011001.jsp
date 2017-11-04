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
		//공통코드 가져오기
//		f_selectListEnaBuyGubnCode();
		f_selectListEnaCityCode();
//		f_selectListEnaBoroughCode();
//		f_selectListEnaUseTypeCode();
		//공통코드 가져오기 끝
		
	});


	$(function(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '수당관리'
			url:"/home/selectListEnaSudangMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['지급일', '담당자', '매출금액', '지급금액', '세액', '차감지급액'] ,
			colModel:[
				{name:"PAYDATE",		index:'PAYDATE',		width:60,		align:'center'}
				,{name:"SALERCD",		index:'SALERCD',		width:60,		align:'center'}
				,{name:"SELLAMT",		index:'SELLAMT',		width:60,		align:'center'}
				,{name:"PAYAMT",		index:'PAYAMT',			width:60,		align:'center'}
				,{name:"TAXAMT",		index:'TAXAMT',			width:60,		align:'center'}
				,{name:"DEDUCTAMT",		index:'DEDUCTAMT',		width:60,		align:'center'}
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
			onSelectRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
				alert(selRowData.ADDRESS);
// 				$("#SALEDATE").val(selRowData.SALEDATE);
// 				$("#SALEID").val(selRowData.SALEID);
// 				$("#SALEGUBUN").val(selRowData.SALEGUBUN);
// 				$("#BRANCHCODE").val(selRowData.BRANCHCODE);
// 				$("#MANAGENO").val(selRowData.MANAGENO);
// 				$("#CITYCODE").val(selRowData.CITYCODE);
				$("#ADDRESS").val(selRowData.ADDRESS);
// 				$("#CONNAME").val(selRowData.CONNAME);
// 				$("#CONM2").val(selRowData.CONM2);
// 				$("#CONPY").val(selRowData.CONPY);
// 				$("#SALEAMT").val(selRowData.SALEAMT);
// 				$("#SALEDANGA").val(selRowData.SALEDANGA);
// 				$("#DCGUBUN").val(selRowData.DCGUBUN);
// 				$("#DCRATE").val(selRowData.DCRATE);
// 				$("#DCAMT").val(selRowData.DCAMT);
// 				$("#SELLAMT").val(selRowData.SELLAMT);
				
// 				$("#PAYDATE").val(selRowData.PAYDATE);
// 				$("#SALERCD").val(selRowData.SALERCD);
// 				$("#SALERNM").val(selRowData.SALERNM);
// 				$("#SUDANGRATE").val(selRowData.SUDANGRATE);
// 				$("#ADDRATE").val(selRowData.ADDRATE);
				
// 				$("#PAYAMT").val(selRowData.PAYAMT);
// 				$("#TAXGUBUN").val(selRowData.TAXGUBUN);
// 				$("#TAXINCOME").val(selRowData.TAXINCOME);
// 				$("#TAXLOCAL").val(selRowData.TAXLOCAL);
// 				$("#SUPPLYTAX").val(selRowData.SUPPLYTAX);
// 				$("#DEDUCTAMT").val(selRowData.DEDUCTAMT);
// 				$("#REMARK").val(selRowData.REMARK);
			} ,
			hidegrid: false
		});

		
		$('#bottomList').jqGrid({
			//caption: '수당지급관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['직책', '직급', '성명', '수당지급율(%)', '추가지급율(%)', '지급금액', '신고기준', '사업소득세', '지방세', '부가가치세', '차감지급액', '신고인 수', '비고'] ,
			colModel:[  			          
				  {name:"GRADE",			index:'GRADE',		width:60,		align:'center'}
//				{name:"SYSID",			index:'SYSID',		width:60,		align:'center',  editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaBranchCode}}
				, {name:"DUTY",			index:'DUTY',		width:60,		align:'center'}
				, {name:"SALERNM",		index:'SALERNM',	width:60,		align:'center'}
				, {name:"SUDANGRATE",	index:'SUDANGRATE',	width:60,		align:'center'}
				, {name:"ADDRATE",		index:'ADDRATE',	width:60,		align:'center'}
				, {name:"PAYAMT",		index:'PAYAMT',		width:60,		align:'center'}
				, {name:"TAXGUBUN",		index:'TAXGUBUN',	width:60,		align:'center'}
				, {name:"TAXINCOME",	index:'TAXINCOME',	width:60,		align:'center'}
				, {name:"TAXLOCAL",		index:'TAXLOCAL',	width:60,		align:'center'}
				, {name:"SUPPLYTAX",	index:'SUPPLYTAX',	width:60,		align:'center'}
				, {name:"DEDUCTAMT",	index:'DEDUCTAMT',	width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"REMARK",		index:'REMARK',		width:60,		align:'center'}
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
				alert(id);
			} ,
			hidegrid: false
		});
	});
	
	
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
	
		
</script>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%" class="blueone">
				<tr>
					<td>지급년월</td>
					<td colspan="3"><input type="text" id="S_SALEDATESYM" name="S_SALEDATESYM" /> ~ <input type="text" id="S_SALEDATEEYM" name="S_SALEDATEEYM" /></td>
				</tr>
				<tr>
					<td>지사</td>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE">
							<option></option>
						</select>
					</td>
					<td>부서</td>
					<td>
						<select id="S_DEPTCODE" name="S_DEPTCODE">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>담당자</td>
					<td colspan="3">
						<input type="text" id="S_SALERCD" name="S_SALERCD" />
					</td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>계약일자/번호</td>
					<td colspan="3"><input type="text" id="SALEDATE" name="SALEDATE" /><input type="text" id="SALEID" name="SALEID" /></td>
				</tr>
				<tr>
					<td>매출구분</td>
					<td colspan="3">
						<select id="SALEGUBUN" name="SALEGUBUN">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>담당자</td>
					<td>
						<select id="SALERCD" name="SALERCD">
							<option></option>
						</select>
					</td>
					<td>계약지사</td>
					<td>
						<select id="BRANCHCODE" name="BRANCHCODE">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>관리번호</td>
					<td>
						<select id="MANAGENO" name="MANAGENO">
							<option></option>
						</select>
					</td>
					<td>지역구분</td>
					<td>
						<select id="CITYCODE" name="CITYCODE">
						</select>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td colspan="3"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
				</tr>
				<tr>
					<td>계약자 성명</td>
					<td colspan="3"><input type="text" id="CONNAME" name="CONNAME" /></td>
				</tr>
				<tr>
					<td>계약면적</td>
					<td><input type="text" id="CONM2" name="CONM2" /></td>
					<td>계약평수</td>
					<td><input type="text" id="CONPY" name="CONPY" /></td>
				</tr>
				<tr>
					<td>매매대금</td>
					<td><input type="text" id="SALEAMT" name="SALEAMT" /></td>
					<td>매매단가</td>
					<td><input type="text" id="SALEDANGA" name="SALEDANGA" /></td>
				</tr>
				<tr>
					<td>DC사항</td>
					<td>
						<select id="DCGUBUN" name="DCGUBUN">
							<option></option>
						</select>
					</td>
					<td>DC 율</td>
					<td><input type="text" id="DCRATE" name="DCRATE" /> % </td>
				</tr>
				<tr>
					<td>DC금액</td>
					<td><input type="text" id="DCAMT" name="DCAMT" /></td>
					<td>실 판매가</td>
					<td><input type="text" id="SELLAMT" name="SELLAMT" /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>지급일자</td>
					<td><input type="text" id="PAYDATE" name="PAYDATE" /></td>
					<td>담당자 성명</td>
					<td colspan="7"><input type="text" id="SALERCD" name="SALERCD" /> <input type="text" id="SALERNM" name="SALERNM" /></td>
				</tr>
				<tr>
					<td>수당지급율(%)</td>
					<td><input type="text" id="SUDANGRATE" name="SUDANGRATE" /></td>
					<td>추가지급율(%)</td>
					<td colspan="5"><input type="text" id="ADDRATE" name="ADDRATE" /></td>
					<td>지급금액</td>
					<td><input type="text" id="PAYAMT" name="PAYAMT" /></td>
				</tr>
				<tr>
					<td>신고기준</td>
					<td><input type="text" id="TAXGUBUN" name="TAXGUBUN" /></td>
					<td>사업소득세</td>
					<td><input type="text" id="TAXINCOME" name="TAXINCOME" /></td>
					<td>지방세</td>
					<td><input type="text" id="TAXLOCAL" name="TAXLOCAL" /></td>
					<td>부가가치세</td>
					<td><input type="text" id="SUPPLYTAX" name="SUPPLYTAX" /></td>
					<td>차감지급액</td>
					<td><input type="text" id="DEDUCTAMT" name="DEDUCTAMT" /></td>
				</tr>
				<tr>
					<td>비고</td>
					<td colspan="9"><input type="text" id="REMARK" name="REMARK" /></td>
				</tr>
			</table>
			<table id="bottomList"></table>
		</div>
	</div>
</body>
</html>