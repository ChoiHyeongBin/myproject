<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
NoticeInfo noticeInfo = (NoticeInfo)request.getAttribute("noticeInfo");
// 보려는 공지사항 게시글을 NoticeInfo형 인스턴스에 담음

String cpage = (String)request.getAttribute("cpage");		// 현재 페이지 번호
String schType = (String)request.getAttribute("schType");	// 검색조건
String keyword = (String)request.getAttribute("keyword");	// 검색어
int maxNotice = (int)request.getAttribute("maxNotice");
System.out.println("maxNotice : " + maxNotice);
String prev = (String)request.getAttribute("prev");
String next = (String)request.getAttribute("next");
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";

String args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항 보기 폼</title>
<style>
a { color: inherit; text-decoration: none; text-align:center; }
#mainBox { position:absolute; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; border:1px solid black; }
#upperLine { border-top:1px solid black; border-collapse: collapse; }
#upperLine th, td { height:40px; padding:5px; }
#upperLine2 { border-top:1px solid #e2e2e2; border-collapse: collapse; }
#upperLine2 th, td { height:20px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
#btn { width:200px; height:50px; background-color:black; color:white; border:1px solid black; cursor:pointer; }
</style>
</head>
<body>
<div id="mainBox">
<h2>고객센터</h2>
<br />
<a href="index.jsp"><font color="gray">home</font></a> > <a href="support"><font color="gray">고객센터</font></a> > <a href="list.notice2"><font color="black">공지사항</font></a>
<hr size="5px" color="black">
<br />
<form action="list.notice2" method="get">
<h2>공지사항</h2>
<br />
<table width="1300" id="upperLine">
<tr>
	<td class="underLine" width="3%"></td>
	<td class="underLine" width="*"><%=noticeInfo.getNl_title() %></td>
	<th class="underLine" width="10%">구분</th>
<%
String val = "";

if (noticeInfo.getNl_kind().equals("a")) {
	val ="알림/소식";
} else if (noticeInfo.getNl_kind().equals("b")) {
	val = "이벤트";
}
%>
	<td class="underLine" width="10%"><%=val %></td>
	<th class="underLine" width="10%">작성일</th>
	<td class="underLine" width="15%"><%=noticeInfo.getNl_date() %></td>
	<th class="underLine" width="10%">조회수</th>
	<td class="underLine" width="10%"><%=noticeInfo.getNl_read() %></td>
</tr>
<tr><td></td><td colspan="7"><%=noticeInfo.getNl_content().replace("\r\n", "<br />") %></td></tr>
<!-- "\r\n" 문자열을 찾아 "<br />" 문자열로 바꿈 -->
</table>
<br /><br />
<table width="1300" id="upperLine2">
<tr>
	<td class="underLine2" width="30px"></td>
	<td class="underLine2" width="10%">이전글</td>
	<td class="underLine2" width="*" align="left">
<%
String lnk = "";

if (noticeInfo.getNl_num() == 1) {
	out.println("이전 글이 없습니다.");
} else {	// 이전 글이 존재한다면
	lnk = "<a href='view.notice2" + args + "&num=" + (noticeInfo.getNl_num() - 1) + "'>";
	out.println(lnk + prev + "</a>&nbsp;&nbsp;&nbsp;");
}
%>
	</td>
</tr>
<tr>
	<td class="underLine2"></td>
	<td class="underLine2">다음글</td>
	<td class="underLine2">
<%
if (noticeInfo.getNl_num() == maxNotice) {
	// nl_num의 값을 정렬하지 않으면 비교 불가능
	out.println("다음 글이 없습니다.");
} else {	// 다음 글이 존재한다면
	lnk = "<a href='view.notice2" + args + "&num=" + (noticeInfo.getNl_num() + 1) + "'>";
	out.println(lnk + next + "</a>&nbsp;&nbsp;&nbsp;");
}
%>
	</td>
</tr>
<tr><td align="center" colspan="3"><br /><br />
	<input type="button" id="btn" value="수정" onclick="location.href='up.notice2<%=args %>&num=<%=noticeInfo.getNl_num() %>';" />
<script>
function isDel(val) {
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href = "proc.notice2?wtype=del&num=" + <%=noticeInfo.getNl_num() %>;
	}
}
</script>
	<input type="button" id="btn" value="삭제" onclick="isDel();" />
	<input type="button" id="btn" value="목 록" onclick="location.href='list.notice2<%=args %>';" />
</td></tr>
</table>
</form>
</div>
</body>
</html>