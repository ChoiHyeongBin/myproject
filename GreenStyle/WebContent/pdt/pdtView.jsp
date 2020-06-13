<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<% 

request.setCharacterEncoding("utf-8");
MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
//로그인된 회원정보를 MemberInfo형 인스턴스로 받아옴

PdtInfo pdt = (PdtInfo)request.getAttribute("pdtInfo");
// 보여줄 상품 정보를 PdtInfo형 인스턴스로 형변환 후 받아옴
String plid = pdt.getPl_id();
String kind = request.getParameter("kind");
String args = "?plid=" + plid + "&kind=" + kind;
if (kind.equals("c"))	args += "&csid=" + request.getParameter("csid");
else if (kind.equals("m"))	args += "&csid=" + request.getParameter("csid");
else 					args += "&keyword=" + request.getParameter("keyword");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
html { font-family:"Ropa Sans", sans-serif; font-size: 16px; line-height: 1.5; }
body { background-color:white; overflow-x:hidden; width:100%; height:100%; }
#view-table1 { position:relative; top:100px; }
#view-table2 { position:relative; top:400px; }
#addCart { padding: 30px 45px 30px 45px; margin-bottom:10px; background-color:black; color:white; display:block; }
#but { padding: 30px 48px 30px 45px; background-color:black; color:white; display:block; }
#explanation { position:absolute; left:300px; top:900px;  }
#under { position:absolute; width:70%; height:2px; top:950px; left:250px; }

/* 코디 상품 이미지 */
.pdtimages { overflow:hidden; position:relative; width:500px; height:700px; }
.pdtimages img { display:none; position:absolute; left:50%; margin-left:-250px; }

/* 상품 품절 */
#nopdtCnt { display:none; padding: 30px 48px 30px 45px; background-color:black; color:white;}

</style>
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script>
function directBuy() {
	var frm = document.frm;
	var cCata = document.frm.optcolor.value;
	var sCata = document.frm.optsize.value;
	if (sCata == "") { //색상를 선택하지 않았을 경우
		alert("사이즈을 선택하세요");
		frm.sCata.focus(); return false;
	} 
	if (cCata == "") { //사이즈를 선택하지 않았을 경우
		alert("컬러를 선택하세요");
		frm.cCata.focus(); return false;
	}
}

function chkValue() {
	var frm = document.frm;
	var cCata = frm.optcolor.value;
	var sCata = frm.optsize.value;
	if (sCata == "") { //색상를 선택하지 않았을 경우
		alert("사이즈을 선택하세요");
		frm.sCata.focus(); return false;
	} 
	if (cCata == "") { //사이즈를 선택하지 않았을 경우
		alert("컬러를 선택하세요");
		frm.cCata.focus(); return false;
	}
	frm.onsubmit = "return true";
}

$(function() {
	$(".pdtimages").each(function(){
	// 클래스가 'pdtimages'인 객체내의 요소들을 하나씩 접근하여 작업
		var $slides = $(this).find("img");//클래스가 'pdtimages'인 객체내의 요소들중 img요소들을 $slides에 담음
		var slideCount = $slides.length;//슬라이드에서 보여줄 img태그의 개수를 저장
		var currentIndex = 0;//현재보여줄 슬라이드의 인덱스번호를 저장

		$slides.eq(currentIndex).fadeIn();
		//eq() : 인덱스를 선택하게 해주는 함수
		//currentIndex라는 인덱스 번호를 eq()함수를 통해 $slides에 전달
		
		setInterval(showNextSlide, 2000);
		//1초마다 showNextSlide()함수를 호출
		//setInterval(명령, 시간) : window객체의 함수로 window를 생략해도 됨
		//주어진 시간마다 명령을 시행하게 하는 함수

		function showNextSlide() {//다음슬라이드를 보여주는 함수
			var nextIndex = (currentIndex + 1) % slideCount;
			//다음에 보여줄 슬라이드의 인덱스번호를 생성
			//단, 마지막슬라이드인 경우 다음에는 처음 슬라이드로 가야 함

			$slides.eq(currentIndex).fadeOut();
			//현재 슬라이드를 fadeOut()으로 사라지게함
			$slides.eq(nextIndex).fadeIn();
			//다음 슬라이드를 fadeIn()으로 나타나게 함
			currentIndex = nextIndex;
			//현재슬라이드 번호를 다음슬라이드번호로 변경함
		}
	});
});

