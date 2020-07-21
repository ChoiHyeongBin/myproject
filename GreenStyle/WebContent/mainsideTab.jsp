<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
request.setCharacterEncoding("utf-8");
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
	#topName { position:absolute; top:0; left:50%;} 
	ul { padding-left: 0; }
	ul li { list-style-type: none; }
	li { width:200px;}
	a { color:inherit; text-decoration:none; text-align:center; }
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
	.search { background: url( "img/search.png" ) no-repeat; background-color:rgba(200,200,200,0); 
	border: none; width: 32px; height: 32px; cursor: pointer; }
</style>
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/main.js"></script>
<script>
function logout() {
	alert("정상적으로 로그아웃 되었습니다.");
}
</script>
</head>
<body>
<form action="list.product" method="get">
<input type="hidden" name="kind" value="s" />
<h1 id="topName">Green Style</h1>
<!-- 사이드탭메뉴 시작 -->
<div class="page-left">
		<nav class="left-tab">
			<ul>
				<li class="list"><a href="main"><h3>HOME<h3></a></li>
				<li class="list"><h3 id="man">MAN</h3></li>
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
						<input type="submit" value=" " class="search" />
					</div>		
				</li>
			</ul>
		</nav>
</div>
<div class="page-right">
	<div class="right-tab">
		<ul>
			<li class="list"><h3 id="member">회원</h3></li>
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
			<li class="list"><a href="cart.ord" id="cart" onclick="memChk()" ><h3>장바구니</h3></a></li>
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
</form>
</body>
</html>