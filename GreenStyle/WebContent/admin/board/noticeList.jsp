<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<NoticeInfo> getNoticeList = (ArrayList<NoticeInfo>)request.getAttribute("getNoticeList");

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int rcount = pageInfo.getRcount();
int cpage = pageInfo.getCpage();
int mpage = pageInfo.getMpage();

String schType = pageInfo.getSchType();
String keyword = pageInfo.getKeyword();

if (schType == null)	schType = "";
if (keyword == null)	keyword = "";
System.out.println("rcount : " + rcount);
System.out.println("cpage : " + cpage);
System.out.println("mpage : " + mpage);


String args = "&schType=" + schType + "&keyword=" + keyword;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#total {position:relative; left:650px; width:600px; top:100px;}
</style>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<div id="total">
<div id="mainBox">
<h2>게시판  관리 / 공지사항</h2> 
<br />
<hr size="5px" color="black">
<br />
<!-- 게시판 종류 시작 -->
<div></div>
<!-- 게시판 종류 종료 -->
<!-- 검색 시작 -->
<div class="searchbox">
<form action="list.adminNotice" method="get" />
검색조건&nbsp;&nbsp;&nbsp;&nbsp;
<select name="schType">
		<option value="title" <% if (schType.equals("title")) { %>selected="selected"<% } %>>제목</option>
		<option value="content" <% if (schType.equals("content")) { %>selected="selected"<% } %>>내용</option>
		<option value="tnc" <% if (schType.equals("tnc")) { %>selected="selected"<% } %>>제목+내용</option>
</select>
<input type="text" name="keyword" size="20" placeholder="검색어를 입력하세요."/>&nbsp;&nbsp;
<input type="submit" id="button" value="검 색" /><br />
작성일자&nbsp;&nbsp;&nbsp;&nbsp; 
<input type="text" name="sdate" value="" size="13" onclick="fnPopUpCalendar(sdate, sdate, 'yyyy-mm-dd')" /> 
- <input type="text" name="edate" value="" size="13" onclick="fnPopUpCalendar(edate, edate, 'yyyy-mm-dd')" />
	<input type="reset" id="button" value="초기화" />
</div>
<!-- 검색 종료 -->
<!-- 검색 결과 시작 -->
<form name="noticeFrm" action="list.adminNotice" method="post">
<table id="noticeTable">
<tr>
<th>글 번호</th><th>분류</th><th>제목</th><th>작성자</th><th>게시여부</th><th>작성일</th>
</tr>
<%
String lnk ="";
if (getNoticeList.size() > 0) {
	for (int i = 0; i < getNoticeList.size(); i++) {
		NoticeInfo notice = getNoticeList.get(i);
		lnk = "<a href='view.adminNotice?cpage=" + cpage + args + "&num=" + notice.getNl_num() + "'>";
		String title = notice.getNl_title();
%>
<tr align="center">
<td><%=notice.getNl_num() %></td>
<td><%=notice.getNl_kind() %></td>
<td><%=lnk + title + "</a>" %></td>
<td><%=notice.getAl_name() %></td>
<td><%=notice.getNl_isview() %></td>
<td><%=notice.getNl_date() %></td>
</tr>
<%
	}
%>
</table>
<br />
<table>
<tr>
	<td>
<%
	lnk = "";
	
	//이전 페이지 이동 버튼
	if (cpage == 1) {
		out.println("<&nbsp;&nbsp;&nbsp;");
	} else {
		lnk = "<a href='list.adminNotice?cpage=" + (cpage - 1) + args + "'>";
		out.println(lnk + " <</a>&nbsp;&nbsp;&nbsp;");
	}
	
	for (int i = 1; i <= mpage; i++) {
		lnk = "<a href='list.adminNotice?cpage=" + i + args + "'>";
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
		lnk = "<a href='list.adminNotice?cpage=" + (cpage + 1) + args + "'>";
		out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
	}
%>
	</td>
	<td>
		<input type="button" value="공지사항 등록" onclick="location.href='in.notice';" />
	</td>
</tr>
<%
} else {
	out.println("<tr height='50'><th colspan='6'>검색 결과가 없습니다.</th></tr>");
}
%>
</table>
</form>
</div>
<!-- 검색 결과 종료 -->
</div>
</body>
</html>