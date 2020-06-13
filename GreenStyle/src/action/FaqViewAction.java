package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class FaqViewAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		
		FaqService faqService = new FaqService();
		
		int result = faqService.updateRead(num);
		
		FaqInfo faqInfo = faqService.getFaq(num);
		// 글번호에 해당하는 글의 데이터를 FaqInfo형 인스턴스로 받아옴
		
		int maxFaq = faqService.getListCount("");
		// 글의 최대 개수를 가져옴
		
		if (faqInfo == null) { // 게시글 정보가 없으면
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		request.setAttribute("cpage", request.getParameter("cpage"));
		request.setAttribute("schType", request.getParameter("schType"));
		request.setAttribute("keyword", request.getParameter("keyword"));
		request.setAttribute("maxFaq", maxFaq);
		request.setAttribute("faqInfo", faqInfo);
		// 필요한 데이터들은 request객체의 속성으로 담아서 가져감
		// 단, Dispatcher방식일 경우에만 사용가능
		
		ActionForward forward = new ActionForward();
		forward.setPath("/board/faqView.jsp");

		return forward;
	}
}
