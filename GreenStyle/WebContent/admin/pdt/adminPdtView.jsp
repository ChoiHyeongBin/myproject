<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
PdtInfo pdt = (PdtInfo)request.getAttribute("pdtInfo");
System.out.println(pdt);
// 보려는 공지사항 게시글을 NoticeInfo형 인스턴스에 담음
String cpage = (String)request.getAttribute("cpage");
String schType = (String)request.getAttribute("schType");
String keyword = (String)request.getAttribute("keyword");
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";
String args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table { border:1px solid black; }
tr, th, td {margin:0; padding:0; height:30px;}
td { border:1px solid black;}
#view { position:relative; left:600px; }
</style>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<h2 align="center">상품 상세보기</h2>
<br /><br />
<div id="view" align="center">
<table width="700px" cellspacing="0" algin="center" >
<tr><td width="20%">대분류 카테고리 ID</td><td width="*"><%=pdt.getCb_id() %></td></tr>
<tr><td>소분류 카테고리 ID</td><td><%=pdt.getCs_id() %></td></tr>
<tr><td>상품 ID</td><td><%=pdt.getPl_id() %></td></tr>
<tr><td>상품 이름</td><td><%=pdt.getPl_name() %></td></tr>
<tr><td>상품 가격</td><td><%=pdt.getPl_price() %></td></tr>
<tr><td>상품 컬러</td><td><%=pdt.getPl_optcolor() %></td></tr>
<tr><td>상품 사이즈</td><td><%=pdt.getPl_optsize() %></td></tr>
<tr><td>상품 이미지1</td><td><%=pdt.getPl_img1() %></td></tr>
<tr><td>상품 이미지2</td><td><%=pdt.getPl_img2() %></td></tr>
<tr><td>상품 이미지3</td><td><%=pdt.getPl_img3() %></td></tr>
<tr><td>상품 이미지4</td><td><%=pdt.getPl_img4() %></td></tr>
<tr><td>상품 이미지5</td><td><%=pdt.getPl_img5() %></td></tr>
<tr><td>상품 수량</td><td><%=pdt.getPl_stock() %></td></tr>
<tr><td>상품 판매량</td><td><%=pdt.getPl_salecnt() %></td></tr>
<tr><td>상품 등록여부</td><td><%=pdt.getPl_isview() %></td></tr>
<tr><td>상품 판매여부</td><td><%=pdt.getPl_issell() %></td></tr>
</table>
<br /><br /><br /><br />
<tabele width="700px">
<tr><input type="button" value="수정" onclick="location.href='up.pdtproc?plid=<%=pdt.getPl_id() %>&wtype=up;'" /></tr>
<script>
function isDel() {
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href="proc.pdtproc?wtype=del&plid=<%=pdt.getPl_id() %>";
	}
}
</script>
<tr align="right"><input type="button" value="삭제" onclick="isDel()" /></tr>
<input type="button" value="목록" onclick="location.href='list.adminpdt';"/>
</tabele>
</div>
</body>
</html>