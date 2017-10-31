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
		
		f_selectListEP012002();
		
	});

	function f_selectListEP012002(){
		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '월 수령액 확인서', 
			url:"/home/selectListSysMst.do" ,
			datatype:"json",
			loadError:function(){alert("Error~!!");},
			colNames:['지사', '부서', '직위', '직급', '사번', '성명', '기본급', '활동비', '일비', '시상금',
			          '수당금액', '총지급액', '소득세', '지방세', '부가가치세', '차감지급액'],
			colModel:[
						{name:"KNAME",				index:'kName',		width:100,	align:'center'}
						, {name:"JUMINID",			index:'juminId',	width:100,	align:'center'}
						, {name:"MOBILENO",			index:'mobileNo',	width:100,	align:'center'}
						, {name:"BRANCHCODE",		index:'branchCode',	width:100,	align:'center'}
						, {name:"DEPTCODE",			index:'deptCode',	width:150,	align:'center'}
						, {name:"KNAME",			index:'kName',		width:100,	align:'center'}
						, {name:"O_JUMINID",		index:'juminId',	width:100,	align:'center'}
						, {name:"MOBILENO",			index:'mobileNo',	width:100,	align:'center'}
						, {name:"BRANCHCODE",		index:'branchCode',	width:100,	align:'center'}
						, {name:"O_BRANCHCODE",		index:'deptCode',	width:150,	align:'center'}
						, {name:"O_JOINDATE",		index:'kName',		width:100,	align:'center'}
						, {name:"O_RETIREDATE",		index:'juminId',	width:100,	align:'center'}
						, {name:"O_TOTAMT",			index:'mobileNo',	width:100,	align:'center'}
						, {name:"O_JOINDATE",		index:'kName',		width:100,	align:'center'}
						, {name:"O_RETIREDATE",		index:'juminId',	width:100,	align:'center'}
						, {name:"O_TOTAMT",			index:'mobileNo',	width:100,	align:'center'}
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
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
					<th>지사</th>
					<td>
						<select id="branchCode" name="branchCode">
							<option>서울</option>
							<option>경기</option>
							<option>부산</option>
						</select>
					</td>
					<th>부서</th>
					<td>
						<select id="branchCode" name="branchCode">
							<option>서울</option>
							<option>경기</option>
							<option>부산</option>
						</select>
					</td>
					<th>담당자명</th>
					<td><input type="text" id="SALEDATE" name="SALEDATE" /></td>
				</tr>
			</table>
			<br/>
			<table id="mainList" width="98%"></table>
			<div id="mainNav"></div>
		</div>
	</div>
</body>
</html>