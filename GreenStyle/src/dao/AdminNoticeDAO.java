package dao;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.ArrayList;
import javax.servlet.http.*;

import com.mysql.cj.protocol.x.Notice;

import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class AdminNoticeDAO {
	private static AdminNoticeDAO adminNoticeDAO;
	private Connection conn;
	
	private AdminNoticeDAO() {}	
	
	public static AdminNoticeDAO getInstance() {
		if (adminNoticeDAO == null) {	
			adminNoticeDAO = new AdminNoticeDAO();
		}
		
		return adminNoticeDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<NoticeInfo> getNoticeList(String where, int cpage, int limit) {
		ArrayList<NoticeInfo> noticeList = new ArrayList<NoticeInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		NoticeInfo notice = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_notice_list where 1=1 " + where;
			sql += " order by nl_num desc limit " + start + ", " + limit;
			System.out.println("getNoticeList : " + sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				notice = new NoticeInfo();
				notice.setNl_num(rs.getInt("nl_num"));
				notice.setNl_title(rs.getString("nl_title"));
				notice.setNl_content(rs.getString("nl_content"));
				notice.setNl_kind(rs.getString("nl_kind"));
				notice.setNl_read(rs.getInt("nl_read"));
				notice.setNl_date(rs.getString("nl_date"));
				notice.setAl_num(rs.getInt("al_num"));
				notice.setNl_isview(rs.getString("nl_isview"));
				notice.setAl_name(rs.getString("al_name"));
				
				noticeList.add(notice);
			}
		} catch (Exception e) {
			System.out.println("getNoticeList() 메소드에서 오류 발생");
			
		} finally {
			close(rs);
			close(stmt);
		}
		return noticeList;
	}
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_notice_list where 1=1 " + where;
			System.out.println("getListCount : " + sql);
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
	
	public int insertNotice(HttpServletRequest request) {
		  
		  int result = 0;	
		  Statement stmt = null;;
		  
		  String sql = "";
		  
		  try {
			 request.setCharacterEncoding("utf-8");
			 String title = request.getParameter("title").trim().replaceAll("'", "''");
			 String content = request.getParameter("content").trim().replaceAll("'", "''");
			 String kind = request.getParameter("kind");
			 String isview = request.getParameter("isview");
			 String alName = request.getParameter("alName");
			 
			 sql = "insert into t_notice_list (nl_kind, nl_title, nl_content, nl_isview, al_name)";
			 sql += "values ('" + kind + "', '" + title +"', '" + content + "', '" + isview + "', '" + alName + "');";
		  
		     stmt = conn.createStatement();
		     result = stmt.executeUpdate(sql);
		
		  } catch (Exception e) {
		     System.out.println("insertNotice() 메소드 오류");
		         e.printStackTrace();
		      } finally {
		         try {
		            close(stmt);
		         } catch (Exception e) {
		            e.printStackTrace();
		         } 
		      }
		      
		      return result;
		   }
	
	 public int updateNotice(HttpServletRequest request) {
	      
	      int result = 0;	
	      Statement stmt = null;
	      String wtype = request.getParameter("wtype");
	      String kind = request.getParameter("kind");
	      String title = request.getParameter("title");
	      String content = request.getParameter("content");
	      String num = request.getParameter("num");
	      String isview = request.getParameter("isview");
	      
	      String sql = "";
	      
	      try {
	    	 request.setCharacterEncoding("utf-8");

	    	 if (wtype.equals("up")) {
	    		 sql = "update t_notice_list set nl_kind = '" + kind + "', nl_title = '" + title + "', nl_content = '" + content + "', nl_isview = '" + isview + "' ";
	    		 sql += " where nl_num = " + num;
	    	 } else if (wtype.equals("del")) {
	    		 sql = "update t_notice_list set nl_isview = 'n' where nl_num = " + num; 
	    	 }
	    	 System.out.println("updateNotice : " + sql);
	    	 
	         stmt = conn.createStatement();
	         result = stmt.executeUpdate(sql);

	      } catch (Exception e) {
	         System.out.println("updateNotice() 메소드 오류");
	         e.printStackTrace();
	      } finally {
	         try {
	            close(stmt);
	         } catch (Exception e) {
	            e.printStackTrace();
	         } 
	      }
	      
	      return result;
	   }
	 
	 public NoticeInfo getNotice(int num) {
		 	NoticeInfo noticeInfo = null;
			Statement stmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "select * from t_notice_list where nl_num = " + num;
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
					noticeInfo = new NoticeInfo();
					
					noticeInfo.setNl_num(rs.getInt("nl_num"));
					noticeInfo.setNl_title(rs.getString("nl_title"));
					noticeInfo.setNl_content(rs.getString("nl_content"));
					noticeInfo.setNl_kind(rs.getString("nl_kind"));
					noticeInfo.setNl_read(rs.getInt("nl_read"));
					noticeInfo.setNl_date(rs.getString("nl_date"));
					noticeInfo.setAl_num(rs.getInt("al_num"));
					noticeInfo.setNl_isview(rs.getString("nl_isview"));
					noticeInfo.setAl_name(rs.getString("al_name"));
				}
			} catch(Exception e) {
				System.out.println("getNotice() 메소드에서 오류 발생");
			} finally {
				close(rs);
				close(stmt);
			}
			
			return noticeInfo;
		}
}
