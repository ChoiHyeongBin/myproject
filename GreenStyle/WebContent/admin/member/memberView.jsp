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
<div id="upForm">
	<table width="500" height="100%" cellpadding="5" cellspacing="10">
	<tr><td width="25%">회원번호</td><td width="*"><%=memberInfo.getMl_num() %></td></tr>
	<tr><td>아이디</td><td><%=memberInfo.getMl_id() %></td></tr>
	<tr><td>이름</td><td><%=memberInfo.getMl_name() %></td></tr>

    <tr><td>생년월일</td><td><%=memberInfo.getMl_birth() %></td></tr>
    <tr><td>전화번호</td><td><%=memberInfo.getMl_phone() %></td></tr>
    <tr><td>이메일</td><td><%=memberInfo.getMl_email() %></td></tr>
    <tr><td>회원상태</td><td><%=memberInfo.getMl_isrun() %></td></tr>
	<tr><td colspan="2">
      <input type="button" value="수정" onclick="location.href='memberUp.mem<%=args %>&num=<%=memberInfo.getMl_num() %>';" />
      <input type="button" value="목록" onclick="location.href='memberList.mem<%=args %>';"/>
   </td></tr>
   </table>
</div>
</div>
</body>
</html>