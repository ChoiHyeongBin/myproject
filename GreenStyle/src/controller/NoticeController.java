package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.notice")
public class NoticeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NoticeController() { super(); }

    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // 요청방식에 상관없이 일괄적으로 요청을 처리하기 위한 메소드
    	request.setCharacterEncoding("utf-8");
    	String RequestURI = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = RequestURI.substring(contextPath.length());
    	// '/list.notice'
    	System.out.println("command : " + command);
    	
    	Action action = null;
    	ActionForward forward = null;
    	
    	if (command.equals("/list.notice")) {	// 목록화면이면
    		action = new NoticeListAction();
    		try {
    			forward = action.execute(request, response);
    		} catch (Exception e) { 
    			System.out.println("/list.notice에서 문제 발생");
    			e.printStackTrace();
    			// 메소드가 내부적으로 예외 결과를 화면에 출력
    		}
    		
    	} else if (command.equals("/in.notice")) {	// 글 등록화면이면
    		forward = new ActionForward();
    		forward.setPath("/board/noticeForm.jsp?wtype=in");
    		
    	} else if (command.equals("/view.notice")) { // 보기 작업이면
    		action = new NoticeViewAction();
    		try {
    			forward = action.execute(request, response);
    		} catch (Exception e) { 
    			e.printStackTrace(); 
    		}
    	}
    	
    	// 기능 실행 후 이동할 페이지에 대한 if문
    	if (forward != null) {
    		if (forward.isRedirect()) {
    			response.sendRedirect(forward.getPath());
    			// history에 쌓여 '뒤로 가기'가 가능한 이동
    		} else {
    			RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
    			dispatcher.forward(request, response);
    			// history에 쌓이지 않아 '뒤로 가기'가 불가능한 이동(url불변)
    			// request와 response 객체를 공유하여 사용할 수 있음
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
