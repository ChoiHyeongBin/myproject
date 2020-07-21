<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
System.out.println("adminInfo : " + adminInfo);
if (adminInfo == null || adminInfo.equals("")) {
	out.println("<script>");
    out.println("alert('잘못된 경로로 들어오셨습니다.');");
    out.println("history.back();");
    out.println("</script>");
}

ArrayList<MemberInfo> getMemList = (ArrayList<MemberInfo>)request.getAttribute("getMemList");
System.out.println("MemberList 폼의 getMemList : " + getMemList);
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
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
<title>Insert title here</title>
<style>
.d { width:112px; height:20px; margin:5px 0; }
.e { width:100px; height:25px; }
th { background-color: #F8E0E6; height:50px; }
#total {position:relative; left:420px; width:1000px; top:50px;}
#member th,td { border-bottom:1px solid black; }
table { cellpadding:0; cellspacing:0; }
#page { border:0; }
#button { width:80px; height:30px; }
</style>
<script type="text/javascript" src="/portfolio/calendar.js"></script>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<div id="total">
<h2>회원 관리</h2>
<br />
<hr size="5px" color="black">
<br />
<form action="memberList.mem" method="get">
<div class="nbox">
<p>	<select name="schType2" class="e">
		<option value="date" <% if (schType2.equals("date")) { %>selected="selected"<% } %>>회원 가입일</option>
		<option value="lastlogin" <% if (schType2.equals("lastlogin")) { %>selected="selected"<% } %>>마지막 로그인일</option>
	</select>
  <input type="text" name="sdate" value="" class="d" onclick="fnPopUpCalendar(sdate, sdate, 'yyyy-mm-dd')" /> 
- <input type="text" name="edate" value="" class="d" onclick="fnPopUpCalendar(edate, edate, 'yyyy-mm-dd')" /><p>
	<select name="schType" class="e">
		<option value="id" <% if (schType.equals("id")) { %>selected="selected"<% } %>>회원ID</option>
		<option value="name" <% if (schType.equals("name")) { %>selected="selected"<% } %>>회원이름</option>
	</select>
	<input type="text" class="d" name="keyword" size="10" />&nbsp;&nbsp;
	<input type="submit" id="button" value="검 색" />
	<input type="reset" id="button" value="초기화" />
</div>
</form>
<form name="frm" action="memberList.mem" method="post">
<table width="1000" id="member" cellpadding=0 cellspacing=0>
<tr>
<th width="8%">회원번호</th><th width="10%">회원ID</th>
<th width="7%">이름</th><th width="15%">생년월일</th><th width="15%">번호</th>
<th width="15%">이메일 주소</th><th width="12%">회원가입일</th><th width="12%">최종로그인</th><th width="6%">상태</th>
</tr>
<%
String lnk ="";
if (getMemList.size() > 0) {	// 공지사항 목록이 있으면
	for (int i = 0; i < getMemList.size(); i++) {
		MemberInfo member = getMemList.get(i);
		lnk = "<a href='memberView.mem?cpage=" + cpage + args + "&num=" + member.getMl_num() + "'>";
		String id = member.getMl_id();
%>
<tr align="center">
<td><%=member.getMl_num() %></td>
<td><%=lnk + id + "</a>" %></td>
<td><%=member.getMl_name() %></td>
<td><%=member.getMl_birth() %></td>
<td><%=member.getMl_phone() %></td>
<td><%=member.getMl_email() %></td>
<td><%=member.getMl_date() %></td>
<td><%=member.getMl_lastlogin() %></td>
<td><%=member.getMl_isrun() %></td>
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
	lnk = "<a href='memberList.mem?cpage=" + (cpage - 1) + args + "'>";
	out.println(lnk + " <</a>&nbsp;&nbsp;&nbsp;");
}

for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='memberList.mem?cpage=" + i + args + "'>";
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
	lnk = "<a href='memberList.mem?cpage=" + (cpage + 1) + args + "'>";
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