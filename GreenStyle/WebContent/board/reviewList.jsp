<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList"); 
// mlid랑 plid랑 olid랑 ordDetail의 상품 사이즈, 상품 컬러
int rcount = 0;
int cpage = 1;	
int mpage = 1;	
int spage = 1;	
int epage = 1;

if(pageInfo != null) {
	rcount = pageInfo.getRcount();
	cpage = pageInfo.getCpage();	
	mpage = pageInfo.getMpage();	
	spage = pageInfo.getSpage();	
	epage = pageInfo.getEpage();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 메인 페이지</title>
</head>
<body>
<h2>상품 리뷰</h2>
<a href="#">전체</a> | <a href="review">포토리뷰</a> | <a href="review">일반리뷰</a>
<hr size="1px" color="black">
<table>
<%
%>
<tr><td>★★★★★ 5점 (컬러 / 사이즈)</td><td>운영자1</td><td>2020-05-25</td></tr>
<tr><td>상품이 너무 좋아요</td></tr>
<tr><td>★★★★☆ 4점 (컬러 / 사이즈)</td><td>운영자2</td><td>2020-05-25</td></tr>
<tr><td>딱 맞는 사이즈에요</td></tr>
<tr><td>★★★☆☆ 3점 (컬러 / 사이즈)</td><td>손님1</td><td>2020-05-25</td></tr>
<tr><td>입을만 하네요</td></tr>
<tr><td>★★☆☆☆ 2점 (컬러 / 사이즈)</td><td>악플러1</td><td>2020-05-25</td></tr>
<tr><td>사이즈가 좀 크네요</td></tr>
<tr><td>★☆☆☆☆ 1점 (컬러 / 사이즈)</td><td>악플러2</td><td>2020-05-25</td></tr>
<tr><td>색깔이 별로네요</td></tr>
<tr><td>★★★★★ 5점 (컬러 / 사이즈)</td><td>운영자1</td><td>2020-05-25</td></tr>
<tr><td>상품이 너무 좋아요</td></tr>
<tr><td>★★★★☆ 4점 (컬러 / 사이즈)</td><td>운영자2</td><td>2020-05-25</td></tr>
<tr><td>딱 맞는 사이즈에요</td></tr>
<tr><td>★★★☆☆ 3점 (컬러 / 사이즈)</td><td>손님1</td><td>2020-05-25</td></tr>
<tr><td>입을만 하네요</td></tr>
<tr><td>★★☆☆☆ 2점 (컬러 / 사이즈)</td><td>악플러1</td><td>2020-05-25</td></tr>
<tr><td>사이즈가 좀 크네요</td></tr>
<tr><td>★☆☆☆☆ 1점 (컬러 / 사이즈)</td><td>악플러2</td><td>2020-05-25</td></tr>
<tr><td>색깔이 별로네요</td></tr>
<%
%>
</table>
<%
String lnk = "";

//첫 페이지 이동 버튼
if (cpage == 1) {
	out.println("<<&nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.review?cpage=1'>";
	out.println(lnk + " <<</a>&nbsp;&nbsp;&nbsp;");
}

//이전 페이지 이동 버튼
if (cpage == 1) {
	out.println("<&nbsp;&nbsp;&nbsp;");
} else {
		lnk = "<a href='list.review?cpage=" + (cpage - 1) + "'>";
		out.println(lnk + " <</a>&nbsp;&nbsp;&nbsp;");
}

for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='list.review?cpage=" + i  + "'>";
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
	lnk = "<a href='list.review?cpage=" + (cpage + 1) + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}

//마지막 페이지 이동 버튼
if (cpage == epage) {
	out.println("&nbsp;&nbsp;&nbsp; >>");
} else {
	lnk = "<a href='list.review?cpage=" + epage + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " >> </a>");
}
%>
</body>
</html>