<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
String wtype = request.getParameter("wtype");
String btn = "등록";

int nlnum = 0;
String args = "", title = "", content = "";
String cpage = "", schType = "", keyword = "";

if (wtype.equals("up")) {	// 공지사항 수정일 경우
	btn = "수정";
	NoticeInfo noticeInfo = (NoticeInfo) request.getAttribute("noticeInfo");
	nlnum = noticeInfo.getNl_num();
	title = noticeInfo.getNl_title();
	content = noticeInfo.getNl_content();
	
	cpage = (String)request.getAttribute("cpage");	 
	schType = (String)request.getAttribute("schType");
	keyword = (String)request.getAttribute("keyword");
	if (schType == null)	schType = "";
	if (keyword == null)	keyword = "";
	args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글 수정 폼</title>
</head>
<body>
<h2>공지사항 글<%=btn %> 폼</h2>
<form name="frmNotice" action="proc.notice" method="post">	<!-- controller로 이동 -->
<input type="hidden" name="num" value="<%=nlnum %>" />
<input type="hidden" name="wtype" value="<%=wtype %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<input type="hidden" name="schType" value="<%=schType %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<table width="600" id="control">
<tr>
	<th width="15%">제목</th>
	<td width="*"><input type="text" name="title" size="50" value="<%=title %>"/></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea name="content" rows="10" cols="50"><%=content %></textarea></td>
</tr>
</table>
<table width="600">
<tr><td align="center">
	<input type="submit" value="공지사항 <%=btn %>" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" value="다시 입력" />
</td></tr>
</table>
</form>
</body>
</html>