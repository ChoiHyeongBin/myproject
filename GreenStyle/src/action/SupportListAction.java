package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class SupportListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ArrayList<NoticeInfo> noticeList = new ArrayList<NoticeInfo>();
		ArrayList<FaqInfo> faqList = new ArrayList<FaqInfo>();
		
		NoticeService noticeService = new NoticeService();
		FaqService faqService = new FaqService();
		
		int rcount1 = noticeService.getListCount("");
		int rcount2 = faqService.getListCount("");
		
		noticeList = noticeService.getNoticeList("", 1, 10);
		faqList = faqService.getFaqList("", 1, 10);
		
		request.setAttribute("rcount1", rcount1);
		request.setAttribute("rcount2", rcount2);
		
		request.setAttribute("noticeList", noticeList);
		request.setAttribute("faqList", faqList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/board/supportForm.jsp");

		return forward;
	}
}
