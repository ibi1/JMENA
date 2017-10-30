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
			//caption: '공통코드 권한관리'
			url:"/home/selectListEnaInsaMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['공통코드', '공통코드 명'] ,
			colModel:[
				{name:"CCODE",			index:'CCODE',			width:60,		align:'center'}
				, {name:"CCODENAME",	index:'CCODENAME',		width:60,		align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			rowList:[10,20,30] ,
			sortname: 'CCODE' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			//height: '100%' ,
			onSelectRow: function(id){
				alert(id);
			} ,
			hidegrid: false
		});

		$('#bottomList').jqGrid({
			//caption: '공통코드 권한관리'
			url:"/home/selectListEnaInsaMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['상세코드', '상세코드명', '사용여부', '정렬순서', 
						'비고', '관리구분1', '관리구분1명', '관리구분2', 
						'관리구분2명', '관리구분3', '관리구분3명', '관리구분4', '관리구분4명'] ,
			colModel:[
				{name:"DCODE",			index:'DCODE',		width:60,		align:'center'}
				, {name:"DCODENAME",	index:'DCODENAME',	width:60,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,		align:'center'}
				, {name:"SORTKEY",		index:'SORTKEY',	width:60,		align:'center'}
				, {name:"REMARK",		index:'REMARK',		width:60,		align:'center'}
				, {name:"AUX1",			index:'AUX1',		width:60,		align:'center'}
				, {name:"AUX1DESC",		index:'AUX1DESC',	width:60,		align:'center'}
				, {name:"AUX2",			index:'AUX2',		width:60,		align:'center'}
				, {name:"AUX2DESC",		index:'AUX2DESC',	width:60,		align:'center'}
				, {name:"AUX3",			index:'AUX3',		width:60,		align:'center'}
				, {name:"AUX3DESC",		index:'AUX3DESC',	width:60,		align:'center'}
				, {name:"AUX4",			index:'aux4',		width:60,		align:'center'}
				, {name:"AUX4DESC",		index:'AUX4DESC',	width:60,		align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			rowList:[10,20,30] ,
			sortname: 'DCODE' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			//, height: '100%'
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
			<table class="blueone">
				<tr>
					<td>공통코드명</td>
					<td><input type="text" id="CCODENAME" name="CCODENAME" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>공통코드</td>
					<td><input type="text" id="CCODE" name="CCODE" /> </td>
				</tr>
				<tr>
					<td>공통코드명</td>
					<td><input type="text" id="CCODENAME" name="CCODENAME" /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table id="bottomList"></table>
		</div>
	</div>
</body>
</html>