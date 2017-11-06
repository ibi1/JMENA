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
		
		f_selectListEnaCityCode();
		f_selectListEnaBoroughCode();
		
		f_selectListSA012008(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
		
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
	
	function f_selectListSA012008(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS){

		$('#mainList').jqGrid("GridUnload");	//새로운 값으로 변경할 때 사용
		$('#mainList').jqGrid({
			//caption: '재고장', 
			url:"/home/selectListSA012008.do" ,
			datatype:"json",
			postdata : {
				S_CITYCODE : S_CITYCODE,
				S_BOROUGHCODE : S_BOROUGHCODE,
				S_ADDRESS : S_ADDRESS
			},
			loadError:function(){alert("Error~!!");},
			colNames:['매입구분', '매도자', '주민번호', '주소/지번', '면적(m2)',
			          '등기이전일', '매입금액', '매출순번', '매수자', '주민번호',
			          '계약면적', '이전일', '매도금액', '재고면적', '재고금액'],
			colModel:[
						{name:"BUYGUBUN",		index:'BUYGUBUN',		width:100,	align:'center'}
						,{name:"OWNERNAME",		index:'OWNERNAME',		width:100,	align:'center'}
						,{name:"OWNERJUMINID",	index:'OWNERJUMINID',	width:100,	align:'center'}
						,{name:"ADDRESS",		index:'ADDRESS',		width:100,	align:'center'}
						,{name:"BUYM2",			index:'BUYM2',			width:100,	align:'center'}
						,{name:"REGDATE1",		index:'REGDATE1',		width:100,	align:'center'}
						,{name:"BUYAMT",		index:'BUYAMT',			width:100,	align:'center'}
						,{name:"SELLSEQ",		index:'SELLSEQ',		width:100,	align:'center'}
						,{name:"CONNAME",		index:'CONNAME',		width:100,	align:'center'}
						,{name:"CONJUMINID",	index:'CONJUMINID',		width:100,	align:'center'}
						,{name:"CONM2",			index:'CONM2',			width:100,	align:'center'}
						,{name:"REGDATE2",		index:'REGDATE2',		width:100,	align:'center'}
						,{name:"SALEAMT",		index:'SALEAMT',		width:100,	align:'center'}
						,{name:"REMNM2",		index:'REMNM2',			width:100,	align:'center'}
						,{name:"REMNAMT",		index:'REMNAMT',		width:100,	align:'center'}
						
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
	
	$(function(){
		$("#selectButton").click(function(){
			
			var S_CITYCODE = $("#S_CITYCODE").val();
			var S_BOROUGHCODE = $("#S_BOROUGHCODE").val();
			var S_ADDRESS = $("#S_ADDRESS").val();
			
			f_selectListSA012008(S_CITYCODE, S_BOROUGHCODE, S_ADDRESS);
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
					<th>지역구분</th>
					<td>
						<select id="S_CITYCODE" name="S_CITYCODE">
						</select>
					</td>
					<th>시/도 구분</th>
					<td>
						<select id="S_BOROUGHCODE" name="S_BOROUGHCODE">
						</select>
					</td>
					<th>주소 및 지번</th>
					<td><input type="text" id="S_ADDRESS" name="S_ADDRESS" /></td>
				</tr>
			</table>
			<br/>
			<table id="mainList" width="98%"></table>
			<div id="mainNav"></div>
		</div>
	</div>
</body>
</html>