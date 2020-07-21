<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
request.setCharacterEncoding("utf-8");
OrdInfo oi = (OrdInfo)request.getAttribute("ordInfo");
String csid = request.getParameter("cs_id");
System.out.println(oi);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Green Style</title>
<style>
html { font-family:"Ropa Sans", sans-serif; font-size: 16px; line-height: 1.5; }
body { background-color:white; overflow-x:hidden; width:100%; height:100%; }
.box { width:1200px; margin:100px 0 0 400px; }
#generalOrder { width:1200px; height:25px; }
#pdtInfo { width:1200px; height:100px; }
</style>
<script>
function ordcancel() {
	var frm = document.getElementById("frm");
	
	var message = "정말로 주문을 취소하시겠습니까?";
	var result = confirm(message);
	if(result==true){
	alert("주문이 취소되었습니다.");
	frm.submit();
	}else{
	alert("취소되었습니다.");
	}
}
</script>
</head>
<body>
<form action="ordcancel.nologord" method="post" id="frm">
<input type="hidden" name="olbuyer" value="<%=oi.getOl_buyer() %>" />
<input type="hidden" name="olids" value="<%=oi.getOl_id() %>" />
<div class="box">
<h2>주문/배송 상세</h2><br />
상품/배송 정보<br />

<hr width="1200" color="black">
<div id="generalOrder">
일반주문 | 주문일 <%=oi.getOl_date() %> | 주문번호 <%=oi.getOl_id() %>
</div>
<hr width="1200" color="black">

<table width="1200">
[배송지]
	<table width="100%">
	<tr>
		<th width="15%">받는 분</th>
		<td width="*"><%=oi.getOl_rname() %></td>
	</tr>
	<tr>
		<th>주소</th>
		<td><%=oi.getOl_raddr1() %> <%=oi.getOl_raddr2() %></td>
	</tr>
	<tr>
		<th>연락처</th>
		<td><%=oi.getOl_phone() %></td>
	</tr>
</table>

<hr width="1200" color="black">
<div id="pdtInfo">
<table width="1200">
<%
		ArrayList<OrdDetailInfo> ordDetailList = oi.getOrdPdtList();
		for (int j = 0; j < ordDetailList.size(); j++) {
			OrdDetailInfo odi = ordDetailList.get(j);
			String lnk2 = "<a href=\"view.pdt?plid=" + odi.getPl_id() + "\">";
%>

	<tr height="100">
		<td width="*" align="center">
			<a href="view.product?cpage=1&kind=c&csid=<%=odi.getCs_id() %>&plid=<%=odi.getPl_id() %>">
			<img src="pdt-img/<%=odi.getCs_id() %>/<%=odi.getPl_img1() %>" width="100" height="110" /></a>
		</td>
		<td width="20%">
			<%=odi.getPl_name() %><br /><%=odi.getOd_price() %>원<br /><%=odi.getOd_optcolor() %> / <%=odi.getOd_optsize() %>
		</td>
		<td width="20%">
			<%=odi.getOd_amount() %>개
		</td>
		<td width="20%">
			<%=oi.getOl_pay() %>원
		</td>
		<td width="20%">
			<%=oi.getStatus() %>
		</td>
	</tr>	

</table>
</div><br />
<hr width="1200" color="black">
결제 정보
<hr width="1200" color="black">

<table width="1200">
<tr>
	<th width="50%">상품금액</th><td width="50%"><%=odi.getOd_price() %>원</td>
</tr>
<%
	}
%>
<tr>
	<th>총 결제 금액</th><td><%=oi.getOl_pay() %>원</td>
</tr>
<tr>
	<th>결제방법</th><td><%=oi.getPayStatus() %></td>
</tr>
<tr height="40"><td></td></tr>
<tr>
	<td><input type="button" value="1:1 문의" id="orderBtn" style="height:50px; width:220px; cursor:pointer;" onclick="location.href='in.qna?noMem=y'" /></td>
<%if (oi.getOl_status().equals("a")) { %>
	<td><input type="button" value="주문 취소" id="orderBtn" style="height:50px; width:220px; cursor:pointer;" onclick="ordcancel()" /></td>
<%} %>
</tr>
</table>
</form>
</div>
</body>
</html>
<%@ include file="../footer.jsp" %>