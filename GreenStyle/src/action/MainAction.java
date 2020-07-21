package action;

import java.util.*;
import javax.servlet.http.*; 
import svc.*;
import vo.*;

public class MainAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  ArrayList<PdtInfo> pdtList = new ArrayList<PdtInfo>();
	      
	      request.setCharacterEncoding("utf-8");
	      
	      MainService mainService = new MainService();
	      String where = "";
	      where = " and cs_id = '" + request.getParameter("csid") + "' ";
	      pdtList = mainService.getPdtList(where);
	      
	      request.setAttribute("pdtList", pdtList);
	      
	      ActionForward forward = new ActionForward();
			forward.setPath("main.jsp");
			
			return forward;
	   }
}
