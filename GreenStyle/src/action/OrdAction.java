package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class OrdAction implements Action {
	private String command;
	
	public OrdAction(String command) { this.command = command; }
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		String mlid = mem.getMl_id();
		
		String lnk = "";
		OrdService ordService = new OrdService();
		ActionForward forward = new ActionForward();
		
		int result = 1;
		if (command.equals("/cartIn.ord")) {		// 장바구니 추가이면
			lnk = "cart.ord";
			result = ordService.cartIn(request);
			forward.setRedirect(true);
			// dispatcher방식이 아닌  sendRedirect방식으로 이동하게 함
		
		} else if (command.equals("/cart.ord")) {	// 장바구니 화면이면
			lnk = "ord/cart.jsp";
			ArrayList<CartInfo> cartList = ordService.getCartList(mlid);
			request.setAttribute("cartList", cartList);
			
		} else if (command.equals("/cartDel.ord")) {// 장바구니 삭제이면
			lnk = "cart.ord";
			result = ordService.cartDel(request, mlid);
			forward.setRedirect(true);
			
		} else if (command.equals("/cartUp.ord")) {// 장바구니 변경이면
			lnk = "cart.ord";
			result = ordService.cartUp(request, mlid);
			forward.setRedirect(true);
			
		} else if (command.equals("/form.ord")) {	// 구매폼 화면이면
			System.out.println("OrdAction의 구매폼 화면");
			lnk = "/ord/ordForm.jsp";
			ArrayList<CartInfo> preOrdList = ordService.getPreOrdList(request, mlid);
			ArrayList<MemberCouponInfo> memberCoupon = ordService.getCouponList(request, mlid);
			request.setAttribute("preOrdList", preOrdList);
			request.setAttribute("memberCoupon", memberCoupon);
			// 구매할 상품(들)의 목록을 ArrayList형으로 받아 옴
			
		} else if (command.equals("/proc.ord")) {	// 구매처리 기능이면
			System.out.println("OrdAction의 구매처리 기능작동");
			lnk = "list.ord";
			result = ordService.ordProcess(request, mlid);
			forward.setRedirect(true);
			// dispatcher방식이 아닌 sendRedirect방식으로 이동하게 함
		
		} else if (command.equals("/list.ord")) {	// 구매목록 화면이면
			System.out.println("OrdAction의 구매목록 화면");
			System.out.println("proc다음에 여기로 왔음");
			lnk = "/ord/ordList.jsp";	
			int cpage = 1;	// 현재 페이지 번호를 저장할 변수
			int limit = 1;	// 한 페이지에서 보여줄 공지사항 개수, 페이지 크기
			if (request.getParameter("cpage") != null) {
			// 받아온 페이지 번호가 있으면 String에서 int형 데이터로 변형
				cpage = Integer.parseInt(request.getParameter("cpage"));
			}
			
			int rcount = ordService.getOrdListCount(mlid);
			// 특정 회원(mlid)이 구매한 목록의 레코드 개수를 저장
			ArrayList<OrdInfo> ordList = ordService.getOrdList(request, mlid, cpage, limit);
			// 특정 회원이(mlid) 구매한 목록을 OrdInfo형 인스턴스의 ArrayList로 저장
			
			int mpage = (int)((double)rcount / limit + 0.95);
			int spage = (((int)((double)cpage / 10 + 0.9)) - 1) * 10 + 1;
			int epage = spage + 10 - 1;	
			if (epage > mpage)	epage = mpage;
			
			PageInfo pageInfo = new PageInfo();
			pageInfo.setCpage(cpage);	// 현재 페이지 번호
			pageInfo.setEpage(epage);	// 종료 페이지 번호(블록별 종료 페이지)
			pageInfo.setMpage(mpage);	// 전체 페이지 수
			pageInfo.setRcount(rcount);	// 전체 레코드 개수
			pageInfo.setSpage(spage);	// 시작 페이지 번호(블록별 시작 페이지)
			
			request.setAttribute("ordList", ordList);
			request.setAttribute("pageInfo", pageInfo);
		
		} else if (command.equals("/view.ord")) {	// 구매상세보기 화면이면
			System.out.println("/view.ord 가동");
			lnk = "/ord/ordView.jsp";
			int cpage = Integer.parseInt(request.getParameter("cpage"));
			// 특정 회원(mlid)이 구매한 목록의 레코드 개수를 저장
			String olid = request.getParameter("olid");
			
			OrdInfo ordInfo = ordService.getOrdInfo(request, olid, mlid);	// request 추가
			request.setAttribute("ordInfo", ordInfo);	// 추가
		
		} else if (command.equals("/coupon.ord")) {		// 쿠폰팝업 화면이면
			lnk ="/ord/findCoupon.jsp?visited=y";
			ArrayList<MemberCouponInfo> memberCoupon = ordService.getCouponList(request, mlid);
			request.setAttribute("MemberCoupon", memberCoupon);
		} else if (command.equals("/ordcancel.ord")) {	// 주문취소 기능이면
			System.out.println("/ordcancel.ord 액션 들어옴");
			lnk = "main";
			String olid = request.getParameter("olid");
			String olbuyer = request.getParameter("olbuyer");
			
			result = ordService.orderCancel(request, olid, olbuyer);
			forward.setRedirect(true);
		}
		
		forward.setPath(lnk);
		if (result < 1) {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('작업에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return forward;
	}
}
