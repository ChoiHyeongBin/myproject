package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

import vo.ActionForward;

public class AdminNoticeProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		String lnk = "";
		AdminNoticeService adminNoticeService = new AdminNoticeService();

		String num = request.getParameter("num");
		String cpage = request.getParameter("cpage");
		String schType = request.getParameter("schType");
		String keyword = request.getParameter("keyword");
		String wtype = request.getParameter("wtype");
		
		String args = "?num=" + num + "&cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
		System.out.println("args : " + args);
		
		if (wtype.equals("in")) {
			result = adminNoticeService.insertNotice(request);
			lnk = "view.adminNotice" + args;
		} else if (wtype.equals("up")) {
			result = adminNoticeService.updateNotice(request);
			lnk = "view.adminNotice" + args;
		} else if (wtype.equals("del")) {
			result = adminNoticeService.updateNotice(request);
			lnk = "view.adminNotice" + args;
		}

		
		ActionForward forward = new ActionForward();
		if (result == 1) {
			forward.setRedirect(true);	
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
