<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
System.out.println("ordForm의 MemberInfo : " + mem);
// 로그인된 회원정보를 MemberInfo형 인스턴스로 받아옴

if (mem == null) {
	out.println("<script>");
	out.println("alert('로그인 후 사용하실 수 있습니다.');");
	out.println("location.href='loginForm.jsp';");
	out.println("</script>");
}
String[] phone = mem.getMl_phone().split("-");
ArrayList<CartInfo> preOrdList = (ArrayList<CartInfo>)request.getAttribute("preOrdList");
System.out.println("preOrdList : " + preOrdList);

ArrayList<MemberCouponInfo> memberCoupon = (ArrayList<MemberCouponInfo>)request.getAttribute("memberCoupon");
System.out.println("ordForm의 memberCoupon : " + memberCoupon);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ordForm</title>
<style>
table tr td { border-collapse:collpase; }
#frm { position:relative; left:11%; margin-top:3%; width:1200px; }
#ordFont { font-size:12px; }
#status {
	margin-left:11%; margin-top:2%; width:1200px; height:60px; padding-top:10px; border:1px solid black; 
	text-align:center; background-color:black; color:white; float:left; 
}
#subStatus { color:#6e6969; }
#payment { border:2px solid black; width:250px; height:300px; float:left; margin-top:-173%; margin-left:102%; }
#innerPayment { margin:14px 0 0 14px; width:220px; height:270px; }
#orderBtn { color:white; background-color:black; border:1px black solid; }
#asterisk { color:red; }
#point { color:#f28124; }
#totalPrice { color:red; font-weight:bold; }
#numOfCases { color:#eb8c10; }
#radio { text-align:center; }
#pdtList { border-bottom:1px solid black; height:80px; }
#pdtList2 { border-bottom:1px solid black; border-top:1px solid black; }
#ordInfo { width:50px; height:80px; }
</style>
<script>
function sameInfo(chk) {
	var frm = document.frmOrder;
	if (chk == 'y') {
		frm.rname.value = "<%=mem.getMl_name()%>";
		frm.p1.value = "<%=phone[0]%>";
		frm.p2.value = "<%=phone[1]%>";
		frm.p3.value = "<%=phone[2]%>";
		frm.rzip.value = "<%=mem.getMa_zip()%>";
		frm.raddr1.value = "<%=mem.getMa_addr1() %> <%=mem.getMa_addr2() %>";
	} else {
		frm.rname.value = "";
		frm.p1.value = "";
		frm.p2.value = "";
		frm.p3.value = "";
		frm.rzip.value = "";
		frm.raddr1.value = "";
		frm.call1.value = "";
		frm.call2.value = "";
		frm.call3.value = "";
	}
}

function chkVal(frm) { 
	var ordName = frm.ordName.value;	var ordP2 = frm.ordP2.value;
	var ordP3 = frm.ordP3.value;		var ordE1 = frm.ordE1.value;
	var ordE2 = frm.ordE2.value;		var rname = frm.rname.value;		
	var p2 = frm.p2.value;				var p3 = frm.p3.value;				
	var rzip = frm.rzip.value;			var raddr1 = frm.raddr1.value;		
		
	if (ordName == "") {
		alert("주문자명을 입력하세요.");	frm.ordName.focus();	return false;
	}
	if (ordP2 == "") {
		alert("휴대폰 중간번호를 입력하세요.");	frm.ordP2.focus();	return false;
	}
	if (ordP3 == "") {
		alert("휴대폰 끝자리번호를 입력하세요.");	frm.ordP3.focus();	return false;
	}
	if (ordE1 == "") {
		alert("이메일 주소를 입력하세요.");	frm.ordE1.focus();	return false;
	}
	if (ordE2 == "") {
		alert("이메일 주소를 입력하세요.");	frm.ordE2.focus();	return false;
	}
	if (rname == "") {
		alert("수취인명을 입력하세요.");	frm.rname.focus();	return false;
	}
	if (p2 == "") {
		alert("전화번호를 입력하세요.");	frm.p2.focus();		return false;
	}
	if (p3 == "") {
		alert("전화번호를 입력하세요.");	frm.p3.focus();		return false;
	}
	if (rzip == "") {
		alert("우편번호를 입력하세요.");	frm.rzip.focus();	return false;
	}
	if (raddr1 == "") {
		alert("주소을 입력하세요.");		frm.raddr1.focus();	return false;
	} 

	return true;
}

function schZipcode() {
	var width = screen.width;	// 화면 해상도(너비)
	var height = screen.height;	// 화면 해상도(높이)
	var w = 400;	// 팝업창의 넓이
	var h = 300;	// 팝업창의 높이
	var x = (width - w) / 2;	
	var y = (height - h) / 2;	

	window.open("ord/zipcode.jsp", "zip", "width="+w+", height="+h+", left="+x+", top="+y);
}

