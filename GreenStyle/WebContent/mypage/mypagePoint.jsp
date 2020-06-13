<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList");
ArrayList<MemberPointInfo> pointList = (ArrayList<MemberPointInfo>)request.getAttribute("pointList");

int num = 0, pointcnt = 0, totalPoint = 0;
String content = "", use = "", date = "";

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
<div id="pointBox">
<h2>포인트</h2>
<input type="button" class="btn" style="float:right; margin-top:-30px;" value="뒤로 가기" onclick="history.back();"/>
<br />
<table width="1300" align="center" id="upperLine">
	<tr align="center">
	<th class="underLine2">포인트 번호</th>
	<th class="underLine2">포인트 내용</th>
	<th class="underLine2">변동 포인트</th>
	<th class="underLine2">사용 여부</th>
	<th class="underLine2">발행 날짜</th>
	</tr>
<%
if (pointList != null && pointList.size() > 0) {
	for (int i = 0; i < pointList.size(); i++) {
		MemberPointInfo point = pointList.get(i);
		num = point.getMp_num();
		content = point.getMp_content();
		pointcnt = point.getMp_point();
		use = point.getMp_use();
		date = point.getMp_date();
		totalPoint += pointcnt;
%>
	<tr align="center">
	<td class="underLine2"><%=point.getMp_num() %></td>
	<td class="underLine2"><%=point.getMp_content() %></td>
	<td class="underLine2"><%=point.getMp_point() %></td>
	<td class="underLine2"><%=point.getMp_use() %></td>
	<td class="underLine2"><%=point.getMp_date() %></td>
	</tr>
<%
	}
} else {	
	out.println("<tr height='50'><th colspan='5'>포인트 내역이 없습니다.</th></tr>");
}
%>
<tr align="right"><td colspan="5"><strong>총 보유 포인트 : <%=totalPoint %> point</strong></td></tr>
</table>
<br />
</div>
</div>
</body>
</html>