</script>
<script src="main.js"></script>
</head>
<body>
<%@ include file="../mainsideTab.jsp" %>
<%
System.out.println(pdt.getPl_issell());
System.out.println(pdt.getPl_stock()); 
%>
<form name="frm" action="cartIn.ord<%=args %>" method="post" onsubmit="return false" >
<input type="hidden" name="plid" value="<%=pdt.getPl_id() %>" />
<table width="70%" id="view-table1" align="center">
<tr>
<td align="right" width="50%" rowspan="8">
	<div class="pdtimages">
	<img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img1() %>" width="500" height="700" />
	<img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img2() %>" width="500" height="700" />
	</div>
</td>
</tr>
<tr align="center">
<td width="*">상품명 : <%=pdt.getPl_name() %></td>
</tr>
<tr align="center"><td>가격 : <%=pdt.getPl_price() %></td></tr>
<tr align="center"><td width="*">옵션(SIZE) :
<%
if (pdt.getPl_optsize() == null || pdt.getPl_optsize().equals("")) {
// 옵션중 size옵션이 없을경우
	out.println("SIZE 옵션 없음");
} else {
	String[] optsize = pdt.getPl_optsize().split(",");
	out.println("<select name=\"optsize\">");
	out.println("<option value=\"\">옵션 선택</option>");
	for (int i = 0; i < optsize.length ; i++) {
		out.println("<option>" + optsize[i] + "</option>");
	}
	out.println("</select>");
}
%>
</td></tr>
<tr align="center"><td>옵션(COLOR) :
<%
if (pdt.getPl_optcolor() == null || pdt.getPl_optsize().equals("")) {
// 옵션중 color옵션이 없을경우
	out.println("color 옵션 없음");
} else {
	String[] optcolor = pdt.getPl_optcolor().split(",");
	out.println("<select name=\"optcolor\">");
	out.println("<option value=\"\">옵션 선택</option>");
	for (int i = 0; i < optcolor.length ; i++) {
		out.println("<option>" + optcolor[i] + "</option>");
	}
	out.println("</select>");
}
%>
</td></tr>
<tr align="center"><td>수 량 : 
	<select id="amount" name="amount" onchange="total()">
<% for (int i = 1 ; i <= 10 ; i++) { %>
		<option value="<%=i %>"><%=i %> EA</option>
<%} %>
	</select>
</td></tr>
<tr><td align="center">
<script>
function memCart() {
	var addCart = document.getElementById("addCart");
<%if(memberInfo == null) { %>
	alert("로그인 후 사용가능합니다.");
	frm.action = "member/loginForm.jsp";
<% }%>
}
</script>
<%if (pdt.getPl_issell().equals("n") || pdt.getPl_stock() == 0) {
%>
<style>
#nopdtCnt { display:block; }
#addCart { display:none; }
#but { display:none; }
</style>
<%} %>
	<input type="button" value="상품 준비중" id="nopdtCnt" />
	<input type="submit" value="Add to Cart" id="addCart" onclick="chkValue(), memCart()"/><br />
	<input type="button" value="BUY NOW" onclick="directBuy(), subchk()" id="but" />
<%
if (mem == null) { 

%>
<script>
function subchk() {
	var frm = document.frm;
	frm.action = "form.nologord";
	frm.submit();
}
</script>
<%} else {%>
<script>
function subchk() {
	var frm = document.frm;
	frm.action = "form.ord?kind=d";
	frm.submit();
}
</script>
<%}%>
</td></tr>
</table>
<h2 id="explanation">상품 설명</h2>
<hr id="under" color="black" />
<table width="70%" id="view-table2" align="center">
<tr><td align="center"><img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img1() %>" width="900px" height="1300px"  /></td></tr>
<tr><td align="center"><img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img2() %>" width="900px" height="1300px"  /></td></tr>
<tr><td align="center"><img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img3() %>" width="900px" height="1300px"  /></td></tr>
<tr><td align="center"><img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img4() %>" width="900px" height="1300px"  /></td></tr>
<tr><td align="center"><img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img5() %>" width="900px" height="1300px"  /></td></tr>
</table>
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</form>
</body>
</html>
<%@ include file="../footer.jsp" %>