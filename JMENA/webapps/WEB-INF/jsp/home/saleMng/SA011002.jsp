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
		$("#SL_KNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#SL_CONADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		
		$("#SALEDATE").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#SALEID").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#MANAGENO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		$("#BUYM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#JANM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#BUYPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#JANPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#CONNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#CONJUMINID").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#CONTELNO").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#CONADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		$("#CONM2").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#CONPY").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#BRROWAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#BRROWPERIOD").jqxInput({theme: 'energyblue', height: 25, width: 80, minLength: 1});
		$("#PAYRATE").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#PAYAMT").jqxInput({theme: 'energyblue', height: 25, width: 100, minLength: 1});
		$("#PAYACCOUNT").jqxInput({theme: 'energyblue', height: 25, width: 120, minLength: 1});
		$("#PAYOWNER").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#BRROWDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#EXPIREDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#EXTENDDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#CANCELDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#REMARK").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		$("#REGDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});		
		
		f_selectListEnaSaleMst();
		f_selectListEnaSaleBDtl();
		
		f_selectListEnaCityCode();
		f_selectListEnaSalerCode();
		f_selectListEnaBranchCode();
		f_selectListEnaBankGubunCode();
		
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
	
	function f_selectListEnaBankGubunCode(){
		$("#PAYBANK").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/bankList.do", 
			dataType : 'json' ,
			success: function(data){
				var inHtml = "";
				data.bankList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.bankCode + "'>" + currentValue.bankName + "</option>\n";
				});
				$("#PAYBANK").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	function f_selectListEnaSaleMst(){
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '금전소비차매출관리'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			postData : {
				
				SL_SALEDATE_FR : $("#SL_SALEDATE_FR").val(),
				SL_SALEDATE_TO : $("#SL_SALEDATE_TO").val(),
				SL_KNAME : $("#SL_KNAME").val(),
				SL_CONADDRESS : $("#SL_CONADDRESS").val()
			},
			loadError:function(){alert("Error~!!");} ,
			colNames:['판매번호', '차입일자', '차입자', '차입물건', '차입금액', '차입형식', '차입이자'] ,
			colModel:[
				{name:"SALEID",			index:'SALEID',			width:100,		align:'center', hidden:true}
				,{name:"BRROWDATE",		index:'BRROWDATE',		width:100,		align:'center'}
				,{name:"CONNAME",		index:'CONNAME',		width:100,		align:'center'}
				,{name:"CONADDRESS",	index:'CONADDRESS',		width:100,		align:'center'}
				,{name:"BRROWAMT",		index:'BRROWAMT',		width:100,		align:'center'}
				,{name:"PERIODGUBUN",	index:'PERIODGUBUN',	width:100,		align:'center'}
				,{name:"PAYAMT",		index:'PAYAMT',			width:100,		align:'center'}
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
				
				var selRowData = $(this).jqGrid('getRowData', ids);
				var SALEID = selRowData.SALEID;
				f_selectListEnaSaleRDtl(SALEID);
				
				
			} ,
			hidegrid: false
		});
	}

	function f_selectListEnaSaleBDtl(){
		$('#bottomList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList').jqGrid({
			//caption: '등기 사항'
			url:"/home/selectListSysMst.do" ,
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['명의자', '주민번호', '연락처', '점유면적', '점유평수', '매매대금', '매매단가', 'DC사항', 'DC 율', '실 매매가', '등본제출여부', '비고'] ,
			colModel:[
				{name:"SYSID",		index:'SYSID',		width:100,		align:'center'}
				, {name:"SYSNAME",	index:'SYSNAME',	width:100,		align:'center'}
				, {name:"SORTKEY",	index:'SORTKEY',	width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"USEYN",	index:'USEYN',		width:100,		align:'center'}
				, {name:"REMARK",	index:'REMARK',		width:100,		align:'center'}
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

	$(function() {
		$("#selectButton").click(function() {
			f_selectListEnaSaleMst();
		});
	})

		
	function f_selectListEnaSaleRDtl(SALEID){
		$("#SL_IPGUMGUBUN").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/home/selectListEnaIpgumMst.do", 
			dataType : 'json' ,
			data : {
				SL_SALEID : SALEID,
			},
			success: function(data){
				data.rows.forEach(function(currentValue, index, array){
					$("#SALEDATE").val(currentValue.SALEDATE);
					$("#SALEID").val(currentValue.SALEID);
					$("#SALERCD").val(currentValue.SALERCD);
					$("#BRANCHNAME").val(currentValue.BRANCHNAME);
					$("#MANAGENO").val(currentValue.MANAGENO);
					$("#CITYCODE").val(currentValue.CITYCODE);
					$("#ADDRESS").val(currentValue.ADDRESS);
					$("#BUYM2").val(currentValue.BUYM2);
					$("#JANM2").val(currentValue.JANM2);
					$("#BUYPY").val(currentValue.BUYPY);
					$("#JANPY").val(currentValue.JANPY);
					$("#CONNAME").val(currentValue.CONNAME);
					$("#CONJUMINID").val(currentValue.CONJUMINID);
					$("#CONTELNO").val(currentValue.CONTELNO);
					$("#CONADDRESS").val(currentValue.CONADDRESS);
					$("#CONM2").val(currentValue.CONM2);
					$("#CONPY").val(currentValue.CONPY);
					$("#BRROWTYPE").val(currentValue.BRROWTYPE);
					$("#BRROWAMT").val(currentValue.BRROWAMT);
					$("#BRROWPERIOD").val(currentValue.BRROWPERIOD);
					$("#PERIODGUBUN").val(currentValue.PERIODGUBUN);
					$("#PAYRATE").val(currentValue.PAYRATE);
					$("#PAYAMT").val(currentValue.PAYAMT);
					$("#PAYACCOUNT").val(currentValue.PAYACCOUNT);
					$("#PAYBANK").val(currentValue.PAYBANK);
					$("#PAYOWNER").val(currentValue.PAYOWNER);
					$("#BRROWDATE").val(currentValue.BRROWDATE);
					$("#EXPIREDATE").val(currentValue.EXPIREDATE);
					$("#EXTENDYN").val(currentValue.EXTENDYN);
					$("#EXTENDDATE").val(currentValue.EXTENDDATE);
					$("#CANCELYN").val(currentValue.CANCELYN);
					$("#CANCELDATE").val(currentValue.CANCELDATE);
					$("#REMARK").val(currentValue.REMARK);
				});
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
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
					<th width="120">차입기간</th>
					<td><input type="text" id="SL_SALEDATE_FR" name="SL_SALEDATE_FR" /> ~ <input type="text" id="SL_SALEDATE_TO" name="SL_SALEDATE_TO" /></td>
				</tr>
				<tr>
					<th width="120">담당자</th>
					<td><input type="text" id="SL_KNAME" name="SL_KNAME" /></td>
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
					<th width="120">담당자</th>
					<td>
						<select id="SALERCD" name="SALERCD">
							<option></option>
						</select>
					</td>
					<th width="120">계약지사</th>
					<td>
						<select id="BRANCHNAME" name="BRANCHNAME">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">관리번호</th>
					<td><input type="text" id="MANAGENO" name="MANAGENO" /></td>
					<th width="120">지역구분</th>
					<td>
						<select id="CITYCODE" name="CITYCODE">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">주소</th>
					<td colspan="3"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
				</tr>
				<tr>
					<th width="120">분양/잔여면적</th>
					<td><input type="text" id="BUYM2" name="BUYM2" /> / <input type="text" id="JANM2" name="JANM2" /></td>
					<th width="120">분양/잔여평수</th>
					<td><input type="text" id="BUYPY" name="BUYPY" /> / <input type="text" id="JANPY" name="JANPY" /></td>
				</tr>
				<tr>
					<th width="120">차입자 성명</th>
					<td><input type="text" id="CONNAME" name="CONNAME" /></td>
					<th width="120">차입자주민번호</th>
					<td><input type="text" id="CONJUMINID" name="CONJUMINID" /></td>
				</tr>
				<tr>
					<th width="120">차입자 연락처</th>
					<td colspan="3"><input type="text" id="CONTELNO" name="CONTELNO" /></td>
				</tr>
				<tr>
					<th width="120">차입자 주소</th>
					<td colspan="3"><input type="text" id="CONADDRESS" name="CONADDRESS" /></td>
				</tr>
				<tr>
					<th width="120">계약면적</th>
					<td><input type="text" id="CONM2" name="CONM2" /></td>
					<th width="120">계약평수</th>
					<td><input type="text" id="CONPY" name="CONPY" /></td>
				</tr>
				<tr>
					<th width="120">차입형식</th>
					<td><input type="radio" id="BRROWTYPE" name="BRROWTYPE" value="M"/> 월지급     <input type="radio" id="BRROWTYPE" name="BRROWTYPE"  value="Y"/> 년지급    </td>
				</tr>
				<tr>
					<th width="120">차입대금</th>
					<td><input type="text" id="BRROWAMT" name="BRROWAMT" /></td>
					<th width="120">차입기간</th>
					<td>
						<input type="text" id="BRROWPERIOD" name="BRROWPERIOD" /> 
						<select id="PERIODGUBUN" name="PERIODGUBUN">
							<option value="M">월</option>
							<option value="Y">년</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">지급이율</th>
					<td><input type="text" id="PAYRATE" name="PAYRATE" /> % </td>
					<th width="120">지급이자</th>
					<td><input type="text" id="PAYAMT" name="PAYAMT" /></td>
				</tr>
				<tr>
					<th width="120">지급계좌</th>
					<td><input type="text" id="PAYACCOUNT" name="PAYACCOUNT" /></td>
					<th width="120">지급은행</th>
					<td>
						<select id="PAYBANK" name="PAYBANK">
							<option></option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120">계좌주</th>
					<td colspan="3"><input type="text" id="PAYOWNER" name="PAYOWNER" /></td>
				</tr>
				<tr>
					<th width="120">차입날짜</th>
					<td><input type="text" id="BRROWDATE" name="BRROWDATE" /></td>
					<th width="120">만기날짜</th>
					<td><input type="text" id="EXPIREDATE" name="EXPIREDATE" /></td>
				</tr>
				<tr>
					<th width="120">만기연장</th>
					<td><input type="checkbox" id="EXTENDYN" name="EXTENDYN" /></td>
					<th width="120">연장날짜</th>
					<td><input type="text" id="EXTENDDATE" name="EXTENDDATE" /></td>
				</tr>
				<tr>
					<th width="120">중도해지</th>
					<td><input type="checkbox" id="CANCELYN" name="CANCELYN" /></td>
					<th width="120">해지날짜</th>
					<td><input type="text" id="CANCELDATE" name="CANCELDATE" /></td>
				</tr>
				<tr>
					<th width="120">비고</th>
					<td colspan="3"><input type="text" id="REMARK" name="REMARK" /></td>
				</tr>
			</table>
		</div>
		<div id="bottomDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table  width="100%">
				<tr>
					<td width="60%" align="left">
						<table >
							<tr>
								<th width="120">공동명의 여부</th>
								<td colspan="4"><input type="checkbox" id="JOINYN" name="JOINYN" /></td>
							</tr>
							<tr>
								<th width="120">등기여부</th>
								<td><input type="radio" id="REGYN" name="REGYN" value="Y"/> 등기완료  <input type="radio" id="REGYN" name="REGYN" value="Y"/> 미등기</td>
								<th width="120">등기일자</th>
								<td><input type="text" id="REGDATE" name="REGDATE" /></td>
							</tr>
						</table>
					</td>
					<td width="40%" align="right">
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
		
			
			<table id="bottomList"></table>
		</div>
	</div>	
</body>
</html>