<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
String wtype = request.getParameter("wtype");
System.out.println("wtype : " + wtype);
String btn = "등록";

int nlNum = 0;
String args = "", title = "", content = "";
String cpage = "", schType = "", keyword = "";

if (wtype.equals("up")) {	// 공지사항 수정일 경우
	btn = "수정";
	NoticeInfo noticeInfo = (NoticeInfo)request.getAttribute("noticeInfo");
	nlNum = noticeInfo.getNl_num();
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
#mainBox { position:relative; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; height:1000px; border:1px solid black; }
.underLine { border-bottom:1px solid black; }
#control { border-top:1px solid black; border-collapse: collapse; }
#control th, td { height:40px; padding:5px; }
#btn { width:200px; height:50px; background-color:black; color:white; border:1px solid black; cursor:pointer; }
</style>
<title>공지사항 글 <%=btn %> 폼</title>
</head>
<body>
<div id="mainBox">
<h2>공지사항 글 <%=btn %> 폼</h2>
<form name="frmNotice" action="proc.notice2" method="post">	<!-- controller로 이동, post 방식은 리소스를 생성/변경하기 위해 설계됨 -->
<input type="hidden" name="num" value="<%=nlNum %>" />	<!-- name으로 파라미터 값을 보낼 수 있음 -->
<input type="hidden" name="wtype" value="<%=wtype %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<input type="hidden" name="schType" value="<%=schType %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<table width="1200" id="control">
<tr>
	<th class="underLine" width="15%">제목</th>
	<td class="underLine" width="*"><input type="text" name="title" size="50" value="<%=title %>" style="height:30px;" /></td>
</tr>
<tr>
	<th class="underLine">내용</th>
	<td class="underLine"><textarea name="content" rows="10" cols="50"><%=content %></textarea></td>
</tr>
</table>
<table width="1200">
<tr>
	<td align="center">
		<input type="submit" id="btn" value="공지사항 <%=btn %>" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" id="btn" value="다시 입력" />
	</td>
</tr>
</table>
</form>
</div>
</body>
</html>