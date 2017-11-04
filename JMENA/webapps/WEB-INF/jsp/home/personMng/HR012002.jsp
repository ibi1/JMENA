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
<style type="text/css">
.ui-jqgrid .ui-jqgrid-bdiv{ overflow-x:auto; }
</style>

<script type="text/javascript">

	$(document).ready(function(){

		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		
		f_selectListHR012002();
	});
	
	function f_selectListEnaBranchCode(){
		$("#S_BRANCHCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/branchMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				data.branchMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.BRANCHCODE + "'>" + currentValue.BRANCHNAME + "</option>\n";
				});
				$("#S_BRANCHCODE").append(inHtml);
				f_selectListEnaDeptCode();
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	$(function(){
		$("#S_BRANCHCODE").change(function() {
			f_selectListEnaDeptCode();
		});
	});
	
	function f_selectListEnaDeptCode(){
		
		var BRANCHCODE = $("#S_BRANCHCODE").val();
		$("#S_DEPTCODE").empty().data('options');
		
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/deptMstList.do", 
			dataType : 'json' , 
			data : {
				BRANCHCODE : BRANCHCODE,
			},
			success: function(data){
				var inHtml = "";
				data.deptMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.DEPTCODE + "'>" + currentValue.DEPTNAME + "</option>\n";
				});
				$("#S_DEPTCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListHR012002(){
		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '퇴사자현황', 
			url:"/home/selectListSysMst.do" ,
			datatype:"json",
			loadError:function(){alert("Error~!!");},
			colNames:['지사코드', '지사', '부서코드', '부서', '직위', '직급', '고용구분', 
			          '사번' , '성명', '추천인', '입사일', '퇴사일',
			          '직전지사실적', '지사코드', '지사', '입사', '퇴사', '실적', '비고', '비고'],
			colModel:[
						{name:"BRANCHCODE",			index:'BRANCHCODE',		width:100,	align:'center', hidden:true}
						, {name:"BRANCHNAME",		index:'BRANCHNAME',		width:100,	align:'center'}
						, {name:"DEPTCODE",			index:'DEPTCODE',		width:100,	align:'center', hidden:true}
						, {name:"DEPTNAME",			index:'DEPTNAME',		width:100,	align:'center'}
						, {name:"DUTY",				index:'DUTY',			width:100,	align:'center'}
						, {name:"GRADE",			index:'GRADE',			width:100,	align:'center'}
						, {name:"EMPLOYGUBUN",		index:'EMPLOYGUBUN',	width:150,	align:'center'}
						, {name:"INSACODE",			index:'INSACODE',		width:100,	align:'center'}
						, {name:"KNAME",			index:'KNAME',			width:100,	align:'center'}
						, {name:"RECONAME",			index:'RECONAME',		width:100,	align:'center'}
						, {name:"JOINDATE",			index:'JOINDATE',		width:100,	align:'center'}
						, {name:"RETIREDATE",		index:'RETIREDATE',		width:100,	align:'center'}
						, {name:"SELLAMT",			index:'SELLAMT',		width:100,	align:'center'}
						, {name:"O_BRANCHCODE",		index:'O_BRANCHCODE',	width:150,	align:'center', hidden:true}
						, {name:"O_BRANCHNAME",		index:'O_BRANCHNAME',	width:150,	align:'center'}
						, {name:"O_JOINDATE",		index:'O_JOINDATE',		width:100,	align:'center'}
						, {name:"O_RETIREDATE",		index:'O_RETIREDATE',	width:100,	align:'center'}
						, {name:"O_SELLAMT",		index:'O_SELLAMT',		width:100,	align:'center'}
						, {name:"O_REMARK",			index:'O_REMARK',		width:100,	align:'center'}
						, {name:"REMARK",			index:'REMARK',			width:150,	align:'center'}
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
			onSelectRow: function(id){
				alert(id);
			},
			hidegrid: false
		});

		$("#mainList").jqGrid('setGroupHeaders', {
		    useColSpanStyle: true, //rowspan자동으로 해줄지 여부.
		    groupHeaders:[
		      {
		        startColumnName: 'O_BRANCHCODE',
		        numberOfColumns: 5,
		        titleText: '전근무현황'
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
			<table class="blueone">
				<tr>
					<th>퇴사기간</th>
					<td colspan="7"><input type="text" id="S_RETIREDATE_FR" name="S_RETIREDATE_FR" /> ~ <input type="text" id="S_RETIREDATE_TO" name="S_RETIREDATE_TO" /></td>
				</tr>
				<tr>
					<th>지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE">
						</select>
					</td>
					<th>부서</th>
					<td>
						<select id="S_DEPTCODE" name="S_DEPTCODE">
						</select>
					</td>
					<th>성명</th>
					<td><input type="text" class="inputName" id="S_KNAME" name="S_KNAME" /></td>
					<th>주민번호</th>
					<td><input type="text" id="S_JUMINID" name="S_JUMINID" /></td>
				</tr>
			</table>
			<br/>
			<table id="mainList" width="98%"></table>
		</div>
	</div>
</body>
</html>