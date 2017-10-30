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

	$(function(){

		$('#leftList').jqGrid({
			//caption: '인사관리', 
			url:"/home/selectListSysMst.do" ,
			datatype:"json",
			loadError:function(){alert("Error~!!");},
			colNames:['사번', '성명', '주민번호', '연락처', '소속지사코드', '소속지사', '소속부서코드', '소속부서'],
			colModel:[
				{name:"INSACODE",		index:'INSACODE',		width:100,	align:'center', hidden:true}
				, {name:"KNAME",		index:'KNAME',			width:100,	align:'center'}
				, {name:"JUMINID",		index:'JUMINID',		width:100,	align:'center'}
				, {name:"MOBILENO",		index:'MOBILENO',		width:100,	align:'center'}
				, {name:"BRANCHCODE",	index:'BRANCHCODE',		width:100,	align:'center', hidden:true}
				, {name:"BRANCHNAME",	index:'BRANCHNAME',		width:100,	align:'center'}
				, {name:"DEPTCODE",		index:'DEPTCODE',		width:100,	align:'center', hidden:true}
				, {name:"DEPTNAME",		index:'DEPTNAME',		width:100,	align:'center'}
			],
			rowNum:10,
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
			onSelectRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
		        
				f_selectEnaInsaMst(selRowData.SYSID);
			} ,
			hidegrid: false
		});

 		$('#bottomList1').jqGrid({
			//caption: '발령사항'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['발령구분', '발령일자', '발령지사', '발령부서', '직급', '직책', '고용구분', '월정지급액', '비고'] ,
			colModel:[
				{name:"appointGubun",		index:'appointGubun',		width:60,		align:'center'}
				, {name:"appointDate",		index:'appointDate',		width:60,		align:'center'}
				, {name:"appointBranch",		index:'appointBranch',		width:60,		align:'center'}
				, {name:"appointDept",		index:'appointDept',		width:60,		align:'center'}
				, {name:"grade",				index:'grade',				width:60,		align:'center'}
				, {name:"duty",				index:'duty',				width:60,		align:'center'}
				, {name:"employGubun",		index:'employGubun',		width:60,		align:'center'}
				, {name:"preBasicPay",		index:'preBasicPay',		width:60,		align:'center'}
				, {name:"remark",			index:'remark',				width:60,		align:'center'}
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
			onSelectRow: function(id){
				alert(id);
			} ,
			hidegrid: false
		});

		
		$('#bottomList2').jqGrid({
			//caption: '신고인관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['소득신고인', '주민번호', '거래은행', '계좌번호', '계좌주', '기본계좌', '비고'] ,
			colModel:[
				{name:"payerName",		index:'payerName',		width:60,		align:'center'}
				, {name:"payerId",		index:'payerId',		width:60,		align:'center'}
				, {name:"bankId",		index:'bankId',			width:60,		align:'center'}
				, {name:"acctNo",		index:'acctNo',			width:60,		align:'center'}
				, {name:"acctOwner",	index:'acctOwner',		width:60,		align:'center'}
				, {name:"acctOwner",	index:'acctOwner',		width:60,		align:'center'}
				, {name:"remark",		index:'remark',			width:60,		align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'payerName' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: '96%' ,
			jsonReader: {
				repeatitems: false
			},
			//, height: '100%'
			onSelectRow: function(id){
				alert(id);
			} ,
			hidegrid: false
		});
	})
	
	function f_selectEnaInsaMst(S_INSACODE){
	   	$.ajax({ 
			type: 'POST' ,
			url: "/home/selectListSysMst.do", 
			dataType : "INSACODE=" + S_INSACODE,
			success: function(data){
				$("#SYSID").val(selRowData.SYSID);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	
	
</script>
<body>

<!-- <div style="width:100%; border:1px solid red;" align=center>
     <div style="width:90%;">
          <div style="width:33%; float:left; border:1px solid #333;">1</div>
          <div style="width:34%; float:left; border:1px solid #333;">2</div>
     </div>
</div>
 -->


	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%" class="blueone">
				<tr>
					<th>지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE">
							<option>서울</option>
							<option>경기</option>
							<option>부산</option>
						</select>
					</td>
					<th>부서</th>
					<td>
						<select id="S_DEPTCODE" name="S_DEPTCODE">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th>성명</th>
					<td colspan="3"><input type="text" class="inputName" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td colspan="3"><input type="text" id="S_JUMINID" name="S_JUMINID" /></td>
				</tr>
			</table>
			<br/>
			<table id="leftList" width="98%"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%" class="blueone">
				<tr>
					<th>성명 / 사번</th>
					<td colspan="3"><input type="text" id="KNAME" name="KNAME" /><input type="text" id="INSACODE" name="INSACODE" /></td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td><input type="text" id="JUMINID" name="JUMINID" /> - <input type="text" id="juminId" name="juminId" /></td>
					<th>생일구분</th>
					<td><input type="radio" id="BIRTHDAYGUBUN" name="BIRTHDAYGUBUN" value="R" />양력 <input type="radio" id="BIRTHDAYGUBUN" name="BIRTHDAYGUBUN" value="F" />음력</td>
				</tr>
				<tr>
					<th>사업자번호</th>
					<td><input type="text" id="SAUPID" name="SAUPID" /> - <input type="text" id="SAUPID" name="SAUPID" /> - <input type="text" id="SAUPID" name="SAUPID" /></td>
					<th>대표자명</th>
					<td><input type="text" id="SAUPOWNER" name="SAUPOWNER" /></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
				</tr>
				<tr>
					<th>핸드폰번호</th>
					<td><input type="text" id="MOBILENO" name="MOBILENO" /></td>
					<th>기타연락처</th>
					<td><input type="text" id="TELNO" name="TELNO" /></td>
				</tr>
				<tr>
					<th>소속지사</th>
					<td colspan="3">
						<select id="BRANCHCODE" name="BRANCHCODE">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th>소속부서</th>
					<td>
						<select id="DEPTCODE" name="DEPTCODE">
							<option></option>
						</select>
					</td>
					<th>월정지급액</th>
					<td><input type="text" id="BASICPAY" name="BASICPAY" /></td>
				</tr>
				<tr>
					<th>고용구분</th>
					<td colspan="3"><input type="radio" id="EMPLOYGUBUN" name="EMPLOYGUBUN" value="R" />정규 <input type="radio" id="EMPLOYGUBUN" name="EMPLOYGUBUN" value="F" />프리</td>
				</tr>
				<tr>
					<th>직급</th>
					<td>
						<select id="GRADE" name="GRADE">
							<option></option>
						</select>
					</td>
					<th>직책</th>
					<td>
						<select id="DUTY" name="DUTY">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th>입사일</th>
					<td><input type="text" id="JOINDATE" name="JOINDATE" /></td>
					<th>재입사여부</th>
					<td><input type="checkbox" id="REJOINYN" name="REJOINYN" /></td>
				</tr>
				<tr>
					<th>퇴사일</th>
					<td colspan="3"><input type="text" id="RETIREDATE" name="RETIREDATE" /></td>
				</tr>
				<tr>
					<th>추천인</th>
					<td colspan="3">
						<select id="RECOID" name="RECOID">
							<option value="recoId">insaCode</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>비고</th>
					<td colspan="3"><input type="text" id="REMARK" name="REMARK" /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table id="bottomList1"></table>
			<table id="bottomList2"></table>
		</div>
	</div>
</body>
</html>