<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
ArrayList<PdtInfo> pdtList = (ArrayList<PdtInfo>)request.getAttribute("pdtList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
//페이징 관련 데이터들을 담은 인스턴스 생성
int rcount = pageInfo.getRcount();
int cpage = pageInfo.getCpage(); 	// 현재 페이지
int mpage = pageInfo.getMpage(); 	// 최대 페이지 개수
int spage = pageInfo.getSpage(); 	// 시작 페이지
int epage = pageInfo.getEpage();	// 마지막 페이지
String csName = null;
String csId = request.getParameter("csid");
String cond = (String)request.getAttribute("condition");
for(int i=0; i<pdtList.size(); i++) {
	PdtInfo pdt = pdtList.get(i); 
	if(csId.equals(pdt.getCs_id())){
		csName = pdtList.get(i).getCs_name();
		break;
	}
}
if (csName == null) { csName = ""; }
//상품 목록을 ArrayList에 담음(제네릭도 포함해서 작업해야 함)
String args = "&kind=c&csid=" + request.getParameter("csid");
if (cond == "") { 
	cond = "";
} else {
	args += "&cond=" + cond;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
html { font-family:"Ropa Sans", sans-serif; font-size: 16px; line-height: 1.5; }
body { background-color:white; overflow-x:hidden; width:100%; height:100%; }
#title-name { position:relative; left:900px; top:100px; }
#list-table { position:relative; top:200px; }
#underLine { position:relative; top:150px; } 
ul { padding-left: 0; }
ul li { list-style-type: none; } 
.condition { float:left; text-align:center; width:100px; }

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
	.pdtimages { overflow:hidden; position:relative; width:400px; height:500px; border:1px solid black;}
	.pdtimages img { display:none; position:absolute; left:50%; margin-left:-200px; }
</style>
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="main.js"></script>
<script>
$(function() {	// 상품이미지 캡션
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

$(function() {	// 상품이미지 변화
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
</head>
<body>
<%@ include file="../mainsideTab.jsp" %>
<h2 id="title-name"><%=csName %> 상품목록</h2>
<hr color="black" width="70%" size="4" id="underLine" align="center" />
<table width="70%" id="list-table" align="center">
<tr><td>
<ul float="left" >
<li class="condition"><a href="list.product?kind=c&csid=<%=csId %>&cond=b">인기상품 순</a></li>
<li class="condition"><a href="list.product?kind=c&csid=<%=csId %>&cond=l">낮은가격 순</a></li>
<li class="condition"><a href="list.product?kind=c&csid=<%=csId %>&cond=h">높은가격 순</a></li>
</ul></td>
</tr>
<tr align="center" >
<% 
if (pdtList != null) {
	int j = 0;
	int num = rcount - (cpage - 1) * 10;
	String lnk = "";
	if (pdtList.size() > 0) {	// 보여줄 상품목록이 있으면
		for (int i = 0 ; i < pdtList.size() ; i++) {
			PdtInfo pdt = pdtList.get(i);
			if (j % 3 == 0) out.println("<tr align=\"center\">");
			lnk = "<a href=\"view.product?cpage=" + cpage + args + "&plid=" + pdt.getPl_id() + "\">";
	%>
	<td width="33%" > <!-- 상품하나당 사이즈 -->
		<div class="pdtimages"><p><%=lnk %>
		<img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img1() %>" width="400" height="500" />
		<img src="pdt-img/<%=pdt.getCs_id() %>/<%=pdt.getPl_img2() %>" width="400" height="500" />
		<strong>사이즈 : <%=pdt.getPl_optsize() %><br /> 색상 : <%=pdt.getPl_optcolor() %></strong><span></span></p></a>
		</div>
		<br /><%=pdt.getPl_name() %></a><br /><%=pdt.getPl_price() %>원<br /><br /><br /><br />
		</div>
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
%>
</tr>
<tr align="center"><td colspan="3">
<%
lnk = "";

//처음 페이지 이동 버튼
if (cpage == 1) {
	out.println(" << &nbsp;&nbsp;");
} else {
	lnk = "<a href='list.product?cpage=1" + args + "'>";
	out.println(lnk + " << </a>&nbsp;&nbsp;");
}

//이전 페이지 이동 버튼
if (cpage == 1) {
	out.println(" < ");
} else {
	lnk = "<a href='list.product?cpage=" + (cpage - 1) + args + "'>";
	out.println(lnk + " < </a>");
}

for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='list.product?cpage=" + i + args + "'>";
	if(i == cpage) {
		out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
	} else {
		out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
	}
}

//다음 페이지 이동 버튼
if (cpage == mpage) {
	out.println(" > ");
} else {
	lnk = "<a href='list.product?cpage=" + (cpage + 1) + args + "'>";
	out.println(lnk + "> </a>");
}

//마지막 페이지 이동 버튼
if (cpage == mpage) {
	out.println("&nbsp;&nbsp; >> ");
} else {
	lnk = "<a href='list.product?cpage=" + mpage + args + "'>";
	out.println("&nbsp;&nbsp;" + lnk + ">> </a>");
}
}
%>
</td></tr>
</table>
<br /><br /><br /><br /><br /><br /><br /><br />
</body>
</html>
<%@ include file="../footer.jsp" %>