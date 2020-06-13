package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.*;
import vo.ActionForward;
import vo.*;

@WebServlet("*.ord2")
public class AdminOrdController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminOrdController() {
        super();
    }
    
    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	
    	/*HttpSession session = request.getSession();
		AdminInfo admin = (AdminInfo)session.getAttribute("adminInfo");
		String alid = admin.getAl_id();
		if (alid == null || alid.equals("")) {
			PrintWriter out = response.getWriter();
			response.setContentType("html/text; charset=utf-8");
			out.println("<script>");
			out.println("alert('로그인 후에 사용하실 수 있습니다.');");
			out.println("location.href='loginForm.jsp';");
			out.println("</script>");
		}*/
    	
		String RequestURI = request.getRequestURI(); 
		String contextPath = request.getContextPath(); 
		String command = RequestURI.substring(contextPath.length()); 
		
		Action action = null;
		ActionForward forward = null;
		System.out.println(command);
		if (command.equals("/list.ord2")) {	// 목록화면이면
    		action = new AdminOrdAction(command);
    		try {
    			forward = action.execute(request, response);
    		} catch (Exception e) { e.printStackTrace(); }
    	
		} else if (command.equals("/ordView.ord2")) {	// 보기작업이면
    		action = new AdminOrdViewAction();
    		try {
    			forward = action.execute(request, response);
    		} catch (Exception e) { e.printStackTrace(); }
    	
		} else if (command.equals("/ordUp.ord2")) {	// 수정작업이면
			System.out.println("AdminOrdController의 ordUp 들어옴");
    		action = new AdminOrdViewAction();
    		try {
    			forward = action.execute(request, response);
    			forward.setPath("/admin/ord/ordForm2.jsp?wtype=up");
    		} catch (Exception e) { e.printStackTrace(); }
    	
		} else if (command.equals("/proc.ord2")) {	// 처리작업이면
    	// 공지사항 등록, 수정, 삭제 등의 작업을 처리
    		action = new AdminOrdProcAction();	// action 폴더의 NoticeProcAction 파일로 이동
    		try {
    			forward = action.execute(request, response);
    		} catch (Exception e) { e.printStackTrace(); }
    	
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
