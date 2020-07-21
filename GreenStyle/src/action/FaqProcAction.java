package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class FaqProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		
		int result = 0, nlnum = 0;
		String lnk = "", flResult = "";
		FaqService faqService = new FaqService();
		
		if (wtype.equals("in")) {	// 공지사항 등록이면
			flResult = faqService.insertFaq(request);
			result = Integer.parseInt(flResult.substring(0, flResult.indexOf(':')));
			nlnum = Integer.parseInt(flResult.substring(flResult.indexOf(':') + 1));
			lnk = "view.faq?cpage=1&num=" + nlnum;
			
		} else if (wtype.equals("up")) {	// 공지사항 수정이면
			result = faqService.updateFaq(request);
			
			String num = request.getParameter("num");
			String cpage = request.getParameter("cpage");	 
			String schType = request.getParameter("schType");
			String keyword = request.getParameter("keyword");

			String args = "?num=" + num + "&cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
			lnk = "view.faq" + args;
			
		} else if (wtype.equals("del"))	{	// 공지사항 삭제이면
			result = faqService.deleteFaq(request);
			
			lnk = "list.faq";
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