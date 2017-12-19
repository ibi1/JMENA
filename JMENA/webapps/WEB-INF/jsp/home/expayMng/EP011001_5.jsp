<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JMENA</title>
	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
	<link rel="stylesheet" href="/resource/css/ui.jqgrid.css" />

	<script type="text/javascript" src="/resource/js/jquery.js"></script>
	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			var BRANCHCODE = $("#BRANCHCODE",opener.document).val();
			var INSACODEARR = $("#INSACODE",opener.document).val();
			var S_KNAME = "";
			
			var ids = jQuery("#bottomList",opener.document).jqGrid('getDataIDs');
			
			ids.some(function(currentValue, index, array){
				var cellData = $("#bottomList",opener.document).jqGrid('getRowData', ids[index]); //셀 전체 데이터 가져오기
				INSACODEARR += "^" + cellData.INSACODE;
			});
			
			f_selectListEnaSaleMstPopup(BRANCHCODE, INSACODEARR, S_KNAME);
		});
		
		
// 		obj.put("INSACODE", lst.get(i).getINSACODE());
// 		obj.put("KNAME", lst.get(i).getKNAME());
// 		obj.put("BRANCHCODE", lst.get(i).getBRANCHCODE());
// 		obj.put("BRANCHNAME", lst.get(i).getBRANCHNAME());
// 		obj.put("GRADE", lst.get(i).getGRADE());
// 		obj.put("GRADENAME", lst.get(i).getGRADENAME());
// 		obj.put("DUTY", lst.get(i).getDUTY());
// 		obj.put("DUTYNAME", lst.get(i).getDUTYNAME());
		
		//수당관리 수당수령인 메인 그리드 팝업
		function f_selectListEnaSaleMstPopup(BRANCHCODE, INSACODEARR, S_KNAME){
			$('#leftList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
			
			$('#leftList').jqGrid({
				url:"/home/selectListEanHRInsaMstPopup.do" ,
				datatype:"json",
				mtype: 'POST',
				postData : {
					BRANCHCODE : BRANCHCODE,
					INSACODEARR : INSACODEARR,
					S_KNAME : S_KNAME
				},
				loadtext: '로딩중...',
				loadError:function(){alert("Error~!!");},
				colNames:['인사코드', '성명', 
				          '지사코드', '지사명', '직급', '직급명', '직책', '직책명'],
				colModel:[
					{name:"INSACODE",	index:'INSACODE',	width:100,	align:'center',	sortable:false},
					{name:"KNAME",		index:'KNAME',		width:100,	align:'center',	sortable:false},
					{name:"BRANCHCODE",	index:'BRANCHCODE',	width:100,	align:'center',	sortable:false, hidden:true},
					{name:"BRANCHNAME",	index:'BRANCHNAME',	width:100,	align:'center',	sortable:false},
					{name:"GRADE",		index:'GRADE',		width:100,	align:'center',	sortable:false, hidden:true},
					{name:"GRADENAME",	index:'GRADENAME',	width:100,	align:'center',	sortable:false},
					{name:"DUTY",		index:'DUTY',		width:100,	align:'center',	sortable:false, hidden:true},
					{name:"DUTYNAME",	index:'DUTYNAME',	width:100,	align:'center',	sortable:false}
				],
				rowNum:10000000,
				autowidth: true,
				shrinkToFit: false,
				rowList:[10,20,30],
				sortname: 'GRADE',
				viewrecords: true,
				sortorder:'asc',
				width: "100%",
				jsonReader: {
					repeatitems: false
				},
				height: '400px',
				onSelectRow: function(ids) {
					
				} ,
				ondblClickRow: function(id,irow,icol,e) {
					var selRowData = $('#leftList').jqGrid('getRowData', id);
					
					var ids = $("#bottomList",opener.document).jqGrid('getGridParam', 'selrow');	//선택아이디 가져오기
					
					$("#bottomList",opener.document).jqGrid('setCell', ids, 'GRADE', selRowData.GRADENAME);
					$("#bottomList",opener.document).jqGrid('setCell', ids, 'DUTY', selRowData.DUTYNAME);
					$("#bottomList",opener.document).jqGrid('setCell', ids, 'TAXGUBUN', '001');
					$("#bottomList",opener.document).jqGrid('setCell', ids, 'KNAME', selRowData.KNAME);
					$("#bottomList",opener.document).jqGrid('setCell', ids, 'SALEID', $("#SALEID",opener.document).val());
					$("#bottomList",opener.document).jqGrid('setCell', ids, 'INSACODE', selRowData.INSACODE);
					
					$("#bottomList",opener.document).jqGrid('setSelection', 0, true);
					
					self.close();
				},
				loadComplete: function(ids) {
					//전체 카운트
					var countRow = $("#leftList").jqGrid('getGridParam', 'records');
					$("#leftListCount").html(countRow);
				},
				hidegrid: false
			});
		}
		
		$(function() {
			$("#S_KNAME").keydown(function() {
				var keyCode = window.event.keyCode;
				if(keyCode==13 || keyCode==9) {
					var BRANCHCODE = $("#BRANCHCODE",opener.document).val();
					var INSACODEARR = $("#INSACODE",opener.document).val();
					var S_KNAME = $("#S_KNAME").val();
					f_selectListEnaSaleMstPopup(BRANCHCODE, INSACODEARR, S_KNAME)
				}
			});
		});
		
	</script>
</head>
<body>
	<div id="contents" style="width:600px;" align="center">
		<div id="leftDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table>
				<tr>
					<td>담당자 : <input type="text" class="inputName" id="S_KNAME" name="S_KNAME" /></td>
				</tr> 
			</table>
		</div>
		<div id="leftDiv" style="width:100%; float:left; padding: 10px" align="left">
			<div align="right">총 건수 : <font color="red"><sapn id="leftListCount"></sapn></font>건</div>
			<table id="leftList"></table>
		</div>
	</div>
</body>
</html>