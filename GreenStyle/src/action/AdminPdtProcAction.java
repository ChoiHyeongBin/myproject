package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;


public class AdminPdtProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		System.out.println("AdminPdtProcAction들어옴");
		System.out.println("wtype : " + wtype);
		int result = 0, plnum = 0;
		String lnk = "", plResult = "";
		AdminPdtService adminpdtService = new AdminPdtService();
		String plid = request.getParameter("plid");
		
		
		if (wtype.equals("in")) {	// 등록이면
			System.out.println("글등록");
			plResult = adminpdtService.insertPdt(request);
			result = Integer.parseInt(plResult.substring(0, plResult.indexOf(':')));
			plnum = Integer.parseInt(plResult.substring(plResult.indexOf(':') + 1));
			lnk = "view.adminpdt?cpage=1&plid=" + plid;

		} else if (wtype.equals("up")) {	// 수정이면
			System.out.println("글수정");
			result = adminpdtService.updatePdt(request);
			lnk = "view.adminpdt?cpage=1&plid=" + plid;
			
		} else if (wtype.equals("del")) {	// 삭제이면
			PdtInfo pdtInfo = adminpdtService.getPdt(request.getParameter("plid"));
			request.setAttribute("pdtInfo", pdtInfo);
			result = adminpdtService.deletePdt(request);
			// 삭제한 레코드 개수를 받아 옴
			lnk = "list.adminpdt";
		}

		ActionForward forward = new ActionForward();
		if (result == 1) {
			forward.setRedirect(true);	// sendRedirect 방식으로 이동시킴
			forward.setPath(lnk);
		} else {
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
