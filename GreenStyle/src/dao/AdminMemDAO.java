package dao;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class AdminMemDAO {
	private static AdminMemDAO adminMemDAO;
	private Connection conn;
	
	private AdminMemDAO() {}	
	
	public static AdminMemDAO getInstance() {
		if (adminMemDAO == null) {	
			adminMemDAO = new AdminMemDAO();
		}
		
		return adminMemDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<MemberInfo> getMemList(String where, int cpage, int limit) {
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo mem = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_member_list where 1=1 " + where;
			sql += " order by ml_num desc limit " + start + ", " + limit;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				mem = new MemberInfo();
				mem.setMl_num(rs.getInt("ml_num"));
				mem.setMl_id(rs.getString("ml_id"));
				mem.setMl_name(rs.getString("ml_name"));
				mem.setMl_birth(rs.getString("ml_birth"));
				mem.setMl_phone(rs.getString("ml_phone"));
				mem.setMl_email(rs.getString("ml_email"));
				mem.setMl_date(rs.getString("ml_date"));
				mem.setMl_lastlogin(rs.getString("ml_lastlogin"));
				mem.setMl_isrun(rs.getString("ml_isrun"));
				
				   
				// 생성된 인스턴스에 데이터 채우기
				   
				memberList.add(mem);
				// 상품 목록을 담을 ArrayList에 생성한 인스턴스를 넣음

			}
		} catch (Exception e) {
			System.out.println("getMemberList() 메소드에서 오류 발생");
			
		} finally {
			close(rs);
			close(stmt);
		}
		return memberList;
	}
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_member_list where 1=1 " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	// if문을 사용하지 않는 것은 count()결과이므로 무조건 결과값이 존재하므로
			rcount = rs.getInt(1);
			System.out.println(sql);
		} catch (Exception e) {
			System.out.println("getListCount() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcount;
	} 
	
	 public int memberUpdate(HttpServletRequest request) {
	      
	      int result = 0;	
	      Statement stmt = null;
	      
	      
	      try {
	    	  request.setCharacterEncoding("utf-8");
	    	
	    	  // request객체의 사용에는 예외처리가 필요하므로 try문 안에서 작업
	    	  String uid = request.getParameter("uid");
	    	  // 회원정보 수정용 업데이트문에서 where절에 조건으로 사용하기 위한 id
	         
	         
	         String p1       = request.getParameter("p1");
	         String p2       = request.getParameter("p2");
	         String p3       = request.getParameter("p3");
	         String e1       = request.getParameter("e1").trim();
	         String e2       = request.getParameter("e2");
	         String status	 = request.getParameter("status");


	         String phone    = p1 + "-" + p2 + "-" + p3;
	         String email   = e1 + "@" + e2;
	         
	         
	         String sql = "update t_member_list set ";
	         
	         sql += "ml_phone = '" 		+ phone 	+ "', ";
	         sql += "ml_email = '" 		+ email 	+ "', ";
	         sql += "ml_isrun = '"		+ status	+ "' ";
	         sql += "where ml_id = '" 	+ uid 		+ "' ";
	         System.out.println(sql);

	         stmt = conn.createStatement();
	         result = stmt.executeUpdate(sql);

	      } catch (Exception e) {
	         System.out.println("memberUpdate(admin) 메소드 오류");
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
	 
	 public MemberInfo getMember(int num) {
		 	MemberInfo memberInfo = null;
			// 지정한 공지사항 글 데이터를 저장하기 위한 인스턴스
			Statement stmt = null;
			// DB에 쿼리를 보내주는 객체
			ResultSet rs = null;
			// 받아온 쿼리를 담는 객체
			
			try {
				String sql = "select * from t_member_list where ml_num = " + num;
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);	// ResultSet 생성
				if (rs.next()) {
					memberInfo = new MemberInfo();
					// 하나의 게시글 데이터를 담기 위한 NoticeInfo 인스턴스 생성
					
					memberInfo.setMl_num(rs.getInt("ml_num"));
					memberInfo.setMl_id(rs.getString("ml_id"));
					
					memberInfo.setMl_name(rs.getString("ml_name"));
					memberInfo.setMl_phone(rs.getString("ml_phone"));
					memberInfo.setMl_email(rs.getString("ml_email"));
					memberInfo.setMl_birth(rs.getString("ml_birth"));
					memberInfo.setMl_date(rs.getString("ml_date"));
					memberInfo.setMl_lastlogin(rs.getString("ml_lastlogin"));
					memberInfo.setMl_isrun(rs.getString("ml_isrun"));
					// 생성된 인스턴스에 데이터 채우기
				}
			} catch(Exception e) {
				System.out.println("getMember() 메소드에서 오류 발생");
			} finally {
				close(rs);
				close(stmt);
			}
			
			return memberInfo;
		}
	 
}
