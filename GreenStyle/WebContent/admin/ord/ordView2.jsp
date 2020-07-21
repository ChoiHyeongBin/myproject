<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
ArrayList<OrdInfo> getOrdList = (ArrayList<OrdInfo>)request.getAttribute("getOrdList");
System.out.println("ordView2 폼의 getOrdList : " + getOrdList);

String cpage = (String)request.getAttribute("cpage");
String schType = (String)request.getAttribute("schType");
String keyword = (String)request.getAttribute("keyword");
String olid = (String)request.getAttribute("olid");
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";

String args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;

Calendar today = Calendar.getInstance();
int py = today.get(Calendar.YEAR);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.txt { width:100px; height:20px; }
.txt2 { width:50px; height:20px; }
#idMsg { font-size:11; }
#total {position:relative; left:35%; width:600px;}
</style>
<title>ordView2</title>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<div id="total">
<h2>주문/배송 상세보기</h2>
<br />
<hr size="5px" color="black">
<br />
<div id="upForm">
<%
if (getOrdList.size() == 0) {
	out.println("<tr align='center'><td colspan='5'>주문내역이 없습니다.</td></tr>");
} else {
	for (int i = 0; i < getOrdList.size(); i++) {
		OrdInfo oi = getOrdList.get(i);
%>


	<table width="500" height="100%" cellpadding="5" cellspacing="10">
	<input type="hidden" name="olid" value="<%=olid %>" />
	<tr><td width="25%">주문번호</td><td width="*"><%=oi.getOl_id() %></td></tr>
	<tr><td>주문자명</td><td><%=oi.getOl_rname() %></td></tr>
	<tr><td>회원아이디</td><td><%=oi.getOl_buyer() %></td></tr>
    <tr><td>연락처</td><td><%=oi.getOl_phone() %></td></tr>
    <tr><td>주문상태</td><td><%=oi.getStatus() %></td></tr>
<%
ArrayList<OrdDetailInfo> ordDetailList = oi.getOrdPdtList();
for (int j = 0; j < ordDetailList.size(); j++) {
	OrdDetailInfo odi = ordDetailList.get(j);
	String lnk2 = "<a href=\"view.pdt?plid=" + odi.getPl_id() + "\">";
%>
    <tr><td>상품번호</td><td><%=odi.getPl_id() %></td></tr>
    <tr><td>상품명</td><td width="60%"><%=odi.getPl_name() %></td></tr>
    <tr><td>사이즈 : <%=odi.getOd_optsize() %></td><td>색상 : <%=odi.getOd_optcolor() %></td></tr>
    <tr><td colspan="2">수량 : <%=odi.getOd_amount() %></td>
<%
}
%>
    <tr><td>포인트 : <%=oi.getOl_point() %></td><td>쿠폰 : 
<%
    if (oi.getMc_num() == -1) {
%>
    쿠폰 사용 X</td></tr> 
<%
    } else {
%>
    <%=oi.getMc_num() %></td>
<%
    }
%>
  </tr>  
    <tr><td width="30%" colspan="2">구매금액 : <%=oi.getOl_pay() %></td></tr>

	<tr><td colspan="2">
      <input type="button" value="수정" onclick="location.href='ordUp.ord2<%=args %>&num=<%=oi.getOl_num() %>&olid=<%=oi.getOl_id() %>';" />
      <input type="button" value="목록" onclick="location.href='list.ord2<%=args %>';"/>
   </td></tr>
   </table>
<%
	}
}
%>
</div>
</div>
</body>
</html>