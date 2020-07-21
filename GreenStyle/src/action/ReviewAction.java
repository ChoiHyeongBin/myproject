package action;

import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class ReviewAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		String mlid = mem.getMl_id();	

		OrdService ordService = new OrdService();
		ActionForward forward = new ActionForward();
		String lnk = "";
		
		ArrayList<OrdInfo> ordList = ordService.getOrdList(request, mlid, 1, 10);
		request.setAttribute("ordList", ordList);
		
		lnk = "/board/reviewForm.jsp?wtype=in";
		
		forward.setPath(lnk);
		
		return forward;
	}
}
