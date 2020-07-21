<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> <!-- ArrayList 사용시 필요 -->
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList");
// 주문목록을 저장한 ArrayList 생성
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
//페이징 관련 정보들을 저장한 ArrayList 생성
int rcount = pageInfo.getRcount();		// 전체 게시글 개수
int cpage = pageInfo.getCpage();		// 현재 페이지 번호
int mpage = pageInfo.getMpage();		// 전체 페이지 개수(마지막 페이지 번호)
int spage = pageInfo.getSpage();		// 시작 페이지 번호
int epage = pageInfo.getEpage();		// 끝 페이지 번호
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#frm { position:relative; left:18%; margin-top:7%; width:1200px; height:1500px; }
#status {
	margin-left:18%; margin-top:-2%; width:1200px; height:60px; padding-top:10px; border:1px solid black; 
	text-align:center; background-color:black; color:white; float:left;
}
#completeTxt { font-size:30px; margin:150px 0 40px 445px; height:70px; width:500px; }
#completeTxt2 { margin:30px 0 30px 245px; }
#orderBtn { width:1200px; margin-left:343px; text-align:center; height:100px; }
#continueBtn { background-color:white; border:1px solid black; font-size:17px; cursor:pointer; }
#pdtViewBtn { color:white; background-color:black; border:1px black solid; font-size:17px; cursor:pointer; }
#price { font-weight:bold; }
</style>
</head>
<body>
<%@ include file="../mainsideTab.jsp" %>

<!-- 상태바 -->
<div id="status">
	<h1 id="">장바구니&nbsp;&nbsp;&nbsp; > 
	&nbsp;&nbsp;&nbsp;주문결제&nbsp;&nbsp;&nbsp; <span id="subStatus">> 
	&nbsp;&nbsp;&nbsp;주문완료</span></h1>
</div>

<div id="frm"><br />
<div id="completeTxt">주문이 완료되었습니다.</div>
<hr width="1200" color="black">
<div id="completeTxt2">구매확정시 포인트 최대 5% 적립, 리뷰 작성시 포인트 증정 해드립니다. [ 포토 1,000P | 텍스트 300P ]</div>
<hr width="1200" color="black"><br />

<!-- 테이블1 시작 -->
<table width="1200">
<tr>
	<th width="15%">주문번호</th><th width="25%">주문상품</th><th width="10%">수량</th>
	<th width="15%">주문일자</th><th width="10%">상태</th><th width="10%">결제방법</th>
</tr>
<%

if (ordList.size() == 0) {
	out.println("<tr align='center'><td colspan='5'>주문내역이 없습니다.</td></tr>");
} else {
	for (int i = 0; i < ordList.size(); i++) {
		OrdInfo oi = ordList.get(i);
		String olid = oi.getOl_id();
		String csid = oi.getCs_id();
		System.out.println("csid : " + csid);
		String lnk1 = "<a href=\"view.ord?cpage=" + cpage + "&csid=" + csid + "&olid=" + olid + "\">";
		String lnk3 = "?cpage=" + cpage + "&csid=" + csid + "&olid=" + olid + "\">";
%>
<tr align="center">
	<td><%=lnk1 + olid + "</a>"%></td>
	<td colspan="2">
	<table width="100%">
<%
		ArrayList<OrdDetailInfo> ordDetailList = oi.getOrdPdtList();
		for (int j = 0; j < ordDetailList.size(); j++) {
			OrdDetailInfo odi = ordDetailList.get(j);
			String lnk2 = "<a href=\"view.pdt?plid=" + odi.getPl_id() + "\">";
%>
<tr>
	<td width="10%" align="center">
		<%=lnk2 %><a href="view.product?cpage=1&kind=c&csid=<%=odi.getCs_id() %>&plid=<%=odi.getPl_id() %>">
		<img src="pdt-img/<%=odi.getCs_id() %>/<%=odi.getPl_img1() %>" width="100" height="110" /></a></a>
	</td>
	<td width="*">
		<strong></a><a href="view.product?cpage=1&kind=c&csid=<%=odi.getCs_id() %>&plid=<%=odi.getPl_id() %>"><%=odi.getPl_name() %></a></strong><br />
		총 상품금액 : <span id="price"><%=oi.getOl_pay() * odi.getOd_amount() %></span>원<br />
		사이즈 : <%=odi.getOd_optsize() %><br />색상 : <%=odi.getOd_optcolor() %>
	</td>
	<td width="73"><%=odi.getOd_amount() %>개&nbsp;</td>
</tr>
<%
		} // 안쪽 for문
%>
	</table>
	</td>
	<td><%=oi.getOl_date().replaceAll(" ", "<br />") %></td>
	<td width="15%"><%=oi.getStatus() %></td>
	<td width="10%"><%=oi.getPayStatus() %></td>
</tr>

</table><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<!-- 테이블1 종료 -->

</div>

<input type="hidden" name="kind" value="<%=request.getParameter("kind") %>" />
<form name="frmOrderList" action="view.mypage" method="post">
<div id="orderBtn">
	<input type="button" name="" id="continueBtn" value="쇼핑 계속하기" style="width:200px; height:60px;" onclick="location.href='main'" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" name="" id="pdtViewBtn" value="주문내역 상세보기" style="width:200px; height:60px;" />
<%
	}
%>
<%
}
%>
</div>
</form>
</body>
</html>
<%@ include file="../footer.jsp" %>