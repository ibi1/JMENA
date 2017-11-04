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
		
		f_selectListEnaBranchCode();
		f_selectListEnaSalerCode();
		f_selectListEnaIpgumGubunCode();
		f_selectListSA012004();
		
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
				f_selectListEnaSalerCode();
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	$(function(){
		$("#S_BRANCHCODE").change(function() {
			f_selectListEnaSalerCode();
		});
	});
	
	function f_selectListEnaSalerCode(){
		
		var BRANCHCODE = $("#S_BRANCHCODE").val();
		$("#S_SALERCD").empty().data('options');
		
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/insaMstList.do", 
			dataType : 'json' , 
			data : {
				BRANCHCODE : BRANCHCODE,
			},
			success: function(data){
				var inHtml = "";
				data.insaMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.INSACODE + "'>" + currentValue.KNAME + "</option>\n";
				});
				$("#S_SALERCD").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaIpgumGubunCode(){
		var CCODE = "009";
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/dcodeList.do", 
			dataType : 'json' ,
			data : {
				CCODE : CCODE,
			},
			success: function(data){
				var inHtml = "";
				data.dcodeList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
				});
				$("#S_IPGUMGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListSA012004(){
		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '은행입금 현황', 
			url:"/home/selectListSysMst.do" ,
			datatype:"json",
			loadError:function(){alert("Error~!!");},
			colNames:['입금일자', '지사', '담당자', '계약자', '입금구분', '입금금액', '수금처리금액', '처리잔액', '입금은행', '입금형태',
			          '소재지', '평수', '비고'],
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
					<th>입금기간</th>
					<td><input type="text" id="S_IPGUMDATE_FR" name="S_IPGUMDATE_FR" /> ~ <input type="text" id="S_IPGUMDATE_TO" name="S_IPGUMDATE_TO" /></td>
				</tr>
				<tr>
					<th>지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE">
						</select>
					</td>
					<th>담당자</th>
					<td>
						<select id="S_SALERCD" name="S_SALERCD">
						</select>
					</td>
				</tr>
				<tr>
					<th>입금구분</th>
					<td>
						<select id="S_IPGUMGUBUN" name="S_IPGUMGUBUN">
						</select>
					</td>
					<th>입금인</th>
					<td><input type="text" id="S_IPGUMPERSON" name="S_IPGUMPERSON" /></td>
					<th>입금금액</th>
					<td><input type="text" id="S_IPGUMAMT" name="S_IPGUMAMT" /></td>
				</tr>
			</table>
			<br/>
			<table id="mainList" width="98%"></table>
			<div id="mainNav"></div>
		</div>
	</div>
</body>
</html>