function cancel() {
	if (confirm("주문을 취소하시겠습니까?")) {
		location.href = "main.jsp";
	} else {
		// null
	}
}

function openPop() {
	var width = screen.width;	// 화면 해상도(너비)
	var height = screen.height;	// 화면 해상도(높이)
	var w = 600;	// 팝업창의 넓이
	var h = 550;	// 팝업창의 높이
	var x = (width - w) / 2;	
	var y = (height - h) / 2;	
	
	window.open('ord/findCoupon.jsp?visited=n', '주문번호 찾기', "width="+w+", height="+h+", left="+x+", top="+y);
}

function onlyNum(obj) {
// 인수에 사용자가 입력한 값(숫자인지 검사할 값)을 담은 컨트롤을 받아옴
	if (isNaN(obj.value)) {
		alert("숫자만 입력가능합니다.");
		obj.value = "";		obj.focus();
	}
}

function schPoint(frm) {
	var pointDC = document.frmOrder.pointDC;
	
	if (frm == "") {
		alert("null");
	} else {
		pointDC.value = <%=mem.getMl_id() %>;
	}
}
</script>
</head>
<body>
<%@ include file="../mainsideTab.jsp" %>

<!-- 상태바 -->
<div id="status">
	<h1 id="">장바구니&nbsp;&nbsp;&nbsp; > 
	&nbsp;&nbsp;&nbsp;주문결제&nbsp;&nbsp;&nbsp; <span id="subStatus">> 
	&nbsp;&nbsp;&nbsp;주문완료</span></h1>
</div>

<div id="frm">
<form name="frmOrder" action="proc.ord" method="post" onsubmit="return chkVal(this);">
<input type="hidden" name="kind" value="<%=request.getParameter("kind") %>" />
<input type="hidden" id="mcnum" name="mcnum" value="-1" />
	<div id="ordInfo"></div>
	<h2>주문 상품 정보</h2><br />
	
	<!-- 테이블 1 시작 -->
	<table width="1200" height="300" cellpadding="0" cellspacing="0">
	<tr>
		<th width="35%" height="50" id="pdtList2">상품</th>
		<th width="10%" id="pdtList2">수량</th>
		<th width="15%" id="pdtList2">할인/혜택</th>
		<th width="10%" id="pdtList2">배송정보</th>
		<th width="15%" id="pdtList2">주문금액</th>
	</tr>
<%
int totalPrice = 0;
int pointDiscount = 0;
System.out.println("개수 : " + preOrdList.size());
if (preOrdList.size() == 0) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어왔습니다.1')");
	out.println("history.back();");
	out.println("</script>");
} else {
	for (int i = 0 ; i < preOrdList.size() ; i++) {
		CartInfo ci = preOrdList.get(i);
		int ocNum = ci.getOc_num();
		String img = ci.getPl_img1();
		totalPrice += ci.getPl_price() * ci.getOc_amount();
		pointDiscount = ci.getMl_point();
		System.out.println(img);
%>
	<input type="hidden" name="ocnums" value="<%=ci.getOc_num() %>" />
	<input type="hidden" name="plids" value="<%=ci.getPl_id() %>" />
	<input type="hidden" name="sizes" value="<%=ci.getOc_optsize() %>" />
	<input type="hidden" name="colors" value="<%=ci.getOc_optcolor() %>" />
	<input type="hidden" name="prices" value="<%=ci.getPl_price() %>" />
	<input type="hidden" name="amounts" value="<%=ci.getOc_amount() %>" />
	<!-- order_detail 테이블에 넣을 상품 정보들을 hidden 컨트롤로 생성 -->
	
	<tr>
		<td align="left" width="10%" id="pdtList">
			<img src="pdt-img/<%=ci.getCs_id() %>/<%=ci.getPl_img1() %>" width="180" height="200" 
			style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black;" />
			&nbsp;&nbsp;<strong><%=ci.getPl_name() %></strong><br />
			색상 <strong><%=ci.getOc_optcolor() %></strong><br />
			사이즈 <strong><%=ci.getOc_optsize() %></strong>
		</td>
		<td width="10%" align="center" id="pdtList"><%=ci.getOc_amount() %> 개</td>
		<td width="10%" align="center" id="pdtList">
			- <%=ci.getMl_point() %> <span id="point">P</span><br />
		</td>
		<td width="10%" align="center" id="pdtList">무료</td>
		<td id="pdtList" width="10%" align="center" id="pdtList">
			<%=ci.getPl_price() * ci.getOc_amount() %>원
		</td>
	</tr>
<%
	}
%>
	</table><br />
	<!-- 테이블1 종료 -->
<%
}
%>
	<!-- 기본 주소지 설정 Ex ci.getMa_isbasic() -->
	<tr>
		<td>- 사은품은  주문 상품과 별도로 배송될 수 있습니다.<br />
			- 결제완료 이후 품절이 발생한 경우, 영업일 4일 이내 고객님께 별도로 안내를 드립니다.<br />
			- 품절 안내 이후 결제하신 금액은 자동취소 처리해 드리며, 재결제가 필요한 경우 추가로 안내 드립니다.
		</td>
	</tr><br /><br /><br /><br />
	
	<!-- 주문자 정보 -->
	<h2>주문자 정보</h2>
	<hr align="reft" width="1200" color="black">
	
	<table width="100%">
	<tr>
		<th align="left">주문하시는 분 <span id="asterisk">*</span></th>
		<td><input type="text" name="ordName" style="height:25px;" value="<%=mem.getMl_name() %>" /></td>
	</tr>	
	<tr>
		<th align="left">휴대폰 번호 <span id="asterisk">*</span></th>
		<td>
		<select name="ordP1" style="height:30px;">
			<option <% if (phone[0].equals("010")) { %>selected="selected"<% } %>>010</option>
			<option <% if (phone[0].equals("011")) { %>selected="selected"<% } %>>011</option>
			<option <% if (phone[0].equals("016")) { %>selected="selected"<% } %>>016</option>
			<option <% if (phone[0].equals("019")) { %>selected="selected"<% } %>>019</option>
		</select> -
		<input type="text" name="ordP2" style="height:25px;" size="4" maxlength="4" value="<%=phone[1] %>" onkeyup="onlyNum(this);" /> -
		<input type="text" name="ordP3" style="height:25px;" size="4" maxlength="4" value="<%=phone[2] %>" onkeyup="onlyNum(this);" />
		</td>
	</tr>
