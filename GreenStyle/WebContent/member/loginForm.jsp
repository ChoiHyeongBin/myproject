<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> <!-- ArrayList 사용시 필요 -->
<%@ page import="vo.*" %>
<%@ include file="../sideTab.jsp" %>
<%
ArrayList<CartInfo> NologOrdList = (ArrayList<CartInfo>)request.getAttribute("NologOrdList");
if (session.getAttribute("memberInfo") != null) {
	   out.println("<script>");
	   out.println("alert('잘못된 경로로 들어오셨습니다.');");
	   out.println("history.back();");
	   out.println("</script>");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body { overflow-x:hidden; }
#log { border:1px solid black; }
.menu { text-align:center; width:400px; height:300px; }
#tab02 { display:none; }
#mem { border:none; background-color:white; border-bottom:1px solid black; font-weight:bold; font-size:15px; }
#nonMem { border:none; background-color:white; border-bottom:1px solid #c9c5c5; font-size:15px; }
#logButton { color:white; background-color:black; border:white; }
a { color:black; text-decoration:none; }
input:focus { outline:none; }
.menu { position:relative; padding-top:150px; left:710px; }
#orderBtn { color:white; background-color:black; }
</style>
<script src="jquery-1.12.4.min.js"></script>
<script src="jquery-ui.min.js"></script>
<script src="main.js"></script>
<script>
var curTab = "tab01";

function showTab(tab) {
   var obj1 = document.getElementById("tab01");
   var obj2 = document.getElementById("tab02");

   if (tab == "tab01") {
      obj1.style.display = "block";
      obj2.style.display = "none";
   } else if (tab == "tab02") {
      obj1.style.display = "none";
      obj2.style.display = "block";
   }
}

function isValue() {
	var nolog = document.nolog;
	var olid = document.nolog.olid.value;
	var rName = document.nolog.rName.value;
	if (olid == "") {
		alert("주문번호를 입력하세요");
		frm.olid.focus(); return false;
	}
	if (rName == "") {
		alert("이름을 입력하세요");
		frm.rName.focus(); return false;
	}
	nolog.onsubmit = "return true";
	
}
</script>
</head>
<body>
<form name="frmJoin" action="../login2" method="post" id="loginfrm">
<input type="hidden" name="kind" value="login" />
<!-- 회원 -->
<div class="menu" id="tab01">
<table width="400" height="200" id="log">
<tr>
<td>
<input type="button" id="mem" value="회원" style="width:150px; height:50px; cursor:pointer;" onclick="showTab('tab01');" />
<input type="button" id="nonMem" value="비회원(주문조회)" style="width:150px; height:50px; cursor:pointer;" onclick="showTab('tab02');" />
</td>
</tr>
<tr>
<td><input type="text" name="uid" id="uid" style="width:300px; height:30px;" value="test1" placeholder="&nbsp;&nbsp;&nbsp;아이디"/></td>
</tr>
<tr>
<td><input type="password" name="pwd" id="pwd" style="width:300px; height:30px;" value="1234"  placeholder="&nbsp;&nbsp;&nbsp;비밀번호" /></td>
</tr>
<td><br /></td>
<tr>
<td><input type="submit" id="logButton" name="" style="width:305px; height:40px;" value="로그인" /></td>
</tr>
<tr>
<td><a href="joinClause.jsp">회원가입</a></td>
</tr>
</table>
</form>
</div>

<!-- 비회원 -->
<div class="menu" id="tab02">
<form name="nolog" action="../nologlist.nologord" method="post" onsubmit="return false">
<input type="hidden" id="orderName" name="orderName" value="" />
<input type="hidden" id="orderId" name="orderId" value="" />
<table width="400" height="200" id="log">
<tr>
<td>
<input type="button" id="nonMem" value="회원" style="width:150px; height:50px; cursor:pointer;" onclick="showTab('tab01');" />
<input type="button" id="mem" value="비회원(주문조회)" style="width:150px; height:50px; cursor:pointer;" onclick="showTab('tab02');" />
</td>
</tr>
<tr>
<td><input type="text" id="olid" name="olid" onchange="inputId()" style="width:300px; height:30px;" maxlength="15" placeholder="&nbsp;&nbsp;&nbsp;주문번호"/></td>
</tr>
<tr>
<td><input type="text" id="rName" name="rName" onchange="inputValue()" style="width:300px; height:30px;" placeholder="&nbsp;&nbsp;&nbsp;이름" /></td>
<script>
function inputValue() {
	var orderName = document.getElementById("rName");
	var hidden = document.getElementById("orderName");
	hidden.value = orderName.value;
}

function inputId() {
	var orderId = document.getElementById("olid");
	var hidden = document.getElementById("orderId");
	hidden.value = orderId.value;
}
</script>
</tr>
<td><br /></td>
<tr>
<td><input type="submit" id="orderBtn" style="width:305px; height:40px; cursor:pointer;" value="주문조회" onclick="isValue();" /></td>
</tr>
<tr>
<td><a href="../in.qna?noMem=y">1:1 고객상담</a></td>
</tr>
</table>
</div>
<table height="200px"></table>
</form>
</body>
</html>
<%@ include file="../footer2.jsp" %>