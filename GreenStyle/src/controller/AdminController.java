package controller;

import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

import action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.*;
import svc.*;

@WebServlet("*.admin")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public AdminController() {
        super();
    }
	
	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("어드민 컨트롤러 진입");
	    request.setCharacterEncoding("utf-8");
	    String RequestURI = request.getRequestURI();
	    String contextPath = request.getContextPath();
	    String command = RequestURI.substring(contextPath.length());
	    
	    Action action = new AdminAction(command);
	    ActionForward forward = null;
	    
	    int result = 0;
	    	  
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