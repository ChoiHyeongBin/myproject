package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import svc.*;
import vo.*;

public class QnaService {
	public int insertQna(HttpServletRequest request) {
		QnaDAO qnaDAO = QnaDAO.getInstance();
		Connection conn = getConnection();
		qnaDAO.setConnection(conn);
		int result = qnaDAO.insertQna(request);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);

		return result;
	}
	
	public ArrayList<QnaInfo> getQnaList(String where, int cpage, int limit) {
		ArrayList<QnaInfo> qnaList = new ArrayList<QnaInfo>();
		QnaDAO qnaDAO = QnaDAO.getInstance();
		Connection conn = getConnection();
		qnaDAO.setConnection(conn);
		qnaList = qnaDAO.getQnaList(where, cpage, limit);
		close(conn);
		
		return qnaList;
	}
	
	public int getListCount(String where) {
		int rcount = 0;
		QnaDAO qnaDAO = QnaDAO.getInstance();
		Connection conn = getConnection();
		qnaDAO.setConnection(conn);
		rcount = qnaDAO.getListCount(where);
		close(conn);
		return rcount;
	}
	
	public QnaInfo getQna(int num) {
		QnaInfo qnaInfo = null;
		QnaDAO qnaDAO = QnaDAO.getInstance();
		Connection conn = getConnection();
		qnaDAO.setConnection(conn);
		qnaInfo = qnaDAO.getQna(num);
		close(conn);
		return qnaInfo;
	}
	
	public int updateQna(HttpServletRequest request) {
		QnaDAO qnaDAO = QnaDAO.getInstance();
		Connection conn = getConnection();
		qnaDAO.setConnection(conn);
		int result = qnaDAO.updateQna(request);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);

		return result;
	}
}