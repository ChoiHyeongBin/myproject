<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="../_include/incHead.jsp" %>
<%
String errMsg = null;
String isAgree = request.getParameter("isAgree");

if (session.getAttribute("memberInfo") != null) errMsg = "잘못된 경로로 들어오셨습니다.";
else if (isAgree == null) errMsg = "약관에 동의하셔야 회원가입이 가능합니다.";

if (errMsg != null) {
   out.println("<script>");
   out.println("alert('" + errMsg +"');");
   out.println("history.back();");
   out.println("</script>");   
}

Calendar today = Calendar.getInstance();
int by = today.get(Calendar.YEAR);


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 -> 회원가입 폼</title>
<style>
.txt { width:100px; height:20px; }
.txt2 { width:50px; height:20px; }
.required {color:red;}
#comment td { color:gray; font-size:3;}
#total {position:relative; top:10%; left:30%; width:800px;}
#redFont { color:red; font-weight:bold; }
#blueFont { color:blue; font-weight:bold; }
</style>
<script>
function idChk(val) {
   var idChk = document.getElementById("idChk");
   idChk.src = "idChk.jsp?uid=" + val;
}

function schZipcode() {
	var width = screen.width;	// 화면 해상도(너비)
	var height = screen.height;	// 화면 해상도(높이)
	var w = 350;	// 팝업창의 넓이
	var h = 250;	// 팝업창의 높이
	var x = (width - w) / 2;	
	var y = (height - h) / 2;	

	window.open("zipcode.jsp", "zip", "width="+w+", height="+h+", left="+x+", top="+y);
}

function onlyNum(obj) {
	// 인수에 사용자가 입력한 값(숫자인지 검사할 값)을 담은 컨트롤을 받아옴
	if (isNaN(obj.value)) {
		obj.value = "";		obj.focus();
	}
}

function chkPassword() {
	var frm = document.frmJoin;
	var pwd = frm.pwd1.value;
	var pwd2 = frm.pwd2.value;
	var msg = "";
	if (pwd != pwd2) {
		msg = "<span id='redFont'>비밀번호와 비밀번호 확인이 다릅니다.</span>";
	} else {
		msg = "<span id='blueFont'>비밀번호와 비밀번호 확인이 같습니다.</span>";
	}
	var pwd = document.getElementById("pwd");
	pwd.innerHTML = msg;
}

function chkValue(frm) {
	var name = frm.uname.value;		var id = frm.uid.value;
	var pw = frm.pwd1.value;		var pw2 = frm.pwd2.value;
	var e1 = frm.e1.value;			var m2 = frm.p2.value;			
	var m3 = frm.p3.value;			var zip = frm.zip.value;
	var addr1 = frm.addr1.value;	var addr2 = frm.addr2.value;	

	
	if (id == "") {
		alert("아이디를 입력하세요.");
		frm.uid.focus();		return false;
	} 
	if (pw == "") {
		alert("비밀번호를 입력하세요.");
		frm.pwd1.focus();		return false;
	} else if (pw != pw2) {
		alert("비밀번호와 비밀번호 확인이 다릅니다.");
		frm.pwd1.value = "";	frm.pwd2.value = "";
		frm.pwd1.focus();		return false;
	}
	if (name == "") {
		alert("이름을 입력하세요.");
		frm.uname.focus();	return false;
	}
	
	//m2는 세자리 이상의 숫자, m3는 네자리의 숫자인지 검사
	if (m2 == "") {
		alert("휴대폰 번호를 입력하세요.");
		frm.p2.focus();		return false;
	} else if (m2.length < 3) {
		alert("휴대폰 중간 자리에는 3자리 이상의 숫자를 입력해야 합니다.");
		frm.p2.select();	return false;
	}
	if (m3 == "") {
		alert("휴대폰 번호를 입력하세요.");
		frm.p3.focus();		return false;
	} else if (m3.length != 4) {
		alert("휴대폰 끝자리에는 4자리의 숫자를 입력해야 합니다.");
		frm.p3.select();	return false;
	}
	
	if (e1 == "") {
		alert("이메일 아이디를 입력하세요.");
		frm.e1.focus();		return false;
	} 

	if (zip == "") {
		alert("주소를 입력하세요.");	return false;
	}
	if (addr2 == "") {
		alert("주소를 입력하세요.");
		frm.addr2.focus();	return false;
	}
	return true;

}

