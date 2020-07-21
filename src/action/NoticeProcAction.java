package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class NoticeProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		
		int result = 0, nlNum = 0;
		String lnk = "", nlResult = "";
		NoticeService noticeService = new NoticeService();
		
		if (wtype.equals("in")) {	// 공지사항 등록이면
			nlResult = noticeService.insertNotice(request);
			System.out.println("Proc의 nlResult : " + nlResult);
			result = Integer.parseInt(nlResult.substring(0, nlResult.indexOf(':')));
			// indexOf() : 지정된 데이터(':')의 위치를 찾아 인덱스를 리턴(없으면 -1)
			System.out.println("Proc의 result : " + result);
			nlNum = Integer.parseInt(nlResult.substring(nlResult.indexOf(':') + 1));
			System.out.println("Proc의 nlNum :  " + nlNum);
			lnk = "view.notice2?cpage=1&num=" + nlNum;
			
		} else if (wtype.equals("up")) {	// 공지사항 수정이면
			result = noticeService.updateNotice(request);
			System.out.println(result);
			String num = request.getParameter("num");
			String cpage = request.getParameter("cpage");
			String schType = request.getParameter("schType");
			String keyword = request.getParameter("keyword");
			
			String args = "?num=" + num + "&cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
			lnk = "view.notice2" + args;
			System.out.println(lnk);
		
		} else if (wtype.equals("del")) {	// 공지사항 삭제이면
			result = noticeService.deleteNotice(request);
			
			lnk = "list.notice2";
		}
		
		ActionForward forward = new ActionForward();
		if (result == 1) {
			forward.setRedirect(true);	// sendRedirect 방식으로 이동시킴
			// 최초 요청을 받은 URL1에서 클라이언트에 redirect할 URL2를 리턴하고, 클라이언트에게 전혀 새로운 요청을 생성하여 URL2에 다시 요청을 보냄 
			// 따라서 처음 보냈던 최초의 요청정보는 더이상 유효하지 않게 됨
			forward.setPath(lnk);
		} else {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('작업에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return forward;
	}
}
