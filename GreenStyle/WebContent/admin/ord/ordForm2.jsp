<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
ArrayList<OrdInfo> getOrdList = (ArrayList<OrdInfo>)request.getAttribute("getOrdList");	// 인스턴스 getOrdList와 getAttribute() 인자값이 같은지 확인
System.out.println("ordForm2의 getOrdList : " + getOrdList);

String cpage = (String)request.getAttribute("cpage");
String schType = (String)request.getAttribute("schType");
String keyword = (String)request.getAttribute("keyword");
String olid = (String)request.getAttribute("olid");
System.out.println("ordForm2의 olid : " + olid);
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";

String args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;

Calendar today = Calendar.getInstance();
int py = today.get(Calendar.YEAR);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.txt { width:100px; height:20px; }
.txt2 { width:50px; height:20px; }
#idMsg { font-size:11; }
#total { position:relative; left:35%; width:600px; }
</style>
<title>ordForm2</title>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<div id="total">
<h2>주문/배송 수정</h2>
<br />
<hr size="5px" color="black">
<br />
<form name="frmUp" action="proc.ord2" method="post">
<%
if (getOrdList.size() == 0) {
	out.println("<tr align='center'><td colspan='5'>주문내역이 없습니다.</td></tr>");
} else {
	for (int i = 0; i < getOrdList.size(); i++) {
		OrdInfo oi = getOrdList.get(i);
		int olnum = oi.getOl_num();
%>

<input type="hidden" name="num" value="<%=olnum %>" />
<input type="hidden" name="olid" value="<%=olid %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<input type="hidden" name="schType" value="<%=schType %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<div id="upForm">
	<table width="500" height="100%" cellpadding="5" cellspacing="10">
	<tr><td width="25%">주문번호</td><td width="20%"><%=oi.getOl_id() %></td></tr>
	<tr><td>주문자명</td><td><%=oi.getOl_rname() %></td></tr>
	<tr><td>회원아이디</td><td><%=oi.getOl_buyer() %></td></tr>
    <tr><td>연락처</td><td><%=oi.getOl_phone() %></td></tr>
    
<%
String ordStatus = "";
if (oi.getOl_status() != null) {
	ordStatus = oi.getOl_status();
}
%>
    <tr>
    <td>주문상태</td>
    <td>
		<select name="ordStatus">
	         <option value="a" <%if (ordStatus.equals("a")) {%>selected="selected"<%} %>>입금대기</option>
	         <option value="b" <%if (ordStatus.equals("b")) {%>selected="selected"<%} %>>결제완료</option>
	         <option value="c" <%if (ordStatus.equals("c")) {%>selected="selected"<%} %>>상품준비</option>
	         <option value="d" <%if (ordStatus.equals("d")) {%>selected="selected"<%} %>>배송준비</option>
	         <option value="e" <%if (ordStatus.equals("e")) {%>selected="selected"<%} %>>배송중</option>
	         <option value="f" <%if (ordStatus.equals("f")) {%>selected="selected"<%} %>>배송완료</option>
	         <option value="g" <%if (ordStatus.equals("g")) {%>selected="selected"<%} %>>반품요청</option>
	         <option value="h" <%if (ordStatus.equals("h")) {%>selected="selected"<%} %>>반품완료</option>
	         <option value="i" <%if (ordStatus.equals("i")) {%>selected="selected"<%} %>>환불요청</option>
	         <option value="j" <%if (ordStatus.equals("j")) {%>selected="selected"<%} %>>환불완료</option>
	         <option value="k" <%if (ordStatus.equals("k")) {%>selected="selected"<%} %>>교환요청</option>
	         <option value="l" <%if (ordStatus.equals("l")) {%>selected="selected"<%} %>>교환완료</option>
		</select>
    </td>
	</tr>
<%
		ArrayList<OrdDetailInfo> ordDetailList = oi.getOrdPdtList();
		for (int j = 0; j < ordDetailList.size(); j++) {
			OrdDetailInfo odi = ordDetailList.get(j);
			String lnk2 = "<a href=\"view.pdt?plid=" + odi.getPl_id() + "\">";
%>
    <tr><td>상품번호</td><td><%=odi.getPl_id() %></td></tr>
    <tr><td>상품명</td><td><%=odi.getPl_name() %></td></tr>
<%
String optsize = "";
if (getOrdList != null) {
	optsize = odi.getOd_optsize();
}
%>
    <tr>
    <td>사이즈 : 
    	<select name="optsize">
	         <option value="S" <%if (optsize.equals("S")) {%>selected="selected"<%} %>>S</option>
	         <option value="M" <%if (optsize.equals("M")) {%>selected="selected"<%} %>>M</option>
	         <option value="L" <%if (optsize.equals("L")) {%>selected="selected"<%} %>>L</option>
	         <option value="XL" <%if (optsize.equals("XL")) {%>selected="selected"<%} %>>XL</option>
		</select>
	</td>
<%
String optcolor = "";
if (getOrdList != null) {
	optcolor = odi.getOd_optcolor();
}
%>
    <td>색상 : 
    	<select name="optcolor">
	         <option value="black" <%if (optcolor.equals("black")) {%>selected="selected"<%} %>>black</option>
	         <option value="white" <%if (optcolor.equals("white")) {%>selected="selected"<%} %>>white</option>
	         <option value="blue" <%if (optcolor.equals("blue")) {%>selected="selected"<%} %>>blue</option>
	         <option value="pink" <%if (optcolor.equals("pink")) {%>selected="selected"<%} %>>pink</option>
	         <option value="yellow" <%if (optcolor.equals("yellow")) {%>selected="selected"<%} %>>yellow</option>
	         <option value="green" <%if (optcolor.equals("green")) {%>selected="selected"<%} %>>green</option>
	         <option value="beige" <%if (optcolor.equals("beige")) {%>selected="selected"<%} %>>beige</option>
	         <!-- 색상 더 추가 -->
		</select>
	</td>
    </tr>
    <tr>
    <td colspan="2">수량 : <%=odi.getOd_amount() %></td>
<%
}
%>
    <tr><td>포인트 : <%=oi.getOl_point() %></td><td>쿠폰 :
<%
    if (oi.getMc_num() == -1) {
%>
    쿠폰 사용 X</td></tr> 
<%
    } else {
%>
    <%=oi.getMc_num() %></td>
<%
    }
%>
	</tr>
	<tr><td width="30%" colspan="2">구매금액 : <%=oi.getOl_pay() %></td></tr>
<%
	}
}
%>
	<tr><td colspan="2">
      <input type="submit" value="정보 수정"/>
   </td></tr>
   </table>
</div>
</form>
</div>
</body>
</html>