package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

import vo.ActionForward;

public class AdminMemProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		String lnk = "";
		AdminMemService adminMemService = new AdminMemService();
		
		result = adminMemService.memberUpdate(request);
		

		String num = request.getParameter("num");
		String cpage = request.getParameter("cpage");
		String schType = request.getParameter("schType");
		String keyword = request.getParameter("keyword");

		String args = "?num=" + num + "&cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
		lnk = "memberView.mem" + args;
		
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
