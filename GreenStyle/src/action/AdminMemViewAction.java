package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AdminMemViewAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println(num);
		
		AdminMemService adminMemService = new AdminMemService();
		MemberInfo memberInfo = adminMemService.getMember(num);
		
		if (memberInfo == null) {	// 게시글 정보가 없으면
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
		request.setAttribute("memberInfo", memberInfo);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/admin/member/memberView.jsp");
		
		return forward;
	}
}
