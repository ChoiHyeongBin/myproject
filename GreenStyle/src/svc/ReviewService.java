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

public class ReviewService {
	public int insertReview(HttpServletRequest request, String mlid) {
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		Connection conn = getConnection();
		reviewDAO.setConnection(conn);
		int result = reviewDAO.insertReview(request, mlid);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);

		return result;
	} 
	
	public int updateReview(HttpServletRequest request, String mlid) {
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		Connection conn = getConnection();
		reviewDAO.setConnection(conn);
		int result = reviewDAO.updateReview(request, mlid);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);
		
		return result;
	}
	
	public ReviewInfo getReview(int num) {
		ReviewInfo reviewInfo = null;
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		Connection conn = getConnection();
		reviewDAO.setConnection(conn);
		reviewInfo = reviewDAO.getReview(num);
		close(conn);
		return reviewInfo;
	}
	
	public ArrayList<ReviewInfo> getReviewList(String where, int cpage, int limit) {
		ArrayList<ReviewInfo> reviewList = new ArrayList<ReviewInfo>();
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		Connection conn = getConnection();
		reviewDAO.setConnection(conn);
		reviewList = reviewDAO.getReviewList(where, cpage, limit);
		close(conn);
		
		return reviewList;
	}
	
	public int getListCount(String where) {
		int rcount = 0;
		ReviewDAO reviewDAO = ReviewDAO.getInstance();
		Connection conn = getConnection();
		reviewDAO.setConnection(conn);
		rcount = reviewDAO.getListCount(where);
		close(conn);
		return rcount;
	}
}