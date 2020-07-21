<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
String visited = (String)request.getParameter("visited");

int rcount = 0;
int cpage = 1;
int mpage = 1;
int spage = 1;
int epage = 1;

if (pageInfo != null) {
rcount = pageInfo.getRcount();		
cpage = pageInfo.getCpage();		
mpage = pageInfo.getMpage();		
spage = pageInfo.getSpage();		
epage = pageInfo.getEpage();		
} 

int cnt = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#findOrdNum { position:absolute; top:5%; left:30%; width:800px; height:820px; padding:10px; border:2px solid black; background-color:white; }
#blackTable { margin:0 auto; width:750px; height:100px; background-color:#e9e9e9; }
#viewOrdTable { margin:0 auto; width:750px; }
#viewOrdTable th, td { height:35px; font-size:15px; }
#btn1 { position:absolute; top:770px; left:310px; }
.ords { border:1px solid white; text-align:center;}
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
.upperLine { border-top:1px solid black; border-collapse: collapse; }
.btn1 { width:200px; height:40px; background-color:black; color:white; }
</style>
<script>
<%
if(visited != null) {
	if(visited.equals("n")) {
%>
	location.href = "../findOrd.qna";
<%
	}
}
%>
function closePop() {
	var arr = document.getElementsByName("selOrd");
	var count = arr.length;
	var checked = "";
	var val = "";
	for(var i = 0; i < count; i++){
		if (arr[i].checked) {
			checked = "ordNum" + i;
			val = document.getElementById(checked);
		}
	}
	if (val != "") {
		opener.document.getElementById("findOrd").value = val.value;
	}
	window.close();
}

function chkDate() {
	var beginDate = document.getElementById("sdate");
	var endDate = document.getElementById("edate");
	var arr = document.getElementsByName("ordDates");
	var count = arr.length;
	var viewCnt = 0;
	
	if (beginDate.value.length != 10) {
		alert("시작 일 날짜를 선택하세요.");
		beginDate.focus();
		return 0;
	} else if (endDate.value.length != 10) {
		alert("마지막 일 날짜를 선택하세요.");
		endDate.focus();
		return 0;
	}
	
	var beginArr = beginDate.value.split('-');
	var begin = new Date(beginArr[0], beginArr[1]-1, beginArr[2]);

	var endArr = endDate.value.split('-');
	var end = new Date(endArr[0], endArr[1]-1, endArr[2]);
	
	if (end - begin < 0) {
		alert("시작 일은 마지막 일 보다 같거나 작아야 합니다.")
		return 0;
	}	
	for(var i = 0; i < count; i++){
		var check = arr[i].value.substring(0, 10).split('-');
		var chkDate = new Date(check[0], check[1]-1, check[2]);
		var hide = document.getElementById("ordList" + i);
		
		if (chkDate - begin >= 0 && chkDate - end <= 0) {
			hide.style.display = "";
			viewCnt++;
		} else {
			hide.style.display = "none";
		}
	}
}
</script>
</head>
<body>
<div id="findOrdNum">
<h2 style="padding-bottom:20px;" class="underLine2">주문번호 조회</h2>
<br />
<table id="blackTable">
<tr align="center">
<td width="5%"></td>
<td width="15%"><b>조회기간</b></td>
<td width="65%">
<%@include file="calendar_js.html" %>
</td>
<td width="*"><input type="button" value="검색" onclick="chkDate()"/></td>
</tr>
</table>
<br /><br />
<table id="viewOrdTable" class="upperLine">
<tr>
<th class="underLine" width="5%"></th>
<th class="underLine" width="10%">주문번호</th>
<th class="underLine" width="10%">주문일자</th>
<th class="underLine" width="*">상품명</th>
<th class="underLine" width="5%">수량</th>
<th class="underLine" width="10%">결제금액</th>
<th class="underLine" width="9%">배송상태</th>
</tr>
<%
if(ordList != null) {
	if (ordList.size() == 0) {
	out.println("<tr><td colspan='7'>");
	out.println("주문 내역이 없습니다.");
	out.println("</td></tr>");
} else {
	for (int i = 0; i < ordList.size(); i++) {
		OrdInfo oi = ordList.get(i);
		String olid = oi.getOl_id();
%>
<tr align="center" id="ordList<%=i %>">
<td class="underLine2"><input type="radio" name="selOrd"/></td>
<td class="underLine2"><input type="text" id="ordNum<%=i %>" class="ords" readonly="readonly" value="<%=oi.getOl_id() %>"></td>
<td class="underLine2"><input type="text" id="ordDate<%=i %>" name="ordDates" class="ords" readonly="readonly" value="<%=oi.getOl_date() %>"></td>
<td class="underLine2"><%=oi.getOrdPdtList().get(0).getPl_name() %></td>
<td class="underLine2"><%=oi.getOrdPdtList().get(0).getOd_amount() %></td>
<td class="underLine2"><%=oi.getOrdPdtList().get(0).getOd_price() * oi.getOrdPdtList().get(0).getOd_amount()%></td>
<td class="underLine2"><%=oi.getOl_status() %></td>
</tr>
<%
		}
	}
}
%>
</table>
<br />
<table width="800">
<tr><td align="center">
<%
String lnk = "";

//첫 페이지 이동 버튼
if (cpage == 1) {
	out.println("<<&nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.notice?cpage=1'>";
	out.println(lnk + " <<</a>&nbsp;&nbsp;&nbsp;");
}

//이전 페이지 이동 버튼
if (cpage == 1) {
	out.println("<&nbsp;&nbsp;&nbsp;");
} else {
		lnk = "<a href='list.notice?cpage=" + (cpage - 1) + "'>";
		out.println(lnk + " <</a>&nbsp;&nbsp;&nbsp;");
}

for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='list.notice?cpage=" + i + "'>";
	if (i == cpage) {
		out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
	} else {
		out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
	}
}

//다음 페이지 이동 버튼
if (cpage == mpage) {
	out.println("&nbsp;&nbsp;&nbsp; > ");
} else {
	lnk = "<a href='list.notice?cpage=" + (cpage + 1) + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}

//마지막 페이지 이동 버튼
if (cpage == epage) {
	out.println("&nbsp;&nbsp;&nbsp; >>");
} else {
	lnk = "<a href='list.notice?cpage=" + epage + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " >> </a>");
}
%>
</td></tr>
</table>
<input type="button" value="확인" class="btn1" id="btn1" onclick="closePop();" />
</div>
</body>
</html>