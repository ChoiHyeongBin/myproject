package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class NoticeProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		
		int result = 0, nlnum = 0;
		String lnk = "", nlResult = "";
		NoticeService noticeService = new NoticeService();
		
		if (wtype.equals("in")) {	// 공지사항 등록이면
			nlResult = noticeService.insertNotice(request);
			result = Integer.parseInt(nlResult.substring(0, nlResult.indexOf(':')));
			nlnum = Integer.parseInt(nlResult.substring(nlResult.indexOf(':') + 1));
			lnk = "view.notice?cpage=1&num=" + nlnum;
			
		} else if (wtype.equals("up")) {	// 공지사항 수정이면
			result = noticeService.updateNotice(request);
			
			String num = request.getParameter("num");
			String cpage = request.getParameter("cpage");	 
			String schType = request.getParameter("schType");
			String keyword = request.getParameter("keyword");

			String args = "?num=" + num + "&cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
			lnk = "view.notice" + args;
			
		} else if (wtype.equals("del"))	{	// 공지사항 삭제이면
			result = noticeService.deleteNotice(request);
			
			lnk = "list.notice";
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