package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class MypageAction implements Action {
	private String command;
	
	public MypageAction(String command) { this.command = command; }
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		String mlid = mem.getMl_id();		
		String lnk = "";
		
		if (mem == null || mem.equals("")) {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("로그인 후 사용가능합니다.");
			out.println("location.href='main'");
			out.println("</script>");
		}
		
		OrdService ordService = new OrdService();
		QnaService qnaService = new QnaService();
		ReviewService reviewService = new ReviewService();
		
		int rcount = 0;
		
		if (command.equals("/view.mypage")) {
			lnk = "/mypage/mypageMain.jsp";
					
			ArrayList<OrdInfo> ordList = ordService.getOrdList(request, mlid, 1, 10);
			ArrayList<MemberCouponInfo> couponList = ordService.getCouponList(request, mlid);
			ArrayList<QnaInfo> qnaList = qnaService.getQnaList(" and ml_id = '" + mlid + "' ", 1, 10);
			ArrayList<ReviewInfo> reviewList = reviewService.getReviewList(" and ml_id = '" + mlid + "' ", 1, 10);
			
			request.setAttribute("ordList", ordList);
			request.setAttribute("couponList", couponList);
			request.setAttribute("qnaList", qnaList);
			request.setAttribute("reviewList", reviewList);
			
		} else if (command.equals("/ord.mypage")) {
			lnk = "/mypage/mypageOrd.jsp";
			ArrayList<OrdInfo> ordList = ordService.getOrdList(request, mlid, 1, 10);
			request.setAttribute("ordList", ordList);
		} else if (command.equals("/coupon.mypage")) {
			lnk = "/mypage/mypageCoupon.jsp";
			ArrayList<MemberCouponInfo> couponList = ordService.getCouponList(request, mlid);
			request.setAttribute("couponList", couponList);
		} else if (command.equals("/qna.mypage")) {
			lnk = "/mypage/mypageQna.jsp";
			rcount = qnaService.getListCount(" and ml_id = '" + mlid + "'");
			ArrayList<QnaInfo> qnaList = qnaService.getQnaList(" and ml_id = '" + mlid + "' ", 1, 10);
			request.setAttribute("qnaList", qnaList);
		} else if (command.equals("/point.mypage")) {
			lnk = "/mypage/mypagePoint.jsp";
			//ArrayList<MemberPointInfo> pointList = ordService.getPointList(request, mlid);
			//request.setAttribute("pointList", pointList);
		} else if (command.equals("/review.mypage")) {
			lnk = "/mypage/mypageReview.jsp";
			rcount = reviewService.getListCount(" and ml_id = '" + mlid + "'");
			ArrayList<ReviewInfo> reviewList = reviewService.getReviewList(" and ml_id = '" + mlid + "' ", 1, 10);
			request.setAttribute("reviewList", reviewList);
		} 
		
		int cpage = 1;
		int limit = 10;
		
		if (request.getParameter("cpage") != null) {
				cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		int mpage = (int)((double)rcount / limit + 0.95);
		int spage = (((int)((double)cpage / 10 + 0.9)) - 1) * 10 + 1;
		int epage = spage + 10 - 1;
		if (epage > mpage)	epage = mpage;
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setEpage(epage);
		pageInfo.setMpage(mpage);
		pageInfo.setRcount(rcount);
		pageInfo.setSpage(spage);
		
		request.setAttribute("pageInfo", pageInfo);
		
		ActionForward forward = new ActionForward();
		forward.setPath(lnk);
		
		return forward;
	}
}