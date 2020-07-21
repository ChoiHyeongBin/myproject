package controller;

import java.io.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import svc.JoinService;


@WebServlet("/join")
// 회원가입 처리를 위한 클래스
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JoinServlet() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		JoinService joinService = new JoinService();
		// JoinService형 인스턴스 joinService 선언 및 생성
		// 실제 작업을 처리할 클래스를 호출
		
		int result = joinService.setMemberJoin(request);
		// joinService인스턴스 안에 있는 setMemberJoin() 메소드를 호출
		// 매개변수로 request객체를 보냄(request객체 안의 파라미터들도 같이 보냄)
		if (result == 1) {	// 쿼리에 영향을 받은 레코드가 1이면(회원가입이 성공했으면, 한 레코드가 추가됨)
			response.sendRedirect("member/loginForm.jsp");
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입에 실패했습니다.')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		String uid = request.getParameter("uid").toLowerCase().trim();
		String pwd = request.getParameter("pwd1").toLowerCase().trim();
		String uname = request.getParameter("uname").trim();
		String by = request.getParameter("by");
		String bm = request.getParameter("bm");
		String bd = request.getParameter("bd");
		String p1 = request.getParameter("p1");
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		String e1 = request.getParameter("e1").trim();
		String e2 = request.getParameter("e2");
		
		String birth = by + "-" + bm + "-" + bd;
		String phone = p1 + "-" + p2 + "-" + p3;
		String email = e1 + "@" + e2;
		
		
		
	}
}
