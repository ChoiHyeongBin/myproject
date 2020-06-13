<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");

request.setCharacterEncoding("utf-8");
ArrayList<PdtInfo> pdtList = (ArrayList<PdtInfo>)request.getAttribute("pdtList");
String args = "?kind=m&csid=" + request.getParameter("csid");
//상품 목록을 ArrayList에 담음(제네릭도 포함해서 작업해야 함)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Green Style</title>
<style>
	html { font-family:"Ropa Sans", sans-serif; font-size: 16px; line-height: 1.5; }
	body { background-color:white; overflow-x:hidden; width:100%; height:100%; }
	h1, h2, h3, p, ul { margin: 0; }
	#topName { position:relative; top:0; left:830px;} 
	ul { padding-left: 0; }
	ul li { list-style-type: none; }
	li { width:200px;}
	a { color: inherit; text-decoration: none; text-align:center; }
	img { vertical-align:middle; } 
	 /* left-tab */
	.page-left { background-color:rgba(200,200,200,0); position:fixed; top:0px; width:200px; min-height:300px; z-index:1;}
	.page-left.sticky { position:fixed; top:0; }

	.left-tab { float:left; line-height:65px; letter-spacing:1px; text-transform:uppercase; }
	.left-tab a { display: block; padding: 0 1.36em; }
	.left-tab a:hover,  .left-tab h3:hover { background-color:black; color:white; }
	
	/* right-tab */
	.page-right { background-color:rgba(200,200,200,0); position:fixed; top:100px; width:200px; height:300px; right:0px; z-index:1;}
	.page-right.sticky { position:fixed; top:100; }
	.right-tab { float:left; line-height:65px; letter-spacing:1px; text-transform:uppercase; }
	.right-tab a { display: block; padding: 0 1.36em; }
	.right-tab a:hover,  .right-tab h3:hover { background-color:black; color:white;}
	
	/* Scata */
	#manScata { width:200px; height:200px;  display:none; }
	#womanScata { width:200px; height:200px; display:none;  }
	#codiScata { width:200px; height:130px; display:none; }
	#memberScata { width:200px; height:200px; display:none; } 
	 
	h3 { cursor:pointer; text-align:center; color:black; }
	#Search { width:200px; height:50px; }
	.Scata { font-size:12px; }
	
	/* 슬라이드 스타일*/
	.slideshow { background:#fff; height:800px; width:100%; overflow:hidden; position:relative; top:50px;}
	.slideshow-slides { height:100%; position:relative; width:100%; }
	.slideshow-slides .slide { height:100%; overflow:hidden; position:absolute; width:100%; }
	.slideshow-slides .slide img { left:50%; margin-left:-50%; position:absolute; width:100%; height:100%; }
	/* 슬라이드 내비게이션 스타일 */
	.slideshow-nav a, .slideshow-indicator a { overflow:hidden; }
	.slideshow-nav a:before, .slideshow-indicator a:before {
		content:url("img/sprites.png"); display:inline-block; font-size:0; line-height:0;
	}
	.slideshow-nav a { position:absolute; top:50%; left:50%; width:72px; height:72px; margin-top:-36px; }
	.slideshow-nav a.prev { margin-left:-480px; }
	.slideshow-nav a.prev:before { margin-top:-20px; }
	.slideshow-nav a.next { margin-left:408px; }
	.slideshow-nav a.next:before { margin-top:-20px; margin-left:-80px; }
	.slideshow-nav a.disabled { display:none; }

	/* 인디케이터 스타일 */
	.slideshow-indicator { bottom:30px; height:16px; left:0; position:absolute; right:0; text-align:center;}
	.slideshow-indicator a { display:inline-block; width:16px; height:16px; margin-left:3px; margin-right:3px; }
	.slideshow-indicator a.active { cursor:default; }
	.slideshow-indicator a:before { margin-left:-110px; }
	.slideshow-indicator a.active:before { margin-left:-130px;}
	
	/* 상품테이블 스타일 */
	#new-arrival { position:relative; top:100px; left:330px; }
	#underLine { position:relative; top:130px; left:5px;}
	#main-table { position:relative; top:200px; }
	#img1 {position:absolute; top:1400px;}
	
	/* 상품이미지 캡션 */
	.pdtimages p { position:relative; width: 400px; height: 500px; margin: 0 auto 80px; overflow:hidden; }
	.pdtimages p strong {
		position:absolute; display:block; z-index:1; bottom:0; width:360px; height:50px;
		color: #fff; font-size: 20px; background:rgba(0, 0, 0, 0.5); text-align:left; padding:20px;
	}
	.pdtimages p span {
		position:absolute; display:block; z-index:0; top:0; width:400px; height:500px; opacity:0;
		inset 0 0 100px rgba(50, 30, 0, 0.3);
	}
	.pdtimages p:nth-child(1) strong { opacity:0; } /* 첫번째 이미지 캡션 숨기기 */

	/* 상품 이미지 */
	.pdtimages { overflow:hidden; position:relative; width:400px; height:500px; }
	.pdtimages img { display:none; position:absolute; left:50%; margin-left:-200px; }
	
	.search { background: url( "img/search.png" ) no-repeat; background-color:rgba(200,200,200,0); 
	border: none; width: 32px; height: 32px; cursor: pointer; }
</style>
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/main.js"></script>
<script>
$(function() {
	var duration = 300; //애니메이션이 동작할 시간
	var $images = $(".pdtimages p") // 애니메이션을 적용시킬 대상 이미지들
	//변수명에 '$'표식을 한 이유는 jQuery객체를 저장한 변수라는 의미로 사용한 것

	// 첫번째 이미지의 캡션 처리
	$images.filter(":nth-child(1)")
	.on("mouseover", function() {
		$(this).find("strong, span").stop(true).animate({ opacity:1 }, duration);
	})
	.on("mouseout", function() {
		$(this).find("strong, span").stop(true).animate({ opacity:0 }, duration);
	});
});

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

function logout() {
	alert("정상적으로 로그아웃 되었습니다.");
}

</script>
</head>
<body>
<h1 id="topName">Green Style</h1>
<form action="list.product" method="get" id="frm">
<input type="hidden" name="kind" value="s" />
<!-- 사이드탭메뉴 시작 -->
<div class="page-left">
		<nav class="left-tab">
			<ul>
				<li><a href="main"><h3>HOME<h3></a></li>
				<li><h3 id="man">MAN</h3></li>
					<div id="manScata" class="Scata">
						<ul>
							<li><a href="list.product?kind=c&csid=cs01">상의</a>
							<li><a href="list.product?kind=c&csid=cs02">하의</a>
							<li><a href="list.product?kind=c&csid=cs03">아우터</a>
						</ul>
					</div>
				<li><h3 id="woman">WOMAN</h3></li>
					<div id="womanScata" class="Scata">
						<ul>
							<li><a href="list.product?kind=c&csid=cs04">상의</a>
							<li><a href="list.product?kind=c&csid=cs05">하의</a>
							<li><a href="list.product?kind=c&csid=cs06">아우터</a>
						</ul>
					</div>
				<li><h3 id="codi">CODI</h3></li>
					<div id="codiScata" class="Scata">
						<ul>
							<li><a href="list.product?kind=d&csid=cs07">MAN</a>
							<li><a href="list.product?kind=d&csid=cs08">WOMAN</a>
						</ul>
					</div>
				<li>
					<div id="Search">
						<input type="text" size="15" name="keyword"/>
						<input type="submit" class="search" value=" " />
					</div>
				</li>
			</ul>
		</nav>
</div>
<div class="page-right">
	<div class="right-tab">
		<ul>
			<li><h3 id="member">회원</h3></li>
				<div id="memberScata" class="Scata">
<%if (memberInfo == null) { %>
					<a href="member/loginForm.jsp">로그인</a>
					<a href="member/joinClause.jsp">회원가입</a>
					<a href="" onclick="myPage();" id="my">마이페이지</a>
<script>
function myPage() {
var my = document.getElementById("my");
alert("로그인후 사용가능합니다.");
my.href="member/loginForm.jsp";
}
</script>
<%} else { %>
					<h4 align="center"><%=memberInfo.getMl_name() %>님 환영합니다.</h4>
					<a href="logout" onclick="logout()">로그아웃</a>
					<a href="view.mypage">마이페이지</a>
<%} %>
				</div>
			<li><a href="cart.ord" id="cart" onclick="memChk()"><h3>장바구니</h3></a></li>
<script>
function memChk() {
	var cart = document.getElementById("cart");
<%if(memberInfo == null) { %>
	alert("로그인 후 사용가능합니다.");
	cart.href="member/loginForm.jsp";
<% }%>
}
</script>
		</ul>
	</div>
</div>
<!-- 사이드탭메뉴 끝 -->

<!-- 메인 슬라이드 메뉴 시작  -->
<div class="slideshow">
	<div class="slideshow-slides">
		<a href="view.product?cpage=1&kind=c&csid=cs01&plid=10001" class="slide"><img src="img/mainSlide-1.jpg"/></a>
		<a href="view.product?cpage=1&kind=c&csid=cs03&plid=10019" class="slide"><img src="img/mainSlide-2.jpg"/></a>
		<a href="view.product?cpage=1&kind=c&csid=cs03&plid=10011" class="slide"><img src="img/mainSlide-3.jpg"/></a>
		<a href="view.product?cpage=1&kind=c&csid=cs01&plid=10008" class="slide"><img src="img/mainSlide-5.jpg"/></a>
	</div>
	<div class="slideshow-nav">
		<a href="" class="prev">Prev</a>
		<a href="" class="next">Next</a>
	</div>
	<div class="slideshow-indicator"></div>
</div>

<!-- 상품리스트 시작 -->
<h2 id="new-arrival">NEW ARRIVAL</h2>
<hr color="black" width="70%" size="4" id="underLine"/>
<table width="70%" id="main-table" align="center">
<tr align="center">
<% 
if (pdtList != null) {
	int j = 0;
	String lnk = "";
	if (pdtList.size() > 0) {	// 보여줄 상품목록이 있으면
		for (int i = 0 ; i < pdtList.size() ; i++) {
			PdtInfo pdt = pdtList.get(i);
			if (j % 3 == 0) out.println("<tr align=\"center\">");
			lnk = "<a href=\"view.product" + args + "&plid=" + pdt.getPl_id() + "\">";
			
	%>
	<td width="33%" > <!-- 상품하나당 사이즈 -->
		<div class="pdtimages"><p><%=lnk %>
		<img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img1() %>" width="400" height="500" />
		<img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img2() %>" width="400" height="500" />
		<strong>사이즈 : <%=pdt.getPl_optsize() %><br /> 색상 : <%=pdt.getPl_optcolor() %></strong><span></span></p></a>
		</div>
		<br /><%=pdt.getPl_name() %></a><br /><%=pdt.getPl_price() %>원<br /><br /><br /><br />
	</td>
	<%
			if (j % 3 == 2) out.println("</tr>");
			j++;
		}
		if (j % 3 != 0) {
			out.println("<td colspan=\"" + (j % 3) + "\"></td></tr>");
		}
	} else {	// 보여줄 상품이 없으면
		out.println("<tr height=\"50\"><th>상품을 준비중 입니다.</th></tr>");
	}
}
%>
</tr>
</table>
</form>
<br /><br /><br /><br /><br /><br /><br /><br />
<%@ include file="footer.jsp" %>
</body>
</html>