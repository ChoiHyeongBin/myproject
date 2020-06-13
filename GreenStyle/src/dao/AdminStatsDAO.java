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

public class AdminStatsDAO {
	private static AdminStatsDAO adminStatsDAO;
	private Connection conn;
	
	private AdminStatsDAO() {}	
	
	public static AdminStatsDAO getInstance() {
		if (adminStatsDAO == null) {	
			adminStatsDAO = new AdminStatsDAO();
		}
		
		return adminStatsDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getProfit() {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select sum(ol_pay) from t_order_list;";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				result = rs.getInt(1);
				System.out.println("총 금액 : " + result);
			}
		} catch (Exception e) {
			System.out.println("getProfit() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		return result;
	}
	
	public ArrayList<TopPdtInfo> getPdtTop() {
		ArrayList<TopPdtInfo> TopPdtList = new ArrayList<TopPdtInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		TopPdtInfo topPdt = null;
		
		try {
			String sql = "select pl_id, pl_name, pl_salecnt, (pl_price * pl_salecnt) from t_product_list order by pl_salecnt desc limit 0, 10";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				topPdt = new TopPdtInfo();
				topPdt.setPl_id(rs.getString(1));
				topPdt.setPl_name(rs.getString(2));
				topPdt.setPl_salecnt(rs.getInt(3));
				topPdt.setPl_income(rs.getInt(4));
				
				TopPdtList.add(topPdt);
			}
		} catch (Exception e) {
			System.out.println("getPdtTop() 메소드에서 오류 발생");
			
		} finally {
			close(rs);
			close(stmt);
		}
		
		return TopPdtList;
	}
	
	public ArrayList<TopMemberInfo> getMemberTop() {
		ArrayList<TopMemberInfo> TopMemberList = new ArrayList<TopMemberInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		TopMemberInfo topMember = null;
		
		try {
			String sql = "select m.ml_id, m.ml_name, sum(o.ol_pay), count(o.ol_num) from t_member_list m, t_order_list o where m.ml_id = o.ol_buyer group by ml_id order by sum(o.ol_pay) desc limit 0, 10;";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				topMember = new TopMemberInfo();
				topMember.setMl_id(rs.getString(1));
				topMember.setMl_name(rs.getString(2));
				topMember.setMl_Purchase(rs.getInt(3));
				topMember.setOl_count(rs.getInt(4));
				
				TopMemberList.add(topMember);
			}
		} catch (Exception e) {
			System.out.println("getMemberTop() 메소드에서 오류 발생");
			
		} finally {
			close(rs);
			close(stmt);
		}
		
		return TopMemberList;
	}
	
	public ArrayList<TopPdtInfo> getMenTop() {
		ArrayList<TopPdtInfo> TopMenList = new ArrayList<TopPdtInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		TopPdtInfo topPdt = null;
		
		try {
			String sql = "select pl_id, pl_name, pl_salecnt, (pl_price * pl_salecnt) from t_product_list where cb_id = 'cb01' order by pl_salecnt desc limit 0, 10;";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				topPdt = new TopPdtInfo();
				topPdt.setPl_id(rs.getString(1));
				topPdt.setPl_name(rs.getString(2));
				topPdt.setPl_salecnt(rs.getInt(3));
				topPdt.setPl_income(rs.getInt(4));
				
				TopMenList.add(topPdt);
			}
		} catch (Exception e) {
			System.out.println("getMenTop() 메소드에서 오류 발생");
			
		} finally {
			close(rs);
			close(stmt);
		}
		
		return TopMenList;
	}
	
	public ArrayList<TopPdtInfo> getWomenTop() {
		ArrayList<TopPdtInfo> TopWomenList = new ArrayList<TopPdtInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		TopPdtInfo topPdt = null;
		
		try {
			String sql = "select pl_id, pl_name, pl_salecnt, (pl_price * pl_salecnt) from t_product_list where cb_id = 'cb02' order by pl_salecnt desc limit 0, 10;";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				topPdt = new TopPdtInfo();
				topPdt.setPl_id(rs.getString(1));
				topPdt.setPl_name(rs.getString(2));
				topPdt.setPl_salecnt(rs.getInt(3));
				topPdt.setPl_income(rs.getInt(4));
				
				TopWomenList.add(topPdt);
			}
		} catch (Exception e) {
			System.out.println("getWomenTop() 메소드에서 오류 발생");
			
		} finally {
			close(rs);
			close(stmt);
		}
		
		return TopWomenList;
	}
}