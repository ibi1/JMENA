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
		
		var S_CITYCODE = "";
		var S_BOROUGHCODE = "";
		var S_ADDRESS = "";
		
		f_selectListMM012001(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
		f_selectListEnaCityCode();
		f_selectListEnaBoroughCode();
	});


	function f_selectListEnaCityCode(){
		$("#S_CITYCODE").empty().data('options');
	   	$.ajax({ 
			type: 'POST' ,
			url: "/codeCom/cityMstList.do", 
			dataType : 'json' , 
			success: function(data){
				var inHtml = "";
				data.cityMstList.forEach(function(currentValue, index, array){
					inHtml += "<option value='" + currentValue.CITYCODE + "'>" + currentValue.CITYNAME + "</option>\n";
				});
				$("#S_CITYCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}

	$(function(){
		$("#S_CITYCODE").change(function() {
			f_selectListEnaBoroughCode();
		});
	});
	
	
	function f_selectListEnaBoroughCode(){
		var CITYCODE = $("#S_CITYCODE").val();
		$("#S_BOROUGHCODE").empty().data('options');

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
				$("#S_BOROUGHCODE").append(inHtml);
			},
			error:function(e){  
				alert("[ERROR]System Menu Combo 호출 중 오류가 발생하였습니다.");
			}  
		});
	}
	
	
	function f_selectListMM012001(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS){
		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '원지주 잔금현황', 
			url:"/home/selectListMM012001.do" ,
			datatype:"json" ,
			mtype: 'POST',
			postData : {
				S_CITYCODE : S_CITYCODE,
				S_BOROUGHCODE : S_BOROUGHCODE,
				S_ADDRESS : S_ADDRESS
			},
			loadtext: '로딩중...',
			loadError:function(){alert("Error~!!");},
			colNames:['지역코드', '지역', '시/도코드', '시/도', '주소/지번', '원지주', '면적(m2)', 
			          '평수' , '분양평수', '잔여평수', '매매대금', '계약금',
			          '계약일', '중도금1', '중도일1', '중도금2', '중도일2',
			          '잔금액', '잔금일', '잔금누계', '오픈여부', '비고'],
			colModel:[
						{name:"CITYCODE",			index:'CITYCODE',		width:100,	align:'center', hideen:true}
						,{name:"CITYNAME",			index:'CITYNAME',		width:100,	align:'center'}
						, {name:"BOROUGHCODE",		index:'BOROUGHCODE',	width:100,	align:'center', hideen:true}
						, {name:"BOROUGHNAME",		index:'BOROUGHNAME',	width:100,	align:'center'}
						, {name:"ADDRESS",			index:'ADDRESS',		width:100,	align:'center'}
						, {name:"OWNERNAME",		index:'OWNERNAME',		width:100,	align:'center'}
						, {name:"BUYM2",			index:'BUYM2',			width:150,	align:'center'}
						, {name:"BUYPY",			index:'BUYPY',			width:100,	align:'center'}
						, {name:"BUNBUYPY",			index:'BUNBUYPY',		width:100,	align:'center'}
						, {name:"JANBUYPY",			index:'JANBUYPY',		width:100,	align:'center'}
						, {name:"BUYAMT",			index:'BUYAMT',			width:100,	align:'center'}
						, {name:"PAYAMT1",			index:'PAYAMT1',		width:100,	align:'center'}
						, {name:"PAYDATE1",			index:'PAYDATE1',		width:100,	align:'center'}
						, {name:"PAYAMT2",			index:'PAYAMT2',		width:100,	align:'center'}
						, {name:"PAYDATE2",			index:'PAYDATE2',		width:100,	align:'center'}
						, {name:"PAYAMT3",			index:'PAYAMT3',		width:150,	align:'center'}
						, {name:"PAYDATE3",			index:'PAYDATE3',		width:150,	align:'center'}
						, {name:"PAYAMT4",			index:'PAYAMT4',		width:100,	align:'center'}
						, {name:"PAYDATE4",			index:'PAYDATE4',		width:100,	align:'center'}
						, {name:"JANPAYAMT",		index:'JANPAYAMT',		width:100,	align:'center'}
						, {name:"OPENYN",			index:'OPENYN',			width:100,	align:'center'}
						, {name:"REMARK",			index:'REMARK',			width:150,	align:'center'}
			],
			rowNum:9999,
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
// 			onSelectRow: function(id){
// 				alert(id);
// 			},
			hidegrid: false
		});
		
	}

	$(function(){
		$("#excelButton").click(function(){
		    $.ajax({ 
				type: 'POST' ,
				data: $("#searchForm").serialize(),
				url: "/home/MM012001_exportToExcel.do" , 
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

	$(function(){
		$("#selectButton").click(function(){
			
			var S_CITYCODE = $("#S_CITYCODE").val();
			var S_BOROUGHCODE = $("#S_BOROUGHCODE").val();
			var S_ADDRESS = $("#S_ADDRESS").val();
			
			f_selectListEnaBuyMstP(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
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
			<form name="searchForm" method="POST" action="" class="" >
				<table class="blueone">
					<tr>
						<th>지역구분</th>
						<td>
							<select id="S_CITYCODE" name="S_CITYCODE">
							</select>
						</td>
						<th>시/도</th>
						<td>
							<select id="S_BOROUGHCODE" name="S_BOROUGHCODE">
							</select>
						</td>
						<th>주소 및 지번</th>
						<td><input type="text" id="S_ADDRESS" name="S_ADDRESS" /></td>
					</tr>
				</table>
			</form>
			<br/>
			<table id="mainList" width="98%"></table>
			<div id="mainNav"></div>
		</div>
	</div>
</body>
</html>