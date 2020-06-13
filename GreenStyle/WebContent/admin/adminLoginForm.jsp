<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> <!-- ArrayList 사용시 필요 -->
<%@ page import="vo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
body {overflow-x:hidden;}
#log { border:1px solid black; padding-bottom:15px;}
.menu { text-align:center; width:400px; height:200px; }
.menu { position:relative; padding-top:150px; left:710px; }
</style>
<script>
function checkValues(frm) {
	var uid = frm.uid.value;
	var pwd = frm.pwd.value;
	
	if (uid == "") {
		alert("아이디를 입력하세요.");	frm.uid.focus();	return false;
	}
	
	if (pwd == "") {
		alert("암호를 입력하세요.");	frm.pwd.focus();	return false;
	}
	return true;
}
</script>
</head>
<body>
<form name="frmJoin" action="main.admin" method="post" id="loginfrm" onsubmit="return checkValues(this);">
<input type="hidden" name="kind" value="login" />
<!-- 회원 -->
<div class="menu" id="tab01">
<table width="400" height="200" id="log" align="center">
<tr><td align="center">
<h2>관리자 로그인</h2>
</td></tr>
<tr>
<td><input type="text" name="uid" id="uid" style="width:300px; height:30px;" placeholder="&nbsp;&nbsp;&nbsp;아이디"/></td>
</tr>
<tr>
<td><input type="password" name="pwd" id="pwd" style="width:300px; height:30px;" placeholder="&nbsp;&nbsp;&nbsp;비밀번호" /></td>
</tr>
<td><br /></td>
<tr>
<td><input type="submit" id="logButton" name="" style="width:305px; height:40px;" value="로그인" /></td>
</tr>

</table>
</form>
</div>
</body>
</html>