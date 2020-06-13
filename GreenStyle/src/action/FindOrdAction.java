package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class FindOrdAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		String mlid = mem.getMl_id();
		
		OrdService ordService = new OrdService();
		ActionForward forward = new ActionForward();
		ArrayList<OrdInfo> ordList = ordService.getOrdList(request, mlid, 1, 10);
		request.setAttribute("ordList", ordList);
		
		String lnk = "/board/findOrdNum.jsp";
		forward.setPath(lnk);
		
		return forward;
	}
}