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
			//caption: '금융기관 코드관리'
			url:"/home/selectListEnaInsaMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['기관코드', '금융기관명', '사용여부', '확장코드'] ,
			colModel:[
				{name:"BANKCODE",		index:'BANKCODE',	width:60,	align:'center'}
				, {name:"BANKNAME",		index:'BANKNAME',	width:60,	align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:60,	align:'center'}
				, {name:"AUXCODE",		index:'AUXCODE',	width:60,	align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			rowList:[10,20,30] ,
			sortname: 'BANKCODE' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			height: '100%' ,
			onSelectRow: function(id){
				alert(id);
			} ,
			hidegrid: false
		});

	});

</script>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:96%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>금융기관</td>
					<td><input type="text" id="BANKNAME" name="BANKNAME" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
	</div>
</body>
</html>