package controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.MemberInfo;
import svc.LoginService;

@WebServlet("/login2")
// 로그인 요청에 작동되는 컨트롤러로 실제 작업을 할 서비스파일(svc패키지)로 연결하고,
// 작업 후 결과로 사용자의 요청에 대한 응답을 처리함
public class LoginServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      String uid = request.getParameter("uid");
      String pwd = request.getParameter("pwd");
      LoginService loginService = new LoginService();
      MemberInfo memberInfo = loginService.getLoginMember(uid, pwd);
      // MemberInfo 형태의 memberInfo 인스턴스로 loginService에서 호출, 매개변수는 (uid, pwd) : 데이터타입 String
      // 로그인 처리 후 아이디(객체)를 받아 옴(성공시 객체가, 실패시 null이 넘어옴)
      int result = 0;
      
      if (memberInfo != null) {   // 로그인 성공시
         HttpSession session = request.getSession();
         // JSP와 다르게 세션객체도 직접 생성해서 사용해야 함
         session.setAttribute("memberInfo", memberInfo);
         response.sendRedirect("main");
         result = loginService.memberLogin(request);
      
      } else if (uid == "") {      // 아이디가 비어있으면
         response.setContentType("text/html; charset=utf-8");
         PrintWriter out = response.getWriter();
         out.println("<script>");
         out.println("alert('아이디를 입력해주세요.');");
         out.println("history.back();");
         out.println("</script>");
      
      } else if (pwd == "") {      // 비밀번호가 비어있으면
         response.setContentType("text/html; charset=utf-8");
         PrintWriter out = response.getWriter();
         out.println("<script>");
         out.println("alert('비밀번호를 입력해주세요.');");
         out.println("history.back();");
         out.println("</script>");
         
      } else {   // 로그인 실패시
         response.setContentType("text/html; charset=utf-8");
         PrintWriter out = response.getWriter();
         out.println("<script>");
         out.println("alert('아이디와 비밀번호를 확인하세요.');");
         out.println("history.back();");
         out.println("</script>");
      }
      
   }
}