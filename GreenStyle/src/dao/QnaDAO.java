package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class QnaDAO {
	private static QnaDAO qnaDAO;
	private Connection conn;
	
	private QnaDAO() {}	
		
	public static QnaDAO getInstance() {
		if (qnaDAO == null) {	
			qnaDAO = new QnaDAO();
		}
		
		return qnaDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int insertQna(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String olid = request.getParameter("findOrd");
			System.out.println("ol_id : " + olid);
			String title = request.getParameter("title").trim().replaceAll("'", "''");
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			String kind = request.getParameter("kind");
			String img = request.getParameter("file");
			String sql = "";
			String mlid = "";
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
			if (mem != null) {
			mlid = mem.getMl_id();
			}
			String nologin = request.getParameter("nologin");
			System.out.println("nologin : " + nologin);
			
			if (olid != null && !olid.equals("")) {
				System.out.println("주문번호 있음");
				sql = "insert into t_qna_list (ql_kind, ml_id, ql_title, ql_content, ql_ip, ql_img1 , al_num, ol_id)";
				sql += " values ('" + kind + "', '" + mlid + "', '" + title + "', '" + content + "', 0, '" + img + "', 0 , "+ olid +");";
			} else if(mlid != null && !mlid.equals("")){
				System.out.println("주문번호 없음");
				sql = "insert into t_qna_list (ql_kind, ml_id, ql_title, ql_content, ql_ip, ql_img1 , al_num)";
				sql += " values ('" + kind + "', '" + mlid + "', '" + title + "', '" + content + "', 0, '" + img + "', 0);";
			} else {
				System.out.println("비로그인" );
				sql = "insert into t_qna_list (ql_kind, ql_nomem, ql_title, ql_content, ql_ip, ql_img1 , al_num)";
				sql += " values ('" + kind + "', '#" + nologin + "', '" + title + "', '" + content + "', 0, '" + img + "', 0);";
			}
			System.out.println(sql);
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("insertQna() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return result;
	}
	
	public ArrayList<QnaInfo> getQnaList(String where, int cpage, int limit) {
		ArrayList<QnaInfo> qnaList = new ArrayList<QnaInfo>(); 
		Statement stmt = null;
		ResultSet rs = null;
		QnaInfo qnaInfo = null;
		
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_qna_list where 1=1 " + where;
			sql += " order by ql_num desc limit " + start + ", " + limit;
			System.out.println("getQnaList SQL : " + sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				qnaInfo = new QnaInfo();
				qnaInfo.setQl_num(rs.getInt("ql_num"));
				qnaInfo.setQl_kind(rs.getString("ql_kind"));
				qnaInfo.setQl_title(rs.getString("ql_title"));
				qnaInfo.setQl_content(rs.getString("ql_content"));
				qnaInfo.setQl_date(rs.getString("ql_date"));
				qnaInfo.setQl_img1(rs.getString("ql_img1"));
				qnaInfo.setOl_id(rs.getString("ol_id"));
				qnaList.add(qnaInfo);
			}

		} catch (Exception e) {
			System.out.println("getQnaList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return qnaList;
	}
	
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_qna_list where 1=1 " + where;
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
	
	public QnaInfo getQna(int num) {
		QnaInfo qnaInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_qna_list where ql_num = " + num;
			System.out.println("getQna : " + sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				qnaInfo = new QnaInfo();
				
				qnaInfo.setQl_num(rs.getInt("ql_num"));
				qnaInfo.setQl_kind(rs.getString("ql_kind"));
				qnaInfo.setQl_title(rs.getString("ql_title"));
				qnaInfo.setQl_content(rs.getString("ql_content"));
				qnaInfo.setQl_date(rs.getString("ql_date"));
				qnaInfo.setQl_img1(rs.getString("ql_img1"));
				qnaInfo.setOl_id(rs.getString("ol_id"));
			}
			
		} catch (Exception e) {
			System.out.println("getQna() 메소드에서 오류 발생");
			close(rs);
			close(stmt);
		}
		
		return qnaInfo;
	}
	
	public int updateQna(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String olid = request.getParameter("findOrd");
			String title = request.getParameter("title").trim().replaceAll("'", "''");
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			String kind = request.getParameter("kind");
			String img = request.getParameter("file");
			String qlnum = request.getParameter("qlnum");
			String sql = "";
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
			String mlid = mem.getMl_id();		
			
			if (olid != null || olid.equals("")) {
				sql = "update t_qna_list set ql_kind = '" + kind + "' , ql_title = '" + title + "' , ql_content = '" + content + "' , ql_img1 = '" + img + "' , ol_id = " + olid;
				sql += " where ml_id = '" + mlid + "' and ql_num = " + qlnum;
			} else {
				sql = "update t_qna_list set ql_kind = '" + kind + "' , ql_title = '" + title + "' , ql_content = '" + content + "' , ql_img1 = '" + img;
				sql += " where ml_id = '" + mlid + "' and ql_num = " + qlnum;
			}
			System.out.println("updateQna() : " + sql);
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("updateQna() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return result;
	}
}
