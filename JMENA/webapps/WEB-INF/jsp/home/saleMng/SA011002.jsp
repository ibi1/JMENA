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
		
		f_selectListEnaSaleMst();
		f_selectListEnaSaleBDtl();
		
	});

	function f_selectListEnaSaleMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '금전소비차매출관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['차입일자', '차입자', '차입물건', '차입금액', '차입형식', '차입이자'] ,
			colModel:[
				{name:"SALEDATE",		index:'SALEDATE',		width:100,		align:'center'}
				,{name:"CONNAME",		index:'CONNAME',		width:100,		align:'center'}
				,{name:"CONADDRESS",	index:'CONADDRESS',		width:100,		align:'center'}
				,{name:"CONPY",			index:'CONPY',			width:100,		align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:100,		align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:100,		align:'center'}
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
	}

	function f_selectListEnaSaleBDtl(){
		$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList').jqGrid({
			//caption: '등기 사항'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['명의자', '주민번호', '연락처', '점유면적', '점유평수', '매매대금', '매매단가', 'DC사항', 'DC 율', '실 매매가', '등본제출여부', '비고'] ,
			colModel:[
				{name:"SYSID",		index:'SYSID',		width:100,		align:'center'}
				, {name:"SYSNAME",	index:'SYSNAME',	width:100,		align:'center'}
				, {name:"SORTKEY",	index:'SORTKEY',	width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"REMARK",	index:'REMARK',		width:100,		align:'center'}
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
	}


		
		
		
</script>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<td align="right">
						<a class="ui-button ui-widget ui-corner-all" id="selectButton" name="selectButton">조회</a>
						<a class="ui-button ui-widget ui-corner-all" id="insertButton" name="insertButton">추가</a>
						<a class="ui-button ui-widget ui-corner-all" id="deleteButton" name="deleteButton">삭제</a>
						<a class="ui-button ui-widget ui-corner-all" id="saveButton" name="saveButton">저장</a>
					</td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>차입기간</td>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /> ~ <input type="text" id="SALEDATE" name="SALEDATE" /></td>
				</tr>
				<tr>
					<td>담당자</td>
					<td><input type="text" id="SALERCD" name="SALERCD" /></td>
				</tr>
				<tr>
					<td>지번(주소)</td>
					<td><input type="text" id="CONADDRESS" name="CONADDRESS" /></td>
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
					<td><input type="text" id="SYSID" name="SYSID" /></td>
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
					<td>분양/잔여면적</td>
					<td><input type="text" id="SYSID" name="SYSID" /> / <input type="text" id="SYSID" name="SYSID" /></td>
					<td>분양/잔여평수</td>
					<td><input type="text" id="SYSID" name="SYSID" /> / <input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>차입자 성명</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>차입자주민번호</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>차입자 연락처</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>차입자 주소</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>계약면적</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>계약평수</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>차입형식</td>
					<td><input type="radio" id="SYSID" name="SYSID" /> 월지급     <input type="radio" id="SYSID" name="SYSID" /> 년지급    </td>
				</tr>
				<tr>
					<td>차입대금</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>차입기간</td>
					<td>
						<input type="text" id="SYSID" name="SYSID" /> 년 
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>지급이율</td>
					<td><input type="text" id="SYSID" name="SYSID" /> % </td>
					<td>지급이자</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>지급계좌</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>지급은행</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>계좌주</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>차입날짜</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>만기날짜</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>만기연장</td>
					<td><input type="checkbox" id="SYSID" name="SYSID" /></td>
					<td>연장날짜</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>중도해지</td>
					<td><input type="checkbox" id="SYSID" name="SYSID" /></td>
					<td>해지날짜</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>비고</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone" width="100%">
				<tr>
					<td width="60%" align="left">
						<table class="blueone">
							<tr>
								<td>등기명의 여부</td>
								<td colspan="4"><input type="checkbox" id="SYSID" name="SYSID" /></td>
							</tr>
							<tr>
								<td>등기여부</td>
								<td><input type="radio" id="SYSID" name="SYSID" /> 등기완료  <input type="radio" id="SYSID" name="SYSID" /> 미등기</td>
								<td>등기일자</td>
								<td><input type="text" id="SYSID" name="SYSID" /></td>
							</tr>
						</table>
					</td>
					<td width="40%" align="right">
						<table class="blueone" width="100%">
							<tr>
								<td align="right">
									<a class="ui-button ui-widget ui-corner-all" id="addButton" name="addButton">추가</a>
									<a class="ui-button ui-widget ui-corner-all" id="deleteButton2" name="deleteButton2">삭제</a>
									<a class="ui-button ui-widget ui-corner-all" id="saveButton2" name="saveButton2">저장</a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		
			
			<table id="bottomList"></table>
		</div>
	</div>	
</body>
</html>