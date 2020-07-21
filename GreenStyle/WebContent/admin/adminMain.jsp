<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
ArrayList<OrdInfo> getOrdList = (ArrayList<OrdInfo>)request.getAttribute("getOrdList");
System.out.println("adminMain 폼의 getOrdList : " + getOrdList);

int aNum = 0, bNum = 0, cNum = 0, dNum = 0, eNum = 0, fNum = 0, gNum = 0, hNum = 0, iNum = 0, jNum = 0, kNum = 0, lNum = 0;

if (getOrdList.size() == 0) {
	out.println("<tr align='center'><td colspan='5'>주문내역이 없습니다.</td></tr>");
} else {
	for (int i = 0; i < getOrdList.size(); i++) {
		OrdInfo oi = getOrdList.get(i);
		if (oi.getOl_status().equals("a")) {
			aNum = aNum + 1;
		} else if (oi.getOl_status().equals("b")) {
			bNum = bNum + 1;
		} else if (oi.getOl_status().equals("c")) {
			cNum = cNum + 1;
		} else if (oi.getOl_status().equals("d")) {
			dNum = dNum + 1;
		} else if (oi.getOl_status().equals("e")) {
			eNum = eNum + 1;
		} else if (oi.getOl_status().equals("f")) {
			fNum = fNum + 1;
		} else if (oi.getOl_status().equals("g")) {
			gNum = gNum + 1;
		} else if (oi.getOl_status().equals("h")) {
			hNum = hNum + 1;
		} else if (oi.getOl_status().equals("i")) {
			iNum = iNum + 1;
		} else if (oi.getOl_status().equals("j")) {
			jNum = jNum + 1;
		} else if (oi.getOl_status().equals("k")) {
			kNum = kNum + 1;
		} else if (oi.getOl_status().equals("l")) {
			lNum = lNum + 1;
		}
	}
}
%>
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
	#total { width:1000px; left:150px; position:relative; top:150px;}
	#sale, #cancel, #notice, #qna { border:2px solid black;  width:450px; height:400px; position:relative; float:left;}
	#sale { left:280px; top:50px; }
	#cancel { left:350px; top:50px; }
	#notice { left:280px; top:100px; }
	#qna { left:350px; top:100px; }
	#notice a { text-align:left; }
	#sSale, #sCancel, #sNotice { 
	border:2px solid black; border-radius:20px; width:120px; height:120px; position:relative; left:12px; 
	margin-right:22px; margin-bottom:25px; margin-top:25px; text-align:center; 
	}
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
<div id="total">
	<div id="sale">
		<h2>&nbsp;&nbsp;&nbsp;판매현황</h2>
		<div id="sSale">
			<br />
			<h3><%=aNum %></h3>
			<h4>입금대기</h4>
		</div>
		<div id="sSale">
			<br />
			<h3><%=bNum %></h3>
			<h4>결제완료</h4>
		</div>
		<div id="sSale">
			<br />
			<h3><%=cNum %></h3>
			<h4>상품준비</h4>
		</div>
		<div id="sSale">
			<br />
			<h3><%=dNum %></h3>
			<h4>배송준비</h4>
		</div>
		<div id="sSale">
			<br />
			<h3><%=eNum %></h3>
			<h4>배송중</h4>
		</div>
		<div id="sSale">
			<br />
			<h3><%=fNum %></h3>
			<h4>배송완료</h4>
		</div>
	</div>
	<div id="cancel">
		<h2>&nbsp;&nbsp;&nbsp;취소/반품 현황</h2>
		<div id="sCancel">
			<br />
			<h3><%=gNum %></h3>
			<h4>교환주문</h4>
		</div>
		<div id="sCancel">
			<br />
			<h3><%=hNum %></h3>
			<h4>반품주문</h4>
		</div>
		<div id="sCancel">
			<br />
			<h3><%=iNum %></h3>
			<h4>환불주문</h4>
		</div>
		<div id="sCancel">
			<br />
			<h3><%=jNum %></h3>
			<h4>교환완료</h4>
		</div>
		<div id="sCancel">
			<br />
			<h3><%=kNum %></h3>
			<h4>반품완료</h4>
		</div>
		<div id="sCancel">
			<br />
			<h3><%=lNum %></h3>
			<h4>환불완료</h4>
		</div>
	</div>
</div>
</body>
</html>