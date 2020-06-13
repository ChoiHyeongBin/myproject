package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AdminOrdViewAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String olid = request.getParameter("olid");
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println("AdminOrdViewAction의 num : " + num);
		String where = " ol_id = '" + olid + "' ";
		int cpage = 1;	// 현재 페이지 번호를 저장할 변수
		int limit = 10;	// 한 페이지에서 보여줄 공지사항 개수, 페이지 크기
		
		AdminOrdService adminOrdService = new AdminOrdService();
		OrdInfo ordInfo = adminOrdService.getOrd(num);
		request.setAttribute("ordInfo", ordInfo);	// set 필수
		
		ArrayList<OrdInfo> getOrdList = adminOrdService.getOrdList2(where, cpage, limit);	// 오류
		request.setAttribute("getOrdList", getOrdList);		// set 필수
		
		if (ordInfo == null) {	// 게시글 정보가 없으면
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		request.setAttribute("cpage", request.getParameter("cpage"));
		request.setAttribute("schType", request.getParameter("schType"));
		request.setAttribute("keyword", request.getParameter("keyword"));
		request.setAttribute("olid", olid);
		request.setAttribute("ordInfo", ordInfo);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/admin/ord/ordView2.jsp");
		
		return forward;
	}
}
