<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<MemberCouponInfo> memberCoupon = (ArrayList<MemberCouponInfo>)request.getAttribute("MemberCoupon");
System.out.println("memberCoupon : " + memberCoupon);
String visited = (String)request.getParameter("visited");
System.out.println("visited : " + visited);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#discount { border:1px solid black; }
table tr td { border-collapse:collapse; }
#findCoupon { border:1px solid black; height:400px; }
</style>
<script>
<%
if (visited.equals("n")) {
%>
	// alert("방문하지 않았습니다.");
	location.href = "../coupon.ord";
<%
} else {
%>
	// alert("방문했습니다.");
<%
}
%>
function couponApply() {
	var arr = document.frmCoupon.selCoupon;
	// alert("arr : " + arr);
	var checked = "";
	var val = "";
	var selected = "";
	var mcNum = "";
	
	for(var i = 0; i < arr.length; i++) {
		if (arr[i].checked) {
			checked = "discount" + i;
			selected = "mcNum" + i;
			
			// alert("checked : " + checked);
			val = document.getElementById(checked);
			mcNum = document.getElementById(selected);
			// alert("val : " + val);
		}
	}
	// alert("적용할 값 : " + val.value);
	
	opener.document.getElementById("couponDC").value = val.value;
	opener.document.getElementById("mcnum").value = mcNum.value;
	
	// alert("적용 완료");
	
	self.close();
}
</script>
</head>
<body>
<h2>쿠폰선택</h2>
<form name="frmCoupon" action="">
<div id="findCoupon">
보유쿠폰
<%
if (memberCoupon != null) {
	if (memberCoupon.size() == 0) {
		out.println("<script>");
		out.println("alert('쿠폰이 존재하지 않습니다.')");
		out.println("self.close();");
		out.println("</script>");
	} else {
		for (int i = 0 ; i < memberCoupon.size() ; i++) {
			MemberCouponInfo mc = memberCoupon.get(i);
			System.out.println("MemberCouponInfo mc : " + mc);
			
%>
<table width="500" cellpadding="0" cellspacing="0">
<tr>
	<td width="10%" height="50"><input type="radio" name="discount" id="selCoupon" /></td>
	<td name="discountName" width="30%"><%=mc.getAc_name() %></td>
	<td name="discountPrice" width="40%"><input type="text" name="discount" id="discount<%=i %>" readonly="readonly" value="<%=mc.getAc_discount() %>"/>원</td>
	<td width="*"><input type="hidden" name="mcNum" id="mcNum<%=i %>" value="<%=mc.getMc_num() %>" /></td>
</tr>
</table>
<%
		}
	}
}
%>
</div>
<div>
	<input type="button" name="dc" value="적용" onclick="couponApply();" />
	<input type="button" value="닫 기" onclick="self.close();" />
</div>
</form>
</body>
</html>