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
		
		f_selectListEnaIpgumMst();
		f_selectListEnaIpgumDtl();
		
	});
	
	function f_selectListEnaIpgumMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '입금관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['입금일자', '입금인', '입금금액', '입금구분', '입금처리금액', '미처리잔액'] ,
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
	
	function f_selectListEnaIpgumDtl(){
		$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList').jqGrid({
			//caption: '입금 스케쥴 관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['계약번호', '계약일자', '계약구분', '계약자', '계약자 연락처', '계약건 주소', '계약면적', '계약평수', '계약대금(실판매가)', '입금구분', '입금예정일', '입금예정금액', '처리금액'] ,
			colModel:[  
				{name:"SYSID",			index:'SYSID',		width:100,		align:'center'}
				, {name:"SYSNAME",		index:'SYSNAME',	width:100,		align:'center'}
				, {name:"SORTKEY",		index:'SORTKEY',	width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"REMARK",		index:'REMARK',		width:100,		align:'center'}
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
					<td>입금기간</td>
					<td colspan="3"><input type="text" id="SALEDATE" name="SALEDATE" /> ~ <input type="text" id="SALEDATE" name="SALEDATE" /></td>
				</tr>
				<tr>
					<td>담당자</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
					<td>입금구분</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>금융기관</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
					<td>입금금액</td>
					<td><input type="text" id="SALERCD" name="SALERCD" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>입금일자/번호</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>입금형태</td>
					<td colspan="3">
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>입금구분</td>
					<td colspan="3">
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>금융기관</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
					<td>입금인</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>입금금액</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>처리금액</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>미처리금액</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>담당지사</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
					<td>담당자</td>
					<td>
						<select id="SYSID" name="SYSID">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>소재지</td>
					<td colspan="3"><input type="text" id="SYSID" name="SYSID" /></td>
				</tr>
				<tr>
					<td>계약자</td>
					<td><input type="text" id="SYSID" name="SYSID" /></td>
					<td>평수</td>
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
					<td align="right">
						<a class="ui-button ui-widget ui-corner-all" id="addButton" name="addButton">추가</a>
						<a class="ui-button ui-widget ui-corner-all" id="deleteButton2" name="deleteButton2">삭제</a>
						<a class="ui-button ui-widget ui-corner-all" id="saveButton2" name="saveButton2">저장</a>
					</td>
				</tr>
			</table>
			<table id="bottomList"></table>
		</div>
	</div>
</body>
</html>