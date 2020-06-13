<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<OrdInfo> getOrdList = (ArrayList<OrdInfo>)request.getAttribute("getOrdList");
System.out.println("ordList2 폼의 getOrdList : " + getOrdList);

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
System.out.println("ordList2 폼의 pageInfo : " + pageInfo);
//페이징 관련 데이터들을 담은 인스턴스 생성
int rcount = pageInfo.getRcount();		// 전체 게시글 개수
int cpage = pageInfo.getCpage();		// 현재 페이지 번호
int mpage = pageInfo.getMpage();		// 전체 페이지 개수(마지막 페이지 번호)

String schType = pageInfo.getSchType();	// 검색조건
String schType2 = pageInfo.getSchType2();
String keyword = pageInfo.getKeyword();	// 검색어

if (schType == null)	schType = "";
if (schType2 == null)	schType2 = "";
if (keyword == null)	keyword = "";
System.out.println(rcount);
System.out.println(cpage);
System.out.println(mpage);


String args = "&schType=" + schType + "&keyword=" + keyword;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ordList2</title>
<style>
.d { width:112px; height:20px; margin:5px 0; }
.e { width:100px; height:25px; }
th { background-color: #F8E0E6; height:50px; }
#total {position:relative; left:380px; width:1000px;}
#order th,td { border-bottom:1px solid black; }
table { cellpadding:0; cellspacing:0; }
#page { border:0; }
#button { width:80px; height:30px; }
</style>
<script type="text/javascript" src="/portfolio/calendar.js"></script>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<div id="total">
<h2>주문 관리</h2>
<br />
<hr size="5px" color="black">
<br />
<form action="list.ord2" method="get">
<div class="nbox">
	<p>	<select name="schType2" class="e">
			<option value="date" <% if (schType2.equals("date")) { %>selected="selected"<% } %>>주문일자</option>
		</select>
	  <input type="text" name="sdate" value="" class="d" onclick="fnPopUpCalendar(sdate, sdate, 'yyyy-mm-dd')" /> 
	- <input type="text" name="edate" value="" class="d" onclick="fnPopUpCalendar(edate, edate, 'yyyy-mm-dd')" /><p>
	<select name="schType" class="e">
		<option value="id" <% if (schType.equals("id")) { %>selected="selected"<% } %>>주문번호</option>
		<option value="rname" <% if (schType.equals("rname")) { %>selected="selected"<% } %>>주문자명</option>
		<option value="buyer" <% if (schType.equals("buyer")) { %>selected="selected"<% } %>>회원아이디</option>
	</select>
	<input type="text" class="d" name="keyword" size="10" />&nbsp;&nbsp;
	<input type="submit" id="button" value="검 색" />
	<input type="reset" id="button" value="초기화" />
	<input type="reset" id="button" value="통계" onclick="location.href='ordGraph.mem';"/>
</div>
</form>

<form name="frm" action="ordList.ord2" method="post">
<table width="1000" id="order" cellpadding=0 cellspacing=0>
<tr>
	<th width="15%">주문일자</th><th width="15%">주문번호</th><th width="15%">주문자명</th>
	<th width="15%">회원아이디</th><th width="15%">주문상태</th><th width="15%">구매금액</th>
</tr>
<%
String lnk ="";
if (getOrdList.size() > 0) {	// 공지사항 목록이 있으면
	for (int i = 0; i < getOrdList.size(); i++) {
		OrdInfo oi = getOrdList.get(i);
		lnk = "<a href='ordView.ord2?cpage=" + cpage + args + "&num=" + oi.getOl_num() + "&olid=" + oi.getOl_id() + "'>";
		String id = oi.getOl_id();
%>
<tr align="center" height="45">
<td><%=oi.getOl_date().substring(0, 11) %></td>
<td><%=lnk + id + "</a>" %></td>
<td><%=oi.getOl_rname() %></td>
<td><%=oi.getOl_buyer() %></td>
<td><%=oi.getStatus() %></td>
<td><%=oi.getOl_pay() %></td>
</tr>
<%
	}
%>
</table>
<br />
<table width="1000"><!-- 페이징 -->
<tr><td align="center" id="page">
<%
lnk = "";

//이전 페이지 이동 버튼
if (cpage == 1) {
	out.println("<&nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.ord2?cpage=" + (cpage - 1) + args + "'>";
	out.println(lnk + " <</a>&nbsp;&nbsp;&nbsp;");
}

for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='list.ord2?cpage=" + i + args + "'>";
	if (i == cpage) {
		out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
	} else {
		out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
	}
}

//다음 페이지 이동 버튼
if (cpage == mpage) {
	out.println("&nbsp;&nbsp;&nbsp; > ");
} else {
	lnk = "<a href='list.ord2?cpage=" + (cpage + 1) + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}
%>
</td></tr>
<%
} else {	// 공지사항 목록이 없으면
	out.println("<tr height='50'><th colspan='4'>검색 결과가 없습니다.</th></tr>");
}
%>
</table>
</form>
</div>
</body>
</html>