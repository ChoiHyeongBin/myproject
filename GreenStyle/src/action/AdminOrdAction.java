package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AdminOrdAction implements Action {
	
	private String command;
	public AdminOrdAction(String command) { this.command = command; }
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate") + " 23:59:59";
		String schType = request.getParameter("schType");	// 검색 조건
		String schType2 = request.getParameter("schType2");
		String keyword = request.getParameter("keyword");	// 검색어
		String olid = request.getParameter("olid");
		String where = "";
		System.out.println(edate);
		
		if (keyword != null && !keyword.equals("") && sdate != null && !sdate.equals("") && edate !=null && !edate.equals("")) {
			where = " and ol_" + schType + " like '%" + keyword + "%' and ol_" + schType2 + " Between '" + sdate + "' and '" + edate + "' " ;
		
		} else if ((keyword == null || keyword.equals("")) &&  sdate !=null && !sdate.equals("") && edate != null && !edate.equals("")) {
			where = " and ol_" + schType2 + " Between '" + sdate + "' and '" + edate + "' " ;
	
		} else if ((sdate == null || sdate.equals("") || edate == null || edate.equals("")) && keyword != null && !keyword.equals("")) {
			where = " and ol_" + schType + " like '%" + keyword + "%' ";
		}

		ArrayList<OrdInfo> getOrdList = new ArrayList<OrdInfo>();
		int cpage = 1;	// 현재 페이지 번호를 저장할 변수
		int limit = 10;	// 한 페이지에서 보여줄 공지사항 개수, 페이지 크기
		
		if (request.getParameter("cpage") != null) {
		// 받아온 페이지 번호가 있으면 String에서 int형 데이터로 변형
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		AdminOrdService adminOrdService = new AdminOrdService();
		int rcount = adminOrdService.getListCount(where);
		getOrdList = adminOrdService.getOrdList(where, cpage, limit);
		
		int mpage = (int)((double)rcount / limit + 0.95);
		int spage = (((int)((double)cpage / 10 + 0.9)) - 1) * 10 + 1;
		int epage = spage + 10 - 1;
		if (epage > mpage)	epage = mpage;
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setEpage(epage);
		pageInfo.setMpage(mpage);
		pageInfo.setRcount(rcount);
		pageInfo.setSpage(spage);
		pageInfo.setSchType(schType);
		pageInfo.setKeyword(keyword);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("getOrdList", getOrdList);
		
		HttpSession session = request.getSession();
		OrdInfo oi = (OrdInfo)session.getAttribute("ordInfo");
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("admin/ord/ordList2.jsp?olid=" + olid);
	
	return forward;
	}
}
