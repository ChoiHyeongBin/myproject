package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.faq")
public class FaqController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public FaqController() {
        super();
    }
    
    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        	request.setCharacterEncoding("utf-8");
        	String RequestURI = request.getRequestURI();
        	String contextPath = request.getContextPath();
        	String command = RequestURI.substring(contextPath.length());
        	System.out.println(command);
        	
        	Action action = null;
        	ActionForward forward = null;
        	
        	if (command.equals("/list.faq")) {
        		action = new FaqListAction();
        		try {
        			forward = action.execute(request, response);
        		} catch (Exception e) { 
        			System.out.println("/list.faq에서 문제 발생");
        			e.printStackTrace(); 
        		}
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
