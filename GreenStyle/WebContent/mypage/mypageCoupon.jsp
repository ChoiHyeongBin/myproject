<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList");
ArrayList<MemberCouponInfo> couponList = (ArrayList<MemberCouponInfo>)request.getAttribute("couponList");

int totalCoupon = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#mainBox { position:absolute; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; border:1px solid black; width:1300px; }
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
<div id="couponBox">
<h2>쿠폰함</h2>
<input type="button" class="btn" style="float:right; margin-top:-30px;" value="뒤로 가기" onclick="history.back();"/>
<br />
<table width="1300" align="center" id="upperLine">
	<tr align="center">
	<th class="underLine2" width="3%" ></th>
	<th class="underLine2">쿠폰 번호</th>
	<th class="underLine2">쿠폰명</th>
	<th class="underLine2">할인 금액</th>
	<th class="underLine2">사용 여부</th>
	<th class="underLine2">발행 날짜</th>
	</tr>
<%
if (couponList != null && couponList.size() > 0) {
	
	for (int i = 0; i < couponList.size(); i++) {
		MemberCouponInfo coupon = couponList.get(i);
		totalCoupon++;
%>
	<tr align="center">
	<td class="underLine2"></td>
	<td class="underLine2"><%=coupon.getMc_num() %></td>
	<td class="underLine2"><%=coupon.getAc_name() %></td>
	<td class="underLine2"><%=coupon.getAc_discount() %></td>
	<td class="underLine2"><%=coupon.getMc_use() %></td>
	<td class="underLine2"><%=coupon.getMc_date() %></td>
	</tr>
<%
	}
} else {	
	out.println("<tr height='50'><th colspan='6'>쿠폰 내역이 없습니다.</th></tr>");
}
%>
<tr align="right"><td colspan="6"><strong>총 보유 쿠폰 : <%=totalCoupon %> 장</strong></td></tr>
</table>
<br />
</div>
</div>
</body>
</html>