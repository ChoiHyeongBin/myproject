package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AdminNoticeAction implements Action{
	
	private String command;
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AdminNoticeAction 진입");
		request.setCharacterEncoding("utf-8");
		
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate") + " 23:59:59";
		String schType = request.getParameter("schType");	
		String keyword = request.getParameter("keyword");	
		String where = "";
		
		
		// 검색 조건을 입력하고, 작성 일자도 입력했을 경우
		if (keyword != null && !keyword.equals("") && sdate != null && !sdate.equals("") && edate !=null && !edate.equals("")) {
			if (schType.equals("tnc")) { // 제목 및 내용 검색일 경우
				where = " and nl_title like '%" + keyword + "%' and nl_content like '%" + keyword + "%' ";
				where += "and nl_date Between '" + sdate + "' and '" + edate + "' " ;
			} else { // 제목 혹은 내용 검색일 경우
				where = " and nl_" + schType + " like '%" + keyword + "%' ";
				where += "and nl_date Between '" + sdate + "' and '" + edate + "' " ;
			}
		// 작성 일자만 입력했을 경우
		} else if ((keyword == null || keyword.equals("")) &&  sdate !=null && !sdate.equals("") && edate != null && !edate.equals("")) {
			where = " and nl_date Between '" + sdate + "' and '" + edate + "' " ;
		// 검색 조건만 입력했을 경우
		} else if ((sdate == null || sdate.equals("") || edate == null || edate.equals("")) && keyword != null && !keyword.equals("")) {
			where = " and nl_" + schType + " like '%" + keyword + "%' ";
		}

		ArrayList<NoticeInfo> getNoticeList = new ArrayList<NoticeInfo>();
		int cpage = 1;	
		int limit = 10;
		
		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		AdminNoticeService adminNoticeService = new AdminNoticeService();
		int rcount = adminNoticeService.getListCount(where);
		getNoticeList = adminNoticeService.getNoticeList(where, cpage, limit);
		
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
		request.setAttribute("getNoticeList", getNoticeList);
		
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("admin/board/noticeList.jsp");
	
	return forward;
	}
}
