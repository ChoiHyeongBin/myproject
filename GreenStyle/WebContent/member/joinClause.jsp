<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if (session.getAttribute("memberInfo") != null) {
   out.println("<script>");
   out.println("alert('잘못된 경로로 들어오셨습니다.');");
   out.println("history.back();");
   out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 -> 약관동의 폼</title>
<style>
#clause { width:800px; height:400px; border:1px solid black; overflow:auto;}
#isAgree { align:absmiddle; }
#total {position:relative; top:10%; left:30%;  width:800px;}
</style>
<script>
function chkAgree(frm) {
   var isAgree = frm.isAgree;
   if (!isAgree.checked) {
      alert("약관에 동의하셔야 회원가입이 가능합니다.");
      return false;
   }
   return true;
}
</script>
</head>
<body>
<%@ include file="../sideTab.jsp" %>
<div id="total">
<h2>회원가입 약관동의</h2>
<br />
<a href=""><font color="gray">home</font></a> > <a href="joinClause.jsp"><font color="gray">회원가입 약관동의</font></a> 
<hr size="5px" color="black">
<br />
<form action="joinForm.jsp" method="post" onsubmit="return chkAgree(this);">
<div id="clause">
   제1장 총칙<br /><br />

제1조(목적)<br />
본 약관은 정부24 (이하 "당 사이트")가 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.<br />
<br />
제2조(용어의 정의)<br />
본 약관에서 사용하는 용어의 정의는 다음과 같습니다.<br />
<br />
① 이용자 : 본 약관에 따라 당 사이트가 제공하는 서비스를 이용할 수 있는 자.<br />
② 가 입 : 당 사이트가 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위<br />
③ 회 원 : 당 사이트에 개인정보 등 관련 정보를 제공하여 회원등록을 한 개인(재외국민, 국내거주 외국인 포함)또는 법인으로서 당 사이트의 정보를 제공 받으며, 당 사이트가 제공하는 서비스를 이용할 수 있는 자.<br />
④ 아이디(ID) : 회원의 식별과 서비스 이용을 위하여 회원이 문자와 숫자의 조합으로 설정한 고유의 체계<br />
⑤ 비밀번호 : 이용자와 아이디가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용자 자신이 선정한 문자와 숫자의 조합.<br />
⑥ 탈 퇴 : 회원이 이용계약을 종료 시키는 행위<br />
⑦ 본 약관에서 정의하지 않은 용어는 개별서비스에 대한 별도 약관 및 이용규정에서 정의하거나 일반적인 개념에 의합니다.<br />
<br />
<br />
제3조(약관의 효력과 변경)<br />
① 당 사이트는 귀하가 본 약관 내용에 동의하는 것을 조건으로 귀하에게 서비스를 제공할 것이며, 귀하가 본 약관의 내용에 동의하는 경우, 당 사이트의 서비스 제공 행위 및 귀하의 서비스 사용 행위에는 본 약관이 우선적으로 적용됩니다.<br />
② 당 사이트는 본 약관을 변경할 수 있으며, 변경된 약관은 당 사이트 내에 공지함으로써 이용자가 직접 확인하도록 할 것입니다. 약관을 변경할 경우에는 적용일자 및 변경사유를 명시하여 당 사이트 내에 그 적용일자 30일 전부터 공지합니다. 약관 변경 공지 후 이용자가 명시적으로 약관 변경에 대한 거부의사를 표시하지 아니하면, 이용자가 약관에 동의한 것으로 간주합니다. 이용자가 변경된 약관에 동의하지 아니하는 경우, 이용자는 본인의 회원등록을 취소(회원탈퇴)할 수 있습니다.<br />
<br />
제4조(약관외 준칙)<br />
① 본 약관은 당 사이트가 제공하는 서비스에 관한 이용규정 및 별도 약관과 함께 적용됩니다.<br />
② 본 약관에 명시되지 않은 사항은 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신 윤리강령, 프로그램보호법 등 관계법령과 개인정보 처리방침 및 행정안전부가 별도로 정한 지침 등의 규정에 따릅니다.<br />
<br />
제5조(회원정보의 통합관리)<br />
당 사이트의 회원정보는 행정기관 타 사이트의 회원정보와 통합하여 관리될 수 있습니다.<br />
<br />
제2장 서비스 제공 및 이용<br />
<br />
제6조(이용 계약의 성립)<br />
① 이용계약은 신청자가 온라인으로 당 사이트에서 제공하는 소정의 가입신청 양식에서 요구하는 사항을 기록하고, 이 약관에 대한 동의를 완료한 경우에 성립됩니다.<br />
② 당 사이트는 다음 각 호에 해당하는 이용계약에 대하여는 가입을 취소할 수 있습니다.<br />
   1. 다른 사람의 명의를 사용하여 신청하였을 때<br />
   2. 이용 계약 신청서의 내용을 허위로 기재하였거나 신청하였을 때<br />
   3. 사회의 안녕 질서 혹은 미풍양속을 저해할 목적으로 신청하였을 때<br />
   4. 다른 사람의 당 사이트 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 때<br />
   5. 당 사이트를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우<br />
   6. 기타 당 사이트가 정한 이용신청요건이 미비 되었을 때<br />
③ 당 사이트는 다음 각 호에 해당하는 경우 그 사유가 해소될 때까지 이용계약 성립을 유보할 수 있습니다.<br />
   1. 기술상의 장애사유로 인한 서비스 중단의 경우(시스템관리자의 고의·과실 없는 디스크장애, 시스템 다운 등)<br />
   2. 전기통신사업법에 의한 기간통신사업자가 전기통신 서비스를 중지하는 경우<br />
   3. 전시. 사변, 천재지변 또는 이에 준하는 국가 비상사태가 발생하거나 발생할 우려가 있는 경우<br />
   4. 긴급한 시스템 점검, 증설 및 교체설비의 보수 등을 위하여 부득이한 경우<br />
   5. 서비스 설비의 장애 또는 서비스 이용의 폭주 등 기타 서비스를 제공할 수 없는 사유가 발생한 경우<br />
④ 당 사이트가 제공하는 서비스는 아래와 같으며, 그 변경될 서비스의 내용을 이용자에게 공지하고 아래에서 정한 서비스를 변경하여 제공할 수 있습니다. 다만, 비회원에게는 서비스 중 일부만을 제공할 수 있습니다.<br />
   1. 당 사이트가 자체 개발하거나 다른 기관과의 협의 등을 통해 제공하는 일체의 서비스<br />
<br />
<br />
부칙<br />
본 약관은 2017년 12월 21일부터 시행됩니다.<br />
   * 본 약관에 대한 저작권은 행정안전부에 귀속하며 무단 복제, 배포, 전송, 기타 저작권 침해행위를 엄금합니다.<br />
</div>
<p>약관에 동의하시겠습니까? <input type="checkbox" name="isAgree" id="isAgree" value="y" /></p>
<p><input type="submit" value="확 인" /></p>
</form>
</div>
</body>
</html>
<%@ include file="../footer2.jsp" %>