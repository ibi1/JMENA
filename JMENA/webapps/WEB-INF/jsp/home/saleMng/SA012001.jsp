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
		
		var S_SALEDATE = "";
		var S_BOROUGHCODE = "";
		var S_KNAME = "";
		
		f_selectListEnaBranchCode();
		
		
		f_selectListSA012001(S_SALEDATE, S_BOROUGHCODE, S_KNAME);
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
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListSA012001(S_SALEDATE, S_BOROUGHCODE, S_KNAME){
		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '시스템 및 메뉴관리' ,
			url:"/home/selectListSA012001.do" ,
			datatype:"json" ,
			mtype: 'POST',
			postData : {
				S_SALEDATE : S_SALEDATE,
				S_BOROUGHCODE : S_BOROUGHCODE,
				S_KNAME : S_KNAME
			},
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['지사코드', '지사', '부서코드', '부서', '직급',
			          '성명', '입사일', '퇴사일' , '전근무지코드', '전근무지',
			          '입사', '퇴사', '고용구분', 'M-6', 'M-5',
			          'M-4', 'M-3', 'M-2', 'M-1', '합계'],
			colModel:[
						{name:"BRANCHCODE",			index:'BRANCHCODE',		width:100,	align:'center', hidden:true}
						, {name:"BRANCHNAME",		index:'BRANCHNAME',		width:100,	align:'center'}
						, {name:"DEPTCODE",			index:'DEPTCODE',		width:150,	align:'center', hidden:true}
						, {name:"DEPTNAME",			index:'DEPTNAME',		width:150,	align:'center'}
						, {name:"GRADE",			index:'GRADE',			width:100,	align:'center'}
			          	, {name:"KNAME",			index:'KNAME',			width:100,	align:'center'}
			          	, {name:"JOINDATE",			index:'JOINDATE',		width:100,	align:'center'}
			          	, {name:"RETIREDATE",		index:'RETIREDATE',		width:100,	align:'center'}
						, {name:"O_BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center', hidden:true}
						, {name:"O_BRANCHNAME",		index:'BRANCHNAME',		width:100,	align:'center'}
			          	, {name:"O_JOINDATE",		index:'O_JOINDATE',		width:100,	align:'center'}
			          	, {name:"O_RETIREDATE",		index:'O_RETIREDATE',	width:100,	align:'center'}
			          	, {name:"O_EMPLOYGUBUN",	index:'O_EMPLOYGUBUN',	width:100,	align:'center'}
			          	, {name:"AMT6",				index:'AMT6',			width:100,	align:'center'}
			          	, {name:"AMT5",				index:'AMT5',			width:100,	align:'center'}
			          	, {name:"AMT4",				index:'AMT4',			width:100,	align:'center'}
			          	, {name:"AMT3",				index:'AMT3',			width:100,	align:'center'}
			          	, {name:"AMT2",				index:'AMT2',			width:100,	align:'center'}
			          	, {name:"AMT1",				index:'AMT1',			width:100,	align:'center'}
			          	, {name:"TOTAMT",			index:'TOTAMT',			width:100,	align:'center'}
			          	
			],
			rowNum:100 ,
			autowidth: true ,
			rowList:[10,20,30] ,
			//pager: $('#leftNav') ,
			sortname: 'SORTKEY' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(ids){
				
			} ,
			hidegrid: false ,
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
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_SALEDATE = $("#S_SALEDATE").val();
			var S_BOROUGHCODE = $("#S_BOROUGHCODE").val();
			var S_KNAME = $("#S_ADDRESS").val();
			
			f_selectListSA012001(S_SALEDATE, S_BOROUGHCODE, S_KNAME);
		})
	})
	
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
					<th>기준월</th>
					<td colspan="3"><input type="text" id="S_SALEDATE" name="S_SALEDATE" /></td>
				</tr>
				<tr>
					<th>지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:80px">
						</select>
					</td>
					<th>담당자명</th>
					<td><input type="text" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
			</table>
			<br/>
			<table id="mainList" width="98%"></table>
			<div id="mainNav"></div>
		</div>
	</div>
</body>
</html>