<!-- // 회원가입 때 안받아서 삭제
	<tr>
		<th align="left">전화 번호</th>
		<td>
			<input type="text" name="" style="height:25px;" size="4" maxlength="4" value="" /> -
			<input type="text" name="" style="height:25px;" size="4" maxlength="4" value="" /> -
			<input type="text" name="" style="height:25px;" size="4" maxlength="4" value="" />
		</td>
	</tr>
-->
	<tr>
		<th align="left">이메일 주소 <span id="asterisk">*</span></th>
		<td>
			<input type="text" name="ordE1" style="height:25px;" value="<%=mem.getMl_email().substring(0, mem.getMl_email().indexOf("@")) %>" />&nbsp;@&nbsp;
			<input type="text" name="ordE2" style="height:25px;" value="<%=mem.getMl_email().substring(mem.getMl_email().lastIndexOf("@") + 1) %>" />
		</td>
	</tr>
	</table>
	<hr align="reft" width="1200" color="black">알림톡 및 이메일로 주문 진행상황을 안내해 드립니다.<br /><br /><br /><br /><br /><br />
	
	<!-- 배송지 정보 -->
	<h2>배송지 정보</h2> (<span id="asterisk">*</span> 필수입력 항목)
	<table width="100%">
	<tr><td colspan="2"><span id="ordFont">주문자 정보와 동일 
		<input type="radio" name="isSame" value="y" onclick="sameInfo(this.value);" checked="checked" />예
		<input type="radio" name="isSame" value="n" onclick="sameInfo(this.value);" />아니오
	</td></tr>
	<hr align="reft" width="1200" color="black">
	<tr>
	<th>받는 분 <span id="asterisk">*</span></th>
	<td><input type="text" name="rname" style="height:25px;" value="<%=mem.getMl_name() %>" /></td>
	</tr>
	<tr>
	<th>전화 번호</th>
	<td>
		<input type="text" name="call1" style="height:25px;" size="4" maxlength="4" value="" onkeyup="onlyNum(this);" /> -
		<input type="text" name="call2" style="height:25px;" size="4" maxlength="4" value="" onkeyup="onlyNum(this);" /> -
		<input type="text" name="call3" style="height:25px;" size="4" maxlength="4" value="" onkeyup="onlyNum(this);" />
	</td>
	</tr>
	<tr>
	<th>휴대폰 번호 <span id="asterisk">*</span></th>
	<td>
		<select name="p1" style="height:30px;">
			<option <% if (phone[0].equals("010")) { %>selected="selected"<% } %>>010</option>
			<option <% if (phone[0].equals("011")) { %>selected="selected"<% } %>>011</option>
			<option <% if (phone[0].equals("016")) { %>selected="selected"<% } %>>016</option>
			<option <% if (phone[0].equals("019")) { %>selected="selected"<% } %>>019</option>
		</select> -
		<input type="text" name="p2" style="height:25px;" size="4" maxlength="4" value="<%=phone[1] %>" onkeyup="onlyNum(this);" /> -
		<input type="text" name="p3" style="height:25px;" size="4" maxlength="4" value="<%=phone[2] %>" onkeyup="onlyNum(this);" />
	</td>
	</tr>
	<tr>
	<th>배송지 주소 <span id="asterisk">*</span></th>
		<td>
			<input type="text" name="rzip" style="width:380px; height:25px;" size="35" readonly="readonly" value="<%=mem.getMa_zip() %>" />
			<input type="button" value="우편번호" style="width:114px; height:32px;" onclick="schZipcode();" /><br />
			<input type="text" name="raddr1" style="width:500px; height:25px;" size="35" readonly="readonly" value="<%=mem.getMa_addr1() %> <%=mem.getMa_addr2() %>" />
			<br />
			<input type="text" name="raddr2" style="width:500px; height:25px;" />
		</td>
	</tr>
	<tr>
		<td></td>
		<td>
		<input type="checkbox" />기본배송지로 지정&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="checkbox" />배송지관리 목록에 추가
		</td>
	</tr>
	<tr>
		<th>배송요청사항</th>
		<td>
		<textarea name="comment" style="width:500px; height:50px;" maxlength="200" placeholder="직접입력"></textarea>
		</td>
	</tr>
	</table><br /><br /><br /><br /><br /><br />
	
	<!-- 테이블2 시작 -->
	<table>
		<h2>할인 정보</h2>
		<hr align="left" width="1200" color="black">
		<tr>

			<td>쿠폰</td>
			<td><input type="text" id="couponDC" name="couponDC" readonly="readonly" style="height:25px;" value="0"/></td>
			<td>
