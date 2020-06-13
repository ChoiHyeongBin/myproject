<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<MemberPointInfo> memberPoint = (ArrayList<MemberPointInfo>)request.getAttribute("MemberPoint");
System.out.println("memberPoint : " + memberPoint);
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
	location.href = "../point.ord";
<%
} else {
%>
	// alert("방문했습니다.");
<%
}
%>
function couponApply() {
	var arr = document.frmPoint.selPoint;
	// alert("arr : " + arr);
	var checked = "";
	var val = "";
	var selected = "";
	var mpNum = "";
	
	// alert(arr.checked);
	if (arr.length > 1) {
		for(var i = 0; i < arr.length; i++) {
			if (arr[i].checked) {
				checked = "disPoint" + i;
				selected = "mpNum" + i;
				
				// alert("checked : " + checked);
				val = document.getElementById(checked);
				mpNum = document.getElementById(selected);
				// alert("val : " + val);
			}
		}
	} else {
		if(arr.checked) {
			val = document.getElementById("disPoint0");
			mpNum = document.getElementById("mpNum0");
		}
	}
	
	// alert("적용할 값 : " + val.value);
	
	opener.document.getElementById("pointDC").value = val.value;
	opener.document.getElementById("mpnum").value = mpNum.value;
	
	// alert("val : " + val.value);
	// alert("mpNum : " + mpNum.value);
	// alert("적용 완료");
	
	self.close();
}
</script>
</head>
<body>
<h2>포인트선택</h2>
<form name="frmPoint" action="">
<div id="findPoint">
보유포인트
<%
if (memberPoint != null) {
	if (memberPoint.size() == 0) {
		out.println("<script>");
		out.println("alert('보유하신 포인트가 없습니다.')");
		out.println("self.close();");
		out.println("</script>");
	} else {
		for (int i = 0 ; i < memberPoint.size() ; i++) {
			MemberPointInfo mp = memberPoint.get(i);
			System.out.println("MemberPointInfo mp : " + mp);
			
%>
<table width="500" cellpadding="0" cellspacing="0">
<tr>
	<td width="10%" height="50"><input type="radio" name="discount" id="selPoint" /></td>
	<td name="discountName" width="30%"><%=mp.getMp_content() %></td>
	<td name="discountPrice" width="40%"><input type="text" name="discount" id="disPoint<%=i %>" readonly="readonly" value="<%=mp.getMp_point() %>"/>원</td>
	<td width="*"><input type="hidden" name="mpNum" id="mpNum<%=i %>" value="<%=mp.getMp_num() %>" /></td>
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