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
	var PayGubun = "";
	var BranchCode = "";

	$(document).ready(function(){
		
		var LS_BUYDATE_FR = "";
		var LS_BUYDATE_TO = "";
		var LS_INSERTUSER = "";
		var LS_ADDRESS = "";
		var BUYID = "";
		f_selectListEnaBuyMst(LS_BUYDATE_FR, LS_BUYDATE_TO, LS_INSERTUSER, LS_ADDRESS);
		f_selectListEnaPayScheduleTb(BUYID);
		f_selectListEnaSalesOpenTb(BUYID);
		$("#right1Div").show();
		$("#right2Div").hide();
		//공통코드 가져오기
		f_selectListEnaBuyGubnCode();
		f_selectListEnaCityCode();
		f_selectListEnaBoroughCode();
		f_selectListEnaUseTypeCode();
		//공통코드 가져오기 끝
		
	});
	
	function f_selectListEnaBuyGubnCode(){
		var CCODE = "014";
		$("#BUYGUBUN").empty().data('options');
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
				$("#BUYGUBUN").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
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
				f_selectListEnaBoroughCode();
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	   	
	}

	$(function(){
		$("#CITYCODE").change(function() {
			f_selectListEnaBoroughCode();
		});
	});
	
	
	function f_selectListEnaBoroughCode(){
		var CITYCODE = $("#CITYCODE").val();
		$("#BOROUGHCODE").empty().data('options');

	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/cityDtlList.do", 
			dataType : 'json' , 
			data : {
				CITYCODE : CITYCODE,
			},
			success: function(data){
				var inHtml = "";
				data.cityDtlList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.BOROUGHCODE + "'>" + currentValue.BOROUGHNAME + "</option>\n";
				});
				$("#BOROUGHCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListEnaUseTypeCode(){
		var CCODE = "006";
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
				$("#USETYPE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListEnaBuyMst(LS_BUYDATE_FR, LS_BUYDATE_TO, LS_INSERTUSER, LS_ADDRESS){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '매입관리'
			url:"/home/selectListEnaBuyMst.do" ,
			datatype:"json",
			mtype: 'POST',
			postData : {
				LS_BUYDATE_FR : LS_BUYDATE_FR,
				LS_BUYDATE_TO : LS_BUYDATE_TO,
				LS_INSERTUSER : LS_INSERTUSER,
				LS_ADDRESS : LS_ADDRESS
			},
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");},
			colNames:['매입번호', '매입일자', '매입구분', '관리번호', '지역코드',
			          '지역구분', '시/도코드', '시/도구분',  '지목', '주소',
			          '원지주 성명', '주민번호', '계약면적', '계약평수', '잔여면적',
			          '잔여평수', '매매대금', '매매단가', '등기여부', '등기일자',
			          '비고'],
			colModel:[
				{name:"BUYID",				index:'BUYID',			width:100,	align:'center', hidden:true}
				, {name:"BUYDATE",			index:'BUYDATE',		width:100,	align:'center'}
				, {name:"BUYGUBUN",			index:'BUYGUBUN',		width:100,	align:'center', hidden:true}
				, {name:"MANAGENO",			index:'MANAGENO',		width:100,	align:'center', hidden:true}
				, {name:"CITYCODE",			index:'CITYCODE',		width:100,	align:'center', hidden:true}
				, {name:"CITYNAME",			index:'CITYNAME',		width:100,	align:'center', hidden:true}
				, {name:"BOROUGHCODE",		index:'BOROUGHCODE',	width:100,	align:'center', hidden:true}
				, {name:"BOROUGHNAME",		index:'BOROUGHNAME',	width:100,	align:'center', hidden:true}
				, {name:"USETYPE",			index:'USETYPE',		width:100,	align:'center', hidden:true}
				, {name:"ADDRESS",			index:'ADDRESS',		width:100,	align:'center'}
				, {name:"OWNERNAME",		index:'OWNERNAME',		width:100,	align:'center'}
				, {name:"OWNERJUMINID",		index:'OWNERJUMINID',	width:100,	align:'center', hidden:true}
				, {name:"BUYM2",			index:'BUYM2',			width:100,	align:'center'}
				, {name:"BUYPY",			index:'BUYPY',			width:100,	align:'center'}
				, {name:"BUNJANM2",			index:'BUNJANM2',		width:100,	align:'center', hidden:true}
				, {name:"BUNJANPY",			index:'BUNJANPY',		width:100,	align:'center', hidden:true}
				, {name:"BUYAMT",			index:'BUYAMT',			width:100,	align:'center'}
				, {name:"BUYDANGA",			index:'BUYDANGA',		width:100,	align:'center', hidden:true}
				, {name:"REGYN",			index:'REGYN',			width:100,	align:'center', hidden:true}
				, {name:"REGDATE",			index:'REGDATE',		width:100,	align:'center', hidden:true}
				, {name:"REMARK",			index:'REMARK',			width:100,	align:'center', hidden:true}
				
			],
			rowNum:10,
			autowidth: true,
			shrinkToFit: false,
			rowList:[10,20,30],
			sortname: 'buyDate',
			viewrecords: true,
			sortorder:'asc',
			width: "96%",
			jsonReader: {
				repeatitems: false
			},
			//height: '100%',
			onSelectRow: function(ids){
				var selRowData = $(this).jqGrid('getRowData', ids);
				$("#BUYDATE").val(selRowData.BUYDATE);
				$("#BUYID").val(selRowData.BUYID);
				$("#BUYGUBUN").val(selRowData.BUYGUBUN);
				$("#MANAGENO").val(selRowData.MANAGENO);
				$("#CITYCODE").val(selRowData.CITYCODE);
				$("#BOROUGHCODE").val(selRowData.BOROUGHCODE);
				$("#USETYPE").val(selRowData.USETYPE);
				$("#ADDRESS").val(selRowData.ADDRESS);
				$("#OWNERNAME").val(selRowData.OWNERNAME);
				$("#OWNERJUMINID").val(selRowData.OWNERJUMINID);
				$("#BUYM2").val(selRowData.BUYM2);
				$("#BUYPY").val(selRowData.BUYPY);
				$("#BUNYM2").val(selRowData.BUNYM2);
				$("#BUNJANM2").val(selRowData.BUNJANM2);
				$("#BUNYPY").val(selRowData.BUNYPY);
				$("#BUNJANPY").val(selRowData.BUNJANPY);
				$("#BUYAMT").val(selRowData.BUYAMT);
				$("#BUYDANGA").val(selRowData.BUYDANGA);
				$("input:radio[name=REGYN]:input[value=" + selRowData.REGYN + "]").attr("checked", true);
				$("#REGDATE").val(selRowData.REGDATE);
				$("#REMARK").val(selRowData.REMARK);
				
				f_selectListEnaPayScheduleTb(selRowData.BUYID);
				f_selectListEnaSalesOpenTb(selRowData.BUYID);
				
				$("#right1Div").show();
				$("#right2Div").hide();
				f_selectListEnaBoroughCode();
			} ,
			hidegrid: false
		});
	}
	
	function f_selectListEnaPayScheduleTb(BUYID){
		$('#rightList1').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#rightList1').jqGrid({
			//caption: '매입관리'
			url:"/home/selectListEnaPayScheduleTb.do" ,
			datatype:"json",
			mtype: 'POST',
			postData : {
				BUYID : BUYID
			},
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");},
			colNames:['지급구분', '지급일자', '지급금액', '지급여부', '비고'],
			colModel:[
				{name:"PAYGUBUN",	index:'PAYGUBUN',	width:100,	align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/dcodeList.do?CCODE=005", buildSelect:f_selectListEnaPayGubunCode} }
				, {name:"PAYDATE",	index:'PAYDATE',	width:100,	align:'center', editable:true}
				, {name:"PAYAMT",	index:'PAYAMT',		width:100,	align:'center', editable:true}
				, {name:"PAYYN",	index:'PAYYN',		width:100,	align:'center', editable:true, edittype:'select', editoptions:{value: "Y:Y;N:N"}}
				, {name:"REMARK",	index:'REMARK',		width:100,	align:'center', editable:true}
			],
			rowNum:100,
			autowidth: true,
			shrinkToFit: false,
			rowList:[10,20,30],
			sortname: 'payGubun',
			viewrecords: true,
			sortorder:'desc',
			width: "96%",
			jsonReader: {
				repeatitems: false
			},
			onSelectRow : function(rowid) {
				$('#rightList1').jqGrid('editRow',rowid,false);
			},
			hidegrid: false
		});
	}
	
	function f_selectListEnaPayGubunCode(data){
		var jsonValue = $.parseJSON(data).dcodeList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.DCODE + "'>" + currentValue.DCODENAME + "</option>\n";
		});
		
		result +="</select>";
		return result;
				
	}
	
	function f_selectListEnaSalesOpenTb(BUYID){
		$('#rightList2').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#rightList2').jqGrid({
			//caption: '매입관리'
			url:"/home/selectListEnaSalesOpenTb.do" ,
			datatype:"json",
			mtype: 'POST',
			postData : {
				BUYID : BUYID
			},
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");},
			colNames:['지사', '오픈여부', '홀딩여부', '홀딩면적', '홀딩일자', '비고'],
			colModel:[
				{name:"BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center', editable:true, edittype:'select', editoptions:{dataUrl:"/codeCom/branchMstList.do", buildSelect:f_selectListEnaBranchCode}}
				, {name:"OPENYN",		index:'OPENYN',			width:100,	align:'center', editable:true, edittype:'select', editoptions:{value: "Y:Y;N:N"}}
				, {name:"HOLDINGYN",	index:'HOLDINGYN',		width:100,	align:'center', editable:true, edittype:'select', editoptions:{value: "Y:Y;N:N"}}
				, {name:"HOLDINGPY",	index:'HOLDINGPY',		width:100,	align:'center', editable:true}
				, {name:"HOLDINGDATE",	index:'HOLDINGDATE',	width:100,	align:'center', editable:true}
				, {name:"REMARK",		index:'REMARK',			width:100,	align:'center', editable:true}
			],
			rowNum:100,
			autowidth: true,
			shrinkToFit: false,
			rowList:[10,20,30],
			sortname: 'branchCode',
			viewrecords: true,
			sortorder:'asc',
			width: "96%",
			jsonReader: {
				repeatitems: false
			},
			//height: '100%',
			onSelectRow: function(rowid){
				$('#rightList2').jqGrid('editRow',rowid,false);
			},
			hidegrid: false
		});
	}
	
	function f_selectListEnaBranchCode(data){
		var jsonValue = $.parseJSON(data).branchMstList;
		
		var result = "<select>";
		
		jsonValue.some(function(currentValue, index, array){
			result += "<option value='" + currentValue.BRANCHCODE + "'>" + currentValue.BRANCHNAME + "</option>\n";
		});
		
		result +="</select>";
		return result;
	}
	
	$(function(){
		$("#rightList1B").click(function(){
			$("#right1Div").show();
			$("#right2Div").hide();
		}) 
	})
	$(function(){
		$("#rightList2B").click(function(){
			$("#right2Div").show();
			$("#right1Div").hide();
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
						<a class="ui-button ui-widget ui-corner-all" id="insertButton" name="insertButton">추가</a>
						<a class="ui-button ui-widget ui-corner-all" id="deleteButton" name="deleteButton">삭제</a>
						<a class="ui-button ui-widget ui-corner-all" id="saveButton" name="saveButton">저장</a>
					</td>
				</tr>
			</table>
		</div>
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
		
			<table class="blueone">
				<tr>
					<td>매입기간</td>
					<td><input type="text" id="LS_BUYDATE_FR" name="LS_BUYDATE_FR" /> - <input type="text" id="LS_BUYDATE_TO" name="LS_BUYDATE_TO" /></td>
				</tr>
				<tr>
					<td>담당자</td>
					<td>
						<input type="text" id="LS_INSERTUSER" name="LS_INSERTUSER" />
					</td>
				</tr>
				<tr>
					<td>지번(주소)</td>
					<td><input type="text" id="LS_ADDRESS" name="LS_ADDRESS" /></td>
				</tr>
			</table>
			<table id="leftList"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table class="blueone">
				<tr>
					<td>계약일자 / 번호</td>
					<td colspan="3"><input type="text" id="BUYDATE" name="BUYDATE" /> - <input type="text" id="BUYID" name="BUYID" />&nbsp;<a class="ui-button ui-widget ui-corner-all" id="searchButton" name="searchButton">=></a></td>
				</tr>
				<tr>
					<td>매입구분</td>
					<td colspan="3">
						<select id="BUYGUBUN" name="BUYGUBUN">
						</select>
					</td>
				</tr>
				<tr>
					<td>관리번호</td>
					<td colspan="3"><input type="text" id="MANAGENO" name="MANAGENO" /></td>
				</tr>
				<tr>
					<td>지역구분</td>
					<td>
						<select id="CITYCODE" name="CITYCODE">
						</select>
					</td>
					<td>시/도구분</td>
					<td>
						<select id="BOROUGHCODE" name="BOROUGHCODE">
						</select>
					</td>
				</tr>
				<tr>
					<td>지목</td>
					<td colspan="3">
						<select id="USETYPE" name="USETYPE">
						</select>
					</td>	
				</tr>
				<tr>
					<td>주소</td>
					<td colspan="3"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
				</tr>
				<tr>
					<td>원지주성명</td>
					<td><input type="text" id="OWNERNAME" name="OWNERNAME" /></td>
					<td>주민번호</td>
					<td><input type="text" id="OWNERJUMINID" name="OWNERJUMINID" /></td>
				</tr>
				<tr>
					<td>계약면적</td>
					<td><input type="text" id="BUYM2" name="BUYM2" /></td>
					<td>계약평수</td>
					<td><input type="text" id="BUYPY" name="BUYPY" /></td>
				</tr>
				<tr>
					<td>분양/잔여면적</td>
					<td><input type="text" id="BUNYM2" name="BUNYM2" /> / <input type="text" id="BUNJANM2" name="BUNJANM2" /></td>
					<td>분양/잔여평수</td>
					<td><input type="text" id="BUNYPY" name="BUNYPY" /> / <input type="text" id="BUNJANPY" name="BUNJANPY" /></td>
				</tr>
				<tr>
					<td>매매대금</td>
					<td><input type="text" id="BUYAMT" name="BUYAMT" /></td>
					<td>매매단가</td>
					<td><input type="text" id="BUYDANGA" name="BUYDANGA" /></td>
				</tr>
				<tr>
					<td>등기여부</td>
					<td colspan="3">
						<input type="radio" id="REGYN" name="REGYN" value="Y">등기완료
						<input type="radio" id="REGYN" name="REGYN" value="N">미등기
					</td>
				</tr>
				<tr>
					<td>등기일자</td>
					<td colspan="3"><input type="text" id="REGDATE" name="REGDATE" /></td>
				</tr>
				<tr>
					<td>비고</td>
					<td colspan="3"><input type="text" id="REMARK" name="REMARK" /></td>
				</tr>
			</table>
			<br/>
			<table>
				<tr>
					<td><a class="ui-button ui-widget ui-corner-all" id="rightList1B" name="rightList1B">지급 스케줄관리</a></td>
					<td><a class="ui-button ui-widget ui-corner-all" id="rightList2B" name="rightList2B">지사 오픈관리</a></td>
				</tr>
			</table>
			<div id="right1Div">
				<table id="rightList1"></table>
			</div>
			<div id="right2Div">
				<table id="rightList2"></table>
			</div>
			<div id="topDiv2" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
				<table width="99%">
					<tr>
						<td align="left" width="70%" >
							<table class="blueone">
								<tr>
									<td>지급합계</td>
									<td colspan="3"><input type="text" id="BUYDATE" name="BUYDATE" /></td>
								</tr>
							</table>
						</td>
						<td align="right">
							<a class="ui-button ui-widget ui-corner-all" id="addButton" name="addButton">추가</a>
							<a class="ui-button ui-widget ui-corner-all" id="saveButton2" name="saveButton2">저장</a>
						</td>
					</tr>
				</table>
			</div>
			
		</div>
	</div>	
</body>
</html>