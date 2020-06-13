package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AdminMemAction implements Action{
	
	private String command;
	public AdminMemAction(String command) { this.command = command; }
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate") + " 23:59:59";
		String schType = request.getParameter("schType");	// 검색 조건
		String schType2 = request.getParameter("schType2");
		String keyword = request.getParameter("keyword");	// 검색어
		String where = "";
		System.out.println(edate);
		
		
		if (keyword != null && !keyword.equals("") && sdate != null && !sdate.equals("") && edate !=null && !edate.equals("")) {
			where = " and ml_" + schType + " like '%" + keyword + "%' and ml_" + schType2 + " Between '" + sdate + "' and '" + edate + "' " ;
		} else if ((keyword == null || keyword.equals("")) &&  sdate !=null && !sdate.equals("") && edate != null && !edate.equals("")) {
			where = " and ml_" + schType2 + " Between '" + sdate + "' and '" + edate + "' " ;
		} else if ((sdate == null || sdate.equals("") || edate == null || edate.equals("")) && keyword != null && !keyword.equals("")) {
			where = " and ml_" + schType + " like '%" + keyword + "%' ";
		}

		ArrayList<MemberInfo> getMemList = new ArrayList<MemberInfo>();
		int cpage = 1;	// 현재 페이지 번호를 저장할 변수
		int limit = 10;	// 한 페이지에서 보여줄 공지사항 개수, 페이지 크기
		
		if (request.getParameter("cpage") != null) {
		// 받아온 페이지 번호가 있으면 String에서 int형 데이터로 변형
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		AdminMemService adminMemService = new AdminMemService();
		int rcount = adminMemService.getListCount(where);
		getMemList = adminMemService.getMemList(where, cpage, limit);
		
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
		request.setAttribute("getMemList", getMemList);
		
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("admin/member/memberList.jsp");
	
	return forward;
	}
}
