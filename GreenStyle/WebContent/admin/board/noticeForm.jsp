<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
NoticeInfo noticeInfo = null;

String cpage = (String)request.getAttribute("cpage");
String schType = (String)request.getAttribute("schType");
String keyword = (String)request.getAttribute("keyword");
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";

String args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;

Calendar today = Calendar.getInstance();
int py = today.get(Calendar.YEAR);

String wtype = (String)request.getAttribute("wtype");
System.out.println("wtype : " + wtype);
String btn = "";

int num = 0, read = 0;
String kind = "", title = "", content = "", date = "";
String alName = "";
String isview = "n";

if (wtype.equals("in")) {
	btn = "등록";
	alName = adminInfo.getAl_name();
} else if (wtype.equals("up")) {
	btn = "수정";
	noticeInfo = (NoticeInfo)request.getAttribute("noticeInfo");
	
	num = noticeInfo.getNl_num();
	kind = noticeInfo.getNl_kind();
	read = noticeInfo.getNl_read();
	title = noticeInfo.getNl_title();
	content = noticeInfo.getNl_content();
	date = noticeInfo.getNl_date();
	isview = noticeInfo.getNl_isview();
	alName = noticeInfo.getAl_name();
}

System.out.println("noticeForm args : " + args);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>Insert title here</title>
<style>
#total {position:relative; left:650px; width:600px; top:100px;}
</style>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<div id="total">
<div id="mainBox">
<form id="noticeForm" action="proc.adminNotice<%=args %>">
<input type="hidden" name="cpage" value="<%=cpage %>" />
<input type="hidden" name="schType" value="<%=schType %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<input type="hidden" name="num" value="<%=num %>" />
<input type="hidden" name="read" value="<%=read %>" />
<input type="hidden" name="wtype" value="<%=wtype %>"/>
<input type="hidden" name="date" value="<%=date %>" />
<input type="hidden" name="alName" value="<%=alName %>" />
<h2>게시판 관리페이지 / 공지사항 <%=btn %></h2>
<br />
<hr size="5px" color="black">
<br />
<div id="viewBox">
<table>
<tr><th>글번호</th><td><%=num %></td><th></th><td></td></tr>
<tr><th>분류</th><td>
<select id="kind" name="kind">
		<option value="a" <% if (kind.equals("a")) { %>selected="selected"<% } %>>알림/소식</option>
		<option value="b" <% if (kind.equals("b")) { %>selected="selected"<% } %>>이벤트 당첨</option>
</select>
</td><th>조회수</th><td><%=read %></td></tr>
<tr>
<th>제목</th><td><input type="text" id="title" name="title" value="<%=title %>" /></td>
<th>게시여부</th>
<td>
<select id="isview" name="isview">
		<option value="n" <% if (isview.equals("n")) { %>selected="selected"<% } %>>n</option>
		<option value="y" <% if (isview.equals("y")) { %>selected="selected"<% } %>>y</option>
</select>
</td>
</tr>
<tr><th>작성자</th><td><%=alName %></td><th>작성일</th><td><%=date %></td></tr>
<tr><td colspan="4"><textarea id="content" name="content" rows="10" cols="30"><%=content %></textarea></td></tr>
</table>
<input type="submit" value="<%=btn %>" />
<input type="button" value="취소" onclick="history.back();"/>
</div>
</form>
</div>
</div>
</body>
</html>