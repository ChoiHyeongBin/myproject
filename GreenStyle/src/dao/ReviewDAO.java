package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class ReviewDAO {
	private static ReviewDAO reviewDAO;
	private Connection conn;
	
	private ReviewDAO() {}	
		
	public static ReviewDAO getInstance() {
		if (reviewDAO == null) {	
			reviewDAO = new ReviewDAO();
		}
		
		return reviewDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int insertReview(HttpServletRequest request, String mlid) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			String img1 = request.getParameter("img1");
			String olid = request.getParameter("olid");
			String plid = request.getParameter("plid");
			String kind = request.getParameter("kind");
			int score = Integer.parseInt(request.getParameter("scores"));
			// int num = Integer.parseInt(request.getParameter("num"));
			
			String sql = "insert into t_review_list (ml_id, ol_id, pl_id, rl_kind, rl_content, rl_img1, rl_ip, al_num, rl_score)";
			sql += " values ('" + mlid + "', '"  + olid + "', '"  + plid + "', '" + kind + "', '" + content + "', '" + img1 +  "', 0, 0, " + score + ");";
			System.out.println("insertReview : " + sql);
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("insertReview() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return result;
	}
	
	public int updateReview(HttpServletRequest request, String mlid) {
		int result = 0;
		Statement stmt = null;
		try {
			String num = request.getParameter("num");
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			String img1 = request.getParameter("img1");
			String olid = request.getParameter("olid");
			String plid = request.getParameter("plid");
			String kind = request.getParameter("kind");
			String score = request.getParameter("scores");
			
			String sql = "update t_review_list set ";
			sql += "rl_content = '" + content + "' , rl_score = " + score + " , rl_kind = '" + kind + "' ";
			
			if(img1 != null) {
				sql += " , rl_img1 = '" + img1 + "' ";
			}
			
			sql += "where rl_num = " + num + " and ml_id = '" + mlid + "' ";
			System.out.println("updateReview : " + sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("updateReview() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public ReviewInfo getReview(int num) {
		ReviewInfo reviewInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_review_list where rl_num = " + num;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				reviewInfo = new ReviewInfo();
				
				reviewInfo.setRl_num(rs.getInt("rl_num"));
				reviewInfo.setRl_kind(rs.getString("rl_kind"));
				reviewInfo.setRl_content(rs.getString("rl_content"));
				reviewInfo.setRl_date(rs.getString("rl_date"));
				reviewInfo.setRl_score(rs.getInt("rl_score"));
				reviewInfo.setRl_img1(rs.getString("rl_img1"));
				reviewInfo.setAl_num(rs.getInt("al_num"));
				reviewInfo.setOl_id(rs.getString("ol_id"));
				reviewInfo.setPl_id(rs.getString("pl_id"));
			}
			
		} catch (Exception e) {
			System.out.println("getReview() 메소드에서 오류 발생");
			close(rs);
			close(stmt);
		}
		
		return reviewInfo;
	}
	
	public ArrayList<ReviewInfo> getReviewList(String where, int cpage, int limit) {
		ArrayList<ReviewInfo> reviewList = new ArrayList<ReviewInfo>(); 
		Statement stmt = null;
		ResultSet rs = null;
		ReviewInfo reviewInfo = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_review_list where 1=1 " + where;
			sql += " order by rl_num desc limit " + start + ", " + limit;
			System.out.println("getReviewList SQL : " + sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				reviewInfo = new ReviewInfo();
				
				reviewInfo.setRl_num(rs.getInt("rl_num"));
				reviewInfo.setMl_id(rs.getString("ml_id"));
				reviewInfo.setRl_kind(rs.getString("rl_kind"));
				reviewInfo.setRl_content(rs.getString("rl_content"));
				reviewInfo.setOl_id(rs.getString("ol_id"));
				reviewInfo.setPl_id(rs.getString("pl_id"));
				reviewInfo.setRl_score(rs.getInt("rl_score"));
				reviewInfo.setRl_date(rs.getString("rl_date"));
				reviewInfo.setOl_id(rs.getString("ol_id"));
				reviewInfo.setPl_id(rs.getString("pl_id"));
				
				reviewList.add(reviewInfo);
			}

		} catch (Exception e) {
			System.out.println("getReviewList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return reviewList;
	}
	
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_review_list where 1=1 " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	
			rcount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("getListCount() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcount;
	} 
}
