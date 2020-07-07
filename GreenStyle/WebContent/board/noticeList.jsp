<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
ArrayList<NoticeInfo> noticeList = (ArrayList<NoticeInfo>)request.getAttribute("noticeList");
// 공지사항 목록을 ArrayList에 담음(제네릭도 포함해서 작업해야 함)
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
// 페이징 관련 데이터들을 담은 인스턴스 생성
int rcount = pageInfo.getRcount();		// 전체 게시글 개수
int cpage = pageInfo.getCpage();		// 현재 페이지 번호
int mpage = pageInfo.getMpage();		// 전체 페이지 개수(마지막 페이지 번호)
int spage = pageInfo.getSpage();		// 시작 페이지 번호
int epage = pageInfo.getEpage();		// 끝 페이지 번호
String schType = pageInfo.getSchType();	// 검색조건
String keyword = pageInfo.getKeyword();	// 검색어
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";
String args = "&schType=" + schType + "&keyword=" + keyword;
String seltag = (String)request.getAttribute("seltag");
System.out.println("noticeList의 seltag : " + seltag);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 메인 페이지</title>
<style>
#mainBox { position:relative; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; height:1000px; }
.nbox { float:right; }
#upperLine { border-top:1px solid black; border-collapse:collapse; }
#upperLine th, td { height:40px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
</style>
</head>
<body>
<div id="mainBox">
<h2>고객센터</h2>
<br />
<a href="main"><font color="gray">home</font></a> > <a href="support"><font color="gray">고객센터</font></a> > <a href="list.notice"><font color="black">공지사항</font></a> 
<hr size="5px" color="black">
<br />
<form action="list.notice" method="get">
<h2>공지사항</h2>
<br />
<a href="list.notice"<% if (seltag == "t1") { out.println("style='font-size:17px; font-weight:bold'"); } %>>전체</a>&nbsp; | &nbsp;
<a href="list.notice?kind=nta" <% if (seltag == "t2") { out.println("style='font-size:17px; font-weight:bold'"); } %>>알림/소식</a>&nbsp; | &nbsp;
<a href="list.notice?kind=evt" <% if (seltag == "t3") { out.println("style='font-size:17px; font-weight:bold'"); } %>>이벤트 당첨</a>
<div class="nbox">
	<select name="schType" style="height:28px;">
		<option value="">검색 조건</option>
		<option value="title" <% if (schType.equals("title")) { %>selected="selected"<% } %>>제목</option>
		<option value="content" <% if (schType.equals("content")) { %>selected="selected"<% } %>>내용</option>
		<option value="tc" <% if (schType.equals("tc")) { %>selected="selected"<% } %>>제목+내용</option>
	</select>
	<input type="text" style="width:200px; height:28px;" name="keyword" />
	<input type="submit" style="width:80px; height:28px;" value="검 색" />
</div>
</form>
<br /><br />
<table width="1200" align="center" id="upperLine">
<tr>
<th class="underLine" width="10%">번호</th>
<th class="underLine" width="10%">분류</th>
<th class="underLine" width="*">제목</th>
<th class="underLine" width="10%">조회수</th>
<th class="underLine" width="15%">작성일</th>
</tr>
<%
String lnk ="";

if (noticeList.size() > 0) {	// 공지사항 목록이 있으면
	int num = rcount - (cpage - 1) * 10;
	for (int i = 0; i < noticeList.size(); i++) {
		NoticeInfo notice = noticeList.get(i);
		// noticeList안의 i번째 데이터를 notice에 넣음
		lnk = "<a href='view.notice?cpage=" + cpage + args + "&num=" + notice.getNl_num() + "'>";
		String title = notice.getNl_title();
		if (title.length() > 27)	title = title.substring(0, 27) + "...";
		// 공지사항 제목이 27글자 이상이면 글자를 자름
%>
<tr align="center">
<td class="underLine2"><%=num %></td>
<%
String val = "";
if (notice.getNl_kind().equals("a")) {
	val = "알림/소식";
} else if (notice.getNl_kind().equals("b")) {
	val = "이벤트";
}
%>
<td class="underLine2"><%=val %></td>
<td class="underLine2" align="center">&nbsp;<%=lnk + title + "</a>" %></td>
<td class="underLine2"><%=notice.getNl_read() %></td>
<td class="underLine2"><%=notice.getNl_date().substring(2, 10) %></td>
</tr>
<%
		num--;
	}
%>
</table>
<br />
<table width="1200">
<tr><td align="center">
<%
lnk = "";

// 첫 페이지 이동 버튼
if (cpage == 1) {
	out.println("<<&nbsp;&nbsp;&nbsp;");	// out.println : 웹에서 출력, System.out.println : 콘솔창 출력
} else {
	lnk = "<a href='list.notice?cpage=1" + args + "'>";
	out.println(lnk + " <<</a>&nbsp;&nbsp;&nbsp;");
}

// 이전 페이지 이동 버튼
if (cpage == 1) {
	out.println("<&nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.notice?cpage=" + (cpage - 1) + args + "'>";
	out.println(lnk + " <</a>&nbsp;&nbsp;&nbsp;");
}

// 페이지 번호
for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='list.notice?cpage=" + i + args + "'>";
	if (i == cpage) {
		out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");	// b 태그 : 글자를 굵게 표시하는 태그로 bold의 약자
	} else {
		out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
	}
}

// 다음 페이지 이동 버튼
if (cpage == mpage) {
	out.println("&nbsp;&nbsp;&nbsp; > ");
} else {
	lnk = "<a href='list.notice?cpage=" + (cpage + 1) + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}

//마지막 페이지 이동 버튼
if (cpage == epage) {
	out.println("&nbsp;&nbsp;&nbsp; >>");
} else {
	lnk = "<a href='list.notice?cpage=" + epage + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " >> </a>");
}
%>
</td></tr>
<%
} else {	// 공지사항 목록이 없으면
	out.println("<tr height='50'><th colspan='4'>공지사항 검색 결과가 없습니다.</th></tr>");
}
%>
</table>
<br /><br /><br />
</div>
</body>
</html>
<%@ include file="../footer.jsp" %>