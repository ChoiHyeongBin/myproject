package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import svc.*;
import vo.*;

public class AdminNoticeService {
	public int getListCount(String where) {
		int rcount = 0;
		AdminNoticeDAO adminNoticeDAO = AdminNoticeDAO.getInstance();
		Connection conn = getConnection();
		adminNoticeDAO.setConnection(conn);
		rcount = adminNoticeDAO.getListCount(where);
		close(conn);
		return rcount;
	}
	
	public ArrayList<NoticeInfo> getNoticeList(String where, int cpage, int limit) {
		ArrayList<NoticeInfo> noticeList = null;
		AdminNoticeDAO adminNoticeDAO = AdminNoticeDAO.getInstance();
		Connection conn = getConnection();
		adminNoticeDAO.setConnection(conn);
		noticeList = adminNoticeDAO.getNoticeList(where, cpage, limit);
		close(conn);
		
		return noticeList;
	}
	
	public int insertNotice(HttpServletRequest request) {
		int result = 0;
		AdminNoticeDAO adminNoticeDAO = AdminNoticeDAO.getInstance();
	
		Connection conn = getConnection();
		adminNoticeDAO.setConnection(conn);
		
		result = adminNoticeDAO.insertNotice(request);
		
		
		if (result == 1) { commit(conn);
		} else {				
			rollback(conn);		
		}
		close(conn);
		
		return result;
	}
	
	public int updateNotice(HttpServletRequest request) {
		int result = 0;
		AdminNoticeDAO adminNoticeDAO = AdminNoticeDAO.getInstance();
	
		Connection conn = getConnection();
		adminNoticeDAO.setConnection(conn);
		
		result = adminNoticeDAO.updateNotice(request);
		
		
		if (result == 1) { commit(conn);
		} else {				
			rollback(conn);		
		}
		close(conn);
		
		return result;
	}
	
	public NoticeInfo getNotice(int num) {
		NoticeInfo noticeInfo = null;
		AdminNoticeDAO adminNoticeDAO = AdminNoticeDAO.getInstance();
		Connection conn = getConnection();
		adminNoticeDAO.setConnection(conn);
		noticeInfo = adminNoticeDAO.getNotice(num);
		close(conn);
		
		return noticeInfo;
	}
}