</script>
</head>
<body>
<%@ include file="../sideTab.jsp" %>
<div id="total">
<h2>회원가입</h2>
<br />
<a href=""><font color="gray">home</font></a> > <a href="joinForm.jsp"><font color="gray">회원가입</font></a> 
<hr size="5px" color="black">
<br />
<h4 class="title06">가입정보입력</h4>
<iframe src="" id="idChk" style="width:300px; height:200px; display:none;"></iframe>
<form name="frmJoin" action="../join" method="post" onsubmit="return chkValue(this);">
<input type="hidden" name="uniqueID" value="n" />
<!-- 아이디 사용가능 여부를 검사하는 히든 컨트롤로 사용가능한 아이디 입력시 y로 값이 바뀜 -->
<div id="joinForm">
	<table width="500" height="100%" cellpadding="5" cellspacing="10">
		<tr>
			<td colspan="2"><span class="required">*</span>필수입력</td>
		</tr>
		<tr>
		   <td width="25%"><span class="required">*</span><label for="uid">아이디</label></td>
		   <td width="*"><input type="text" name="uid" maxlength="40" class="txt" onkeyup="idChk(this.value);"/></td>
		</tr>
		<tr id="comment"><td colspan="2" ><span id="idMsg">아이디는 4~20자 이내로 입력하세요.</span></td></tr>
		<tr>
		   <td><span class="required">*</span><label for="pwd">비밀번호</label></td>  
		   <td><input type="password" name="pwd1" maxlength="20" class="txt" onkeyup=""/></td>
		</tr>
		<tr>
		   <td><span class="required">*</span><label for="pwd">비밀번호 확인</label></td> 
		   <td><input type="password" name="pwd2" maxlength="20" class="txt" onkeyup="chkPassword();"/></td>
		</tr>
		<tr><td colspan="2"><span id="pwd"></span></td></tr>
		<tr>
		   <td><span class="required">*</span><label for="uname">이름</label></td>  <td><input type="text" name="uname" class="txt" /></td>
		</tr>
		<tr>
		   <td><span class="required">*</span><label for="birth">생년월일</label></td>  
		      <td><select name="by">
		<% for (int i = by ; i > 1900 ; i--) { %>
		      <option value="<%=i %>"><%=i %></option>   
		<% } %>         
		   </select> 년
		   <select name="bm">
		<% for (int i = 1 ; i <= 12 ; i++ ) { %>
		      <option value="<%=(i < 10) ? "0" + i : i %>"><%=i %></option>
		<% } %>
		   </select> 월
		   <select name="bd">
		<% for (int i = 1 ; i <= 31 ; i++ ) { %>
		      <option value="<%=(i < 10) ? "0" + i : i %>"><%=i %></option>
		<% } %>
		      </select> 일
		      </td>
		</tr>
		<tr>
		   <td><span class="required">*</span><label for="phone">전화번호</label></td>
		   <td><select name="p1" >
		      <option value="010">010</option>
		      <option value="011">011</option>
		      <option value="016">016</option>
		      <option value="019">019</option>
		   </select> - 
		   <input type="text" name="p2" class="txt2" maxlength="4" onkeyup="onlyNum(this);"/> - 
		   <input type="text" name="p3" class="txt2" maxlength="4" onkeyup="onlyNum(this);"/> 
		   </td>
		</tr>
		<tr>
		   <td><span class="required">*</span><label for="e1">이메일</label></td>
		   <td><input type="text" name="e1" class="txt" /> @
		   <select name="e2">
		      <option value="naver.com">네이버</option>
		      <option value="daum.net">다음</option>
		      <option value="gmail.com">지메일</option>
		   </select>
		   </td>
		</tr>
		<tr>
		<td><span class="required">*</span>주소</td>
		<td>
			<input type="text" name="zip" size="5" maxlength="5" readonly="readonly" />
			<input type="button" value="우편번호 검색" onclick="schZipcode();" /><br />
			<input type="text" name="addr1" size="40" readonly="readonly" />
			<input type="text" name="addr2" size="40" />
		</td>
		</tr>
		<tr><td colspan="2">
		   <input type="submit" value="회원 가입" />
		   <input type="reset" value="다시 입력" />
		</td></tr>
	</table>
</div>
</form>
</div>
<div>
</div>
</body>
</html>
<%@ include file="../_include/incFoot.jsp" %>
<%@ include file="../footer2.jsp" %>
