<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
ReviewInfo reviewInfo = (ReviewInfo) request.getAttribute("reviewInfo");
ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList");

int getnum =  (int)request.getAttribute("getnum");
OrdInfo ord = ordList.get(getnum);
int rlnum = reviewInfo.getRl_num();
int score = reviewInfo.getRl_score();
String kind = reviewInfo.getRl_kind();

if (kind.equals("a")) {
	kind = "텍스트 리뷰";
} else if (kind.equals("b")) {
	kind = "포토 리뷰";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 보기 폼</title>
<style>
#mainBox { position:absolute; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; }
.nbox { float:right; }
#upperLine { border-top:1px solid black; border-collapse: collapse; }
#upperLine th, td { height:40px; padding:5px; }
#upperLine2 { border-top:1px solid #e2e2e2; border-collapse: collapse; }
#upperLine2 th, td { height:20px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
#btn { width:200px; height:50px; background-color:black; color:white; }
.btn1 { width:200px; height:40px; background-color:black; color:white; }
.btn2 { width:200px; height:40px; background-color:white; color:black; }
.btn3 { width:100px; height:35px;}
</style>
</head>
<body>
<div id="mainBox">
<h2>마이페이지</h2>
<br />
<a href="main"><font color="gray">home</font></a> > <a href="view.mypage"><font color="gray">마이페이지</font></a> > <a href="review.mypage"><font color="gray">리뷰</font></a>  > <font color="black">리뷰 보기</font>
<hr size="5px" color="black">
<br />
<form name="frmReview" action="up.review" method="post">
<input type="hidden" name="num" value="<%=rlnum %>" />
<input type="hidden" name="getnum" value="<%=getnum %>" />
<input type="hidden" name="wtype" value="up" />
<h2>리뷰</h2>
<br />
<br /><br />
<table width="1300" align="center" id="upperTable">
<tr>
	<td rowspan="6" width="50%">
	상품명 : <%=ord.getOrdPdtList().get(0).getPl_name() %>&nbsp;&nbsp;<br />
	(색상 : <%=ord.getOrdPdtList().get(0).getOd_optcolor() %> / 사이즈 : <%=ord.getOrdPdtList().get(0).getOd_optsize() %>)
	<br /><img src="pdt-img/cs01/<%=ord.getOrdPdtList().get(0).getPl_img1() %>" width="300" height="200"/></td>
	<td width="*"></td>
</tr>
<tr><td>분류 : <%=kind %></td></tr>
<tr>
	<td>별점 : <%=score %>점 
		(<%
		for (int i = 1; i <= score; i++) {
			out.println("★");
		}
		for(int j = 5; j - score > 0; j--) {
			out.println("☆");
		}
		%>)
	</td>
</tr>
<tr><td>내용 : <%=reviewInfo.getRl_content() %></textarea></td></tr>
<tr><td>첨부한 파일 : <%=reviewInfo.getRl_img1() %></td></tr>
<tr><td>작성 날짜 : <%=reviewInfo.getRl_date() %></td></tr>
</table>
<br /><br /><br /><br />
<table width="1300">
<tr><td align="center">
<input type="submit" class="btn1" value="수정">&nbsp;&nbsp;&nbsp;
<input type="button" class="btn2" value="뒤로 가기" onclick="history.back()">
</td></tr>
</table>
</form>
</div>
</body>
</html>