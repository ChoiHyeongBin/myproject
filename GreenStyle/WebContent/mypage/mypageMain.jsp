<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../mainsideTab.jsp" %>
<%
memberInfo = (MemberInfo)session.getAttribute("memberInfo");

ArrayList<OrdInfo> ordList = (ArrayList<OrdInfo>)request.getAttribute("ordList");
ArrayList<MemberCouponInfo> couponList = (ArrayList<MemberCouponInfo>)request.getAttribute("couponList");
ArrayList<QnaInfo> qnaList = (ArrayList<QnaInfo>)request.getAttribute("qnaList");
ArrayList<ReviewInfo> reviewList = (ArrayList<ReviewInfo>)request.getAttribute("reviewList");

String lnk = "";


if (memberInfo == null) {
   out.println("<script>");
   out.println("alert('로그인 후 사용하실 수 있습니다.');");
   out.println("history.back();");
   out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지 메인 페이지</title>
<style>
#mainBox { position:relative; top:50px; margin-left:300px; padding-left:50px; padding-right:50px; width:1300px; }
#imgWrap { margin-left:300px;}
.imgBox { margin-top:10px; float:left; width:300px; height:100px; border:1px solid black; text-align:center; background-color:#f8f8f8; }
.btn { width:100px; height:28px; background-color:black; color:white;}
#upperLine { border-top:1px solid black; border-collapse: collapse; }
.upperLine { border-top:1px solid black; border-collapse: collapse; }
#upperLine th, td { height:40px; padding:5px; }
.underLine { border-bottom:1px solid black; }
.underLine2 { border-bottom:1px solid #e2e2e2; }
#upDel { background-color:rgba(200,200,200,0); position:fixed; right:0; top:30px; width:200px; min-height:70px; z-index:1; text-align:center;
		font-family:"Ropa Sans", sans-serif; font-size: 16px; line-height: 1.5;
	}
#upDelcata { font-size: 12px; }
</style>
</head>
<body>
<div id="mainBox">
<h2>마이페이지</h2>
<%if (memberInfo != null) { %>
					<div id="upDel">
					<ul>
						<li><strong id="mypage"><a href="view.mypage" >MY PAGE</a></strong></li>
							<div id="upDelcata">
							<ul>
								<li><a href="member/memberForm.jsp">회원정보수정</a></li>
								<li><a href="member/withdrawal.jsp">회원탈퇴</a></li>
							</ul>
							</div>
							</ul>
					</div>
<%} %>
<br />
<a href="main"><font color="gray">home</font></a> > <font color="black">마이페이지</font> 
<hr size="5px" color="black">
<br />
	<div id="imgWrap">
	<a href="point.mypage"><div class="imgBox">Point<br /><%=memberInfo.getMl_point() %> point</div></a>
	<a href="coupon.mypage"><div class="imgBox">Coupon<br /><% if (couponList == null) { %> <%=0 %> <% } else { %> <%=couponList.size() %> <% } %>장</div></a>
	</div>
<br /><br /><br/><br /><br /><br/><br />
	
<div id="ordBox">
<h2>주문내역</h2>
<br />
<table width="1300" align="center" id="upperLine">
<%
if (ordList != null && ordList.size() > 0) {
	int length = 0;
	
	if (ordList.size() > 10) { 
		length = 10; 
	} else { 
		length = ordList.size(); 
	}
	
	for (int i = 0; i < length; i++) {
		OrdInfo ord = ordList.get(i);
		lnk = "view.ord?cpage=1&num=" + ord.getOl_num();
%>
	<tr align="left">
	<td colspan="5" class="underLine">주문 번호 : <%=ord.getOl_id() %><br />
		<table width="100%" class="upperLine">
<%
	for (int j = 0; j < ord.getOrdPdtList().size(); j++) {
			OrdDetailInfo odi = ord.getOrdPdtList().get(j);
%>
			<tr align="center">
			<td width="3%" class="underLine2"></td> 
			<td width="17%" class="underLine2" align="left">상품명 : <br/><%=odi.getPl_name() %></td>
			<td width="20%" class="underLine2"><a href="view.product?kind=c&csid=<%=ord.getCs_id() %>&plid=<%=odi.getPl_id() %>">
			<input type="image" src="pdt-img/<%=ord.getCs_id() %>/<%=odi.getPl_img1() %>" width="150" height="150"/></a></td>
			<td width="*" class="underLine2" align="left">
			가격 : <%=odi.getOd_price() %>원 * <%=odi.getOd_amount() %>개 = <%=(odi.getOd_price() * odi.getOd_amount()) %>원 <br />
			색상 : <%=odi.getOd_optcolor() %> / 사이즈 : <%=odi.getOd_optsize() %>
			</td>
			<td width="10%" class="underLine2">
			<input type="button" value="리뷰 작성" onclick="location.href='in.review?getnum=<%=i %>&csid=<%=ord.getCs_id()%>&inner=<%=j %>'">
			</td>
			</tr>
<% 
	}
%>
		</table>
	</tr>
<%
	}
} else {	
	out.println("<tr height='50'><th colspan='5'>주문 내역이 없습니다.</th></tr>");
}
%>
</table>
</div>
<br />
<div id="QnaBox">
<h2>1:1 고객상담</h2>
<input type="button" class="btn" style="float:right; margin-top:-30px;" value="전체보기" onclick="location.href='qna.mypage'"/>
<br />
<table width="1300" align="center" id="upperLine">
	<tr>
	<th class="underLine" width="3%" ></th> 
	<th class="underLine" width="10%">번호</th>
	<th class="underLine" width="10%">분류</th>
	<th class="underLine" width="*">제목</th>
	<th class="underLine" width="10%">작성일</th>
	<th class="underLine" width="15%">답변여부</th>
	</tr>
<%
if (qnaList != null && qnaList.size() > 0) {
	int length = 0;
	
	if (qnaList.size() > 10) { 
		length = 10; 
	} else { 
		length = qnaList.size(); 
	}

	if (qnaList.size() > 0) {	
		for (int i = 0; i < length; i++) {
			QnaInfo qna = qnaList.get(i);
			lnk = "<a href='view.qna?cpage=1&num=" + qna.getQl_num() + "'>";
			String title = qna.getQl_title();
			if (title.length() > 27)	title = title.substring(0, 27) + "...";
			
			String kind = qna.getQl_kind();
			if (kind.equals("a")) { 
				kind = "주문/결제";
			} else if (kind.equals("b")){
				kind = "회원 정보";
			} else if (kind.equals("c")){
				kind = "취소/반품";
			} else if (kind.equals("d")){
				kind = "배송";
			}
			String answer = qna.getQl_status();
			if (answer == null) {
				answer = "n";
			}
%>
	<tr align="center">
	<td class="underLine2"></td>
	<td class="underLine2"><%=qna.getQl_num() %></td>
	<td class="underLine2"><%=kind %></td>
	<td class="underLine2"><%=lnk + title + "<a>" %></td>
	<td class="underLine2"><%=qna.getQl_date() %></td>
	<td class="underLine2"><%=answer %></td>
	</tr>
<%
		}
	}
} else {	
	out.println("<tr height='50'><th colspan='5'>상담 내역이 없습니다.</th></tr>");
}
%>
</table>
</div>
<br />
<div id="ReviewBox">
<h2>리뷰</h2>
<input type="button" class="btn" style="float:right; margin-top:-30px;" value="전체보기" onclick="location.href='review.mypage'"/>
<br />
<table width="1300" align="center" id="upperLine">
	<tr>
	<th class="underLine" width="3%" ></th>
	<th class="underLine" width="10%">번호</th>
	<th class="underLine" width="10%">분류</th>
	<th class="underLine" width="*">내용</th>
	<th class="underLine" width="10%">작성일</th>
	<th class="underLine" width="15%">점수</th>
	</tr>
<%
if (reviewList != null && reviewList.size() > 0) {
	int length = 0;
	
	if (reviewList.size() > 10) { 
		length = 10; 
	} else { 
		length = reviewList.size(); 
	}

	if (reviewList.size() > 0) {	
		for (int i = 0; i < length; i++) {
			ReviewInfo review = reviewList.get(i);
			lnk = "<a href='view.review?cpage=1&num=" + review.getRl_num() + "'>";
			String content = review.getRl_content();
			if (content.length() > 27)	content = content.substring(0, 27) + "...";
			
			String kind = review.getRl_kind();
			if (kind.equals("a")) { 
				kind = "텍스트 리뷰";
			} else if (kind.equals("b")){
				kind = "포토 리뷰";
			}
%>
	<tr align="center">
	<td class="underLine2"></td>
	<td class="underLine2"><%=review.getRl_num() %></td>
	<td class="underLine2"><%=kind %></td>
	<td class="underLine2"><%=lnk + content + "<a>" %></td>
	<td class="underLine2"><%=review.getRl_date() %></td>
	<td class="underLine2"><%=review.getRl_score() %></td>
	</tr>
<%
		}
	}
} else {	
	out.println("<tr height='50'><th colspan='5'>리뷰 내역이 없습니다.</th></tr>");
}
%>
</table>
<br />
</div>
</div>
<br /><br /><br /><br /><br />
</body>
</html>
<%@ include file="../footer.jsp" %>