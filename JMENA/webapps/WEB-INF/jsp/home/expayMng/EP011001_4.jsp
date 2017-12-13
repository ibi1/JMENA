<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.jmena.www.web.home.expayMng.Vo.EP011001VO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
Date currDate = new Date();
SimpleDateFormat f = new SimpleDateFormat("yyyyMMddHHmmss");
List<EP011001VO> sheet = (List)request.getAttribute("Sheet");
List<EP011001VO> sheetList = (List)request.getAttribute("SheetList");

response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition", "inline; filename=EP011001_"+ f.format(currDate) +".xls");
%>​
</head>
<body>
	<table border="1">
		<tr>
			<th>계약번호</th>
			<td><%=sheet.get(0).getSALEID()%></td>
			<th>매매대금</th>
			<td align="right"><%=sheet.get(0).getSALEAMT()%></td>
		</tr>
		<tr>
			<td colspan="4">
				<span style="font-weight:bold">주소 : </span>
				<span style="padding-right:5px"><%=sheet.get(0).getADDRESS()%></span>
				<span style="font-weight:bold">계약평수 : </span>
				<span style="padding-right:5px"><%=sheet.get(0).getCONPY()%></span>
				<span style="font-weight:bold">계약자 : </span>
				<span><%=sheet.get(0).getCONNAME()%></span>
			</td>  
		</tr>
		<tr>
			<th>담당자</th>
			<td><%=sheet.get(0).getINSANAME()%></td>
			<th>지사</th>
			<td><%=sheet.get(0).getBRANCHNAME()%></td>
		</tr>
	</table><br/>
	<table border="1">
		<tr>
			<th>성명</th>
			<th>직책</th>
			<th>직급</th>
			<th>수당지급율(%)</th>
			<th>추가지급율(%)</th>
			<th>지급금액</th>
			<th>신고기준</th>
			<th>사업소득세</th>
			<th>지방세</th>
			<th>부가가치세</th>
			<th>차감지급액</th>
			<th>신고인 성명</th>
			<th>거래은행</th>
			<th>계좌번호</th>
			<th>계좌주</th>
			<th>차감지급액</th>
		</tr>
		<%
		if (sheetList.size() > 0) {
			for(int i = 0; i < sheetList.size(); i++) {
		%>
		<tr>
			<td><%=sheetList.get(i).getINSANAME()%></td>
			<td><%=sheetList.get(i).getGRADENAME()%></td>
			<td><%=sheetList.get(i).getDUTYNAME()%></td>
			<td align="right"><%=sheetList.get(i).getSUDANGRATE()%></td>
			<td align="right"><%=sheetList.get(i).getADDRATE()%></td>
			<td align="right"><%=sheetList.get(i).getPAYAMT()%></td>
			<td><%=sheetList.get(i).getTAXGUBUNNAME()%></td>
			<td align="right"><%=sheetList.get(i).getTAXINCOME()%></td>
			<td align="right"><%=sheetList.get(i).getTAXLOCAL()%></td>
			<td align="right"><%=sheetList.get(i).getSUPPLYTAX()%></td>
			<td align="right"><%=sheetList.get(i).getDEDUCTAMT()%></td>
			<td><%=sheetList.get(i).getPAYERNAME()%></td>
			<td><%=sheetList.get(i).getBANKNAME()%></td>
			<td><%=sheetList.get(i).getACCTNO()%></td>
			<td><%=sheetList.get(i).getACCTOWNER()%></td>
			<td align="right"><%=sheetList.get(i).getDEDUCTAMT()%></td>
		</tr>
		<%
			}
		} else {
		%>
		<tr>
			<td colspan="16">No data</td>
		</tr>
		<%
		}
		%>
	</table>
</body>
</html>