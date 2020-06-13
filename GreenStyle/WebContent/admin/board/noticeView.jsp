<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
NoticeInfo noticeInfo = (NoticeInfo)request.getAttribute("noticeInfo");

String cpage = (String)request.getAttribute("cpage");
String schType = (String)request.getAttribute("schType");
String keyword = (String)request.getAttribute("keyword");
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";

String args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;

Calendar today = Calendar.getInstance();
int py = today.get(Calendar.YEAR);
System.out.println("noticeView args : " + args);
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
<h2>게시판 관리페이지 / 공지사항 상세보기</h2>
<br />
<hr size="5px" color="black">
<br />
<div id="viewBox">
<table>
<tr><th>글번호</th><td><%=noticeInfo.getNl_num() %></td><th></th><td></td></tr>
<tr><th>분류</th><td><%=noticeInfo.getNl_kind() %></td><th>조회수</th><td><%=noticeInfo.getNl_read() %></td></tr>
<tr><th>제목</th><td><%=noticeInfo.getNl_title() %></td><th>게시여부</th><td><%=noticeInfo.getNl_isview() %></td></tr>
<tr><th>작성자</th><td><%=noticeInfo.getAl_name() %></td><th>작성일</th><td><%=noticeInfo.getNl_date() %></td></tr>
<tr><td colspan="4"><%=noticeInfo.getNl_content() %></td></tr>
</table>
<input type="button" value="삭제" onclick="location.href='proc.adminNotice<%=args %>&num=<%=noticeInfo.getNl_num() %>&wtype=del';" />
<input type="button" value="수정" onclick="location.href='up.adminNotice<%=args %>&num=<%=noticeInfo.getNl_num() %>';" />
<input type="button" value="목록" onclick="location.href='list.adminNotice<%=args %>';"/>
</div>
</div>
</div>
</body>
</html>