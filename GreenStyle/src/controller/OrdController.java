package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import action.*;
import vo.*;

@WebServlet("*.ord")
public class OrdController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public OrdController() {
        super();
    }
    
    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	
    	HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		String mlid = mem.getMl_id();
		if (mlid == null || mlid.equals("")) {
			PrintWriter out = response.getWriter();
			response.setContentType("html/text; charset=utf-8");
			out.println("<script>");
			out.println("alert('로그인 후에 사용하실 수 있습니다.');");
			out.println("location.href='loginForm.jsp';");
			out.println("</script>");
		}
    	
    	String RequestURI = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = RequestURI.substring(contextPath.length());
    	
    	Action action = new OrdAction(command);
    	ActionForward forward = null;
    	
		try {
			forward = action.execute(request, response);
		} catch (Exception e) { 
			e.printStackTrace(); 
		}
    	
    	if (forward != null) {
    		if (forward.isRedirect()) {
    			response.sendRedirect(forward.getPath());
    		} else {
    			RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
    			dispatcher.forward(request, response);
    		}
    	}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProc(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProc(request, response);
	}

}
