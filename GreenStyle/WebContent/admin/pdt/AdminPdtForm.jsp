<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
String wtype= request.getParameter("wtype");
String btn = "등록";
int plnum = 0, plstock = 0;
String args = "", cpage = "", schType = "", keyword = "";
int plprice = 0;
String cbid = "", csid = "", plid = "", plname = "", ploptcolor = "", ploptsize = "", plimg1 = "", plimg2 = "", plimg3 = "";
String plimg4 = "", plimg5 = "", plisview = "", plissell = "";
if (wtype.equals("up")) {	// 수정일 경우
	btn = "수정";
	PdtInfo pdt = (PdtInfo)request.getAttribute("pdtInfo");
	System.out.println(pdt);
	
	cbid = pdt.getCb_id();
	csid = pdt.getCs_id();
	plid = pdt.getPl_id();
	plname = pdt.getPl_name();
	plprice = pdt.getPl_price();
	ploptcolor = pdt.getPl_optcolor();
	ploptsize = pdt.getPl_optsize();
	plimg1 = pdt.getPl_img1();
	plimg2 = pdt.getPl_img2();
	plimg3 = pdt.getPl_img3();
	plimg4 = pdt.getPl_img4();
	plimg5 = pdt.getPl_img5();
	plstock = pdt.getPl_stock();
	plisview = pdt.getPl_isview();
	plissell = pdt.getPl_issell();
	
	cpage = (String)request.getAttribute("cpage");
	schType = (String)request.getAttribute("schType");
	keyword = (String)request.getAttribute("keyword");
	if (schType == null) schType = "";
	if (keyword == null) keyword = "";

	args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
}
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
p { border:1px solid black; margin:0; padding:0;}
</style>
<script>
function onlyNum(obj) {
	// 인수에 사용자가 입력한 값(숫자인지 검사할 값)을 담은 컨트롤을 받아옴
	if (isNaN(obj.value)) {
		alert("숫자만 입력가능합니다.");
		obj.value = "";		obj.focus();
	}
}

function chkVal(frm) { 
	var cbid = frm.cbid.value;				var csid = frm.csid.value;
	var plid = frm.plid.value;				var plname = frm.plname.value;
	var plprice = frm.plprice.value;		var ploptcolor = frm.ploptcolor.value;
	var ploptsize = frm.ploptsize.value;	var plimg1 = frm.plimg1.value;
	var plimg2 = frm.plimg2.value;			var plimg3 = frm.plimg3.value;				
	var plimg4 = frm.plimg4.value;			var plimg5 = frm.plimg5.value;
	var plstock = frm.plstock.value;		var plisview = frm.plisview.value;		
	var plissell = frm.plissell.value;		
	if (cbid == "") {
		alert("대분류를 입력하세요.");	frm.cbid.focus();	return false;
	}
	if (csid == "") {
		alert("소분류를 입력하세요.");	frm.csid.focus();	return false;
	}
	if (plid == "") {
		alert("상품id를 입력하세요.");	frm.plid.focus();	return false;
	}
	if (plname == "") {
		alert("상품이름을 입력하세요.");	frm.plname.focus();	return false;
	}
	if (plprice == "") {
		alert("가격을 입력하세요.");	frm.plprice.focus();	return false;
	}
	if (ploptcolor == "") {
		alert("색상을 입력하세요.");	frm.ploptcolor.focus();	return false;
	}
	if (ploptsize == "") {
		alert("사이즈를 입력하세요.");	frm.ploptsize.focus();	return false;
	}
	if (plimg1 == "") {
		alert("이미지를 선택해주세요.");	frm.plimg1.focus();		return false;
	}
	if (plimg2 == "") {
		alert("이미지를 선택해주세요.");	frm.plimg2.focus();		return false;
	}
	if (plimg3 == "") {
		alert("이미지를 선택해주세요.");	frm.plimg3.focus();	return false;
	}
	if (plimg4 == "") {
		alert("이미지를 선택해주세요.");	frm.plimg4.focus();	return false;
	}
	if (plimg5 == "") {
		alert("이미지를 선택해주세요.");	frm.plimg5.focus();	return false;
	}
	if (plstock == "") {
		alert("수량을 입력하세요.");		frm.plstock.focus();	return false;
	}
	if (plisview == "") {
		alert("등록여부를 선택해주세요");		frm.plisview.focus();	return false;
	}
	if (plissell == "") {
		alert("판매여부를 선택해주세요");		frm.plissell.focus();	return false;
	}

	return true;
}
</script>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<h2 align="center">상품 <%=btn %>폼</h2>
<br /><br />
<div id="view" align="center">
<form id="frm" action="proc.pdtproc" method="post" onsubmit="return chkVal(this);">
<input type="hidden" name="num" value="<%=plnum %>" />
<input type="hidden" name="wtype" value="<%=wtype %>" />

