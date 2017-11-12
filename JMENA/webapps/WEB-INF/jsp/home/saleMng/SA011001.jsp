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
		
		$("#selectButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#insertButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });

		$("#addButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#deleteButton2").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		$("#saveButton2").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#SL_SALEDATE_FR").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SL_SALEDATE_TO").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SL_CONADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});

		
		$("#SALEDATE").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SALEID").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#MANAGENO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		$("#OWNERNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#OWNERJUMINID").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#BUYM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#JANM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#BUYPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#JANPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#CONNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#CONJUMINID").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#CONADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		$("#CONTELNO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#CONM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#CONPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SALEAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#SALEDANGA").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#AGENCYAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#DCAMT").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#DCRATE").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SELLAMT").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#REMARK").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		$("#REGDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});		
		
		f_selectListEnaDCode();
		
		f_selectListEnaSaleMst();
		f_selectListEnaSaleISTb();
		f_selectListEnaSaleJNTb();
		f_selectListEnaSaleHisTb();
		
		f_selectListEnaCityCode();
		f_selectListEnaSL_SalerCode();
		f_selectListEnaSalerCode();
		f_selectListEnaBranchCode();
		f_selectListEnaDcGubun();
		
		$("#bottomDiv1").show();
		$("#bottomDiv2").hide();
		$("#bottomDiv3").hide();
		
	});

	function f_selectListEnaCityCode(){
		$("#CITYCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/cityMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				data.cityMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.CITYCODE + "'>" + currentValue.CITYNAME + "</option>\n";
				});
				$("#CITYCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaSalerCode(){
		
		var BRANCHCODE = "";
		$("#SALERCD").empty().data('options');
		
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
				$("#SALERCD").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaSL_SalerCode(){
		
		var BRANCHCODE = "";
		$("#SL_KNAME").empty().data('options');
		
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
				$("#SL_KNAME").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListEnaBranchCode(){
		$("#BRANCHNAME").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/branchMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				data.branchMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.BRANCHCODE + "'>" + currentValue.BRANCHNAME + "</option>\n";
				});
				$("#BRANCHNAME").append(inHtml);
				f_selectListEnaSalerCode();
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListEnaDCode(){
		var CCODE = "007";
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
				$("#SALEGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListEnaDcGubun(){
		var CCODE = "008";
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
				$("#DCGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	function f_selectListEnaSaleMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '매출관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['매출일자', '원지주', '주소', '매출평수', '매출면적', '매출대금'] ,
			colModel:[
				{name:"SALEDATE",		index:'SALEDATE',		width:100,	align:'center'}
				,{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center'}
				,{name:"CONADDRESS",	index:'CONADDRESS',		width:100,	align:'center'}
				,{name:"CONPY",			index:'CONPY',			width:100,	align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:100,	align:'center'}
				,{name:"CONM2",			index:'CONM2',			width:100,	align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'sortKey' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(id){
				alert(id);
				$("#bottomDiv1").show();
				$("#bottomDiv2").hide();
				$("#bottomDiv3").hide();
			} ,
			hidegrid: false
		});
		
	}
	
	function f_selectListEnaSaleISTb(){
		$('#bottomList1').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList1').jqGrid({
			//caption: '입금 스케쥴 관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['입금구분', '입금일', '입금예정일', '입금처리금액', '입금여부', '비고'] ,
			colModel:[ 
				{name:"SYSID",			index:'SYSID',		width:100,	align:'center'}
				, {name:"SYSNAME",		index:'SYSNAME',	width:100,	align:'center'}
				, {name:"SORTKEY",		index:'SORTKEY',	width:100,	align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,	align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,	align:'center'}
				, {name:"REMARK",		index:'REMARK',		width:100,	align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'SORTKEY' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(id){
				alert(id);
			} ,
			hidegrid: false
		});
	}
	
	function f_selectListEnaSaleJNTb(){
		
		$('#bottomList2').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList2').jqGrid({
			//caption: '등기 관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['명의자', '주민번호', '연락처', '점유면적', '점유평수', '매매대금', '매매단가', 'DC사항', 'DC율', '실 매매가', '등본제출여부', '비고'] ,
			colModel:[
				{name:"SYSID",		index:'SYSID',		width:100,	align:'center'}
				, {name:"SYSNAME",	Index:'SYSNAME',	width:100,	align:'center'}
				, {name:"SORTKEY",	index:'SORTKEY',	width:100,	align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,	align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,	align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,	align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,	align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,	align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,	align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,	align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,	align:'center'}
				, {name:"REMARK",	index:'REMARK',		width:100,	align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'SORTKEY' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: "96%" ,
			jsonReader: {
				repeatitems: false
			},
			//height: '100%' ,
			onSelectRow: function(id){
				alert(id);
			} ,
			hidegrid: false
		});
	}

	function f_selectListEnaSaleHisTb(){

		$('#bottomList3').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList3').jqGrid({
			//caption: '시스템 및 메뉴관리' ,
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			mtype: 'POST',
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");} ,
			colNames:['변동일자', '변동구분', '직전 계약면적', '직전 계약평수', '변경면적', '변경평수', '비고'] ,
			colModel:[
				{name:"SYSID",			index:'SYSID',		width:100,		align:'center'}
				, {name:"SYSNAME",		index:'SYSNAME',	width:100,		align:'center'}
				, {name:"SORTKEY",		index:'SORTKEY',	width:100,		align:'center'}
				, {name:"USEYN",		index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN1",		index:'USEYN1',		width:100,		align:'center'}
				, {name:"USEYN2",		index:'USEYN2',		width:100,		align:'center'}
				, {name:"REMARK",		index:'REMARK',		width:100,		align:'center'}
			] ,
			rowNum:10 ,
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
	}
	
	$(function(){
		$("#bottomList1B").click(function(){
			$("#bottomDiv1").show();
			$("#bottomDiv2").hide();
			$("#bottomDiv3").hide();
		}) 
	})
	$(function(){
		$("#bottomList2B").click(function(){
			$("#bottomDiv2").show();
			$("#bottomDiv1").hide();
			$("#bottomDiv3").hide();
		}) 
	})
	$(function(){
		$("#bottomList3B").click(function(){
			$("#bottomDiv3").show();
			$("#bottomDiv1").hide();
			$("#bottomDiv2").hide();
		}) 
	})
</script>
<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="조회" id='selectButton' /></td>
					<td><input type="button" value="추가" id='insertButton' /></td>
					<td><input type="button" value="삭제" id='deleteButton' /></td>
					<td><input type="button" value="저장" id='saveButton' /></td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:38%; float:left; padding: 10px" align="left">
			<table >
				<tr>
					<th width="120">매출기간</th>
					<td><input type="text" id="SL_SALEDATE_FR" name="SL_SALEDATE_FR" /> ~ <input type="text" id="SL_SALEDATE_TO" name="SL_SALEDATE_TO" /></td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td>
						<select id="SL_KNAME" name="SL_KNAME">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">지번(주소)</th>
					<td><input type="text" id="SL_CONADDRESS" name="SL_CONADDRESS" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:58%; float:left; padding: 10px" align="left">
			<table >
				<tr>
					<th width="120">계약일자/번호</th>
					<td colspan="3"><input type="text" id="SALEDATE" name="SALEDATE" /><input type="text" id="SALEID" name="SALEID" /></td>
				</tr>
				<tr>
					<th width="120">매출구분</th>
					<td colspan="3">
						<select id="SALEGUBUN" name="SALEGUBUN">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td>
						<select id="SALERCD" name="SALERCD">
						</select>
					</td>
					<th width="120">계약지사</th>
					<td>
						<select id="BRANCHNAME" name="BRANCHNAME">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">관리번호</th>
					<td><input type="text" id="MANAGENO" name="MANAGENO" /></td>
					<th width="120">지역구분</th>
					<td>
						<select id="CITYCODE" name="CITYCODE">
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">주소</th>
					<td colspan="3"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
				</tr>
				<tr>
					<th width="120">원지주 성명</th>
					<td><input type="text" id="OWNERNAME" name="OWNERNAME" /></td>
					<th width="120">주민번호</th>
					<td><input type="text" id="OWNERJUMINID" name="OWNERJUMINID" /></td>
				</tr>
				<tr>
					<th width="120">분양/잔여면적</th>
					<td><input type="text" id="BUYM2" name="BUYM2" /> / <input type="text" id="JANM2" name="JANM2" /></td>
					<th width="120">분양/잔여평수</th>
					<td><input type="text" id="BUYPY" name="BUYPY" /> / <input type="text" id="JANPY" name="JANPY" /></td>
				</tr>
				<tr>
					<th width="120">계약자 성명</th>
					<td><input type="text" id="CONNAME" name="CONNAME" /></td>
					<th width="120">계약자주민번호</th>
					<td><input type="text" id="CONJUMINID" name="CONJUMINID" /></td>
				</tr>
				<tr>
					<th width="120">계약자 주소</th>
					<td colspan="3"><input type="text" id="CONADDRESS" name="CONADDRESS" /></td>
				</tr>
				<tr>
					<th width="120">계약자 연락처</th>
					<td colspan="3"><input type="text" id="CONTELNO" name="CONTELNO" /></td>
				</tr>
				<tr>
					<th width="120">계약면적</th>
					<td><input type="text" id="CONM2" name="CONM2" /></td>
					<th width="120">계약평수</th>
					<td><input type="text" id="CONPY" name="CONPY" /></td>
				</tr>
				<tr>
					<th width="120">매매대금</th>
					<td><input type="text" id="SALEAMT" name="SALEAMT" /></td>
					<th width="120">매매단가</th>
					<td><input type="text" id="SALEDANGA" name="SALEDANGA" /></td>
				</tr>
				<tr>
					<th width="120">위탁수수료</th>
					<td colspan="3"><input type="text" id="AGENCYAMT" name="AGENCYAMT" /></td>
				</tr>
				<tr>
					<th width="120">DC사항</th>
					<td>
						<select id="DCGUBUN" name="DCGUBUN">
							<option></option>
						</select>
					</td>
					<th width="120">DC율</th>
					<td><input type="text" id="DCRATE" name="DCRATE" /> % </td>
				</tr>
				<tr>
					<th width="120">DC금액</th>
					<td><input type="text" id="DCAMT" name="DCAMT" /></td>
					<th width="120">실 판매가</th>
					<td><input type="text" id="SELLAMT" name="SELLAMT" /></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="3"><input type="text" id="REMARK" name="REMARK" /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; padding: 10px" align="left">
			<br/>
			<table width="100%">
				<tr>
					<td width="60%" align="left">
						<a class="ui-button ui-widget ui-corner-all" id="bottomList1B" name="bottomList1B">입급 스케줄관리</a>
						<a class="ui-button ui-widget ui-corner-all" id="bottomList2B" name="bottomList2B">등기 관리</a>
						<a class="ui-button ui-widget ui-corner-all" id="bottomList3B" name="bottomList3B">계약 변동 관리</a>
					</td>
					<td  width="40%" align="right">
						<table align="right">
							<tr>
								<td><input type="button" value="추가" id='addButton' /></td>
								<td><input type="button" value="삭제" id='deleteButton2' /></td>
								<td><input type="button" value="저장" id='saveButton2' /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		
			<div id="bottomDiv1">
				<table id="bottomList1"></table>
				<table >
					<tr>
						<th width="120">입금합계</th>
						<td><input type="text" id="SYSID" name="SYSID" /></td>
					</tr>
				</table>
			</div>
			<div id="bottomDiv2">
				<table >
					<tr>
						<th width="120">공동명의 여부</th>
						<td colspan="3"><input type="checkbox" id="JOINYN" name="JOINYN" /></td>
					</tr>
					<tr>
						<th width="120">등기여부</th>
						<td><input type="radio" id="REGYN" name="REGYN" value="Y"/> 등기완료  <input type="radio" id="REGYN" name="REGYN" value="N"/> 미등기</td>
						<th width="120">등기일자</th>
						<td><input type="text" id="REGDATE" name="REGDATE" /></td>
					</tr>
				</table>
				<table id="bottomList2"></table>
			</div>
			<div id="bottomDiv3">
				<table id="bottomList3"></table>
			</div>
		</div>
	</div>	
		
</body>
</html>