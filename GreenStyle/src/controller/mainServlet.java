package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.MainAction;
import vo.ActionForward;

@WebServlet("/main")
public class mainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public mainServlet() {
        super();
    }
    
    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 방식에 상관없이 일괄적으로 요청을 처리하기 위한 메소드
            request.setCharacterEncoding("utf-8");
            String RequestURI = request.getRequestURI().toLowerCase();
            String contextPath = request.getContextPath();
            String command = RequestURI.substring(contextPath.length());
            
            Action action = null;
            ActionForward forward = null;
            
               action = new MainAction();
               try {
                  forward = action.execute(request, response);
               } catch(Exception e) { e.printStackTrace(); }
            
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
