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
			//caption: '급여관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['지사', '부서', '직위', '직급', '사번', '성명', '기본급', '활동비', '일비', '시상금', '총지급액', '신고기준', '소득세', '지방세', '부가가치세', '차감지급액', '입금은행', '계좌번호', '계좌주'] ,
			colModel:[
				{name:"SALEDATE",		index:'SALEDATE',		width:60,		align:'center'}
				,{name:"CONNAME",		index:'CONNAME',		width:60,		align:'center'}
				,{name:"CONADDRESS",	index:'CONADDRESS',		width:60,		align:'center'}
				,{name:"CONPY",			index:'CONPY',			width:60,		align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:60,		align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:60,		align:'center'}
				,{name:"SALEDATE",		index:'SALEDATE',		width:60,		align:'center'}
				,{name:"CONNAME",		index:'CONNAME',		width:60,		align:'center'}
				,{name:"CONADDRESS",	index:'CONADDRESS',		width:60,		align:'center'}
				,{name:"CONPY",			index:'CONPY',			width:60,		align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:60,		align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:60,		align:'center'}
				,{name:"SALEDATE",		index:'SALEDATE',		width:60,		align:'center'}
				,{name:"CONNAME",		index:'CONNAME',		width:60,		align:'center'}
				,{name:"CONADDRESS",	index:'CONADDRESS',		width:60,		align:'center'}
				,{name:"CONPY",			index:'CONPY',			width:60,		align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:60,		align:'center'}
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
	});

		
</script>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<table width="99%" class="blueone">
			<tr>
				<td>지급년월</td>
				<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
				<td>지급일자</td>
				<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
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
		</table>
		<table id="leftList"></table>
	</div>
</body>
</html>