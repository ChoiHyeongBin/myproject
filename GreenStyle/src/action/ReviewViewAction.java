package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class ReviewViewAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println("num : " + num);
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		String mlid = mem.getMl_id();	
		OrdService ordService = new OrdService();
		ArrayList<OrdInfo> ordList = ordService.getOrdList(request, mlid, 1, 10);
		
		ReviewService reviewService = new ReviewService();
		ReviewInfo reviewInfo = reviewService.getReview(num);
		
		String plid = reviewInfo.getPl_id();
		String olid = reviewInfo.getOl_id();
		System.out.println("plid : " + plid + " / olid : " + olid);
		
		for(int i = 0; i < ordList.size(); i++) {
			String Olid = ordList.get(i).getOl_id();
			String Plid = ordList.get(i).getOrdPdtList().get(0).getPl_id();
			if ( (olid == Olid) && (plid == Plid) )
				System.out.println("olid : " + Olid + " / plid : " + Plid);
				request.setAttribute("getnum", i);
				System.out.println(" i : " + i);
		}
		
		if (reviewInfo == null) { 
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		request.setAttribute("reviewInfo", reviewInfo);
		request.setAttribute("ordList", ordList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/board/reviewView.jsp");

		return forward;
	}
}
