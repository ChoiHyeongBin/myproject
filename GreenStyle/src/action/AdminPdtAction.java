package action;

import java.util.*; // ArrayList 사용하려고
import javax.servlet.http.*; // request, response 사용하려고
import svc.*;
import vo.*;

public class AdminPdtAction implements Action {
	private String command;
	
	public AdminPdtAction(String command) { this.command = command; }
	// uri중 파일명에 해당하는 문자열을 멤버변수 command에 담았음
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		System.out.println("AdminPdtAction액션으로 들어옴");
		
		String lnk = "";
		AdminPdtService adminpdtService = new AdminPdtService();
		System.out.println("adminpdtService에서 나옴");
		String where = "";
		String condition = "";
		String schType = request.getParameter("schType");	// 검색 조건
		String keyword = request.getParameter("keyword");	// 검색어
		
		if (command.equals("/list.adminpdt")) {			// 상품목록 화면이면
			ArrayList<PdtInfo> adminpdtList = new ArrayList<PdtInfo>();
			lnk = "/admin/pdt/adminPdtList.jsp";							

			if (schType != null && !schType.equals("") && 
					keyword != null && !keyword.equals("")) {
					if (schType.equals("id")) {	// 상품아이디 검색
						where = " and (pl_id like '%" + keyword + "%')";
					} else if(schType.equals("name")){	// 상품이름 검색
						where = " and (pl_name like '%" + keyword + "%')";
					}
			}
			
		if(request.getParameter("cond") != null) {
			if (request.getParameter("cond").equals("b")) {
				 where += " order by pl_salecnt desc";
				 condition = "b";
			} 
		} else {
			where += "order by pl_id ";
			condition = "";
		}
			
			int cpage = 1;	// 현재 페이지 번호를 저장할 변수
			int limit = 10;	// 한 페이지에서 보여줄 공지사항 개수, 페이지 크기
			
			if (request.getParameter("cpage") != null) {
			// 받아온 페이지 번호가 있으면 String에서 int형 데이터로 변형
				cpage = Integer.parseInt(request.getParameter("cpage"));
			}
			adminpdtList = adminpdtService.getAdminPdtList(request, where, cpage, limit);
			String plid = request.getParameter("plid");
			int rcount = adminpdtService.getPdtCount(where);		
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
			request.setAttribute("adminpdtList", adminpdtList);
			request.setAttribute("plid", plid);
			request.setAttribute("condition", condition);
			
		} else if (command.equals("/view.adminpdt")) {	// 상품 상세보기이면
			lnk = "admin/pdt/adminPdtView.jsp";
			PdtInfo pdtInfo = adminpdtService.getPdt(request.getParameter("plid"));
			request.setAttribute("pdtInfo", pdtInfo);
		
		} else if (command.equals("/up.pdtproc") ) {
			lnk = "/admin/pdt/AdminPdtForm.jsp?wtype=up";
			PdtInfo pdtInfo = adminpdtService.getPdt(request.getParameter("plid"));
			request.setAttribute("pdtInfo", pdtInfo);
		}
		ActionForward forward = new ActionForward();
		forward.setPath(lnk);
		
		return forward;
		}
	}
