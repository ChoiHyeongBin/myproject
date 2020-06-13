package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import svc.*;
import vo.*;

public class FaqService {
	public int getListCount(String where) {
		int rcount = 0;
		FaqDAO faqDAO = FaqDAO.getInstance();
		Connection conn = getConnection();
		faqDAO.setConnection(conn);
		rcount = faqDAO.getListCount(where);
		close(conn);
		return rcount;
	}
	
	public ArrayList<FaqInfo> getFaqList(String where, int cpage, int limit) {
		ArrayList<FaqInfo> faqList = new ArrayList<FaqInfo>();
		FaqDAO faqDAO = FaqDAO.getInstance();
		Connection conn = getConnection();
		faqDAO.setConnection(conn);
		faqList = faqDAO.getFaqList(where, cpage, limit);
		close(conn);
		return faqList;
	}
	
	public String insertFaq(HttpServletRequest request) {
		FaqDAO faqDAO = FaqDAO.getInstance();
		Connection conn = getConnection();
		faqDAO.setConnection(conn);
		String flResult = faqDAO.insertFaq(request);
		int result = Integer.parseInt(flResult.substring(0, flResult.indexOf(':')));
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);
		
		return flResult;
	}
	
	public int updateFaq(HttpServletRequest request) {
		FaqDAO faqDAO = FaqDAO.getInstance();
		Connection conn = getConnection();
		faqDAO.setConnection(conn);
		int result = faqDAO.updateFaq(request);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);
		
		return result;
	}
	
	public int deleteFaq(HttpServletRequest request) {
		FaqDAO faqDAO = FaqDAO.getInstance();
		Connection conn = getConnection();
		faqDAO.setConnection(conn);
		int result = faqDAO.deleteFaq(request);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);
		
		return result;
	}
		
	
	public FaqInfo getFaq(int num) {
		FaqInfo faqInfo = null;
		FaqDAO faqDAO = FaqDAO.getInstance();
		Connection conn = getConnection();
		faqDAO.setConnection(conn);
		faqInfo = faqDAO.getFaq(num);
		close(conn);
		return faqInfo;
	}
	
	public int updateRead(int num) {
		FaqDAO faqDAO = FaqDAO.getInstance();
		Connection conn = getConnection();
		faqDAO.setConnection(conn);
		int result = faqDAO.updateRead(num);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);
		
		return result;
	}
}