<%
if (preOrdList.size() == 0) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어왔습니다.2')");
	out.println("history.back();");
	out.println("</script>");
} else {
	for (int i = 0 ; i < preOrdList.size() ; i++) {
		CartInfo ci = preOrdList.get(i);
		int ocNum = ci.getOc_num();
		String img = ci.getPl_img1();
		// totalPrice 또 선언하면 2배로 뜸(선언 X)
%>
				<input type="button" class="btn3" value="쿠폰조회" onclick="openPop();" />&nbsp;&nbsp;&nbsp;
				보유 쿠폰 <span id="numOfCases"><%=ci.getMl_coupon() %></span>건
			</td>
		</tr>
		<tr>
			<td>보유 포인트</td>

			<td><input type="text" name="rpoint" style="height:25px;" readonly="readonly" value="<%=ci.getMl_point() %>"/></td>
<%
	}
}
%>
			<td><input type="button" value="적용" style="width:114px; height:32px;" onclick="schPoint(this.value);" /></td>
		</tr>
	
	</table><br /><br /><br /><br /><br /><br />
	<!-- 테이블2 종료 -->
		<tr>
			<td><h2>결제 수단</h2></td><td></td>
		</tr>
		<tr><td><hr align="left" width="1200" color="black"></td></tr><br />
		<tr>
		<div id="radio">
			<td>
			<input type="radio" name="payment" value="a" checked="checked" />신용/체크카드&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="payment" value="b" />무통장입금&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="payment" value="c" />휴대폰결제
			</td>
		</div>
		</tr><br /><br /><br /><br />
		<tr>
		<div id="radio">
			<td>
			<input type="button" value="주문 취소하기" id="orderBtn" style="height:50px; width:220px; cursor:pointer;" onclick="cancel();" />
			</td>
		</div>
		</tr><br /><br /><br /><br /><br /><br /><br /><br />

<!-- 결제정보 창 -->
	<div id="payment">
		<div id="innerPayment">
		<h2>결제정보</h2>
		<hr align="center" width="220" color="black">
		상품금액 : <%=totalPrice %>원<br />
		배송비 : 무료<br />
		할인금액 : -<%=pointDiscount %>원<br />
		총 결제금액 : <span id="totalPrice"><%=totalPrice - pointDiscount %></span>원<br /><br /><br />
		<hr align="center" width="220" color="black">
		<input type="submit" value="주문 하기" style="width:220px; height:40px; cursor:pointer;" id="orderBtn" />
		</div>
	</div>
<input type="hidden" name="total" value="<%=totalPrice - pointDiscount %>" />
</form>
</div>
</body>
</html>
<%@ include file="../footer.jsp" %>