<table width="700px" cellspacing="0" algin="center" >
<tr><td width="20%">대분류 카테고리 ID</td><td width="*"><input type="text" name="cbid" value="<%=cbid %>" /></td></tr>
<tr><td>소분류 카테고리 ID</td><td><input type="text" name="csid" value="<%=csid %>" /></td></tr>
<tr><td>상품 ID</td><td><input type="text" name="plid" value="<%=plid %>" onkeyup="onlyNum(this);"/></td></tr>
<tr><td>상품 이름</td><td><input type="text" name="plname" value="<%=plname %>" /></td></tr>
<tr><td>상품 가격</td><td><input type="text" name="plprice" value="<%=plprice %>" onkeyup="onlyNum(this);"/></td></tr>
<tr><td>상품 컬러</td><td><input type="text" name="ploptcolor" value="<%=ploptcolor %>" />&nbsp;&nbsp;&nbsp;<span>,로 구별하여 입력해주세요.</span></td></tr>
<tr><td>상품 사이즈</td><td><input type="text" name="ploptsize" value="<%=ploptsize %>" />&nbsp;&nbsp;&nbsp;<span>,로 구별하여 입력해주세요.</span></td></tr>
<tr><td>상품 이미지1</td><td><input type="file" name="plimg1" id="plimg1" value="<%=plimg1 %>" /></td></tr>
<tr><td>상품 이미지2</td><td><input type="file" name="plimg2" id="plimg2" value="<%=plimg2 %>" /></td></tr>
<tr><td>상품 이미지3</td><td><input type="file" name="plimg3" id="plimg3" value="<%=plimg3 %>" /></td></tr>
<tr><td>상품 이미지4</td><td><input type="file" name="plimg4" id="plimg4" value="<%=plimg4 %>" /></tr>
<tr><td>상품 이미지5</td><td><input type="file" name="plimg5" id="plimg5" value="<%=plimg5 %>" /></td></tr>
<tr><td>상품 수량</td><td><input type="text" name="plstock" value="<%=plstock %>" onkeyup="onlyNum(this);"/></td></tr>
<tr><td>상품 등록여부</td><td>
	<input type="radio" name="plisview" value="y" id="y" checked="checked"/>등록
	<input type="radio" name="plisview" value="n" id="n" />미등록
</td></tr>
<tr><td>상품 판매여부</td><td>
	<input type="radio" name="plissell" value="y" id="y" checked="checked"/>판매
	<input type="radio" name="plissell" value="n" id="n" />미판매
</td></tr>
</table>
<br /><br /><br /><br />
<tabele width="700px">
<input type="submit" value="<%=btn %>" />
<input type="reset" value="다시 입력" />
<%if(wtype.equals("up")) {%>
<input type="button" value="취소" onclick="location.href='view.adminpdt?plid=<%=plid%>';"/>
<%} else { %>
<input type="button" value="취소" onclick="location.href='list.adminpdt';"/>
<%} %>
</tabele>
</form>
</div>
</body>
</html>