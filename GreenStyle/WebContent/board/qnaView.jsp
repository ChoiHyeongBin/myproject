<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
QnaInfo qnaInfo = (QnaInfo) request.getAttribute("qnaInfo");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 보기 폼</title>
<style>
#mainBox { position:absolute; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; }
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
</head>
<body>
<div id="mainBox">
<h2>마이페이지</h2>
<br />
<a href="main"><font color="gray">home</font></a> > <a href="view.mypage"><font color="gray">마이페이지</font></a> > <a href="qna.mypage"><font color="gray">1:1 고객상담</font></a>  > <a href="in.qna"><font color="black">1:1 고객상담 보기</font></a>
<hr size="5px" color="black">
<br />
<form name="frmQna" action="up.qna" method="post">
<input type="hidden" id="num" name="num" value="<%=qnaInfo.getQl_num() %>"/>
<h2>1:1 고객상담</h2>
<br />
<br /><br />
<table width="1300" align="center" id="upperTable">
<input type="hidden" name="wtype" value="up" />
<tr>
	<td class="underLine2" width="20%">답변 이메일</td>
	<td class="underLine2" width="*">
	<%
	String e1 = "", e2 = "";
	if( memberInfo != null) {
		if (memberInfo.getMl_email() != null && !memberInfo.getMl_email().equals("@")) {
		   e1 = memberInfo.getMl_email().substring(0, memberInfo.getMl_email().indexOf("@"));
		   e2 = memberInfo.getMl_email().substring(memberInfo.getMl_email().indexOf("@") + 1);
		}
	}
	%>
	      <%=e1 %> @ <%=e2 %>
	</td>
</tr>
<tr>
	<td class="underLine2">휴대전화</td>
	<td class="underLine2">
	<%
	String p1 = "", p2 = "", p3 = "";
	if (memberInfo != null) {
		if (memberInfo.getMl_phone() != null && !memberInfo.getMl_phone().equals("010--")) {
		   String[] arrPhone = memberInfo.getMl_phone().split("-");
		   p1 = arrPhone[0];   p2 = arrPhone[1];   p3 = arrPhone[2];
		}
	}
	%>
	<%=p1 %> - <%=p2 %> - <%=p3 %>
	</td>
</tr>
<% 
	if (qnaInfo.getOl_id() == null || qnaInfo.getOl_id().equals("")) {
%>
<tr>
	<td class="underLine2">주문번호</td>
	<td class="underLine2"></td>
</tr>
<%
	} else {
%>
<tr>
	<td class="underLine2">주문번호</td>
	<td class="underLine2"><%=qnaInfo.getOl_id() %></td>
</tr>
<%
	}
%>
<%
String kind = qnaInfo.getQl_kind();
if (kind.equals("a")) { 
	kind = "회원 정보";
} else if (kind.equals("b")){
	kind = "주문/결제";
} else if (kind.equals("c")){
	kind = "취소/반품";
} else if (kind.equals("d")){
	kind = "배송";
}
%>
<tr>
	<td class="underLine2">상담분류</td>
	<td class="underLine2"><%=kind %></td>
</tr>
<tr>
	<td class="underLine2">제목</td>
	<td class="underLine2"><%=qnaInfo.getQl_title() %></td>
</tr>
<tr>
	<td class="underLine2">내용</td>
	<td class="underLine2"><%=qnaInfo.getQl_content() %></td>
</tr>
<tr>
	<td class="underLine2">첨부파일</td>
	<td class="underLine2"><%=qnaInfo.getQl_img1() %></td>
</tr>
</table>
<table width="1300">
<tr><td><span style="font-size:15px; color:gray;">- 문의하신 내용에 대한 답변은 마이페이지 > 1:1고객상담에서 확인하실 수 있습니다.</span></td></tr>
<tr><td align="center">
<input type="submit" class="btn1" value="수정">&nbsp;&nbsp;&nbsp;
<input type="button" class="btn2" value="뒤로 가기" onclick="history.back()">
</td></tr>
</table>
</form>
</div>
</body>
</html>