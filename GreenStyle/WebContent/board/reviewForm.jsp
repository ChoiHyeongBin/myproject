<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
String wtype = request.getParameter("wtype");
ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList");

int getnum =  Integer.parseInt(request.getParameter("getnum"));
String csid = request.getParameter("csid");
int inner =  Integer.parseInt(request.getParameter("inner"));

OrdInfo ord = ordList.get(getnum);

int rlnum = 0, score = 0;
String content = "", img1 = "", kind = "";

String btn = "";
if (wtype.equals("in")) {
	btn = "등록";
} else if (wtype.equals("up")) {
	btn = "수정";
	ReviewInfo reviewInfo = (ReviewInfo)request.getAttribute("reviewInfo");
	rlnum = reviewInfo.getRl_num();
	content = reviewInfo.getRl_content();
	img1 = reviewInfo.getRl_img1();
	score = reviewInfo.getRl_score();
	kind = reviewInfo.getRl_kind();
} 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 <%=btn %> 페이지</title>
<style>
#mainBox { position:absolute; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:600px; }
.nbox { float:right; }
#upperLine { border-top:1px solid black; border-collapse: collapse; }
#upperLine th, td { height:40px; padding:5px; }
#upperLine2 { border-top:1px solid #e2e2e2; border-collapse: collapse; }
#upperLine2 th, td { height:20px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
#btn { width:200px; height:50px; background-color:black; color:white; }
.btn1 { width:200px; height:40px; background-color:black; color:white; }
.btn2 { width:200px; height:40px; background-color:white; color:black; }
.btn3 { width:100px; height:35px;}
</style>
<script>
function chkKind(img1) {
	var kind = document.getElementById("kind");
	
	if (img1 == null) {
		kind.value = "a";
	} else {
		kind.value = "b";
	}
}

function starBlack(number) {
	for(var j = 1; j <= 5; j++) {
		document.getElementById("star" + j).innerHTML = "☆";
	}
	
	for(var i = 1; i <= number; i++) {
		document.getElementById("star" + i).innerHTML = "★";
	}
	document.getElementById("scores").value = number;
	
	document.getElementById("scoreNum").innerHTML = number;
}

function chkValues(frm) {
	var score = frm.scores.value;	var content = frm.content.value;
	var photo = frm.img1.value;
	if (photo != "") {
		document.getElementById("kind").value = "b";
	} else {
		document.getElementById("kind").value = "a";
	}
	
	if (score == 0) {
		alert("점수를 선택하세요.");
		return false;
	} 
	if (content == "") {
		alert("내용을 입력하세요.");
		frm.content.focus();		return false;
	}
	
		
	return true;
}
</script>
</head>
<body>
<div id="mainBox">
<h2>리뷰 <%=btn %></h2>
<hr size="1px" color="black">
<form name="frmReview" action="proc.review" method="post" onsubmit="return chkValues(this);">
<input type="hidden" name="num" value="<%=rlnum %>" />
<input type="hidden" name="wtype" value="<%=wtype %>" />
<input type="hidden" name="olid" value="<%=ord.getOl_id() %>" />
<input type="hidden" name="plid" value="<%=ord.getOrdPdtList().get(0).getPl_id() %>" />
<input type="hidden" name="getnum" value="<%=getnum %>" />
<input type="hidden" id="kind" name="kind" value="<%=kind %>" />
<input type="hidden" id="scores" name="scores" value="<%=score %>" />
<table width="600" id="control" style="border:1px solid black;">
<tr>
	<td rowspan="3" width="50%">상품명 : <%=ord.getOrdPdtList().get(inner).getPl_name() %><br />
	(색상 : <%=ord.getOrdPdtList().get(inner).getOd_optcolor() %> / 사이즈 : <%=ord.getOrdPdtList().get(inner).getOd_optsize() %>)
	<br /><img src="pdt-img/<%=csid %>/<%=ord.getOrdPdtList().get(inner).getPl_img1() %>" width="200" height="150"/></td>
	<td width="*">별점 주기 : <span id="scoreNum"><%=score %></span>점 
		(
		<span id="star1" onclick="starBlack(1)" style="cursor:pointer;">☆</span>
		<span id="star2" onclick="starBlack(2)" style="cursor:pointer;">☆</span>
		<span id="star3" onclick="starBlack(3)" style="cursor:pointer;">☆</span>
		<span id="star4" onclick="starBlack(4)" style="cursor:pointer;">☆</span>
		<span id="star5" onclick="starBlack(5)" style="cursor:pointer;">☆</span>
		)
<script>
<%
if (wtype.equals("up")) {
	for(int i = 1; i <= score; i++) {
%>
		document.getElementById("star<%=i %>").innerHTML = "★";
<%
	}
}
%>
</script>
	</td>
</tr>
<tr>
	<td><textarea id="content" name="content" rows="10" cols="30" placeholder="리뷰 내용을 입력하세요."><%=content %></textarea></td>
</tr>
<tr>
	<td>이미지 파일 첨부하기 : <input type="file" id="img1" name="img1" value="<%=img1 %>" onchange="chkKind(this.value);"/></td>
</tr>
</table>
<br />
- 작성하신 리뷰는 마이페이지에서 보실 수 있습니다.<br />	
- 이미지 파일 첨부시 포토 리뷰로 등록됩니다.<br /><br />
<table width="600">
<tr><td align="center">
	<input type="submit" class="btn1" value="리뷰 <%=btn %>" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" class="btn2" value="취소하기" onclick="history.back();"/>
</td></tr>
</table>
</form>
</div>
</body>
</html>