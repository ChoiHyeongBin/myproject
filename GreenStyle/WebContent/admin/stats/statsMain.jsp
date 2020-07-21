<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<TopPdtInfo> TopPdtList = (ArrayList<TopPdtInfo>)request.getAttribute("TopPdtList");
ArrayList<TopMemberInfo> TopMemberList = (ArrayList<TopMemberInfo>)request.getAttribute("TopMemberList");
ArrayList<TopPdtInfo> TopMenList = (ArrayList<TopPdtInfo>)request.getAttribute("TopMenList");
ArrayList<TopPdtInfo> TopWomenList = (ArrayList<TopPdtInfo>)request.getAttribute("TopWomenList");
int Profit = (int)request.getAttribute("Profit");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#total {position:relative; left:550px; width:800px; top:50px;}
</style>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<div id="total">
<h2>통계 메인 화면</h2>
<br />
<table id="bestpdt" width="800">
<tr><td colspan="5"><h3>가장 많이 팔린 상품 (top 10)</h3></td></tr>
<%
if (TopPdtList.size() > 0) {
	
	int length = 0;
	if (TopPdtList.size() < 10) {
		length = TopPdtList.size();
	} else {
		length = 10;
	}
	
	for (int i = 0; i < length; i++) {
		TopPdtInfo topPdt = TopPdtList.get(i);
%>
<tr>
	<td width="7%"><strong><%=i+1 %> 등 </strong></td>
	<td width="17%">상품 ID : <%=topPdt.getPl_id() %></td>
	<td width="*">상품 명 : <%=topPdt.getPl_name() %></td>
	<td width="13%">판매량 : <%=topPdt.getPl_salecnt() %></td>
	<td width="20%">매출액 : <%=topPdt.getPl_income() %></td>
</tr>
<%
	}
}
%>
</table>
<br />
<table id="bestmem" width="800">
<tr><td colspan="4"><h3>VIP 고객 (top 10)</h3></td></tr>
<%
if (TopMemberList.size() > 0) {	
	
	int length = 0;
	if (TopMemberList.size() < 10) {
		length = TopMemberList.size();
	} else {
		length = 10;
	}
	
	for (int i = 0; i < length; i++) {
		TopMemberInfo topMember = TopMemberList.get(i);
%>
<tr>
	<td width="7%"><strong><%=i+1 %> 등 </strong></td>
	<td width="17%">회원 ID : <%=topMember.getMl_id() %></td>
	<td width="*">회원 명 : <%=topMember.getMl_name() %></td>
	<td width="17%">주문 횟수 : <%=topMember.getOl_count() %></td>
	<td width="20%">구매액 : <%=topMember.getMl_Purchase() %></td>
</tr>
<%
	}
}
%>
</table>
<br />
<table id="bestmen" width="800">
<tr><td colspan="5"><h3>남자들이 가장 선호하는 상품 (top 10)</h3></td></tr>
<%
if (TopMenList.size() > 0) {
	
	int length = 0;
	if (TopMenList.size() < 10) {
		length = TopMenList.size();
	} else {
		length = 10;
	}
	
	for (int i = 0; i < length; i++) {
		TopPdtInfo topPdt2 = TopMenList.get(i);
%>
<tr>
	<td width="7%"><strong><%=i+1 %> 등 </strong></td>
	<td width="17%">상품 ID : <%=topPdt2.getPl_id() %></td>
	<td width="*">상품 명 : <%=topPdt2.getPl_name() %></td>
	<td width="13%">판매량 : <%=topPdt2.getPl_salecnt() %></td>
	<td width="20%">매출액 : <%=topPdt2.getPl_income() %></td>
</tr>
<%
	}
}
%>
</table>
<br />
<table id="bestwomen" width="800">
<tr><td colspan="5"><h3>여자들이 가장 선호하는 상품 (top 10)</h3></td></tr>
<%
if (TopWomenList.size() > 0) {
	
	int length = 0;
	if (TopWomenList.size() < 10) {
		length = TopWomenList.size();
	} else {
		length = 10;
	}
	
	for (int i = 0; i < length; i++) {
		TopPdtInfo topPdt3 = TopWomenList.get(i);
%>
<tr>
	<td width="7%"><strong><%=i+1 %> 등 </strong></td>
	<td width="17%">상품 ID : <%=topPdt3.getPl_id() %></td>
	<td width="*">상품 명 : <%=topPdt3.getPl_name() %></td>
	<td width="13%">판매량 : <%=topPdt3.getPl_salecnt() %></td>
	<td width="20%">매출액 : <%=topPdt3.getPl_income() %></td>
</tr>
<%
	}
}
%>
</table>
<h3>총 매출액 : <%=Profit %> 원</h3>
</div>
</body>
</html>