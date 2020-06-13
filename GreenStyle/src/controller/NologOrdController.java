package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import action.*;
import vo.*;


@WebServlet("*.nologord")
public class NologOrdController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public NologOrdController() { super(); }

    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	HttpSession session = request.getSession();
    	
    	String RequestURI = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = RequestURI.substring(contextPath.length());
    	
    	Action action = new NologOrdAction(command);
    	ActionForward forward = null;
    	
		try {
			forward = action.execute(request, response);
		} catch (Exception e) { 
			e.printStackTrace(); 
		}
    	
    	if (forward != null) { 
    		if (forward.isRedirect()) {
    			System.out.println("forward의 리다이렉트 설정 함 : " + forward.isRedirect());
    			response.sendRedirect(forward.getPath());
    		} else {
    			System.out.println("디스패쳐 방식");
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
