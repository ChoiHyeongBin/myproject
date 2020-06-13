<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<CartInfo> cartList = (ArrayList<CartInfo>)request.getAttribute("cartList");
MemberInfo mem2 = (MemberInfo)session.getAttribute("memberInfo");
if (mem2 == null) {
	   out.println("<script>");
	   out.println("alert('로그인 후 사용하실 수 있습니다.');");
	   out.println("history.back();");
	   out.println("</script>");   
}
System.out.println("cartList : " + cartList);
// 장바구니에서 보여줄 상품목록을 CartInfo형 인스턴스가 들어있는 ArrayList로 받음
String args = "&kind=c&csid=" + request.getParameter("csid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<style>
table tr td { border-collapse:collapse; }
hr { left:15%; }
#status { left:15%; width:1200px; height:60px; padding-top:10px; border:1px solid black; text-align:center; background-color:black; color:white; }
#subStatus { color:#6e6969; }
#formBox { position:relative; left:11%; margin-top:5%; width:1200px; }
tr.underline th { border-top:1px solid black; border-bottom:1px solid black; }
#clause { height:100px; }
#shop { text-align:center; }
#clauseInfo { font-size:14px; }
#payment { border:2px solid black; width:250px; height:300px; position:fixed; float:left; margin-top:-680px; margin-left:1230px; }
#innerPayment { margin:14px 0 0 14px; width:220px; height:270px; }
#recommendation { width:1300px; height:200px; position:relative; margin-top:50px; }
#totalPrice { color:red; font-weight:bold; }
#point { color:#f28124; }
#orderBtn { color:white; background-color:black; border:1px black solid; }
#recPdt { float:left; }
#inRecPdt { border:2px solid black; } #inRecPdt2 { border-top:2px solid black; border-bottom:2px solid black; }
#inRecPdt3 { border:2px solid black; } #inRecPdt4 { border-top:2px solid black; border-bottom:2px solid black; border-right:2px solid black; }
#recTxt { margin:30px 0 0 100px; } #recTxt2 { margin:30px 0 0 115px; } #recTxt3 { margin:30px 0 0 75px; } #recTxt4 { margin:30px 0 0 20px; }
#cataBox { text-align:center; }
#cata { font-weight:bold; text-decoration:underline; font-size:13px; }
#pdtList { border-bottom:1px solid black; height:80px; }
#delBtn { background-color:white; border:1px solid gray; }
#shopBtn { background-color:white; border:1px solid black; }
#sel { border:1px solid #c7bfbf; height:25px; }
</style>
<script>
function selectAll(all) {
	var chk = document.frm.ocNums;
	
	if (chk.length >= 2) { // 장바구니 안에 여러개가 있을 경우
		for (i = 0; i < chk.length; i++) {
			chk[i].checked = all.checked;
		}
	} else { // 장바구니 안에 1개만 있을 경우
		chk.checked = all.checked;
	}
}

function delCart(ocNum) {
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href = "cartDel.ord?ocNum=" + ocNum;
	}
}

function chOpt(cmb, ocNum) {
	var kind = cmb.name;	// 함수를 호출한 옵션의 종류(size, color, amount)
	var val = cmb.value;
	location.href = "cartUp.ord?kind=" + kind + "&val=" + val + "&ocNum=" + ocNum;
}

function allDel() {
	var isChecked = false;
	var cmb = document.frm.ocNums;
	// 콤보박스들 중에서 하나라도 체크되어 있는 지 여부를 검사하는 for문
	// 동일한 이름을 가진 컨트롤이 2개 이상이면 배열로, 하나 이하면 그냥
	
	if (cmb.length != null) {
// 장바구니 안에 2개 이상 있으면 여러 개로 뜸(선택 한 것 말고 전체)
		for (var i = 0; i < cmb.length; i++) {
			if (cmb[i].checked) {
				isChecked = true;
				break;
			}
		}
	} else {
		if (cmb.checked) {
			isChecked = true;
		}
	}

	if (isChecked) {	// 하나라도 체크되어 있으면
		if (confirm("선택한 상품들을 삭제하시겠습니까?")) {
			var frm = document.frm;
			frm.action =  "cartDel.ord";
			frm.submit();
		}
	} else {
		alert("삭제할 상품을 하나 이상 선택하세요.");
	}
}

function directBuy() {
	var frm = document.frm;
	frm.action = "form.ord?kind=c";
	frm.submit();
}
</script>
<script src="main.js"></script>
</head>
<body>
<%@ include file="../mainsideTab.jsp" %>
<div id="formBox">

<!-- 상태바 -->
<div id="status">
	<h1 id="">장바구니&nbsp;&nbsp;&nbsp;<span id="subStatus"> > 
	&nbsp;&nbsp;&nbsp;주문결제&nbsp;&nbsp;&nbsp; > 
	&nbsp;&nbsp;&nbsp;주문완료</span></h1>
