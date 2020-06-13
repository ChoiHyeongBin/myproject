<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> <!-- ArrayList 사용시 필요 -->
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList");

if (session.getAttribute("memberInfo") != null) {
	   out.println("<script>");
	   out.println("alert('잘못된 경로로 들어오셨습니다.');");
	   out.println("history.back();");
	   out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
html { font-family:"Ropa Sans", sans-serif; font-size: 16px; line-height: 1.5; }
body { background-color:white; overflow-x:hidden; width:100%; height:100%; }
#frm { position:relative; margin-top:7%; width:100&; height:900px; }
#tab { position:absolute; top:160px; left:350px; }
#status {
	margin-left:18%; margin-top:-2%; width:1200px; height:60px; padding-top:10px; border:1px solid black; 
	text-align:center; background-color:black; color:white; float:left;
}
#under { position:relative; top:60px;}
#completeTxt2 { margin:30px 0 30px 245px; }
#orderBtn { width:1200px; text-align:center; height:100px; position:relative; left:300px; top:150px;}
#continueBtn { background-color:white; border:1px solid black; font-size:17px; cursor:pointer; }
#pdtViewBtn { color:white; background-color:black; border:1px black solid; font-size:17px; cursor:pointer; }
#price { font-weight:bold; }
</style>
</head>
<body>

<!-- 상태바 -->
<div id="status">
	<h2 id="">
	&nbsp;&nbsp;&nbsp;주문결제&nbsp;&nbsp;&nbsp; <span id="subStatus">> 
	&nbsp;&nbsp;&nbsp;주문완료</span></h2>
</div>

<div id="frm"><br />
<hr id="under" width="1200" color="black"><br />

<!-- 테이블1 시작 -->
<table width="1200" id="tab">
<tr>
	<th width="15%">주문번호</th><th width="20%">주문상품</th>
	<th width="10%">수량</th><th width="15%">주문일자</th><th width="10%">상태</th>
</tr>
<%
if (ordList.size() == 0) {
	out.println("<tr align='center'><td colspan='5'>주문내역이 없습니다.</td></tr>");
} else {
	for (int i = 0; i < ordList.size(); i++) {
		OrdInfo oi = ordList.get(i);
		String olid = oi.getOl_id();
		String lnk1 = "<a href=\"view.nologord?olid=" + olid + "\">";
%>
<tr align="center">
	<td><%=lnk1 + olid + "</a>"%></td>
	<td colspan="2">
	<table width="100%">
<%
		ArrayList<OrdDetailInfo> ordDetailList = oi.getOrdPdtList();
		for (int j = 0; j < ordDetailList.size(); j++) {
			OrdDetailInfo odi = ordDetailList.get(j);
			String lnk2 = "<a href=\"view.product?kind=c&csid=" + odi.getCs_id() + "&plid=" + odi.getPl_id() + "\">";			
%>
<tr>
	<td width="70" align="center">
		<%=lnk2 %><img src="pdt-img/<%=odi.getCs_id() %>/<%=odi.getPl_img1()%>" width="100" height="110" /></a>
	</td>
	<td width="*">
		<strong><%=lnk2 + odi.getPl_name() + "</a>" %></strong><br />
		총 상품금액 : <span id="price"><%=odi.getOd_price() * odi.getOd_amount() %></span>원<br />
		사이즈 : <%=odi.getOd_optsize() %><br />색상 : <%=odi.getOd_optcolor() %>
	</td>
	<td width="88"><%=odi.getOd_amount() %>개&nbsp;</td>
</tr>
<%
		} // 안쪽 for문
%>
	</table>
	</td>
	<td><%=oi.getOl_date().replaceAll(" ", "<br />") %></td>
	<td width="15%"><%=oi.getStatus() %></td>
</tr>
</table><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<!-- 테이블1 종료 -->

<form name="frmOrderList" action="view.nologord?olid=<%=olid %>" method="post">
<div id="orderBtn">
	<input type="button" name="" id="continueBtn" value="쇼핑 계속하기" style="width:200px; height:60px;" onclick="location.href='main'" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" name="" id="pdtViewBtn" value="주문내역 상세보기" style="width:200px; height:60px;" />
</div>
</form>
<%
	}
}
%>
<br /><br /><br /><br /><br /><br /><br /><br /><br />
</body>
</html>
<%@ include file="../footer.jsp" %>