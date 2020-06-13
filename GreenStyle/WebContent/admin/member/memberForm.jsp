<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
MemberInfo memberInfo = (MemberInfo)request.getAttribute("memberInfo");
// 보려는 공지사항 게시글을 NoticeInfo 인스턴스에 담음

String cpage = (String)request.getAttribute("cpage");
String schType = (String)request.getAttribute("schType");
String keyword = (String)request.getAttribute("keyword");
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";

String args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;

Calendar today = Calendar.getInstance();
int py = today.get(Calendar.YEAR);

String mlid = memberInfo.getMl_id();
int mlnum = memberInfo.getMl_num();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.txt { width:100px; height:20px; }
.txt2 { width:50px; height:20px; }
#idMsg { font-size:11; }
#total {position:relative; left:650px; width:600px; top:100px;}
</style>
<title>Insert title here</title>
</head>
<body>
<%@ include file="../adminSideTab.jsp" %>
<div id="total">
<h2>회원 상세보기/수정</h2>
<br />
<hr size="5px" color="black">
<br />
<form name="frmUp" action="proc.mem" method="post">
<input type="hidden" name="num" value="<%=mlnum %>" />
<input type="hidden" name="uid" value="<%=mlid %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<input type="hidden" name="schType" value="<%=schType %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<div id="upForm">
	<table width="500" height="100%" cellpadding="5" cellspacing="10">
	<tr><td width="25%">회원번호</td><td width="*"><%=memberInfo.getMl_num() %></td></tr>
	<tr><td>아이디</td><td><%=memberInfo.getMl_id() %></td></tr>
	<tr><td>이름</td><td><%=memberInfo.getMl_name() %></td></tr>
   
   
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
         <option value="daum.net" <%if (e2.equals("daum.net")) { %>selected="selected"<% } %>>다음</option>
         <option value="gmail.com" <%if (e2.equals("gmail.com")) { %>selected="selected"<% } %>>지메일</option>
      </select></td></tr>
<%
String status = "";
status = memberInfo.getMl_isrun();
%>
   <tr><td>
      <label for="status">회원상태</label></td>
      <td>
      <select name="status">
         <option value="y" <%if (status.equals("y")) { %>selected="selected"<% } %>>y</option>
         <option value="n" <%if (status.equals("n")) { %>selected="selected"<% } %>>n</option>
      </select></td></tr>
   
	<tr><td colspan="2">
      <input type="submit" value="정보 수정"/>
   </td></tr>
   </table>
</div>
</form>
</div>
</body>
</html>