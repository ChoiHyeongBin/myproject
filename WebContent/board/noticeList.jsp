<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<NoticeInfo> noticeList = (ArrayList<NoticeInfo>)request.getAttribute("noticeList");
//공지사항 목록을 ArrayList에 담음(제네릭도 포함해서 작업해야 함)
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
//페이징 관련 데이터들을 담은 인스턴스 생성
int rcount = pageInfo.getRcount();		// 전체 게시글 개수
int cpage  = pageInfo.getCpage();		// 현재 페이지 번호
int mpage  = pageInfo.getMpage();		// 전체 페이지 개수(마지막 페이지 번호)
int spage  = pageInfo.getSpage();		// 시작 페이지 번호
int epage  = pageInfo.getEpage();		// 끝 페이지 번호
String schType = pageInfo.getSchType();	// 검색조건
String keyword = pageInfo.getKeyword();	// 검색어
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";
String args = "&schType=" + schType + "&keyword=" + keyword;
String seltag = (String)request.getAttribute("seltag");
System.out.println("noticeList의 seltag : " + seltag);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bulletinBoard 메인</title>
<style>
body { font-size:14px; }
a { color:inherit; text-decoration:none; text-align:center; }
#COMMUNITY { text-align:center; }	#category { text-align:center; }
#mainBox { position:relative; top:50px; margin-left:250px; padding-left:50px; padding-right:50px; width:1300px; height:1000px; }
.nbox { float:left; width:1200px; margin-left:50px; }
#upperLine { border-top:1px solid black; border-collapse:collapse; }
#upperLine th, td { height:40px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
#pageFont { font-weight:bolder; cursor:pointer; }
#btn { width:50px; height:30px; background-color:black; color:white; border:1px solid black; cursor:pointer; }
</style>
<script>
function inEvent(val) {
	val.style.color = "black";	
}

function outEvent(val) {
	val.style.color = "gray";
}
</script>
</head>
<body>
<div id="mainBox">
<h2 id="COMMUNITY">COMMUNITY</h2>
<br />
	<div id="category">
		<a href="list.notice2"><font color="gray" onmouseover="inEvent(this);" onmouseout="outEvent(this);">NOTICE</font></a>&nbsp;&nbsp;/&nbsp;&nbsp;
		<a href="Q&A"><font color="gray" onmouseover="inEvent(this);" onmouseout="outEvent(this);">Q&A</font></a>&nbsp;&nbsp;/&nbsp;&nbsp;
		<a href="REVIEW"><font color="gray" onmouseover="inEvent(this);" onmouseout="outEvent(this);">REVIEW</font></a>&nbsp;&nbsp;/&nbsp;&nbsp;
		<a href="OEM생산문의"><font color="gray" onmouseover="inEvent(this);" onmouseout="outEvent(this);">OEM생산문의</font></a>&nbsp;&nbsp;/&nbsp;&nbsp;
		<a href="SIZE&WASHING TIP"><font color="gray" onmouseover="inEvent(this);" onmouseout="outEvent(this);">SIZE&WASHING TIP</font></a>&nbsp;&nbsp;/&nbsp;&nbsp;
		<a href="모델지원"><font color="gray" onmouseover="inEvent(this);" onmouseout="outEvent(this);">모델지원</font></a>
	</div>
<br />
<br /><br />
<table width="1200" align="center" id="upperLine">
<tr>
<th class="underLine" width="10%">NO.</th>
<th class="underLine" width="10%">CATEGORY</th>
<th class="underLine" width="*">TITLE</th>
<th class="underLine" width="10%">NAME</th>
<th class="underLine" width="10%">DATE</th>
<th class="underLine" width="8%">HIT</th>
</tr>
<%
String lnk = "";

if (noticeList.size() > 0) {	// 공지사항 목록이 있으면
	int num = rcount - (cpage - 1) * 10;
	for (int i = 0; i < noticeList.size(); i++) {
		NoticeInfo notice = noticeList.get(i);
		// noticeList안의 i번째 데이터를 notice에 넣음
		lnk = "<a href='view.notice2?cpage=" + cpage + args + "&num=" + notice.getNl_num() + "'>";
		String title = notice.getNl_title();
		if (title.length() > 27)	title = title.substring(0, 27) + "...";
%>
<tr align="center">
<td class="underLine2"><%=num %></td>	<!-- DB에서 자동증가(글번호) 값이 바뀔 수도 있으므로 num으로 처리 -->
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
<td class="underLine2"><%=notice.getAl_name() %></td>
<td class="underLine2"><%=notice.getNl_date().substring(0, 10) %></td>
<td class="underLine2"><%=notice.getNl_read() %></td>
</tr>
<%
		num--;
	}
%>
</table>
<br />
<form action="list.notice2" method="get">
<br />
<div class="nbox">
	<select name="schType" style="height:28px;">
		<option value="title" <% if (schType.equals("title")) { %>selected="selected"<% } %>>제목</option>
		<option value="content" <% if (schType.equals("content")) { %>selected="selected"<% } %>>내용</option>
		<option value="tc" <% if (schType.equals("tc")) { %>selected="selected"<% } %>>제목+내용</option>
		<option value="writer" <% if (schType.equals("writer")) { %>selected="selected"<% } %>>글쓴이</option>
	</select>
	<input type="text" style="width:200px; height:28px;" name="keyword" />
	<input type="submit" id="btn" value="검 색" />
</div>
</form>
<!-- 페이징 -->
<table width="1200">	
<tr><td align="center">
<%
lnk = "";

// 첫 페이지 이동 버튼
if (cpage == 1) {
	out.println(" << &nbsp;&nbsp;&nbsp;");	// out.println : 웹에서 출력, System.out.println : 콘솔창 출력
} else {
	lnk = "<a href='list.notice2?cpage=1" + args + "'>";
	out.println(lnk + " << </a>&nbsp;&nbsp;&nbsp;");
}

// 이전 페이지 이동 버튼
if (cpage == 1) {
	out.println(" < &nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.notice2?cpage=" + (cpage - 1) + args + "'>";
	out.println(lnk + " < </a>&nbsp;&nbsp;&nbsp;");
}

// 페이지 번호
for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='list.notice2?cpage=" + i + args + "'>";
	if (i == cpage) {
		out.println("&nbsp;&nbsp;<font id='pageFont' color='black' onmouseover='this.style.color=\"red\"' onmouseout='this.style.color=\"black\"'>" + i + 
				"</font>&nbsp;&nbsp;");
	} else {
		out.println("&nbsp;&nbsp;" + lnk + "<font id='pageFont' color='black' onmouseover='this.style.color=\"red\"' onmouseout='this.style.color=\"black\"'>" + i + 
				"</font>" + "</a>&nbsp;&nbsp;");
	}
}

// 다음 페이지 이동 버튼
if (cpage == mpage) {
	out.println("&nbsp;&nbsp;&nbsp; > ");
} else {
	lnk = "<a href='list.notice2?cpage=" + (cpage + 1) + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}

// 마지막 페이지 이동 버튼
if (cpage == epage) {
	out.println("&nbsp;&nbsp;&nbsp; >> ");
} else {
	lnk = "<a href='list.notice2?cpage=" + epage + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " >> </a>");
}
%>
</td></tr>
<%
} else {	// 공지사항 목록이 없으면
	out.println("<tr height='80'><th colspan='5'>공지사항 검색 결과가 없습니다.</th></tr>");
}
%>
</table>
<br /><br /><br />삭제삭제
</div>
</body>
</html>