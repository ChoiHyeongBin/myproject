<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
memberInfo = (MemberInfo)session.getAttribute("memberInfo");

request.setCharacterEncoding("utf-8");
String wtype = request.getParameter("wtype");
String isLogin = request.getParameter("isLogin");
System.out.println("memberinfo : " + memberInfo);
System.out.println("isLogin : " + isLogin);

int num = 0;
String kind = "", title = "", content = "";
String btn = "", img1 = "";
String noMem = request.getParameter("noMem");

if (wtype.equals("in")) {
	btn = "등록";
} else if (wtype.equals("up")) {
	btn = "수정";
	QnaInfo qnaInfo = (QnaInfo)request.getAttribute("qnaInfo");
	kind = qnaInfo.getQl_kind();
	title = qnaInfo.getQl_title();
	content = qnaInfo.getQl_content();
	img1 = qnaInfo.getQl_img1();
	num = qnaInfo.getQl_num();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 고객상담 <%=btn %> 페이지</title>
<style>
.imgBox { position:relative; margin-top:10px; float:left; width:250px; height:80px; border:1px solid black; text-align:center; background-color:#f8f8f8; }
#mainBox { position:absolute; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; }
.upperLine { border-top:1px solid black; border-collapse: collapse; }
#upperTable { border-top:1px solid black; border-collapse: collapse; }
#upperTable th, td { height:40px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
.redFont { font-size:1.2em; color:red}
.txt { height:25px; }
.txt2 { height:25px; width:100px; }
.btn1 { width:200px; height:40px; background-color:black; color:white; }
.btn2 { width:200px; height:40px; background-color:white; color:black; }
.btn3 { width:100px; height:35px;}
.readonly { background-color:#e2e2e2; border:1px solid #e2e2e2; color:black; height:25px; width:200px;}
#footerBox { position:absolute; width:100%; bottom:-100%;}
</style>
<script>

<%
if (memberInfo == null && isLogin == null && noMem == null) {
%>
	alert("로그인이 필요합니다.");
	location.href = "member/loginForm.jsp?callType=qna";
<%
}
%>

function changeDomain(domain) {
	var e2 = document.getElementById("e2");
	e2.value = domain;
	
	if(e2.value != "") {
		e2.readOnly = true;
	} else {
		e2.readOnly = false;
	}
}
function chkval(frm) {
var p1 = frm.e1.value; var p2 = frm.p2.value; var p3 = frm.p3.value;
var e1 = frm.e1.value; var e2 = frm.e2.value;
var kind = frm.kind.value; var title = frm.title.value; var content = frm.content.value;
var find = frm.findOrd.value;

if (e1 == "") { alert("이메일 아이디를 입력하세요."); frm.e1.focus(); return false; }
if (e2 == "") { alert("이메일 도메인을 입력하세요."); frm.e2.focus(); return false; }
if (p1 == "") { alert("핸드폰 번호 앞자리를 선택하세요."); frm.p1.focus(); return false; }
if (p2 == "") { alert("핸드폰 번호 중간자리를 입력하세요."); frm.p2.focus(); return false; }
if (p3 == "") { alert("핸드폰 번호 뒷자리를 입력하세요."); frm.p3.focus(); return false; }
if (kind == "") { alert("분류를 선택하세요."); frm.kind.focus(); return false; }
if (title == "") { alert("제목을 입력하세요."); frm.title.focus(); return false; }
if (content == "") { alert("내용을 입력하세요."); frm.content.focus(); return false; }

	return true;
}
</script>
</head>
<body>
<div id="mainBox">
<h2>고객센터</h2>
<br />
<a href="main"><font color="gray">home</font></a> > <a href="support"><font color="gray">고객센터</font></a> > <a href="in.qna"><font color="black">1:1 고객상담</font></a> 
<hr size="5px" color="black">
<br />
<form name="frmQna" action="proc.qna" method="post" onsubmit="return chkval(this)">
<input type="hidden" name="wtype" value="<%=wtype %>" />
<input type="hidden" name="qlnum" value="<%=num %>" />
<h2>1:1 고객상담 <%=btn %></h2>
<br />
<span class="redFont">*</span>필수 입력 항목.
<br /><br />
<table width="1300" align="center" id="upperTable">
<tr>
	<td class="underLine2" width="20%">답변 이메일<span class="redFont">*</span></td>
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
	      <input type="text" name="e1" class="txt" id="e1" value="<%=e1 %>" /> @
	      <input type="text" name="e2" class="txt" id="e2" value="<%=e2 %>" />
	      <select name="e3" class="txt" onchange="changeDomain(this.value);">
	      	 <option value="">직접입력</option>
	         <option value="naver.com" <% if (e2.equals("naver.com")) { %>selected="selected"<% } %>>naver.com</option>
	         <option value="nate.com" <% if (e2.equals("nate.com")) { %>selected="selected"<% } %>>nate.com</option>
	         <option value="gmail.com" <% if (e2.equals("gmail.com")) { %>selected="selected"<% } %>>gmail.com</option>
	      </select>
	   	</p>
	</td>
</tr>
<% 
if (noMem != null) {
%>
<tr><td class="underLine2">받는 사람<span class="redFont">*</span></td>
	<td class="underLine2"><input type="text" name="nologin" class="txt" value=""/></td>
</tr>
<%
}
%>
<tr>
	<td class="underLine2">휴대전화<span class="redFont">*</span></td>
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
	      <select name="p1" class="txt">
	         <option value="010" <% if (p1.equals("010")) { %>selected="selected"<% } %>>010</option>
	         <option value="011" <% if (p1.equals("011")) { %>selected="selected"<% } %>>011</option>
	         <option value="016" <% if (p1.equals("016")) { %>selected="selected"<% } %>>016</option>
	         <option value="019" <% if (p1.equals("019")) { %>selected="selected"<% } %>>019</option>
	      </select> - 
	      <input type="text" name="p2" class="txt" maxlength="4" size="5" value="<%=p2 %>" /> -
	      <input type="text" name="p3" class="txt" maxlength="4" size="5" value="<%=p3 %>" />
	   </p>
	</td>
</tr>
<script>
function openPop() {
	window.open('board/findOrdNum.jsp?visited=n', '주문번호 찾기', 'width=1500, height=1000');
}
</script>
<%
if (memberInfo != null || isLogin != null){
%>
<tr>
	<td class="underLine2">주문번호</td>
	<td class="underLine2">
	<input type="text" id="findOrd" name="findOrd" class="readonly" readonly="readonly" value=""/>
	<input type="button" class="btn3" value="주문찾기" onclick="openPop();"/>
	</td>
</tr>
<%
}
%>
<tr>
	<td class="underLine2">상담분류<span class="redFont">*</span></td>
	<td class="underLine2">
	<select name="kind" class="txt">
	      	 <option value="" >선택</option>
	         <option value="a" <% if (kind.equals("a")) { %>selected="selected"<% } %>>회원 정보</option>
	         <option value="b" <% if (kind.equals("b")) { %>selected="selected"<% } %>>주문/결제</option>
	         <option value="c" <% if (kind.equals("c")) { %>selected="selected"<% } %>>취소/반품</option>
	         <option value="d" <% if (kind.equals("d")) { %>selected="selected"<% } %>>배송</option>
	</select>
	</td>
</tr>
<tr>
	<td class="underLine2">제목<span class="redFont">*</span></td>
	<td class="underLine2">
	<input type="text" name="title" size="30" placeholder="제목 입력은 30자 미만입니다." value="<%=title %>"/>
	</td>
</tr>
<tr>
	<td class="underLine2">내용<span class="redFont">*</span></td>
	<td class="underLine2">
	<textarea name="content" rows="10" cols="50" placeholder="내용 입력은 1000자 미만입니다."><%=content %></textarea>
	</td>
</tr>
<script>
function fileChange(path) {
	var file = document.getElementById("filePath");
	var ext = path.substring(path.lastIndexOf('.') + 1, path.length);
	
	if (ext == "hwp" || ext == "doc" || ext == "xls" || ext == "ppt" || ext == "jpg" || ext == "png" || ext == "gif" || ext == "pdf")
	{
		file.value = path;
	} else {
		alert("hwp, doc, xls, ppt, jpg, png, gif, pdf 파일만 업로드 할 수 있습니다.");
		file.value = "";
	}
}
</script>
<tr>
	<td class="underLine2">첨부파일</td>
	<td class="underLine2">
	<input type="text" id="filePath" class="readonly" value="" readonly="readonly"/>
	<input type="button" class="btn3" value="파일찾기" onclick="document.all.file.click()"/><br />
	<input type="file" id="file" name="file" style="display:none;" onchange="fileChange(this.value)" />
	- 첨부 파일은 1개만 가능하며, 10MB 이하의 파일만 업로드 가능합니다.<br />
	- 업로드 가능한 파일 형식은 [hwp, doc, xls, ppt, jpg, png, gif, pdf] 입니다.
	</td>
</tr>
</table>
<table width="1300">
<tr><td><span style="font-size:15px; color:gray;">- 문의하신 내용에 대한 답변은 마이페이지 > 1:1고객상담에서 확인하실 수 있습니다.</span></td></tr>
<% 
if (noMem != null) {
%>
<tr><td><span style="font-size:15px; color:gray;">- 비회원 문의에 대한 답변은 등록하신 휴대전화로 발송합니다.</span></td></tr>
<%
}
%>
<tr><td align="center">
<input type="submit" class="btn1" value="저장">&nbsp;&nbsp;&nbsp;
<input type="button" class="btn2" value="취소" onclick="history.back()">
</td></tr>
</table>
</form>
</div>
<div id=footerBox>
<%@ include file="../footer.jsp" %>
</div>
</body>
</html>