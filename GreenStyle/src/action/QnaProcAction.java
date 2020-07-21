package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class QnaProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		String nologin = request.getParameter("nologin");
		String lnk = "";

		QnaService qnaService = new QnaService();
		int result = 0;
		
		if (wtype.equals("in")) { 
			result = qnaService.insertQna(request);
			
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('1:1 문의글이 등록되었습니다.');");
			out.println("</script>");
		} else if (wtype.equals("up")) {
			result = qnaService.updateQna(request);
			
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('1:1 문의글이 수정되었습니다.');");
			out.println("</script>");
		}

		ActionForward forward = new ActionForward();
		
		if (nologin != null) {
			lnk = "/main";
		} else {
			lnk = "/view.mypage";
		}
		
		forward.setPath(lnk);
		
		return forward;
	}
}
