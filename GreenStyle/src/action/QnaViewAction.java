package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class QnaViewAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		
		QnaService qnaService = new QnaService();
		
		QnaInfo qnaInfo = qnaService.getQna(num);
		
		if (qnaInfo == null) { 
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		request.setAttribute("qnaInfo", qnaInfo);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/board/qnaView.jsp");

		return forward;
	}
}
