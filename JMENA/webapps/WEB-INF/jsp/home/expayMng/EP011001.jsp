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
			//caption: '수당관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['지급일', '담당자', '매출금액', '지급금액', '세액', '차감지급액'] ,
			colModel:[
				{name:"SALEDATE",		index:'SALEDATE',		width:60,		align:'center'}
				,{name:"CONNAME",		index:'CONNAME',		width:60,		align:'center'}
				,{name:"CONADDRESS",	index:'CONADDRESS',		width:60,		align:'center'}
				,{name:"CONPY",			index:'CONPY',			width:60,		align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:60,		align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:60,		align:'center'}
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
				alert(id);
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
				{name:"SYSID",			index:'SYSID',		width:60,		align:'center'}
				, {name:"SYSNAME",		index:'SYSNAME',	width:60,		align:'center'}
				, {name:"SORTKEY",		index:'SORTKEY',	width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
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
		
</script>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%" class="blueone">
				<tr>
					<td>지급년월</td>
					<td colspan="3"><input type="text" id="SALEDATE" name="SALEDATE" /> ~ <input type="text" id="SALEDATE" name="SALEDATE" /></td>
				</tr>
				<tr>
					<td>지사</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
					<td>부서</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>담당자</td>
					<td colspan="3">
						<input type="text" id="SALERCD" name="SALERCD" />
					</td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>계약일자/번호</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>매출구분</td>
					<td colspan="3">
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>담당자</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
					<td>계약지사</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>관리번호</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
					<td>지역구분</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>계약자 성명</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>계약면적</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>계약평수</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>매매대금</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>매매단가</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>DC사항</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
					<td>DC 율</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>DC 금액</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>실 판매가</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>지급일자</td>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
					<td>담당자 성명</td>
					<td colspan="7"><input type="text" id="SALEDATE" name="SALEDATE" /> ~ <input type="text" id="SALEDATE" name="SALEDATE" /></td>
				</tr>
				<tr>
					<td>수당지급율(%)</td>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
					<td>추가지급율(%)</td>
					<td colspan="5"><input type="text" id="SALEDATE" name="SALEDATE" /></td>
					<td>지급금액</td>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
				</tr>
				<tr>
					<td>신고기준</td>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
					<td>사업소득세</td>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
					<td>지방세</td>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
					<td>부가가치세</td>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
					<td>차감지급액</td>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
				</tr>
				<tr>
					<td>비고</td>
					<td colspan="9"><input type="text" id="SALEDATE" name="SALEDATE" /></td>
				</tr>
			</table>
			<table id="bottomList"></table>
		</div>
	</div>
</body>
</html>