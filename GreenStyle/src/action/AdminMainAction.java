package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AdminMainAction implements Action {
	private String command;
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
	
		ArrayList<OrdInfo> getOrdList = new ArrayList<OrdInfo>();
		
		AdminOrdService adminOrdService = new AdminOrdService();
		// AdminNoticeService adminNoticeService = new AdminNoticeService();
		// AdminQnaService adminQnaService = new AdminQnaService();
		getOrdList = adminOrdService.getMainOrdList();
		
		request.setAttribute("getOrdList", getOrdList);
		
		HttpSession session = request.getSession();
		OrdInfo oi = (OrdInfo)session.getAttribute("ordInfo");
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("/admin/adminMain.jsp");
		
	return forward;
	}
}
