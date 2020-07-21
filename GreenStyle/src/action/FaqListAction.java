package action;

import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class FaqListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String schType = request.getParameter("schType");	// 검색 조건
		String keyword = request.getParameter("keyword");	// 검색어
		String kind = request.getParameter("kind");	// 분류
		String selbox = null;

		String where = "";
		if (schType != null && !schType.equals("") && keyword != null && !keyword.equals("")) {
			if (schType.equals("tc")) {	// 제목 + 내용 검색일 경우
				where = " and (fl_title like '%" + keyword + "%'";
				where += " or fl_content like '%" + keyword + "%') ";
			} else {	// 제목이나 내용 검색일 경우
				where = " and fl_" + schType + " like '%" + keyword + "%' ";
			}
		}
		if (kind != null) {
			if (kind.equals("a")) { 
				where = " and fl_kind = 'a' ";
				selbox = "b2";
			} else if (kind.equals("b")) {	
				where = " and fl_kind = 'b' ";
				selbox = "b3";
			} else if (kind.equals("c")) {	
				where = " and fl_kind = 'c' ";
				selbox = "b4";
			} else if (kind.equals("d")) {	
				where = " and fl_kind = 'd' ";
				selbox = "b5";
			}
		} else {
			selbox = "b1";
		}

		ArrayList<FaqInfo> faqList = new ArrayList<FaqInfo>();
		int cpage = 1;	
		int limit = 10;	
		
		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		FaqService faqService = new FaqService();
		int rcount = faqService.getListCount(where);
		faqList = faqService.getFaqList(where, cpage, limit);
		
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
		request.setAttribute("faqList", faqList);
		request.setAttribute("selbox", selbox);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/board/faqList.jsp");

		return forward;
	}
}
