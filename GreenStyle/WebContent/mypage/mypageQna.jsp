<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
ArrayList<QnaInfo> qnaList = (ArrayList<QnaInfo>)request.getAttribute("qnaList");

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
<title>마이페이지 > 1:1 고객상담</title>
<style>
#mainBox { position:relative; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; height:800px; }
.upperLine { border-top:1px solid black; border-collapse: collapse; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
.btn { width:130px; height:32px; background-color:black; color:white;}
</style>
</head>
<body>
<div id="mainBox">
<h2>마이페이지</h2>
<br />
<a href="main"><font color="gray">home</font></a> > <a href="view.mypage"><font color="gray">마이페이지</font></a> > <font color="black">1:1 고객상담</font> 
<hr size="5px" color="black">
<br />
<h2>1:1 고객상담</h2>
<br />
1:1 고객상담에 대한 내역과 답변을 확인하실 수 있습니다.<br />
<strong>고객센터 000-000-0000</strong> (평일 오전 9시 ~ 오후 6시 : 토/일 공휴일 휴무)
<br /><br />
<input type="button" class="btn" style="float:right; margin-top:-30px" value="1:1 고객상담 등록" onclick="location.href='in.qna?call=mypage'"/>
<br />
<table width="1300" align="center" class="upperLine" cellpadding="7">
<tr>
<th width="3%" class="underLine"></th>
<th width="10%" class="underLine">번호</th>
<th width="15%" class="underLine">분류</th>
<th width="*" class="underLine">제목</th>
<th width="20%" class="underLine">작성일</th>
<th width="15%" class="underLine">답변여부</th>
</tr>
<%
if (qnaList != null && qnaList.size() > 0) {
	
	for (int i = 0; i < qnaList.size(); i++) {
		QnaInfo qna = qnaList.get(i);
		String lnk = "<a href='view.qna?cpage=" + cpage + "&num=" + qna.getQl_num() + "'>";
		String title = qna.getQl_title();
		if (title.length() > 27)	title = title.substring(0, 27) + "...";
		
		String kind = qna.getQl_kind();
		if (kind.equals("a")) { 
			kind = "회원 정보";
		} else if (kind.equals("b")){
			kind = "주문/결제";
		} else if (kind.equals("c")){
			kind = "취소/반품";
		} else if (kind.equals("d")){
			kind = "배송";
		}
		String answer = qna.getQl_answer();
		if (answer == null) {
			answer = "n";
		}
%>
	<tr align="center">
	<td class="underLine2"></td> 
	<td class="underLine2"><%=qna.getQl_num() %></td>
	<td class="underLine2"><%=kind %></td>
	<td class="underLine2"><%=lnk + title + "</a>" %></td>
	<td class="underLine2"><%=qna.getQl_date() %></td>
	<td class="underLine2"><%=answer %></td>
	</tr>
<%
	}
} else {	
	out.println("<tr height='50' align='center'><th colspan='6'>상담 내역이 없습니다.</th></tr>");
}
%>
</table>
<br />
<table width="1300">
<tr><td align="center">
<%
String lnk = "";
if (qnaList != null && qnaList.size() > 0) {
	if (cpage == 1) {
		out.println("<<&nbsp;&nbsp;&nbsp;");
	} else {
		lnk = "<a href='qna.mypage?cpage=1" + "'>";
		out.println(lnk + " <<</a>&nbsp;&nbsp;&nbsp;");
	}
	
	if (cpage == 1) {
		out.println("<&nbsp;&nbsp;&nbsp;");
	} else {
			lnk = "<a href='qna.mypage?cpage=" + (cpage - 1) + "'>";
			out.println(lnk + " <</a>&nbsp;&nbsp;&nbsp;");
	}
	
	for (int i = 1; i <= mpage; i++) {
		lnk = "<a href='qna.mypage?cpage=" + i + "'>";
		if (i == cpage) {
			out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
		} else {
			out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
		}
	}
	
	if (cpage == mpage) {
		out.println("&nbsp;&nbsp;&nbsp; > ");
	} else {
		lnk = "<a href='qna.mypage?cpage=" + (cpage + 1) + "'>";
		out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
	}
	
	if (cpage == epage) {
		out.println("&nbsp;&nbsp;&nbsp; >>");
	} else {
		lnk = "<a href='qna.mypage?cpage=" + epage + "'>";
		out.println("&nbsp;&nbsp;&nbsp;" + lnk + " >> </a>");
	}
}
%>
</td></tr>
</table>
<br />
</div>
<br /><br /><br /><br /><br />
</body>
</html>
<%@ include file="../footer.jsp" %>