package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

import vo.ActionForward;

public class AdminOrdProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		String lnk = "";
		String olid = request.getParameter("olid");
		System.out.println("olid : "+ olid);
		AdminOrdService adminOrdService = new AdminOrdService();
		
		result = adminOrdService.ordUpdate(request);

		String num = request.getParameter("num");
		String cpage = request.getParameter("cpage");
		String schType = request.getParameter("schType");
		String keyword = request.getParameter("keyword");

		String args = "?num=" + num + "&cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword + "&olid=" + olid;
		lnk = "ordView.ord2" + args;
		
		ActionForward forward = new ActionForward();
		if (result == 1) {
			forward.setRedirect(true);	// sendRedirect ������� �̵���Ŵ
    		forward.setPath(lnk);
		} else {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�۾��� �����߽��ϴ�.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return forward;
	}
}