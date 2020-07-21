package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AdminStatsAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		AdminStatsService adminStatsService = new AdminStatsService();
		
		ArrayList<TopPdtInfo> TopPdtList = adminStatsService.getPdtTop();
		ArrayList<TopMemberInfo> TopMemberList = adminStatsService.getMemberTop();
		int Profit = adminStatsService.getProfit();
		
		ArrayList<TopPdtInfo> TopMenList = adminStatsService.getMenTop();
		ArrayList<TopPdtInfo> TopWomenList = adminStatsService.getWomenTop();
		
		request.setAttribute("TopPdtList", TopPdtList);
		request.setAttribute("TopMemberList", TopMemberList);
		request.setAttribute("Profit", Profit);
		
		request.setAttribute("TopMenList", TopMenList);
		request.setAttribute("TopWomenList", TopWomenList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/admin/stats/statsMain.jsp");

		return forward;
	}
}
