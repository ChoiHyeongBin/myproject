package action;

import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class NoticeListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String schType = request.getParameter("schType");	// 검색 조건
		String keyword = request.getParameter("keyword");	// 검색어
		String kind = request.getParameter("kind");			// 분류
		
		String where = "";	// 쿼리에 추가할 조건
		String seltag = null;	// 공지사항 분류
		
		if (schType != null && !schType.equals("") && keyword != null && !keyword.equals("")) {
			if (schType.equals("tc")) {	// 제목 + 내용 검색일 경우
				where = " and (nl_title like '%" + keyword + "%'";
				where += " or nl_content like '%" + keyword + "%'";
			} else if (schType.equals("writer")) {	// 글쓴이 검색일 경우
				where = " and (al_name like '%" + keyword + "%')";
			} else {	// 제목이나 내용 검색일 경우
				where = " and nl_" + schType + " like '%" + keyword + "%' ";
			}
		}
		if (kind != null) {
			if (kind.equals("nta")) {	// 알림/소식 이면
				where = " and nl_kind = 'a' ";
				seltag = "t2";
			} else if (kind.equals("evt")) {	// 이벤트 당첨 이면
				where = " and nl_kind = 'b' ";
				seltag = "t3";
			}
		} else {	// 전체 이면
			seltag = "t1";
		}
		
		ArrayList<NoticeInfo> noticeList = new ArrayList<NoticeInfo>();
		// 공지사항 목록을 저장하기 위한 컬렉션으로 NoticeInfo형 인스턴스만 저장됨
		int cpage = 1;	// 현재 페이지 번호를 저장할 변수
		int limit = 15;	// 한 페이지에서 보여줄 공지사항 개수, 페이지 크기
		
		if (request.getParameter("cpage") != null) {
		// 받아온 페이지 번호가 있으면 String에서 int형 데이터로 변형
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		NoticeService noticeService = new NoticeService();
		int rcount = noticeService.getListCount(where);
		noticeList = noticeService.getNoticeList(where, cpage, limit);
		
		int mpage = (int)((double)rcount / limit  + 0.95);
		int spage = ( ( (int) ( (double) cpage / 10 + 0.9) ) - 1 ) * 10 + 1;
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
		request.setAttribute("noticeList", noticeList);
		// request객체에 새로운 속성을 추가
		// 이동할 곳으로 request객체와 response객체를 공유하기 위해 Dispatcher방식 사용
		request.setAttribute("seltag", seltag);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/board/noticeList.jsp");
		
		return forward;
	}
}
