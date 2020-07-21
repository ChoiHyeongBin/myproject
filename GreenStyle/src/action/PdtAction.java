package action;

import java.util.*; // ArrayList 사용하려고
import javax.servlet.http.*; // request, response 사용하려고
import svc.*;
import vo.*;


public class PdtAction implements Action {
	private String command;
	
	public PdtAction(String command) { this.command = command; }
	// uri중 파일명에 해당하는 문자열을 멤버변수 command에 담았음
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		// 검색어 관련 request를 위한 캐릭터 인코딩(한글 검색 때문에)
		
		String lnk = "";
		String condition = "";
		PdtService pdtService = new PdtService();
		String where = "";
		
		
		if (command.equals("/list.product")) {			// 상품목록 화면이면
			ArrayList<PdtInfo> pdtList = new ArrayList<PdtInfo>();
			if (request.getParameter("kind").equals("c")) {
			// 분류목록 화면일 경우
				lnk = "/pdt/pdtListCata.jsp";
				where = " and cs_id = '" + request.getParameter("csid") + "' ";
				
			} else if (request.getParameter("kind").equals("s")) {
			// 검색목록 화면일 경우
				lnk = "/pdt/pdtListSearch.jsp";
				where = " and pl_name like '%" + request.getParameter("keyword") + "%' "; // 검색조건 늘릴때에는 and로 더만들기/ 브랜드는 or
			
			} else if (request.getParameter("kind").equals("d")) {
				lnk = "/pdt/pdtCodiCata.jsp";
				if (request.getParameter("csid").equals("cs07")) {
						where = " and cs_id = 'cs07'";
				} else if (request.getParameter("csid").equals("cs08")) {
						where = " and cs_id = 'cs08'";
				}
			}
			
			if(request.getParameter("cond") != null) {
				if (request.getParameter("cond").equals("b")) {
					 where += " order by pl_stock ";
					 condition = "b";
				} else if (request.getParameter("cond").equals("l")) {
					where += " order by pl_price ";
					condition = "l";
				} else if (request.getParameter("cond").equals("h")) {
					where += " order by pl_price desc ";
					condition = "h";
				}
			} else {
				where += " order by pl_name ";
				condition = "";
			}
			
			int cpage = 1;	// 현재 페이지 번호를 저장할 변수
			int limit = 9;	// 한 페이지에서 보여줄 공지사항 개수, 페이지 크기
			
			if (request.getParameter("cpage") != null) {
			// 받아온 페이지 번호가 있으면 String에서 int형 데이터로 변형
				cpage = Integer.parseInt(request.getParameter("cpage"));
			}
			pdtList = pdtService.getPdtList(where, cpage, limit);
			
			int rcount = pdtService.getPdtCount(where);		
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
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("pdtList", pdtList);
			
		} else if (command.equals("/view.product")) {	// 상품 상세보기이면
			lnk = "/pdt/pdtView.jsp";
			PdtInfo pdtInfo = pdtService.getPdtInfo(request.getParameter("plid"));
			request.setAttribute("pdtInfo", pdtInfo);
		}
		
		request.setAttribute("condition", condition);
		ActionForward forward = new ActionForward();
		forward.setPath(lnk);
		
		return forward;
	}
}
