<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ include file="../sideTab.jsp" %>
<%

if (memberInfo == null) {
   out.println("<script>");
   out.println("alert('로그인 후 사용하실 수 있습니다.');");
   out.println("history.back();");
   out.println("</script>");
}

Calendar today = Calendar.getInstance();
int py = today.get(Calendar.YEAR);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지 -> 정보수정 폼</title>
<style>
.txt { width:100px; height:20px; }
.txt2 { width:50px; height:20px; }
#idMsg { font-size:11; }
#total {position:relative; left:35%; width:600px;}

</style>
<script>
function schZipcode() {
	var width = screen.width;	// 화면 해상도(너비)
	var height = screen.height;	// 화면 해상도(높이)
	var w = 300;	// 팝업창의 넓이
	var h = 200;	// 팝업창의 높이
	var x = (width - w) / 2;	
	var y = (height - h) / 2;	
	
	window.open("zipcode2.jsp", "zip", "width="+w+", height="+h+", left="+x+", top="+y);
}
</script>
</head>
<body>

<div id="total">
<h2>회원정보수정</h2>
<br />
<a href=""><font color="gray">home</font></a> > <a href="memberForm.jsp"><font color="gray">회원정보수정</font></a> 
<hr size="5px" color="black">
<br />
<form name="frmUp" action="../member" method="post" >
<input type="hidden" name="kind" value="up" />
<div id="upForm">
	<table width="500" height="100%" cellpadding="5" cellspacing="10">
	<tr><td width="25%">아이디</td><td width="*"><%=memberInfo.getMl_id() %></td></tr>
	<tr><td>이름</td><td><%=memberInfo.getMl_name() %></td></tr>
    <tr><td><label for="pwd">새 비밀번호</label></td><td><input type="password" name="pwd" maxlength="20" class="txt" id="pwd" value="<%=memberInfo.getMl_pwd() %>"/></td></tr>
   
   <%
   	String by = memberInfo.getMl_birth().substring(0, 4);
    String bm = memberInfo.getMl_birth().substring(5, 7);
  	String bd = memberInfo.getMl_birth().substring(8);
  	String slt= "";
   %>
   
   <tr>
      <td><label for="birth">생년월일</label></td> 
         <td><select name="by">
<% 
for (int i = py ; i > 1900 ; i--) { 
	slt = "";
	if (by.equals(i+""))	slt = "selected='selected'";
%>
            <option value="<%=i %>"<%=slt %>><%=i %></option>   
<% } %>         
         </select> 년
         <select name="bm">
<% 
for (int i = 1 ; i <= 12 ; i++ ) { 
	slt = "";
	if (bm.equals(((i < 10) ? "0" + i : i)+""))	slt = "selected='selected'";
%>
            <option value="<%=(i < 10) ? "0" + i : i %>"<%=slt %>><%=i %></option>
<% } %>
         </select> 월
         <select name="bd">
<% 
for (int i = 1 ; i <= 31 ; i++ ) { 
	slt = "";
	if (bd.equals(((i < 10) ? "0" + i : i)+""))	slt = "selected='selected'";
%>
            <option value="<%=(i < 10) ? "0" + i : i %>"<%=slt %>><%=i %></option>
<% } %>
         </select> 일
   </td></tr>
   
<%
String p1 = "", p2 = "", p3 = "";
if (memberInfo.getMl_phone() != null && !memberInfo.getMl_phone().equals("010--")) {
	String[] arrPhone = memberInfo.getMl_phone().split("-");
	p1 = arrPhone[0];	p2 = arrPhone[1];	p3 = arrPhone[2];
}
%>

   <tr>
      <td><label for="phone">전화번호</label></td>
      <td>
      <select name="p1">
         <option value="010" <%if (p1.equals("010")) {%>selected="selected"<%} %>>010</option>
         <option value="011" <%if (p1.equals("011")) {%>selected="selected"<%} %>>011</option>
         <option value="016" <%if (p1.equals("016")) {%>selected="selected"<%} %>>016</option>
         <option value="019" <%if (p1.equals("019")) {%>selected="selected"<%} %>>019</option>
      </select> - 
      <input type="text" name="p2" class="txt2" maxlength="4" value="<%=p2 %>" /> - 
      <input type="text" name="p3" class="txt2" maxlength="4" value="<%=p3 %>"/> 
   		</td></tr>
   
<%
String e1 = "", e2 = "";
if (memberInfo.getMl_email() != null && !memberInfo.getMl_email().equals("@")) {
	e1 = memberInfo.getMl_email().substring(0, memberInfo.getMl_email().indexOf("@"));
	e2 = memberInfo.getMl_email().substring(memberInfo.getMl_email().indexOf("@")+1);
}
%>

   <tr><td>
      <label for="e1">이메일</label></td>
      <td><input type="text" name="e1" class="txt" id="e1" value = "<%=e1 %>"/> @
      <select name="e2">
         <option value="naver.com" <%if (e2.equals("naver.com")) { %>selected="selected"<% } %>>네이버</option>
         <option value="daum.net" <%if (e2.equals("daum.com")) { %>selected="selected"<% } %>>다음</option>
         <option value="gmail.com" <%if (e2.equals("gmail.com")) { %>selected="selected"<% } %>>지메일</option>
      </select></td></tr>
   <tr>
		<td>주소(선택)</td>
		<td>
			<input type="text" name="zip" size="5" maxlength="5" readonly="readonly" value="<%=memberInfo.getMa_zip() %>"/>
			<input type="button" value="우편번호 검색" onclick="schZipcode();" /><br />
			<input type="text" name="addr1" size="40" readonly="readonly" value="<%=memberInfo.getMa_addr1() %>"/>
			<input type="text" name="addr2" size="40" value="<%=memberInfo.getMa_addr2() %>" />
		</td>
	</tr>
	<tr><td colspan="2">
      <input type="submit" value="정보 수정" />
      <input type="reset" value="다시 입력" />
   </td></tr>
   </table>
</div>
</form>
</div>
</body>
</html>
<%@ include file="../footer2.jsp" %>