<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList");
ArrayList<ReviewInfo> reviewList = (ArrayList<ReviewInfo>)request.getAttribute("reviewList");

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int rcount = pageInfo.getRcount();		
int cpage = pageInfo.getCpage();		
int mpage = pageInfo.getMpage();		
int spage = pageInfo.getSpage();		
int epage = pageInfo.getEpage();		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
#mainBox { position:relative; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; height:800px; }
#imgWrap { margin-left:300px;}
.imgBox { margin-top:10px; float:left; width:300px; height:100px; border:1px solid black; text-align:center; background-color:#f8f8f8; }
.btn { width:100px; height:28px; background-color:black; color:white;}
#upperLine { border-top:1px solid black; border-collapse: collapse; }
#upperLine th, td { height:40px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
</style>
</head>
<body>
<div id="mainBox">
<div id="reviewBox">
<h2>작성한 리뷰 보기</h2>
<input type="button" class="btn" style="float:right; margin-top:-30px;" value="뒤로 가기" onclick="history.back();"/>
<br />
<table width="1300" align="center" id="upperLine">
	<tr align="center">
	<th class="underLine" width="3%" ></th> 
	<th class="underLine">분류</th>
	<th class="underLine">내용</th>
	<th class="underLine">주문 번호</th>
	<th class="underLine">상품 번호</th>
	<th class="underLine">작성 날짜</th>
	<th class="underLine">점수</th>
	</tr>
<%
if (reviewList != null && reviewList.size() > 0) {
	
	for (int i = 0; i < reviewList.size(); i++) {
		ReviewInfo review = reviewList.get(i);
		String lnk = "<a href='view.review?cpage=" + cpage + "&num=" + review.getRl_num() + "'>";
		String content = review.getRl_content();
		if (content.length() > 27)	content = content.substring(0, 27) + "...";
		
		String kind = review.getRl_kind();
		if (kind.equals("a")) { 
			kind = "텍스트 리뷰";
		} else if (kind.equals("b")){
			kind = "포토 리뷰";
		}
%>
	<tr align="center">
	<td class="underLine2"></td> 
	<td class="underLine2"><%=kind %></td>
	<td class="underLine2"><%=lnk + content + "</a>" %></td>
	<td class="underLine2"><%=review.getOl_id() %></td>
	<td class="underLine2"><%=review.getPl_id() %></td>
	<td class="underLine2"><%=review.getRl_date() %></td>
	<td class="underLine2"><%=review.getRl_score() %></td>
	</tr>
<%
	}
} else {	
	out.println("<tr height='50'><th colspan='7'>리뷰 내역이 없습니다.</th></tr>");
}
%>
</table>
<br />
<table width="1200">
<tr><td align="center">
<%
String lnk = "";

if (cpage == 1) {
	out.println("<<&nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.notice?cpage=1" + "'>";
	out.println(lnk + " <<</a>&nbsp;&nbsp;&nbsp;");
}

if (cpage == 1) {
	out.println("<&nbsp;&nbsp;&nbsp;");
} else {
		lnk = "<a href='list.notice?cpage=" + (cpage - 1) + "'>";
		out.println(lnk + " <</a>&nbsp;&nbsp;&nbsp;");
}

for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='list.notice?cpage=" + i + "'>";
	if (i == cpage) {
		out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
	} else {
		out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
	}
}

if (cpage == mpage) {
	out.println("&nbsp;&nbsp;&nbsp; > ");
} else {
	lnk = "<a href='list.notice?cpage=" + (cpage + 1) + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}

if (cpage == epage) {
	out.println("&nbsp;&nbsp;&nbsp; >>");
} else {
	lnk = "<a href='list.notice?cpage=" + epage + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " >> </a>");
}
%>
</td></tr>
</table>
<br />
</div>
</div>
<br /><br /><br /><br /><br />
</body>
</html>
<%@ include file="../footer.jsp" %>
