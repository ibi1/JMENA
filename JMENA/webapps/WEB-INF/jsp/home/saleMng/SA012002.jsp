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
		var S_DCODE = "";
		var S_KNAME = "";
		
		f_selectListSA012002();
	});

	function f_selectListSA012002(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_DCODE, S_KNAME){
		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '매출현황 - 일반', 
			url:"/home/selectListSA012002.do" ,
			datatype:"json" ,
			mtype: 'POST',
			postData : {
				S_SALEDATE_FR : S_SALEDATE_FR
				, S_SALEDATE_TO : S_SALEDATE_TO
				, S_BRANCHCODE : S_BRANCHCODE
				, S_DEPTCODE : S_DEPTCODE
				, S_DCODE : S_DCODE
				, S_KNAME : S_KNAME
			},
			
			loadError:function(){alert("Error~!!");},
			colNames:['지사코드', '지사', '부서코드', '부서', '계약일', '매출구분', '계약번호', '담당자' , '고객명', '주소', '계약면적', '계약평수',
			          '원 판매가', '할인율(%)',  '실판매가', '평단가', '위탁수수료', '계약금', '중도금', '잔금', '계약입금액',
			          '중도입금액', '잔금입금액', '입금총액', '입금잔액', '입금율(%)', '비고'],
			colModel:[
					{name:"BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center', hidden:true}
					, {name:"BRANCHNAME",	index:'BRANCHNAME',		width:100,	align:'center'}
					,{name:"DEPTCODE",		index:'DEPTCODE',		width:100,	align:'center', hidden:true}
					,{name:"DEPTNAME",		index:'DEPTNAME',		width:100,	align:'center'}
					,{name:"SALEDATE",		index:'SALEDATE',		width:100,	align:'center'}
					,{name:"DCODENAME",		index:'DCODENAME',		width:100,	align:'center'}
					,{name:"SALEID",		index:'SALEID',			width:100,	align:'center'}
					,{name:"KNAME", 		index:'KNAME',			width:100,	align:'center'}
					,{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center'}
					,{name:"ADDRESS",		index:'ADDRESS',		width:100,	align:'center'}
					,{name:"CONM2",			index:'CONM2',			width:100,	align:'center'}
					,{name:"CONPY",			index:'CONPY',			width:100,	align:'center'}
					,{name:"SALEAMT",		index:'SALEAMT',		width:100,	align:'center'}
					,{name:"DCRATE",		index:'DCRATE',			width:100,	align:'center'}
					,{name:"SELLAMT",		index:'SELLAMT',		width:100,	align:'center'}
					,{name:"SALEDANGA",		index:'SALEDANGA',		width:100,	align:'center'}
					,{name:"AGENCYAMT",		index:'AGENCYAMT',		width:100,	align:'center'}
					,{name:"DEPOSITAMT1",	index:'DEPOSITAMT1',	width:100,	align:'center'}
					,{name:"DEPOSITAMT2",	index:'DEPOSITAMT2',	width:100,	align:'center'}
					,{name:"DEPOSITAMT3",	index:'DEPOSITAMT3',	width:100,	align:'center'}
					,{name:"SUGUMAMT1",		index:'SUGUMAMT1',		width:100,	align:'center'}
					,{name:"SUGUMAMT2",		index:'SUGUMAMT2',		width:100,	align:'center'}
					,{name:"SUGUMAMT3",		index:'SUGUMAMT3',		width:100,	align:'center'}
					,{name:"SUGUMAMT",		index:'SUGUMAMT',		width:100,	align:'center'}
					,{name:"REMNAMT",		index:'REMNAMT',		width:100,	align:'center'}
					,{name:"IPGUMRATE",		index:'IPGUMRATE',		width:100,	align:'center'}
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
			var S_DCODE = $("#S_DCODE").val();
			var S_KNAME = $("#S_KNAME").val();
			
			f_selectListSA012002(S_SALEDATE_FR, S_SALEDATE_TO, S_BRANCHCODE, S_DEPTCODE, S_DCODE, S_KNAME);
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
					<td><input type="text" id="S_SALEDATE_FR" name="S_SALEDATE_FR" /> ~ <input type="text" id="S_SALEDATE_TO" name="S_SALEDATE_TO" /></td>
					<th>지사</th>
					<td>
						<select id="S_BRANCHCODE" name="S_BRANCHCODE">
							<option>서울</option>
							<option>경기</option>
							<option>부산</option>
						</select>
					</td>
					<th>부서</th>
					<td>
						<select id="S_DEPTCODE" name="S_DEPTCODE">
							<option>서울</option>
							<option>경기</option>
							<option>부산</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>매출구분</th>
					<td>
						<select id="S_DCODE" name="S_DCODE">
							<option>서울</option>
							<option>경기</option>
							<option>부산</option>
						</select>
					</td>
					<th>담당자명</th>
					<td colspan="3"><input type="text" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
			</table>
			<br/>
			<table id="mainList" width="98%"></table>
			<div id="mainNav"></div>
		</div>
	</div>
</body>
</html>