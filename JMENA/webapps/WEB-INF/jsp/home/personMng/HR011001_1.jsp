<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인사 정보 조회</title>

	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>


</head>


<script type="text/javascript">
	
	$(function(){
		var KNAME = $("#KNAME",opener.document).val();
		var INSACODE = $("#INSACODE",opener.document).val();

		selectListInsaMst();
		
		$("#S_KNAME").val(KNAME);
		$("#S_INSACODE").val(INSACODE);
		
		$("#searchButton").click(function(){
			selectListInsaMst();
		}); 
		
	})
	
	
	function selectListInsaMst(){
		if($("#S_KNAME").val() == "" && $("#S_INSACODE").val() == "" && $("#S_JUMINID").val() == ""){
			alert("검색 조건을 입력 해 주세요");
			return;
		}
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용

		$('#leftList').jqGrid({
			//caption: '인사관리', 
			url:"/home/selectListEnaInsaMst.do",
			mtype: 'POST',
			postData : {
				S_KNAME : $("#S_KNAME").val(),
				S_INSACODE : $("#S_INSACODE").val(),
				S_JUMINID : $("#S_JUMINID").val()
			},			
			datatype:"json",		
			loadError:function(){alert("Error~!!");},
			colNames:['사번', '성명', '주민번호', '연락처', '소속지사',  '소속부서','생일구분'
			          ,'사업자번호','대표자명','주소','기타연락처','월정지급액','고용구분','직급','직책','입사일','재입사여부','퇴사일','추천인사번','비고'],
			colModel:[
				{name:"INSACODE",			index:'INSACODE',		width:100,	align:'center'}
				, {name:"KNAME",			index:'KNAME',			width:100,	align:'center'}
				, {name:"JUMINID",			index:'JUMINID',		width:100,	align:'center'}
				, {name:"MOBILENO",			index:'MOBILENO',		width:100,	align:'center'}
				, {name:"BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center'}
	 			, {name:"DEPTCODE",			index:'DEPTCODE',		width:100,	align:'center'} 		
				, {name:"BIRTHDAYGUBUN",	index:'BIRTHDAYGUBUN',	width:100,	align:'center', hidden:true}
				, {name:"SAUPID",			index:'SAUPID',			width:100,	align:'center', hidden:true}
				, {name:"SAUPOWNER",		index:'SAUPOWNER',		width:100,	align:'center', hidden:true}
				, {name:"ADDRESS",			index:'ADDRESS',		width:100,	align:'center', hidden:true}
				, {name:"TELNO",			index:'TELNO',			width:100,	align:'center', hidden:true}
				, {name:"BASICPAY",			index:'BASICPAY',		width:100,	align:'center', hidden:true}
				, {name:"EMPLOYGUBUN",		index:'EMPLOYGUBUN',	width:100,	align:'center', hidden:true}
				, {name:"GRADE",			index:'GRADE',			width:100,	align:'center', hidden:true}
				, {name:"DUTY",				index:'DUTY',			width:100,	align:'center', hidden:true}
				, {name:"JOINDATE",			index:'JOINDATE',		width:100,	align:'center', hidden:true}
				, {name:"REJOINYN",			index:'REJOINYN',		width:100,	align:'center', hidden:true}
				, {name:"RETIREDATE",		index:'RETIREDATE',		width:100,	align:'center', hidden:true}
				, {name:"RECOID",			index:'RECOID',			width:100,	align:'center', hidden:true}
				, {name:"REMARK",			index:'REMARK',			width:100,	align:'center', hidden:true}
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
			ondblClickRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
				$("#INSACODE", parent.opener.document).val(selRowData.INSACODE);
	 			$("#KNAME", parent.opener.document).val(selRowData.KNAME);
				$("#JUMINID1", parent.opener.document).val(selRowData.JUMINID.substr(0,6));
				$("#JUMINID2", parent.opener.document).val(selRowData.JUMINID.substr(6,selRowData.JUMINID.length));
				$("input:radio[name=BIRTHDAYGUBUN]:input[value=" + selRowData.BIRTHDAYGUBUN + "]", parent.opener.document).attr("checked", true);
				$("#SAUPID1", parent.opener.document).val(selRowData.SAUPID.substr(0,3));
				$("#SAUPID2", parent.opener.document).val(selRowData.SAUPID.substr(3,2));
				$("#SAUPID3", parent.opener.document).val(selRowData.SAUPID.substr(5,5));
				$("#SAUPOWNER", parent.opener.document).val(selRowData.SAUPOWNER);
				$("#ADDRESS", parent.opener.document).val(selRowData.ADDRESS);
				$("#MOBILENO", parent.opener.document).val(selRowData.MOBILENO);
				$("#TELNO", parent.opener.document).val(selRowData.TELNO);
				$("#BRANCHCODE", parent.opener.document).val(selRowData.BRANCHCODE);
				$("#DEPTCODE", parent.opener.document).val(selRowData.DEPTCODE);
				$("#BASICPAY", parent.opener.document).val(selRowData.BASICPAY);
				$("input:radio[name=EMPLOYGUBUN]:input[value=" + selRowData.EMPLOYGUBUN + "]", parent.opener.document).attr("checked", true);
				$("#GRADE", parent.opener.document).val(selRowData.GRADE);
				$("#DUTY", parent.opener.document).val(selRowData.DUTY);
				$("#JOINDATE", parent.opener.document).val(selRowData.JOINDATE);
				if(selRowData.REJOINYN == "Y"){
					$("#REJOINYN", parent.opener.document).attr('checked', true);					
				}else{
					$("#REJOINYN", parent.opener.document).attr('checked', false);
				}
				$("#RETIREDATE", parent.opener.document).val(selRowData.RETIREDATE);
				$("#RECOID", parent.opener.document).val(selRowData.RECOID);
				$("#REMARK", parent.opener.document).val(selRowData.REMARK);
				
				window.self.close();
			} ,
			loadComplete: function() {				
				
			},			
			hidegrid: false
		});		
	}	
		
</script>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:80%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%">
				<tr>
					<th>성명</th>
					<td><input type="text" class="inputName" id="S_KNAME" name="S_KNAME" /></td>
					<th>사번</th>
					<td><input type="text" class="inputName" id="S_INSACODE" name="S_INSACODE" /></td>
					<th>주민번호</th>
					<td><input type="text" id="S_JUMINID" name="S_JUMINID" />
					<a class="ui-button ui-widget ui-corner-all" id="searchButton" name="searchButton">조회 </a></td>
				</tr>
			</table>
			<table id="leftList" width="98%"></table>
		</div>
		
	</div>
</body>
</html>