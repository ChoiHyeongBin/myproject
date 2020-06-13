package dao;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.MemberInfo;

public class MemberDAO {
	private static MemberDAO memberDAO;
	   private Connection conn;
	   
	   private MemberDAO() {}
	   
	   public static MemberDAO getInstance() {
	      if (memberDAO == null) {      
	    	  memberDAO = new MemberDAO();
	      } 
	      
	      return memberDAO;
	   }
	   
	   public void setConnection(Connection conn) {
	      this.conn = conn;
	   }
	   
	   public int memberUpdate(HttpServletRequest request) {
		      
		      int result = 0;	
		      Statement stmt = null;
		      
		      
		      try {
		    	  HttpSession session = request.getSession();
		    	  request.setCharacterEncoding("utf-8");
		    	  MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
		    	  
		    	  // request객체의 사용에는 예외처리가 필요하므로 try문 안에서 작업
		    	  String uid = memberInfo.getMl_id();
		    	  // 회원정보 수정용 업데이트문에서 where절에 조건으로 사용하기 위한 id
		    	  
		         String pwd      = request.getParameter("pwd").toLowerCase().trim();
		         String by       = request.getParameter("by");
		         String bm       = request.getParameter("bm");
		         String bd       = request.getParameter("bd");
		         String p1       = request.getParameter("p1");
		         String p2       = request.getParameter("p2");
		         String p3       = request.getParameter("p3");
		         String e1       = request.getParameter("e1").trim();
		         String e2       = request.getParameter("e2");
		         String zip       = request.getParameter("zip");
		         String addr1       = request.getParameter("addr1");
		         String addr2       = request.getParameter("addr2");
		         

		         String birth   = by + "-" + bm + "-" + bd;
		         String phone    = p1 + "-" + p2 + "-" + p3;
		         String email   = e1 + "@" + e2;
		         
		         String sql = "update t_member_list set ";
		         sql += "ml_pwd = '" 		+ pwd 		+ "', ";
		         sql += "ml_birth = '" 		+ birth 	+ "', ";
		         sql += "ml_phone = '" 		+ phone 	+ "', ";
		         sql += "ml_email = '" 		+ email 	+ "' ";
		         sql += "where ml_id = '" 	+ uid 		+ "' ";
		        
		         System.out.println(sql);
		         
		         
		         stmt = conn.createStatement();
		         result = stmt.executeUpdate(sql);
		         
		         if (zip != null && !zip.equals("")) {
		        	 result = 0;
		        	 sql = "update t_member_addr set ";
			         sql+= "ma_zip = '" + zip + "', ";
			         sql+= "ma_addr1 = '" + addr1 + "', ";
			         sql+= "ma_addr2 = '" + addr2 + "' ";
			         sql += "where ml_id = '" 	+ uid 		+ "' ";
			         result = stmt.executeUpdate(sql);
			         System.out.println(sql);
		         }
		         
		         
		         if (result == 1) {
		        	// 정보수정이 정상적으로 이루어졌으면 로그인 정보도 수정해 줌
		        	memberInfo.setMl_pwd(pwd);
		        	memberInfo.setMl_birth(birth);
		        	memberInfo.setMl_phone(phone);
		        	memberInfo.setMl_email(email);
		        	memberInfo.setMa_zip(zip);
		        	memberInfo.setMa_addr1(addr1);
		        	memberInfo.setMa_addr2(addr2);
		         }

		      } catch (Exception e) {
		         System.out.println("memberUpdate() 메소드 오류");
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
	   public int memberDelete(HttpServletRequest request) {
		   int result = 0;	
		   Statement stmt = null;
		   try {
		    	  HttpSession session = request.getSession();
		    	  request.setCharacterEncoding("utf-8");
		    	  MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
		    	  // request객체의 사용에는 예외처리가 필요하므로 try문 안에서 작업
		    	  String uid = memberInfo.getMl_id();
		    	  // 회원정보 수정용 업데이트문에서 where절에 조건으로 사용하기 위한 id

		         String sql = "update t_member_list set ";
		         sql += "ml_isrun = 'n' ";
		         sql += "where ml_id = '" 	+ uid 	+ "' ";
		        
		         System.out.println(sql);
		         
		         
		         stmt = conn.createStatement();
		         result = stmt.executeUpdate(sql);

		      } catch (Exception e) {
		         System.out.println("memberDelete() 메소드 오류");
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
}
