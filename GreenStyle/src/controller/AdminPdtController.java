package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import action.*;
import vo.*;

@WebServlet("*.adminpdt")
public class AdminPdtController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminPdtController() { super(); }
    
	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI(); 
		String contextPath = request.getContextPath(); 
		String command = RequestURI.substring(contextPath.length()); 
		
		Action action = new AdminPdtAction(command);
		ActionForward forward = null;
		
		try {
			forward = action.execute(request, response);
		} catch(Exception e) { 
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
