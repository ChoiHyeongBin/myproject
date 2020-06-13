<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
ArrayList<FaqInfo> faqList = (ArrayList<FaqInfo>)request.getAttribute("faqList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int rcount = pageInfo.getRcount();		
int cpage = pageInfo.getCpage();		
int mpage = pageInfo.getMpage();		
int spage = pageInfo.getSpage();		
int epage = pageInfo.getEpage();		
String schType = pageInfo.getSchType();	
String keyword = pageInfo.getKeyword();	
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";
String args = "&schType=" + schType + "&keyword=" + keyword;

String selbox = (String)request.getAttribute("selbox");
System.out.println(selbox);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 메인 페이지</title>
<style>
.imgBox { position:relative; margin-top:10px; float:left; width:250px; height:80px; border:1px solid black; text-align:center; background-color:#f8f8f8; }
#mainBox { position:absolute; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; }
.nbox { float:right; margin-top:30px; margin-bottom:30px; }
#upperLine { border-top:1px solid black; border-collapse: collapse; }
#upperLine th, td { height:40px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
</style>
<script>
function selectBox(div) {
	var tag = div.id;
	
	var b1 = document.getElementById("allTag");
	var b2 = document.getElementById("memTag");
	var b3 = document.getElementById("ordTag");
	var b4 = document.getElementById("senTag");
	var b5 = document.getElementById("canTag");
	
	if (tag == b1.id) {
		b1.style.backgroundColor = "black";
		b1.style.color = "white";
	} else if (tag == b2.id) {
		b2.style.backgroundColor = "black";
		b2.style.color = "white";
	} else if (tag == b3.id) {
		b3.style.backgroundColor = "black";
		b3.style.color = "white";
	} else if (tag == b4.id) {
		b4.style.backgroundColor = "black";
		b4.style.color = "white";
	} else if (tag == b5.id) {
		b5.style.backgroundColor = "black";
		b5.style.color = "white";
	}   
} 

function viewContent(count) {
	var status = document.getElementById("viewCont"+count);
	var view = status.style.display;

	if (view == "none") {
		status.style.display = "";
	} else { 
		status.style.display = "none";
	}
}
</script>
</head>
<body>
<div id="mainBox">
<h2>고객센터</h2>
<br />
<a href="index.jsp"><font color="gray">home</font></a> > <a href="support"><font color="gray">고객센터</font></a> > <a href="list.faq"><font color="black">자주 묻는 질문</font></a> 
<hr size="5px" color="black">
<br />
<form action="list.faq" method="get">
<h2>자주 묻는 질문</h2>
<br />
<div id="imgWrap">
	<a href="list.faq"><div id="allTag" class="imgBox" onclick="selectBox(this);" <% if (selbox == "b1") { out.println("style='background-color:black; color:white;'"); } %>><br/>전체</div></a>
	<a href="list.faq?kind=a"><div id="memTag" class="imgBox" onclick="selectBox(this);" <% if (selbox == "b2") { out.println("style='background-color:black; color:white;'"); } %>><br/>회원정보</div></a>
	<a href="list.faq?kind=b"><div id="ordTag" class="imgBox" onclick="selectBox(this);" <% if (selbox == "b3") { out.println("style='background-color:black; color:white;'"); } %>><br/>주문/결제</div></a>
	<a href="list.faq?kind=c"><div id="senTag" class="imgBox" onclick="selectBox(this);" <% if (selbox == "b4") { out.println("style='background-color:black; color:white;'"); } %>><br/>배송</div></a>
	<a href="list.faq?kind=d"><div id="canTag" class="imgBox" onclick="selectBox(this);" <% if (selbox == "b5") { out.println("style='background-color:black; color:white;'"); } %>><br/>취소/환불</div></a>
</div>
<br />
<div class="nbox">
	<select name="schType" style="height:28px;">
		<option value="">검색 조건</option>
		<option value="title" <% if (schType.equals("title")) { %>selected="selected"<% } %>>제목</option>
		<option value="content" <% if (schType.equals("content")) { %>selected="selected"<% } %>>내용</option>
		<option value="tc" <% if (schType.equals("tc")) { %>selected="selected"<% } %>>제목+내용</option>
	</select>
	<input type="text" style="width:200px; height:28px;" name="keyword"/>
	<input type="submit" style="width:80px; height:28px;" value="검 색" />
</div>
</form>
<br /><br />
<table width="1200" align="center" id="upperLine">
<tr>
<th class="underLine" width="10%">번호</th>
<th class="underLine" width="10%">분류</th>
<th class="underLine" width="*">제목</th>
</tr>
<%
if (faqList.size() > 0) {	
	int num = rcount - (cpage - 1) * 10;
	for (int i = 0; i < faqList.size(); i++) {
		FaqInfo faq = faqList.get(i);
%>
<tr align="center" id="viewLine<%=i %>">
<td style="border-bottom:1px solid #e2e2e2"><%=num %></td>
<%
String val = "";
if (faq.getFl_kind().equals("a")) {
	val = "회원정보";
} else if (faq.getFl_kind().equals("b")) {
	val = "주문/결제";
} else if (faq.getFl_kind().equals("c")) {
	val = "배송";
} else if (faq.getFl_kind().equals("d")) {
	val = "취소/환불";
}
%>
<td style="border-bottom:1px solid #e2e2e2"><%=val %></td>
<td style="border-bottom:1px solid #e2e2e2; cursor:pointer;" onclick="viewContent(<%=i %>);"><%=faq.getFl_title() %></td>
</tr>
<tr align="center" id="viewCont<%=i %>" style="display:none;">
<td class="underLine2"></td>
<td class="underLine2"></td>
<td class="underLine2"><%=faq.getFl_content() %></td>
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
String lnk = "";

//첫 페이지 이동 버튼
if (cpage == 1) {
	out.println("<<&nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.faq?cpage=1" + args + "'>";
	out.println(lnk + " <<</a>&nbsp;&nbsp;&nbsp;");
}

//이전 페이지 이동 버튼
if (cpage == 1) {
	out.println("<&nbsp;&nbsp;&nbsp;");
} else {
		lnk = "<a href='list.faq?cpage=" + (cpage - 1) + args + "'>";
		out.println(lnk + " <</a>&nbsp;&nbsp;&nbsp;");
}

for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='list.faq?cpage=" + i + args + "'>";
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
	lnk = "<a href='list.faq?cpage=" + (cpage + 1) + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}

//마지막 페이지 이동 버튼
if (cpage == epage) {
	out.println("&nbsp;&nbsp;&nbsp; >>");
} else {
	lnk = "<a href='list.faq?cpage=" + epage + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " >> </a>");
}
%>
</td></tr>
<%
} else {	
	out.println("<tr height='50'><th colspan='4'>검색 결과가 없습니다.</th></tr>");
}
%>
</table>
<br /><br /><br />
</div>
</body>
</html>