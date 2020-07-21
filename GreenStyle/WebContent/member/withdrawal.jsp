<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../sideTab.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#total {position:relative; top:5%; left:25%; width:1000px;}

</style>
<script>
function confirmDel() {
	var confirmResult = confirm("정말 탈퇴하시겠습니까?");
	if (confirmResult) {
		var frm = document.frmDel;
		frm.action = "../member"
		frm.submit();
	} else {
		self.close;
	}
}

</script>
</head>
<body>

<div id="total">
<h2>회원탈퇴</h2>
<br />
<a href=""><font color="gray">home</font></a> > <a href="withdrawal.jsp"><font color="gray">회원탈퇴</font></a> 
<hr size="5px" color="black">
<br />
<form name="frmDel" action="../member" method="post" >
<input type="hidden" name="kind" value="del" />
<table width="1000" height="100%" cellpadding="5" cellspacing="10">
<tr><td><strong>유의사항</strong></td></tr>
<tr><td>- 탈퇴 후 30일간 재가입 방지 및 마일리지 부정사용을 방지하기 위해 CI등 일부 회원 정보가 보존됩니다.</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;(회원가입 시 동의하신 개인정보 취급 방침에 명시한 파기절차와 방법에 따라 30일 이후 회원 정보를 지체 없이 파기합니다.)</td></tr>
<tr><td>- 전자상거래 이용내역이 있는 회원님은 전자상거래 등에서의 소비자보호에 관한 법률에 의거 교환/반품/환불 및 사후처리(A/S)등을 위해 회원정보가 관리됩니다.</td></tr>
</table>
<br /><br />
<table width="800" height="100%" cellpadding="5" cellspacing="10" >
<tr><td colspan="3"><strong>회원탈퇴 사유</strong></td></tr>
<tr>
	<td width="33%"><input type="radio" name="reason" value="a" id="a" /><label for="a">배송불만</label></td>
	<td width="33%"><input type="radio" name="reason" value="b" id="b" /><label for="b">이용빈도낮음</label></td>
	<td width="*"><input type="radio" name="reason" value="c" id="c" /><label for="c">A/S불만</label></td>
</tr>
<tr>
	<td><input type="radio" name="reason" value="d" id="d" /><label for="d">상품의 다양성/가격 품질 불만</label></td>
	<td><input type="radio" name="reason" value="e" id="e" /><label for="e">개인정보유출 우려</label></td>
	<td><input type="radio" name="reason" value="f" id="f" /><label for="f">쇼핑몰 시스템 불만</label></td>
</tr>
<tr>
	<td><input type="radio" name="reason" value="g" id="g" /><label for="g">교환/환불 불만</label></td>
	<td><input type="radio" name="reason" value="h" id="h" /><label for="h">회원특혜/쇼핑혜택 낮음</label></td>
	<td><input type="radio" name="reason" value="i" id="i" /><label for="i">기타</label></td>
</tr>
</table>
<br /><br />
<table width="800" height="100%" cellpadding="5" cellspacing="10" >
<tr><td><strong>회원 탈퇴 사유를 입력해주시면 보다 나은 서비스로 찾아뵙겠습니다.</strong></td></tr>
<tr><td><textarea name="content" rows="10" cols="50"></textarea></td></tr>
<tr><td><input type="button" value="회원탈퇴" onclick="confirmDel();"/></td></tr>
</table>
</form>
</div>
</body>
</html>
<%@ include file="../footer2.jsp" %>