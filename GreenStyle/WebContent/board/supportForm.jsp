<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
ArrayList<NoticeInfo> noticeList = (ArrayList<NoticeInfo>)request.getAttribute("noticeList");
ArrayList<FaqInfo> faqList = (ArrayList<FaqInfo>)request.getAttribute("faqList");

int rcount1 = (int)request.getAttribute("rcount1");
int rcount2 = (int)request.getAttribute("rcount2");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고객센터 메인 페이지</title>
<style>
#mainBox { position:absolute; top:50px; margin-left:400px; padding-left:50px; padding-right:50px; width:900px; }
#imgWrap { margin-left:150px;}
.imgBox { margin-top:10px; float:left; width:200px; height:100px; border:1px solid black; text-align:center; background-color:#f8f8f8; }
#searchBox { text-align:center; }
.btn { width:100px; height:28px; background-color:black; color:white;}
#upperLine { border-top:1px solid black; border-collapse: collapse; }
#upperLine th, td { height:40px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
#footerBox { position:absolute; width:100%; bottom:-100%;}
</style>
<script>
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
<a href="main"><font color="gray">home</font></a> > <a href="/portfolio/support"><font color="black">고객센터</font></a> 
<hr size="5px" color="black">
<br />
	<div id="imgWrap">
	<a href="list.notice"><div class="imgBox"><img src="img/noticeImg.jpg" /></div></a>
	<a href="list.faq"><div class="imgBox"><img src="img/faqImg.jpg" /></div></a>
	<a href="in.qna"><div class="imgBox"><img src="img/qnaImg.jpg" /></div></a>
	</div>
<br /><br /><br/><br /><br /><br/><br />
	
<div id="faqBox">
<h2>자주 묻는 질문</h2>
<input type="button" class="btn" style="float:right; margin-top:-30px" value="전체보기" onclick="location.href='list.faq'"/>
<br />
<table width="900" align="center" id="upperLine">
	<tr>
	<th class="underLine" width="10%">번호</th>
	<th class="underLine" width="10%">분류</th>
	<th class="underLine" width="*">제목</th>
	</tr>
<%
	if (faqList.size() > 0) {
		//int num = rcount2;
		int num = 1;
		
		int length = 0;
		if (faqList.size() >= 10) {
			length = 10;
		} else {
			length = faqList.size();
		}
		
		for (int i = 0; i < length; i++) {
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
<td colspan="2" class="underLine2" ></td>
<td align="center" class="underLine2" ><%=faq.getFl_content() %></td>
</tr>
<%
		num++;
	}
} else {	
	out.println("<tr height='50'><th colspan='3'>검색 결과가 없습니다.</th></tr>");
}
%>
</table>
</div>
<br /><br />
	
<div id="qnaBox">
<h2>공지사항</h2>
<input type="button" class="btn" style="float:right; margin-top:-30px;" value="전체보기" onclick="location.href='list.notice'"/>
<br />
<table width="900" align="center" id="upperLine">
	<tr>
	<th class="underLine" width="10%">번호</th>
	<th class="underLine" width="10%">분류</th>
	<th class="underLine" width="*">제목</th>
	<th class="underLine" width="10%">조회수</th>
	<th class="underLine" width="15%">작성일</th>
	</tr>
<%
String lnk = "";
if (noticeList.size() > 0) {	
	int num = rcount1;
	
	int length = 0;
	if (noticeList.size() >= 10) {
		length = 10;
	} else {
		length = noticeList.size();
	}
	
	for (int i = 0; i < length; i++) {
		NoticeInfo notice = noticeList.get(i);
		lnk = "<a href='view.notice?cpage=1&num=" + notice.getNl_num() + "'>";
		String title = notice.getNl_title();
		if (title.length() > 27)	title = title.substring(0, 27) + "...";
%>
	<tr align="center">
	<td class="underLine2"><%=i+1 %></td>
<%
String val = "";
if (notice.getNl_kind().equals("a")) {
	val = "알림/소식";
} else if (notice.getNl_kind().equals("b")) {
	val = "이벤트";
}
%>
	<td class="underLine2"><%=val %></td>
	<td class="underLine2"><%=lnk + title + "</a>" %></td>
	<td class="underLine2"><%=notice.getNl_read() %></td>
	<td class="underLine2"><%=notice.getNl_date() %></td>
	</tr>
<%
		num--;
	}
} else {	
	out.println("<tr height='50'><th colspan='5'>검색 결과가 없습니다.</th></tr>");
}
%>
</table>
</div>
</div>

<div id=footerBox>
<%@ include file="../footer.jsp" %>
</div>
</body>
</html>