package action;

import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class ReviewProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		String mlid = mem.getMl_id();	

		OrdService ordService = new OrdService();
		ReviewService reviewService = new ReviewService();
		int result = 0;
		ActionForward forward = new ActionForward();
		
		ArrayList<OrdInfo> ordList = ordService.getOrdList(request, mlid, 1, 10);
		request.setAttribute("ordList", ordList);

		if (wtype.equals("in")) {
			result = reviewService.insertReview(request, mlid);
		} else if (wtype.equals("up")) {
			result = reviewService.updateReview(request, mlid);
		}
		
		forward.setPath("view.mypage");
		
		return forward;
	}
}
