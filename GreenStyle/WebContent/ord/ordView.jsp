<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));

OrdInfo oi = (OrdInfo)request.getAttribute("ordInfo");
System.out.println("oi : " + oi);
ArrayList<MemberCouponInfo> memberCoupon = (ArrayList<MemberCouponInfo>)request.getAttribute("memberCoupon");
System.out.println("memberCoupon : " + memberCoupon);
// 주문 정보를 저장한 OrdInfo형 인스턴스 생성

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.box { width:1200px; margin:100px 0 0 400px; }
#generalOrder { width:1200px; height:25px; }
#pdtInfo { width:1200px; height:100px; }
#error { position:relative;  align:left; }
#error2 { text-align:center; }
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
<%@ include file="../mainsideTab.jsp" %>
<form action="ordcancel.ord" method="post" id="frm">
<input type="hidden" name="olid" value="<%=oi.getOl_id() %>" />
<input type="hidden" name="olbuyer" value="<%=oi.getOl_buyer() %>" />
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
int pointDiscount = oi.getOl_point();
		ArrayList<OrdDetailInfo> ordDetailList = oi.getOrdPdtList();
		for (int j = 0; j < ordDetailList.size(); j++) {
			OrdDetailInfo odi = ordDetailList.get(j);
			pointDiscount = oi.getOl_point();
			System.out.println("cs_id : " + ordDetailList.get(j).getCs_id());
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
<div id="error">
<table width="1200" id="table">
<tr>
	<th width="20%">총 상품금액</th><td width="*"><%=odi.getOd_price() %>원</td>
</tr>
<tr>
<%
int couponDiscount = 0;
if (memberCoupon != null) {
	if (memberCoupon.size() == 0) {
		out.println("<script>");
		out.println("alert('잘못된 경로로 들어왔습니다.')");
		out.println("history.back();");
		out.println("</script>");
	} else {
			MemberCouponInfo mc = memberCoupon.get(0);
			System.out.println("MemberCouponInfo mc : " + mc);
			couponDiscount = mc.getAc_discount();
			
%>
	<th>사용 쿠폰</th><td> - 원</td>
</tr>
<%
		}
	}
%>
<tr>
	<th>사용 포인트</th><td> - <%=oi.getOl_point() %> P</td>
</tr>
<tr>
	<th>총 할인 금액</th><td> - <%=pointDiscount + couponDiscount %> 원</td>
</tr>
<tr>
	<th>총 결제 금액</th><td><%=oi.getOl_pay() %>원</td>
</tr>
<tr>
	<th>결제방법</th><td><%=oi.getPayStatus() %></td>
</tr>
<%
}
%>

<tr height="40"><td></td></tr>
</table>
<table width="1200" id="error2">
<tr>
	<td width="33%"><input type="button" value="1:1 문의" id="orderBtn" style="height:50px; width:220px; cursor:pointer;" onclick="location.href='in.qna'" /></td>
	<td width="33%"><input type="button" value="전체 취소" id="orderBtn" style="height:50px; width:220px; cursor:pointer;" onclick="ordcancel()" /></td>
	<td width="*"><input type="button" value="목록" id="orderBtn" style="height:50px; width:220px; cursor:pointer;" /></td>
</tr>
</table>
</div>
</form>
</div>
</body>
</html>
<%@ include file="../footer.jsp" %>