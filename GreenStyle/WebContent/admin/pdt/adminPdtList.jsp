<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
System.out.println("adminInfo : " + adminInfo);
if (adminInfo == null || adminInfo.equals("")) {
	out.println("<script>");
    out.println("alert('잘못된 경로로 들어오셨습니다.');");
    out.println("history.back();");
    out.println("</script>");
}
request.setCharacterEncoding("utf-8");
String cond = (String)request.getAttribute("condition");
ArrayList<PdtInfo> pdtList = (ArrayList<PdtInfo>)request.getAttribute("adminpdtList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int rcount = pageInfo.getRcount();
int cpage = pageInfo.getCpage(); 	// 현재 페이지
int mpage = pageInfo.getMpage(); 	// 최대 페이지 개수
int spage = pageInfo.getSpage(); 	// 시작 페이지
int epage = pageInfo.getEpage();	// 마지막 페이지

String schType = pageInfo.getSchType();	// 검색조건
String keyword = pageInfo.getKeyword();	// 검색어
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";
String plid = request.getParameter("plid");
String args = "&schType=" + schType + "&keyword=" + keyword;
if (cond == "") { 
	cond = "";
} else {
	args += "&cond=" + cond;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#list-table { border:1px solid black; position:relative; top:100px;}
td, th { margin:0; padding:0; height:30px; }
.nBox { position:relative; left:700px; top:50px; border:3px solid black; width:500px; padding-bottom:10px; }
a { color: inherit; text-decoration: none; text-align:center; }
#page { position:relative; top:130px;}
#pdtIn {position:relative; top:150px;}
</style>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<h2 align="center">상품리스트</h2>
<form action="list.adminpdt" method="get">
<div class="nBox" align="center">
	<select name="schType">
		<option value="">검색 조건</option>
		<option value="id" <% if (schType.equals("id")) { %>selected="selected"<% } %>>상품아이디</option>
		<option value="name" <% if (schType.equals("name")) { %>selected="selected"<% } %>>상품이름</option>
	</select>
	<input type="text" name="keyword" size="15" value="<%=keyword %>" />
	<input type="submit" value="검 색" />
	<br />
	<span ><a href="list.adminpdt?<%=args %>&cond=b">판매량 순</a></span>
</div>
</form>
<br /><br /><br /><br />
<table width="800px" height="100%" id="list-table" align="center">
<tr height="30" >
<th width="10%">번호</th><th width="*"  text-align="center">상품명</th>
<th width="15%">판매상태</th><th width="10%">판매가</th><th width="20%">판매량</th>
</tr>
<%
String lnk = "";
if (pdtList.size() > 0) {
	int num = rcount - (cpage - 1) * 10;
	for (int i = 0 ; i < pdtList.size() ; i++) {
		PdtInfo pdt = pdtList.get(i);
		
		lnk = "<a href='view.adminpdt?cpage=" + cpage + "&plid=" + pdt.getPl_id() + "'>";
%>
<tr align="center">
<td><%=pdt.getPl_id() %></td>
<td align="left">&nbsp;<%=lnk + pdt.getPl_name() + "</a>" %></td>
<td><%=pdt.getPl_issell() %></td>
<td><%=pdt.getPl_price() %></td>
<td><%=pdt.getPl_salecnt() %></td>
</tr>
<%
		num--;
	}
%>
</table>
<br /><br /><br /><br />
<table width="700px" id="page" align="center"><!-- 페이징 -->
<tr><td align="center">
<%

lnk = "";
// 이전 페이지 이동 버튼
if (cpage == 1) {
	out.println(" < &nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.adminpdt?cpage=" + (cpage - 1) + args + "'>";
	out.println(lnk + " < </a>&nbsp;&nbsp;&nbsp;");
}

for (int i = 1 ; i <= mpage ; i++) {
	lnk = "<a href='list.adminpdt?cpage=" + i + args + "'>";
	if (i == cpage) {
		out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
	} else {
		out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
	}
}

// 다음 페이지 이동 버튼
if (cpage == mpage) {
	out.println("&nbsp;&nbsp;&nbsp; > ");
} else {
	lnk = "<a href='list.adminpdt?cpage=" + (cpage + 1) + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}
%>
</td></tr>
<%
} else {	// 공지사항 목록이 없으면
	out.println("<tr height='50'><th colspan='5'>");
	out.println("검색 결과가 없습니다.</th></tr>");
}
%>
</table>
</table>
<table width="700px" id="pdtIn">
<tr><td align="right">
	<input type="button" value="상품 등록" onclick="location.href='in.pdtproc';" />
</td></tr> 
</table>
</body>
</html>