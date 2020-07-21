package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AdminAction implements Action {
	private String command;
	
	public AdminAction(String command) { this.command = command; }
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script> alert('정상작동'); </script>");
		System.out.println("어드민 액션 진입");
		
		String lnk = "";
		AdminService adminService = new AdminService();
		ActionForward forward = new ActionForward();
		String uid = request.getParameter("uid");
		String pwd = request.getParameter("pwd");
		AdminInfo adminInfo = null;
		int result = 1;
		System.out.println("command : " + command);
		if (command.equals("/main.admin")) {		// 로그인이면		
			adminInfo = adminService.main(uid, pwd);
			if (adminInfo != null) { 
				 session = request.getSession();
		         // JSP와 다르게 세션객체도 직접 생성해서 사용해야 함
		         session.setAttribute("adminInfo", adminInfo);
		         lnk = "/view.adminMain";
		      } else {	// 로그인 실패시
		    	  out.println("<script>");
			      out.println("alert('작업실패');");
			      out.println("</script>");
			      lnk = "/admin/adminLoginForm.jsp";
		      }
			
		} else if(command.equals("/login.admin")) {	// 로그인화면으로 가는거면
			lnk = "/admin/adminLoginForm.jsp";
		}
		
		if (result < 1) {
			out.println("<script>");
			out.println("alert('작업에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		forward.setPath(lnk);
		return forward;
	}
}
