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

	$(function(){
		var INSACODE = "";
		$("#table1").show();
		$("#table2").hide();
		selectListInsaMst();
		selectListEnaAppointItem(INSACODE);
		selectListEnaTexPayerItem(INSACODE);
		f_selectListEnaBranchCode();
		f_selectListEnaDeptcodeCode();
		f_selectListEnaGradeCode();
		f_selectListEnaDutyCode();		
	})


	function selectListInsaMst(){	
		$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#leftList').jqGrid({
			//caption: '인사관리', 
			url:"/home/selectListEnaInsaMst.do" ,
			mtype: 'POST',
			postData : {
				S_BRANCHCODE : $("#S_BRANCHCODE,").val(),
				S_DEPTCODE : $("#S_DEPTCODE,").val(),
				S_KNAME : $("#S_KNAME,").val(),
				S_JUMINID : $("#S_JUMINID,").val()
			},			
			datatype:"json",		
			loadError:function(){alert("Error~!!");},
			colNames:['사번', '성명', '주민번호', '연락처', '소속지사코드', '소속지사', '소속부서코드', '소속부서','생일구분'
			          ,'사업자번호','대표자명','주소','기타연락처','월정지급액','고용구분','직급','직책','입사일','재입사여부','퇴사일','추천인사번','비고'],
			colModel:[
				{name:"INSACODE",			index:'INSACODE',		width:100,	align:'center'}
				, {name:"KNAME",			index:'KNAME',			width:100,	align:'center'}
				, {name:"JUMINID",			index:'JUMINID',		width:100,	align:'center'}
				, {name:"MOBILENO",			index:'MOBILENO',		width:100,	align:'center'}
				, {name:"BRANCHCODE",		index:'BRANCHCODE',		width:100,	align:'center', hidden:true}
				, {name:"BRANCHNAME",		index:'BRANCHNAME',		width:100,	align:'center'}
				, {name:"DEPTCODE",			index:'DEPTCODE',		width:100,	align:'center', hidden:true}
	 			, {name:"DEPTNAME",			index:'DEPTNAME',		width:100,	align:'center'} 		
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
			onSelectRow: function(ids){
				
				var selRowData = $(this).jqGrid('getRowData', ids);
				$("#INSACODE").val(selRowData.INSACODE);
	 			$("#KNAME").val(selRowData.KNAME);
				$("#JUMINID").val(selRowData.JUMINID);
				$("input:radio[name=BIRTHDAYGUBUN]:input[value=" + selRowData.BIRTHDAYGUBUN + "]").attr("checked", true);
				$("#SAUPID").val(selRowData.SAUPID);
				$("#SAUPOWNER").val(selRowData.SAUPOWNER);
				$("#ADDRESS").val(selRowData.ADDRESS);
				$("#MOBILENO").val(selRowData.MOBILENO);
				$("#TELNO").val(selRowData.TELNO);
				$("#BRANCHCODE").val(selRowData.BRANCHCODE);
				$("#DEPTCODE").val(selRowData.DEPTCODE);
				$("#BASICPAY").val(selRowData.BASICPAY);
				$("input:radio[name=EMPLOYGUBUN]:input[value=" + selRowData.EMPLOYGUBUN + "]").attr("checked", true);
				$("#GRADE").val(selRowData.GRADE);
				$("#DUTY").val(selRowData.DUTY);
				$("#JOINDATE").val(selRowData.JOINDATE);
				$("#REJOINYN").val(selRowData.REJOINYN);
				$("#RETIREDATE").val(selRowData.RETIREDATE);
				$("#RECOID").val(selRowData.RECOID);
				$("#REMARK").val(selRowData.REMARK);
				selectListEnaAppointItem(selRowData.INSACODE);				
				selectListEnaTexPayerItem(selRowData.INSACODE);
			} ,
			hidegrid: false
		});		
	}

	
	function selectListEnaAppointItem(INSACODE){
		$('#bottomList1').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용		
		$('#bottomList1').jqGrid({
		//caption: '발령사항'
		url:"/home/selectListEnaAppointItem.do" ,
		mtype: 'POST',
		postData : {
			INSACODE : INSACODE
		},
		datatype:"json" ,
		loadError:function(){alert("Error~!!!!");} ,
		colNames:['발령구분', '발령일자', '발령지사', '발령부서', '직급', '직책', '고용구분', '월정지급액', '비고'] ,
		colModel:[
			{name:"APPOINTGUBUN",		index:'APPOINTGUBUN',		width:60,		align:'center'}
			, {name:"APPOINTDATE",		index:'APPOINTDATE',		width:60,		align:'center'}
			, {name:"APPOINTBRANCH",	index:'APPOINTBRANCH',		width:60,		align:'center'}
			, {name:"APPOINTDEPT",		index:'APPOINTDEPT',		width:60,		align:'center'}
			, {name:"GRADE",			index:'GRADE',				width:60,		align:'center'}
			, {name:"DUTY",				index:'DUTY',				width:60,		align:'center'}
			, {name:"EMPLOYGUBUN",		index:'EMPLOYGUBUN',		width:60,		align:'center'}
			, {name:"PREBASICPAY",		index:'PREBASICPAY',		width:60,		align:'center'}
			, {name:"REMARK",			index:'REMARK',				width:60,		align:'center'}
		] ,
		rowNum:10 ,
		autowidth: true ,
		shrinkToFit: false,
		rowList:[10,20,30] ,
		sortname: 'appointDate' ,
		viewrecords: true ,
		sortorder:'desc' ,
		width: '96%' ,
		jsonReader: {
			repeatitems: false
		},
		//, height: '100%'
		onSelectRow: function(id){
			alert(id);
		} ,
		hidegrid: false
		});	
		
	}	
	
	
	
	function selectListEnaTexPayerItem(INSACODE){
		$('#bottomList2').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#bottomList2').jqGrid({
			//caption: '신고인관리'
			url:"/home/selectListEnaTexPayerItem.do" ,
			postData : {
				INSACODE : INSACODE
			},		
			datatype:"json" ,
			loadError:function(){alert("Error~!!");} ,
			colNames:['사번','순번','소득신고인', '주민번호', '거래은행', '계좌번호', '계좌주', '기본계좌', '비고'] ,
			colModel:[
				 {name:"INSACODE",		index:'INSACODE',		width:60,		align:'center', hidden:true}
				,{name:"ITEMSEQ",		index:'ITEMSEQ',		width:60,		align:'center', hidden:true}
				,{name:"PAYERNAME",		index:'PAYERNAME',		width:60,		align:'center'}
				,{name:"PAYERID",		index:'PAYERID',		width:60,		align:'center'}
				,{name:"BANKID",		index:'BANKID',			width:60,		align:'center'}
				,{name:"ACCTNO",		index:'ACCTNO',			width:60,		align:'center'}
				,{name:"ACCTOWNER",		index:'ACCTOWNER',		width:60,		align:'center'}
				,{name:"BASICACCT",		index:'BASICACCT',		width:60,		align:'center'}
				,{name:"REMARK",		index:'REMARK',			width:60,		align:'center'}
			] ,
			rowNum:10 ,
			autowidth: true ,
			shrinkToFit: false,
			rowList:[10,20,30] ,
			sortname: 'ITEMSEQ' ,
			viewrecords: true ,
			sortorder:'asc' ,
			width: '96%' ,
			jsonReader: {
				repeatitems: false
			},
			//, height: '100%'
			onSelectRow: function(id){
				alert(id);
			} ,
			hidegrid: false
		});
	}

	
	
	
	
	$(function(){
		$("#searchButton").click(function(){
			selectListInsaMst();
		}) 
		
		$("#bottomDiv1").click(function(){
//			$("#bottomList2").hide();
//			$("#bottomList1").show();

			$("#table1").show();
			$("#table2").hide();
			
		}) 		
		
		$("#bottomDiv2").click(function(){
			$("#table1").hide();
			$("#table2").show();	
		}) 		
	})	


	$(function(){
		$("#saveButton").click(function(){
			var formData = $("#HR011001").serialize();
		   	$.ajax({ 
				type: 'POST' ,
				url: "/home/updateHR011001.do", 
				//dataType : 'json' , 
				data : formData,
				//contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
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
					alert("인사 정보를 저장하는 중 오류가 발생하였습니다.");
				}  
			});
		}) 
	})	
	

	function f_selectListEnaBranchCode(){		
		var CCODE = "001";
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
				$("#BRANCHCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});		
	}
	
	
	function f_selectListEnaDeptcodeCode(){
		var CCODE = "001";
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
				$("#DEPTCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	
	function f_selectListEnaGradeCode(){
		var CCODE = "003";
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
				$("#GRADE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
		
	
	function f_selectListEnaDutyCode(){
		var CCODE = "004";
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
				$("#DUTY").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
			
	
	$(function() {
		$("#insertButton").click(function() {
			var ids = $("#leftList").jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
			
			if (ids == null || ids == "") {
				alert("선택된 사원이 없습니다.");
				
				return false;
			}
			
//			$("#S_FLAG_R").val("I");
			$("#bottomList1").jqGrid("addRow", 0);
		});
	})
	
	
	
</script>
<body>

<table width="99%">
	<tr>
		<td align="right">
			<table>
				<tr>
					<td><a class="ui-button ui-widget ui-corner-all" id="searchButton" name="searchButton">조회 </a></td>
					<td><a class="ui-button ui-widget ui-corner-all" id="addButton"    name="addButton">추가 </a></td>
					<td><a class="ui-button ui-widget ui-corner-all" id="saveButton"   name="saveButton">저장 </a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	<div id="contents" style="width:1200px;" align="center">
		<div id="leftDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<table width="99%" class="blueone">
				<tr>
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
							<option value="1">개발 1팀</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>성명</th>
					<td colspan="3"><input type="text" class="inputName" id="S_KNAME" name="S_KNAME" /></td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td colspan="3"><input type="text" id="S_JUMINID" name="S_JUMINID" /></td>
				</tr>
			</table>
			<br/>
			<table id="leftList" width="98%"></table>
		</div>
		<div id="rightDiv" style="width:48%; float:left; border:1px solid #333; padding: 10px" align="left">
			<form id="HR011001">
			<table width="99%" class="blueone">
				<tr>
					<th>성명 / 사번</th>
					<td colspan="3"><input type="text" id="KNAME" name="KNAME" /><input type="text" id="INSACODE" name="INSACODE" /></td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td><input type="text" id="JUMINID" name="JUMINID" /> - <input type="text" id="juminId" name="juminId" /></td>
					<th>생일구분</th>
					<td><input type="radio" id="BIRTHDAYGUBUN" name="BIRTHDAYGUBUN" value="S" />양력 <input type="radio" id="BIRTHDAYGUBUN" name="BIRTHDAYGUBUN" value="M" />음력</td>
				</tr>
				<tr>
					<th>사업자번호</th>
					<td><input type="text" id="SAUPID" name="SAUPID" /> - <input type="text" id="SAUPID" name="SAUPID" /> - <input type="text" id="SAUPID" name="SAUPID" /></td>
					<th>대표자명</th>
					<td><input type="text" id="SAUPOWNER" name="SAUPOWNER" /></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3"><input type="text" id="ADDRESS" name="ADDRESS" /></td>
				</tr>
				<tr>
					<th>핸드폰번호</th>
					<td><input type="text" id="MOBILENO" name="MOBILENO" /></td>
					<th>기타연락처</th>
					<td><input type="text" id="TELNO" name="TELNO" /></td>
				</tr>
				<tr>
					<th>소속지사</th>
					<td colspan="3">
						<select id="BRANCHCODE" name="BRANCHCODE">
						</select>
					</td>
				</tr>
				<tr>
					<th>소속부서</th>
					<td>
						<select id="DEPTCODE" name="DEPTCODE">
						</select>
					</td>
					<th>월정지급액</th>
					<td><input type="text" id="BASICPAY" name="BASICPAY" /></td>
				</tr>
				<tr>
					<th>고용구분</th>
					<td colspan="3"><input type="radio" id="EMPLOYGUBUN" name="EMPLOYGUBUN" value="R" />정규 <input type="radio" id="EMPLOYGUBUN" name="EMPLOYGUBUN" value="F" />프리</td>
				</tr>
				<tr>
					<th>직급</th>
					<td>
						<select id="GRADE" name="GRADE"></select>
					</td>
					<th>직책</th>
					<td>
						<select id="DUTY" name="DUTY"></select>
					</td>
				</tr>
				<tr>
					<th>입사일</th>
					<td><input type="text" id="JOINDATE" name="JOINDATE" /></td>
					<th>재입사여부</th>
					<td><input type="checkbox" id="REJOINYN" name="REJOINYN" value="Y"/></td>
				</tr>
				<tr>
					<th>퇴사일</th>
					<td colspan="3"><input type="text" id="RETIREDATE" name="RETIREDATE" /></td>
				</tr>
				<tr>
					<th>추천인</th>
					<td colspan="3">
						<select id="RECOID" name="RECOID">
							<option value="recoId">insaCode</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>비고</th>
					<td colspan="3"><input type="text" id="REMARK" name="REMARK" /></td>
				</tr>			
			</table>
			</form>
		</div>
	</div>
	
<table width="99%">
	<tr >
		<td><a class="ui-button ui-widget ui-corner-all" id="bottomDiv1"   name="bottomDiv1">발령사항 </a>
		<a class="ui-button ui-widget ui-corner-all" id="bottomDiv2"   name="bottomDiv2">신고인 관리 </a></td>
		<td align="right">
			<a class="ui-button ui-widget ui-corner-all" id="insertButton" name="insertButton">추가</a>
			<a class="ui-button ui-widget ui-corner-all" id="deleteButton"   name="deleteButton">삭제 </a>
			<a class="ui-button ui-widget ui-corner-all" id="saveButton"   name="saveButton">저장 </a>
		</td>
	</tr>
</table>	
		<div id="bottomDiv" style="width:98%; float:left; border:1px solid #333; padding: 10px" align="left">
			<div id ="table1">
			<table id="bottomList1"></table>
			</div>
			<div id="table2">
			<table id="bottomList2"></table>
			</div>
		</div>	
</body>
</html>