package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class FaqDAO {
	private static FaqDAO faqDAO;
	private Connection conn;
	
	private FaqDAO() {}	
		
	public static FaqDAO getInstance() {
		if (faqDAO == null) {	
			faqDAO = new FaqDAO();
		}
		
		return faqDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_faq_list where 1=1 " + where;
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
	
	public ArrayList<FaqInfo> getFaqList(String where, int cpage, int limit) {
		ArrayList<FaqInfo> faqList = new ArrayList<FaqInfo>(); 
		Statement stmt = null;
		ResultSet rs = null;
		FaqInfo faqInfo = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_faq_list where 1=1 " + where;
			sql += " order by fl_num desc limit " + start + ", " + limit;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				faqInfo = new FaqInfo();
				// 하나의 게시글 데이터를 담기 위한 NoticeInfo 인스턴스 생성
				
				faqInfo.setFl_num(rs.getInt("fl_num"));
				faqInfo.setFl_kind(rs.getString("fl_kind"));
				faqInfo.setFl_title(rs.getString("fl_title"));
				faqInfo.setFl_content(rs.getString("fl_content"));
				faqInfo.setAl_num(rs.getInt("al_num"));
				
				faqList.add(faqInfo);
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}

		} catch (Exception e) {
			System.out.println("getFaqList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return faqList;
	}
	
	public String insertFaq(HttpServletRequest request) {
		int result = 0, flnum = 1;
		String flResult = "";
		Statement stmt = null;
		ResultSet rs = null;	
		
		try {
			String sql = "select max(fl_num) + 1 from t_faq_list";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	flnum = rs.getInt(1);
			
			String title = request.getParameter("title").trim().replaceAll("'", "''");
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			
			sql = "insert into t_faq_list (fl_num, fl_title, fl_content, al_num) values (" + flnum + ", '";
			sql += title + "', '" + content + "', 0)";
			result = stmt.executeUpdate(sql);
			flResult = result + ":" + flnum;
		} catch (Exception e) {
			System.out.println("insertFaq() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return flResult;
	}
	
	public FaqInfo getFaq(int num) {
		FaqInfo faqInfo = null;
		// 지정한 공지사항 글 데이터를 저장하기 위한 인스턴스
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_notice_list where nl_num = " + num;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				faqInfo = new FaqInfo();
				
				faqInfo.setFl_num(rs.getInt("fl_num"));
				faqInfo.setFl_kind(rs.getString("fl_kind"));
				faqInfo.setFl_title(rs.getString("fl_title"));
				faqInfo.setFl_content(rs.getString("fl_content"));
				faqInfo.setAl_num(rs.getInt("al_num"));
				
			}
			
		} catch (Exception e) {
			System.out.println("getFaq() 메소드에서 오류 발생");
			close(rs);
			close(stmt);
		}
		
		return faqInfo;
	}
	
	public int updateFaq(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			String num = request.getParameter("num");
			String title = request.getParameter("title").trim().replaceAll("'", "''");
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			
			String sql = "update t_faq_list set ";
			sql += "fl_title = '" + title + "', ";
			sql += "fl_content = '" + content + "' ";
			sql += "where fl_num = " + num;
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("updateFaq() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int deleteFaq(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			String num = request.getParameter("num");
			
			String sql = "delete from t_faq_list where fl_num = " + num;
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("deleteFaq() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int updateRead(int num) {
		int result = 0;
		Statement stmt = null;
		try {
			String sql = "update t_faq_list set ";
			sql += "fl_read = fl_read + 1 where fl_num = " + num;
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("updateRead() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}

}