</div>

	<form name="frm" action="form.ord" method="post" id="loginfrm">
	<input type="hidden" name="isMulti" value="y" />
	<input type="hidden" name="kind" value="c" />
	<br />
	<hr width="1200" color="black">
	<br />
	
	<!-- 테이블1 생성 -->	
	<table width="1200" cellspacing="0" cellpadding="0">
	<input type="button" value="선택 상품 삭제" id="delBtn" onclick="allDel();" style="cursor:pointer; width:120px; height:30px;" />
		<tr class="underline"><br />
		<th width="5%"><input type="checkbox" name="all" onclick="selectAll(this);" checked="checked" style="cursor:pointer;" /></th>
		<th width="35%" height="50">상품</th>
		<th width="10%">수량</th>
		<th width="15%">할인/혜택</th>
		<th width="10%">배송정보</th>
		<th width="15%">주문금액</th>
		<th width="10%">삭제</th>
		</tr>
<%
if (cartList.size() == 0) {	// 장바구니에 담긴 상품이 하나도 없을 경우 => cartList가 null인데 null.size() == 0인지 비교하려고 해서 nullpoint 에러뜸
	out.println("<tr><th colspan=\"7\"><br /><br />장바구니에 상품이 없습니다.</th></tr></table><br />");
	out.println("<div id='cataBox'><a href='list.product?kind=c&csid=cs01' id='cata'>MEN</a>&nbsp;&nbsp;");
	out.println("<a href='list.product?kind=c&csid=cs04' id='cata'>WOMEN</a>&nbsp;&nbsp;");
	out.println("<a href='list.product?kind=d&csid=cs07' id='cata'>CODI</a></div>");
} else {		// 장바구니에 상품이 있을 경우
	int totalPrice = 0;
	int choiceDiscount = 0;
	for (int i = 0 ; i < cartList.size() ; i++) {
		CartInfo cart = cartList.get(i);	// 하나씩 루프로 받아오는것
		int ocNum = cart.getOc_num();
		totalPrice += cart.getPl_price() * cart.getOc_amount();
		choiceDiscount = cart.getMl_point();
%>
	<tr align="center">
	<td id="pdtList"><input type="checkbox" name="ocNums" value="<%=ocNum %>" checked="checked" /></td>
	<td align="left">
	
	<!-- 테이블2 생성 -->
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
		<td rowspan="2" align="center" width="30%" id="pdtList">
			<a href="view.product?cpage=1&kind=c&csid=<%=cart.getCs_id() %>&plid=<%=cart.getPl_id() %>">
			<img src="pdt-img/<%=cart.getCs_id() %>/<%=cart.getPl_img1() %>" width="150" height="180" 
			style="border-left:1px solid black; border-right:1px solid black;" /></a>
		</td>
		<td width="*">&nbsp;&nbsp;<h5>&nbsp;&nbsp;<a href="view.product?cpage=1&kind=c&csid=<%=cart.getCs_id() %>&plid=<%=cart.getPl_id() %>">
		<%=cart.getPl_name() %></a></h5></td>
		</tr>
		<tr><td id="pdtList">
<%
		out.println("&nbsp;&nbsp; <span onclick='option(this);' style='cursor:pointer;'>색상 </span>");
		if (cart.getPl_optcolor() == null || cart.getPl_optcolor().equals("")) {
			out.println("없음");
		} else {
			String[] arrColor = cart.getPl_optcolor().split(",");
			out.println("<select name=\"optcolor\" id='sel' onchange=\"chOpt(this, "+ocNum+");\">");
			for (int j = 0 ; j < arrColor.length ; j++) {
				String slt = "";
				if (arrColor[j].equals(cart.getOc_optcolor())) {
					slt = " selected=\"selected\"";
				}
				out.println("<option" + slt + ">" + arrColor[j] + "</option>");
			}
			out.println("</select><br />");
		}

		out.println("&nbsp;&nbsp;<a href='ord/optionPopup.jsp'>사이즈 </a>");
		if (cart.getPl_optsize() == null || cart.getPl_optsize().equals("")) {
			out.println("없음");
		} else {
			String[] arrSize = cart.getPl_optsize().split(",");
			out.println("<select name=\"optsize\" id='sel' onchange=\"chOpt(this, "+ocNum+");\">");
			for (int j = 0 ; j < arrSize.length ; j++) {
				String slt = "";
				if (arrSize[j].equals(cart.getOc_optsize())) {
					slt = " selected=\"selected\"";
				}
				out.println("<option" + slt + ">" + arrSize[j] + "</option>");
			}
			out.println("</select>");
		}
%>
		</td>
		</tr>
	</table>
	<!-- 테이블2 종료 -->
	</td>
	<td id="pdtList">
		<select name="amount" id='sel' onchange="chOpt(this, <%=ocNum %>);">
<%
		for (int j = 1 ; j <= 10 ; j ++) {
			String slt = "";
			if(cart.getOc_amount() == j)	slt = " selected=\"selected\"";
			out.println("<option" + slt + ">" + j + "</option>");
		}
%>
		</select>
	</td>
	<td id="pdtList">- <%=cart.getMl_point() %><span id="point"> P</span></td>
	<td id="pdtList">무료</td>
	<td id="pdtList">
		<%=cart.getPl_price() * cart.getOc_amount() %>원
	</td>
	<td id="pdtList"><input type="button" value="삭제" onclick="delCart(<%=ocNum %>);" style="cursor:pointer;" /></td>
	</tr>
<%
	} // for (int i = 0 ; i < cartList.size() ; i++)의 종료
%>
	</table><br /><br /><br />
	<!-- 테이블1 종료 -->
	
	<!-- 테이블3 생성 -->
	<table width="1200" id="clause" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15%">
				<!-- <input type="submit" value="선택한 상품 구매" /> 	오른쪽 결제정보창의 주문하기 버튼으로 대체 --> 
				<input type="button" id="delBtn" value="선택 상품 삭제" onclick="allDel();" style="cursor:pointer; width:120px; height:30px;" />
			</td>
			<td width="80%">
			<span id="clauseInfo"> 
			- 장바구니 저장기간은 로그인 시 최대 90일입니다.<br />
			- 매장 배송상품은 일반배송상품과 다른 송장번호로 발송됩니다.<br />
			- 매장배송/매장주문 상품인 경우 주말에 고객센터를 통한 취소/반품/교환에 대한 클레임 처리가 불가능합니다. (고객센터 영업시간 : 월~금 0AM~0PM)<br />
			- 매장배송의 경우 배송준비중 이후 반품을 통한 환불처리만 가능합니다.<br />
			- 결제완료 이후 품절이 발생한 경우, 영업일 4일 이내 고객님께 별도로 안내를 드립니다.<br />
			- 품절 안내 이후 결제하신 금액은 자동취소 처리해 드리며, 재결제가 필요한 경우 추가로 안내 드립니다.</span>
			</td>
		</tr>
	</table><br /><br />
	<!-- 테이블3 종료 -->
		<div id="shop">
			<input type="button" value="쇼핑 계속하기" id="shopBtn" onclick="location.href='main.jsp'" style="height:50px; width:220px; cursor:pointer;" />
		</div><br /><br /><br />

	
	<!-- 결제정보 창 -->
	<div id="payment">
		<div id="innerPayment">
		<h2>결제정보</h2>
		<hr align="center" width="220" color="black">
		선택상품금액 : <%=totalPrice %>원<br />
		배송비 : 무료<br />
		선택할인금액 : -<%=choiceDiscount %>원<br />
		총 주문금액 : <span id="totalPrice"><%=totalPrice - choiceDiscount %></span>원<br />
		<hr align="center" width="220" color="black">
		적립예상 포인트 : (admin)<br /><br />
		<input type="submit" value="주문 하기" style="width:220px; height:40px; cursor:pointer;" id="orderBtn" onclick="directBuy();" />
		</div>
	</div>
<%
} // if (cartList.size() == 0) else의 종료
%>
	<div id="recommendation">
		<h2>추천상품</h2><br />
		<div id="recPdt">
			<a href="list.product?kind=c&csid=cs03"><img src="pdt-img/cs03/pdt10010-1.jpg" id="inRecPdt" width="298px;" height="400px;"></a><br />
			<div id="recTxt">소프트 가디건<br />&nbsp;&nbsp;&nbsp;&nbsp;22,000원</div>
		</div>
		<div id="recPdt">
			<a href="list.product?kind=c&csid=cs03"><img src="pdt-img/cs03/pdt10005-1.jpg" id="inRecPdt2" width="298px;" height="400px;"></a>
			<div id="recTxt2">코치자켓<br />50,000원</div>
		</div>
		<div id="recPdt">
			<a href="list.product?kind=c&csid=cs04"><img src="pdt-img/cs04/pdt10006-1.jpg" id="inRecPdt3" width="298px;" height="400px;"></a>
			<div id="recTxt3">페탈꽃자수 트임박시티<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;37,000원</div>
		</div>
		<div id="recPdt">
			<a href="list.product?kind=c&csid=cs04"><img src="pdt-img/cs04/pdt10020-1.jpg" id="inRecPdt4" width="298px;" height="400px;"></a>
			<div id="recTxt4">꽃촘촘프릴핏 앤틱네모단추블라우스<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;39,000원</div>
		</div>
	</div><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

</form>

</div>
</body>
</html>
<%@ include file="../footer.jsp" %>