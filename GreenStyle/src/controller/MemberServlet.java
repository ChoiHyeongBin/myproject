package controller;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import svc.*;
import vo.MemberInfo;


@WebServlet("/member")
// 회원관련 작업(수정, 탈퇴 등)의 요청을 받는 서블릿
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public MemberServlet() {super();}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		MemberService memberService = new MemberService();
		String kind = request.getParameter("kind");
		int result = 0;
		
		if (kind.equals("up")) {	// 회원정보 수정시
			result = memberService.memberUpdate(request);
			// 수정할 회원정보들을 담은 request객체를 인수로하여 setMemberUpdate()메소드 호출
			// 회원정보 수정 후 수정된 레코드 개수를 정수로 result에 담음
		} else if (kind.equals("del")) { 	// 회원 탈퇴시
			result = memberService.memberDelete(request);
			HttpSession session = request.getSession();
			session.invalidate();
		}
		
		
		// 수정할 회원정보들을 담은 request객체를 인수로하여 setMemberUpdate() 메소드 호출
		// 회원 정보 수정 후 수정된 레코드 개수를 정수로 result에 담음
		if (result == 1) {	
			response.sendRedirect("main");
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원정보 수정에 실패했습니다.')");
			out.println("history.back();");
			out.println("</script>");
		}
		
	}

}
