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
		
		f_selectListHR012003();
	});
	
	
	function f_selectListHR012003(){
		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '인원현황', 
			url:"/home/selectListSysMst.do" ,
			datatype:"json",
			loadError:function(){alert("Error~!!");},
			colNames:['지사코드', '지사', '부서코드', '부서', '직급', '성명', '추천인사번','추천인', 
			          '입사일', '전근무지', '입사', '퇴사', '고용구분', 
			          '연락처', '주민번호', '새일구분', '입금자명', '은행코드','은행명', 
			          '계좌번호', '성명', '주민번호', '주소'],
			colModel:[
						{name:"BRANCHCODE",			index:'BRANCHCODE',			width:100,	align:'center', hidden:true}
						, {name:"BRANCHNAME",		index:'BRANCHNAME',			width:100,	align:'center'}
						, {name:"DEPTCODE",			index:'DEPTCODE',			width:100,	align:'center', hidden:true}
						, {name:"DEPTNAME",			index:'DEPTNAME',			width:100,	align:'center'}
						, {name:"GRADE",			index:'GRADE',				width:100,	align:'center'}
						, {name:"KNAME",			index:'KNAME',				width:100,	align:'center'}
						, {name:"RECOID",			index:'RECOID',				width:100,	align:'center', hidden:true}
						, {name:"RECONAME",			index:'RECONAME',			width:100,	align:'center'}
						, {name:"JOINDATE",			index:'JOINDATE',			width:150,	align:'center'}
						, {name:"O_BRANCHCODE",		index:'O_BRANCHCODE',		width:100,	align:'center'}
						, {name:"O_JOINDATE",		index:'O_JOINDATE',			width:100,	align:'center'}
						, {name:"O_RETIREDATE",		index:'O_RETIREDATE',		width:100,	align:'center'}
						, {name:"O_EMPLOYGUBUN",	index:'O_EMPLOYGUBUN',		width:100,	align:'center'}
						, {name:"MOBILENO",			index:'MOBILENO',			width:100,	align:'center'}
						, {name:"JUMINID",			index:'JUMINID',			width:150,	align:'center'}
						, {name:"BIRTHDAYGUBUN",	index:'BIRTHDAYGUBUN',		width:100,	align:'center'}
						, {name:"ACCTOWNER",		index:'ACCTOWNER',			width:100,	align:'center'}
						, {name:"BANKID",			index:'BANKID',				width:100,	align:'center', hidden:true}
						, {name:"BANKNAME",			index:'BANKNAME',			width:100,	align:'center'}
						, {name:"ACCTNO",			index:'ACCTNO',				width:150,	align:'center'}
						, {name:"T_ACCTOWNER",		index:'T_ACCTOWNER',		width:150,	align:'center'}
						, {name:"T_JUMINID",		index:'T_JUMINID',			width:150,	align:'center'}
						, {name:"ADDRESS",			index:'ADDRESS',			width:150,	align:'center'}
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
			onSelectRow: function(id){
				alert(id);
			},
			hidegrid: false
		});

		$("#mainList").jqGrid('setGroupHeaders', {
		    useColSpanStyle: true, //rowspan자동으로 해줄지 여부.
		    groupHeaders:[
				{
					startColumnName: 'O_7',
					numberOfColumns: 4,
					titleText: '전근무현황'
				},
				{
					startColumnName: 'O_17',
					numberOfColumns: 2,
					titleText: '소득신고'
				}
		      
		     ]
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
			<table class="blueone" style="width:100%;">
				<tr>
					<td width="40%" align="left">
						<table class="blueone">
							<tr>
								<th>기준일</th>
								<td colspan="3"><input type="text" id="S_JOINDATE" name="S_JOINDATE" /></td>
							</tr>
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
						</table>
					</td>
					<td align="right">
						<table style="border:1px solid #333; padding: 10px;">
							<tr>
								<td>임원</td>
								<td>실장</td>
								<td>사원</td>
								<td>총무여직원</td>
								<td>지사 총 원</td>
							</tr>
							<tr>
								<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
								<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
								<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
								<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
								<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br/>
			<table id="mainList" width="98%"></table>
			<div id="mainNav"></div>
		</div>
	</div>
</body>
</html>