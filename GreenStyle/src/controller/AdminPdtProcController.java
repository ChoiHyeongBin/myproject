package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.pdtproc")
public class AdminPdtProcController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminPdtProcController() { super(); }
    
    
    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 요청방식에 상관없이 일괄적으로 요청을 처리하기 위한 메소드
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();
		// '/mvcSite/list.notice'
		String contextPath = request.getContextPath();
		// '/mvcSite'
		String command = RequestURI.substring(contextPath.length());
		// '/list.notice'

		Action action = null;
		ActionForward forward = null;

		// 요청(url)에 따른 Action클래스 인스턴스 생성 및 excute()메소드 실행 if문
		// 요청(url)에 따른 기능별 메소드실행
		if (command.equals("/in.pdtproc")) {		// 글등록화면이면
			forward = new ActionForward();
			forward.setPath("/admin/pdt/AdminPdtForm.jsp?wtype=in");

		} else if (command.equals("/proc.pdtproc")) {	// 처리작업이면
		// 공지사항 등록, 수정, 삭제 등의 작업을 처리
			action = new AdminPdtProcAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }

		} else if (command.equals("/up.pdtproc")) {		// 글수정화면이면
			action = new AdminPdtAction(command);
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
		}

		// 기능 실행 후 이동할 페이지에 대한 if문
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
				// history에 쌓여 '뒤로 가기'가 가능한 이동
			} else {
				RequestDispatcher dispatcher = 
					request.getRequestDispatcher(forward.getPath());
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
