<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	/* 오른쪽 탭 시작 */
	html { font-family:"Ropa Sans", sans-serif; font-size: 16px; line-height: 1.5; }
	body { background-color:white; overflow-x:hidden; width:100%; height:100%; }
	h1, h2, p, ul, .right-tab h3 { margin: 0; }
	ul { padding-left: 0; }
	ul li { list-style-type: none; }
	li { width:200px;}
	a { color: inherit; text-decoration: none; text-align:center; }
	div { float:left; }

	/* right-tab */
	.page-right { background-color:rgba(200,200,200,0); position:fixed; top:100px; width:250px; height:300px; right:0px; z-index:1;}
	.page-right.sticky { position:fixed; top:100; }
	.right-tab { float:left; line-height:85px; letter-spacing:1px; text-transform:uppercase; }
	.right-tab a { display: block; padding: 0 1.36em; }
	.right-tab a:hover,  .right-tab h3:hover { background-color:black; color:white;}
	
	li.h3 { cursor:pointer; text-align:center; color:black; }
	#Search { width:200px; height:50px; }
	.Scata { font-size:12px; }
	#upDel { background-color:rgba(200,200,200,0); position:fixed; right:0; top:30px; width:200px; min-height:300px; z-index:1; text-align:center;
		font-family:"Ropa Sans", sans-serif; font-size: 16px; line-height: 1.5;
	}
	/* 오른쪽 탭 끝 */
</style>
</head>
<body>
<div class="page-right">
	<div class="right-tab">
		<ul>
			<li><a href="logout"><h3>LogOut</h3></a></li>
			<li><a href="view.adminMain"><h3>MAIN</h3></a></li>
			<li><a href="list.adminpdt"><h3>상품 관리</h3></a></li>
			<li><a href="list.ord2"><h3>주문/배송 관리</h3></a></li>
			<li><a href="memberList.mem"><h3>회원 관리</h3></a></li>
			<li><a href="list.adminNotice"><h3>게시판 관리</h3></a></li>
			<li><a href="view.stats"><h3>통계</h3></a></li>
		</ul>
	</div>
</div>
</body>
</html>