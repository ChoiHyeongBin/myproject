package action;

import java.io.*;	// io : input, output (입력, 출력)
import java.util.*;	// 날짜와 관련된 Date, Calendar 가 있으며, 자료구조와 관련된 Collection 프레임워크 관련 클래스들이 포함되어 있음
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class NoticeViewAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		// 글번호를 int형으로 변환하여 저장
		
		NoticeService noticeService = new NoticeService();
		
		int result = noticeService.updateRead(num);
		// 글번호에 해당하는 글의 조회수를 1 증가시킴
		
		NoticeInfo noticeInfo = noticeService.getNotice(num);
		// 글번호에 해당하는 글의 데이터를 NoticeInfo형 인스턴스로 받아옴
		
		int maxNotice = noticeService.getListCount("");
		// 글의 최대 개수를 가져옴
		
		String prev = noticeService.getPrevTitle(num);
		String next = noticeService.getNextTitle(num);
		
		if (noticeInfo == null) { // 게시글 정보가 없으면
			response.setContentType("html/text; charset=utf-8");	// 서블릿에서 한글로 출력하기 위해
			PrintWriter out = response.getWriter();		// 응답으로 내보낼 출력 스트림을 얻어냄
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");		// 현재 페이지의 한단계 이전페이지로 이동
			out.println("</script>");
		}
		
		request.setAttribute("cpage", request.getParameter("cpage"));	// setAttribute(속성 이름, 속성 값)
		request.setAttribute("schType", request.getParameter("schType"));
		request.setAttribute("keyword", request.getParameter("keyword"));
		request.setAttribute("maxNotice", maxNotice);
		request.setAttribute("prev", prev);
		request.setAttribute("next", next);
		request.setAttribute("noticeInfo", noticeInfo);
		// 필요한 데이터들은 request객체의 속성으로 담아서 가져감
		// 단, Dispatcher방식일 경우에만 사용가능
		
		ActionForward forward = new ActionForward();
		forward.setPath("/board/noticeView.jsp");

		return forward;
	}
}
