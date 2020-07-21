package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class NologOrdAction implements Action {
	private String command;
	public NologOrdAction(String command) { this.command = command; }
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		System.out.println("Nolog액션으로 들어옴");
		
		HttpSession session = request.getSession();
		String lnk = "";
		String olbuyer = (String)request.getAttribute("olbuyer");
		if (olbuyer == null) { olbuyer = ""; }
		
		NologOrdService nologordService = new NologOrdService();
		System.out.println("NologOrdService에서 나옴");
		ActionForward forward = new ActionForward();
		
		int result = 1;
		if (command.equals("/form.nologord")) {	// 구매폼 화면이면
		lnk = "/ord/nologordForm.jsp";
		ArrayList<CartInfo> NologOrdList = nologordService.getnologOrdList(request);
		request.setAttribute("NologOrdList", NologOrdList);
		
		} else if (command.equals("/nologproc.nologord")) {	// 구매처리 기능이면
			System.out.println("OrdAction의 구매처리 기능작동");
			String orderName = request.getParameter("orderName");
			System.out.println("orderName : " + orderName);
			lnk = "list.nologord";
			result = nologordService.nologordProcess(request);
			request.setAttribute("olbuyer", orderName); // 여기서 olbuyer을 설정
		
		} else if (command.equals("/list.nologord")) {	// 구매목록 화면이면
			System.out.println("OrdAction의 구매목록 화면");
			System.out.println("proc다음에 여기로 왔음");
			lnk = "/ord/NologordList.jsp";	
			int cpage = 1;	// 현재 페이지 번호를 저장할 변수
			int limit = 10;	// 한 페이지에서 보여줄 공지사항 개수, 페이지 크기
			if (request.getParameter("cpage") != null) {
			// 받아온 페이지 번호가 있으면 String에서 int형 데이터로 변형
				cpage = Integer.parseInt(request.getParameter("cpage"));
			}
			int rcount = nologordService.getnologOrdListCount(olbuyer);
			// 특정 회원(mlid)이 구매한 목록의 레코드 개수를 저장
			ArrayList<OrdInfo> ordList = nologordService.getOrdList(request, olbuyer, cpage, limit);
			// 특정 회원이(mlid) 구매한 목록을 OrdInfo형 인스턴스의 ArrayList로 저장
			
			int mpage = (int)((double)rcount / limit + 0.95);
			int spage = (((int)((double)cpage / 10 + 0.9)) - 1) * 10 + 1;
			int epage = spage + 10 - 1;	
			if (epage > mpage)	epage = mpage;
			
			PageInfo pageInfo = new PageInfo();
			pageInfo.setCpage(cpage);	// 현재 페이지 번호
			pageInfo.setEpage(epage);	// 종료 페이지 번호(블록별 종료 페이지)
			pageInfo.setMpage(mpage);	// 전체 페이지 수
			pageInfo.setRcount(rcount);	// 전체 레코드 개수
			pageInfo.setSpage(spage);	// 시작 페이지 번호(블록별 시작 페이지)
			
			request.setAttribute("ordList", ordList);
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("olbuyer", olbuyer); // 여기서도 olbuyer를 설정
		
		} else if (command.equals("/nologlist.nologord")) {	// 검색이면
			System.out.println("Nologlist에 들어옴");
			lnk = "/ord/nologSchList.jsp";
			olbuyer = request.getParameter("orderName");
			String olids = request.getParameter("orderId");
			int rcount = nologordService.getnologOrdListCount(olbuyer);
			System.out.println("널 포인트 찾기");
			ArrayList<OrdInfo> nologordList = nologordService.getNologOrdList(request, olbuyer, olids);
			System.out.println("널 포인트 찾기");
			request.setAttribute("ordList", nologordList);
			request.setAttribute("olbuyer", olbuyer); // 여기서도 olbuyer를 설정
			request.setAttribute("olids", olids); // 여기서도 olbuyer를 설정
		
		} else if (command.equals("/view.nologord")) {	// 구매상세보기 화면이면
			System.out.println("view에 들어옴");
			lnk = "/ord/nologordView.jsp";
			String olid = request.getParameter("olids");
			OrdInfo ordInfo = nologordService.getOrdInfo(request, request.getParameter("olid"));
			System.out.println("olid " + olid);
			request.setAttribute("ordInfo", ordInfo);
			System.out.println(ordInfo);
			
		} else if (command.equals("/ordcancel.nologord")) {	// 구매삭제 기능이면
			result = nologordService.orderCancel(request);
			lnk = "main";
			
			String buyer = request.getParameter("olbuyer");
			String olids = request.getParameter("olids");
			System.out.println(buyer +  " // " + olids);
			
			
		}
		
		forward.setPath(lnk);
		if (result < 1) {
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
