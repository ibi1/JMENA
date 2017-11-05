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
		
		var S_PAYDATE = "";
		var S_BRANCHCODE = "";
		var S_DEPTCODE = "";
		var S_KNAME = "";
		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		
		f_selectListEP012002(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
		
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
	
	function f_selectListEP012002(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME){
		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '월 수령액 확인서', 
			url:"/home/selectListEP012002.do" ,
			datatype:"json",
			postData : {
				S_PAYDATE : S_PAYDATE
				,S_BRANCHCODE : S_BRANCHCODE
				,S_DEPTCODE : S_DEPTCODE
				,S_KNAME : S_KNAME
			},
			loadError:function(){alert("Error~!!");},
			colNames:['지사', '부서', '직위', '직급', '사번',
			          '성명', '기본급', '활동비', '일비', '시상금',
			          '수당금액', '총지급액', '소득세', '지방세', '부가가치세',
			          '차감지급액'],
			colModel:[
				{name:"BRANCHNAME",	index:'BRANCHNAME',		width:100,	align:'center'}
				,{name:"DEPTNAME",	index:'DEPTNAME',		width:100,	align:'center'}
				,{name:"GRADENAME",	index:'GRADENAME',		width:100,	align:'center'}
				,{name:"DUTYNAME",	index:'DUTYNAME',		width:100,	align:'center'}
				,{name:"INSACODE",	index:'INSACODE',		width:100,	align:'center'}
				,{name:"KNAME",		index:'KNAME',			width:100,	align:'center'}
				,{name:"BASICAMT",	index:'BASICAMT',		width:100,	align:'center'}
				,{name:"ACTAMT",	index:'ACTAMT',			width:100,	align:'center'}
				,{name:"DAILYAMT",	index:'DAILYAMT',		width:100,	align:'center'}
				,{name:"PRIZEAMT",	index:'PRIZEAMT',		width:100,	align:'center'}
				,{name:"PAYAMT",	index:'PAYAMT',			width:100,	align:'center'}
				,{name:"TOTAMT",	index:'TOTAMT',			width:100,	align:'center'}
				,{name:"TAXINCOME",	index:'TAXINCOME',		width:100,	align:'center'}
				,{name:"TAXLOCAL",	index:'TAXLOCAL',		width:100,	align:'center'}
				,{name:"SUPPLYTAX",	index:'SUPPLYTAX',		width:100,	align:'center'}
				,{name:"DEDUCTAMT",	index:'DEDUCTAMT',		width:100,	align:'center'}
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
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_PAYDATE = $("#S_PAYDATE").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			f_selectListEP012002(S_PAYDATE, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
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
					<th>지급년월</th>
					<td><input type="text" id="S_PAYDATE" name="S_PAYDATE" /></td>
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