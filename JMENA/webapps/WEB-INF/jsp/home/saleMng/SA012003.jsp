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
		
		var S_SALEDATE_FR = "";
		var S_SALEDATE_TO = "";
		var S_BRANCHCODE = "";
		var S_DEPTCODE = "";
		var S_KNAME = "";
		
		f_selectListEnaBranchCode();
		f_selectListEnaDeptCode();
		f_selectListSA012003(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
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

	
	function f_selectListSA012003(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME){
		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '매출현황 - 소비대차', 
			url:"/home/selectListSysMst.do" ,
			datatype:"json",
			postData : {
				S_SALEDATE_FR : S_SALEDATE_FR
				, S_SALEDATE_TO : S_SALEDATE_TO
				, S_BRANCHCODE : S_BRANCHCODE
				, S_DEPTCODE : S_DEPTCODE
				, S_KNAME : S_KNAME
			},
			
			loadError:function(){alert("Error~!!");},
			colNames:['지사', '부서', '계약일', '계약번호', '담당자', 
			          '고객명', '주민번호', '지급구분', '차용기간', '차입금액',
			          '지급이율(%)', '지급이자',  '이자소득세', '실 수령액', '만기일',
			          '연장여부', '연장일', '중도해지', '중도해지일', '담보소재지',
			          '입금은행', '입금계좌', '예금주', '비고'],
			colModel:[
				{name:"BRANCHNAME",		index:'BRANCHNAME',		width:100,	align:'center'}
				,{name:"DEPTNAME",		index:'DEPTNAME',		width:100,	align:'center'}
				,{name:"SALEDATE",		index:'SALEDATE',		width:100,	align:'center'}
				,{name:"SALEID",		index:'SALEID',			width:100,	align:'center'}
				,{name:"KNAME",			index:'KNAME',			width:100,	align:'center'}
				,{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center'}
				,{name:"CONJUMINID",	index:'CONJUMINID',		width:100,	align:'center'}
				,{name:"BRROWTYPE",		index:'BRROWTYPE',		width:100,	align:'center'}
				,{name:"BRROWTERM",		index:'BRROWTERM',		width:100,	align:'center'}
				,{name:"BRROWAMT",		index:'BRROWAMT',		width:100,	align:'center'}
				,{name:"PAYRATE",		index:'PAYRATE',		width:100,	align:'center'}
				,{name:"PAYAMT",		index:'PAYAMT',			width:100,	align:'center'}
				,{name:"TAXAMT",		index:'TAXAMT',			width:100,	align:'center'}
				,{name:"JIGUEBAMT",		index:'JIGUEBAMT',		width:100,	align:'center'}
				,{name:"EXPIREDATE",	index:'EXPIREDATE',		width:100,	align:'center'}
				,{name:"EXTENDYN",		index:'EXTENDYN',		width:100,	align:'center'}
				,{name:"EXTENDDATE",	index:'EXTENDDATE',		width:100,	align:'center'}
				,{name:"CANCELYN",		index:'CANCELYN',		width:100,	align:'center'}
				,{name:"CANCELDATE",	index:'CANCELDATE',		width:100,	align:'center'}
				,{name:"ADDRESS",		index:'ADDRESS',		width:100,	align:'center'}
				,{name:"BANKNAME",		index:'BANKNAME',		width:100,	align:'center'}
				,{name:"PAYACCOUNT",	index:'PAYACCOUNT',		width:100,	align:'center'}
				,{name:"PAYOWNER",		index:'PAYOWNER',		width:100,	align:'center'}
				,{name:"REMARK",		index:'REMARK',			width:100,	align:'center'}
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
			
			var S_SALEDATE_FR = $("#S_SALEDATE_FR").val();
			var S_SALEDATE_TO = $("#S_SALEDATE_TO").val();
			var S_BRANCHCODE = $("#S_BRANCHCODE").val();
			var S_DEPTCODE = $("#S_DEPTCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			f_selectListSA012003(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_KNAME);
		})
	})
	
	$(function(){
		$("#excelButton").click(function(){
		    $.ajax({ 
				type: 'POST' ,
				data: $("#searchForm").serialize(),
				url: "/home/SA012003_exportToExcel.do" , 
				dataType : 'json' , 
				success: function(data){
					if(data.rows[0].MSG == "success")
					{
						alert("저장이 완료되었습니다.");
						f_reload();
					}else{
						alert("저장 중 오류가 발생하였습니다.\n\n입력 내용을 확인하세요.");
					}
				},
				error:function(e){  
				}  
			}); 
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
					<th>매출기간</th>
					<td colspan="5"><input type="text" id="S_SALEDATE_FR" name="S_SALEDATE_FR" /> ~ <input type="text" id="S_SALEDATE_TO" name="S_SALEDATE_TO" /></td>
				</tr>
				<tr>
					<th>지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE" style="width:80px">
						</select>
					</td>
					<th>부서</th>
					<td>
						<select id="S_DEPTCODE" name="S_DEPTCODE" style="width:120px">
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