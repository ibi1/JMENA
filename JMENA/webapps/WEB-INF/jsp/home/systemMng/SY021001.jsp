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
		
		$("#saveButton").jqxButton({ theme: 'energyblue', width: 80, height: 25 });
		
		$("#COMPANYNO").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#SANGHO").jqxInput({theme: 'energyblue', height: 25, width: 250, minLength: 1});
		$("#OWNERNAME").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#OPENDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#REGISTNO").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#ADDRESS").jqxInput({theme: 'energyblue', height: 25, width: 300, minLength: 1});
		$("#ADDRESS_HEAD").jqxInput({theme: 'energyblue', height: 25, width: 300, minLength: 1});
		$("#UPTAE").jqxInput({theme: 'energyblue', height: 25, width: 200, minLength: 1});
		$("#UPJONG").jqxInput({theme: 'energyblue', height: 25, width: 200, minLength: 1});
		$("#TELNO").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#RELEASEDATE").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#RELEASEDESC").jqxInput({theme: 'energyblue', height: 25, width: 150, minLength: 1});
		$("#TAXOFFICE").jqxInput({theme: 'energyblue', height: 25, width: 200, minLength: 1});
		
		
		f_reload();
	});

	
	$(function(){
		$("#saveButton").click(function(){
			var formData = $("#SY021001").serialize();
		   	//시스템 메뉴 호출 (SY011001 데이터 사용)
		   	$.ajax({ 
				type: 'POST' ,
				url: "/home/updateSY021001.do", 
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
					alert("법인 정보를 저장하는 중 오류가 발생하였습니다.");
				}  
			});
		}) 
	})
	

	function f_reload(){
	   	$.ajax({ 
			type: 'POST' ,
			url: "/home/selectListSY021001.do", 
			dataType : 'json' , 
			success: function(data){
				
				if(data.rows[0].COMPANYNO != ""){
					$("#COMPANYNO").attr("readonly","readonly");
					
					$("#COMPANYNO").val(data.rows[0].COMPANYNO);
					$("#SANGHO").val(data.rows[0].SANGHO);
					$("#OWNERNAME").val(data.rows[0].OWNERNAME);
					$("#OPENDATE").val(data.rows[0].OPENDATE);
					$("#REGISTNO").val(data.rows[0].REGISTNO);
					$("#ADDRESS").val(data.rows[0].ADDRESS);
					$("#ADDRESS_HEAD").val(data.rows[0].ADDRESS_HEAD);
					$("#UPTAE").val(data.rows[0].UPTAE);
					$("#UPJONG").val(data.rows[0].UPJONG);
					$("#TELNO").val(data.rows[0].TELNO);
					$("#RELEASEDATE").val(data.rows[0].RELEASEDATE);
					$("#RELEASEDESC").val(data.rows[0].RELEASEDESC);
					$("#TAXOFFICE").val(data.rows[0].TAXOFFICE);
					
				}else{
					$("#COMPANYNO").removeAttr("readonly");
				}
				
			},
			error:function(e){  
				alert("법인 정보를 가져오는 중 오류가 발생하였습니다.");
			}  
		});
	}
</script>

<body>
	<div id="contents" style="width:1200px;" align="center">
		<div id="topDiv" style="width:98%; float:left; padding: 10px" align="left">
			<table align="right">
				<tr>
					<td><input type="button" value="저장" id='saveButton' /></td>
				</tr>
			</table>
		</div>
	
		<div id="leftDiv" style="width:48%; float:left; padding: 10px" align="left">
	
			<form id="SY021001">
				<table align="left" style="border-spacing:5px; ">
					<tr>
						<th width="120">사업자번호</th>
						<td><input type="text" id="COMPANYNO" name="COMPANYNO" /></td>
					</tr>
					<tr>
						<th>법인명(상호)</th>
						<td><input type="text" id="SANGHO" name="SANGHO" /></td>
					</tr>
					<tr>
						<th>대표자명</th>
						<td><input type="text" id="OWNERNAME" name="OWNERNAME" /></td>
					</tr>
					<tr>
						<th>개업(설립)일</th>
						<td><input type="text" id="OPENDATE" name="OPENDATE" /></td>
					</tr>
					<tr>
						<th>법인등록번호</th>
						<td><input type="text" id="REGISTNO" name="REGISTNO" /></td>
					</tr>
					<tr>
						<th>사업장 소재지</th>
						<td><input type="text" id="ADDRESS" name="ADDRESS" /></td>
					</tr>
					<tr>
						<th>본점 소재지</th>
						<td><input type="text" id="ADDRESS_HEAD" name="ADDRESS_HEAD" /></td>
					</tr>
					<tr>
						<th>업태</th>
						<td><input type="text" id="UPTAE" name="UPTAE" /></td>
					</tr>
					<tr>
						<th>업종</th>
						<td><input type="text" id="UPJONG" name="UPJONG" /></td>
					</tr>
					<tr>
						<th>대표전화</th>
						<td><input type="text" id="TELNO" name="TELNO" /></td>
					</tr>
					<tr>
						<th>교부일자/사유</th>
						<td><input type="text" id="RELEASEDATE" name="RELEASEDATE" /> / <input type="text" id="RELEASEDESC" name="RELEASEDESC" /></td>
					</tr>
					<tr>
						<th>관할세무서</th>
						<td><input type="text" id="TAXOFFICE" name="TAXOFFICE" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>