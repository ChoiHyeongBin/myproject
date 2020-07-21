package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import svc.OrdService;
import vo.*;

@WebServlet("*.qna")
public class QnaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public QnaController() {
        super();
    }
    
    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        	request.setCharacterEncoding("utf-8");
        	String RequestURI = request.getRequestURI();
        	String contextPath = request.getContextPath();
        	String command = RequestURI.substring(contextPath.length());
        	System.out.println("Qna : " + command);
        	
        	Action action = null;
        	ActionForward forward = null;
        	
        	if (command.equals("/in.qna")) {	// 글 등록화면이면
        		forward = new ActionForward();
        		
        		forward.setPath("/board/qnaForm.jsp?wtype=in");
        	} else if (command.equals("/up.qna")) {	// 글 등록화면이면
        		action = new QnaViewAction();
        		
        		try {
        			forward = action.execute(request, response);
        		} catch (Exception e) { 
        			e.printStackTrace(); 
        		}
        		
        		forward.setPath("/board/qnaForm.jsp?wtype=up");
        	} else if (command.equals("/findOrd.qna")) {
        		action = new FindOrdAction();
        		
        		try {
        			forward = action.execute(request, response);
        		} catch (Exception e) { 
        			e.printStackTrace(); 
        		}
    		} else if (command.equals("/proc.qna")) {	// 처리작업이면
        		action = new QnaProcAction();
        		
        		try {
        			forward = action.execute(request, response);
        		} catch (Exception e) { 
        			e.printStackTrace(); 
        		}
        	} else if (command.equals("/view.qna")) {
        		action = new QnaViewAction();
        		try {
        			forward = action.execute(request, response);
        		} catch (Exception e) { 
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
