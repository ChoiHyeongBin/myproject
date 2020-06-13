package dao;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import vo.MemberInfo;
import static db.JdbcUtil.*;

public class LoginDAO {
	private static LoginDAO loginDAO;
	// 여러 개가 아닌 하나만 존재하게 하기 위한 static
	private Connection conn;
	private LoginDAO() {}
	
	public static LoginDAO getInstance() {
	// LoginDAO의 인스턴스를 생헝해주는 메소드로 하나의 인스턴스만 존재하게 됨
		if (loginDAO == null) {
			loginDAO = new LoginDAO();
			// 새로운 인스턴스를 생성
		}
		
		return loginDAO;
	}
	
	public void setConnection(Connection conn) {
	// LoginDAO에서 사용할 컨넥션 객체를 지정하는 메소드
		this.conn = conn;
	}
	
	public MemberInfo getLoginMember(String uid, String pwd) {
	// 입력받은 아이디와 비밀번호가 DB의 회원테이블에 실제 하는지 검사하는 메소드
		MemberInfo loginMember = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "select l.*, a.ma_zip, a.ma_addr1, a.ma_addr2 from t_member_list l, t_member_addr a where l.ml_isrun = 'y'" +
				" and l.ml_id = '" + uid + "' and l.ml_pwd = '"+ pwd +"' and l.ml_id = a.ml_id";
		System.out.println(sql);
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {	// 데이터가 있으면
				loginMember = new MemberInfo();
				loginMember.setMl_num(rs.getInt("ml_num"));
				loginMember.setMl_id(rs.getString("ml_id"));
				loginMember.setMl_pwd(rs.getString("ml_pwd"));
				loginMember.setMl_name(rs.getString("ml_name"));
				loginMember.setMl_birth(rs.getString("ml_birth"));
				loginMember.setMl_phone(rs.getString("ml_phone"));
				loginMember.setMl_email(rs.getString("ml_email"));
				loginMember.setMl_point(rs.getString("ml_point"));
				loginMember.setMl_date(rs.getString("ml_date"));
				loginMember.setMl_lastlogin(rs.getString("ml_lastlogin"));
				loginMember.setMa_zip(rs.getString("ma_zip"));
				loginMember.setMa_addr1(rs.getString("ma_addr1"));
				loginMember.setMa_addr2(rs.getString("ma_addr2"));
				
			}
		} catch(Exception e) {
			System.out.println("getLoginMember() 메소드 오류");
			e.printStackTrace();
		} finally {
			try {
				close(rs);
				close(stmt);
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		return loginMember;
	}

	
	
	public int memberLogin(HttpServletRequest request) {
	      
	      int result = 0;	
	      Statement stmt = null;
	      
	      try {
	    	  HttpSession session = request.getSession();
	    	  request.setCharacterEncoding("utf-8");
	    	  MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
	    	  // request객체의 사용에는 예외처리가 필요하므로 try문 안에서 작업
	    	  String uid = request.getParameter("uid");
	    	  System.out.println(uid);
	    	  // 회원정보 수정용 업데이트문에서 where절에 조건으로 사용하기 위한 id
	    	  String sql = "update t_member_list set ml_lastlogin = now() where ml_id = '" + uid + "';";
	    	  System.out.println(sql);
	    	  
		      stmt = conn.createStatement();
		      result = stmt.executeUpdate(sql);
		      
	      } catch (Exception e) {
		         System.out.println("memberLogin() 메소드 오류");
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
