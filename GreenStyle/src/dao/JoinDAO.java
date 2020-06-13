package dao;

import java.sql.*;
import javax.servlet.http.HttpServletRequest;
import static db.JdbcUtil.*;

public class JoinDAO {
   private static JoinDAO joinDAO;
   private Connection conn;
   
   private JoinDAO() {}
   
   public static JoinDAO getInstance() {
	// JoinDAO의 인스턴스를 여러 개 생성하지 않고 하나만 생성하게 하기 위한 메소드
	   // 싱글톤 방식으로 메모리의 낭비를 막는 작업
      if (joinDAO == null) {      
    // JoindAO의 인스턴스가 없으면
         joinDAO = new JoinDAO();
    // JoinDAO의 인스턴스를 새롭게 생성
      } 
      // 기존에 존재하는 joinDAO 인스턴스가 있으면 그냥 있는 인스턴스를 리턴
      
      return joinDAO;
   }
   
   public void setConnection(Connection conn) {
	// JoinDAO 클래스에서 하나의 Connection만을 사용하기 위해 만들어진 메소드
      this.conn = conn;
   }
   
   public int setMemberJoin(HttpServletRequest request) {
      // 회원가입 처리를 위한 DB작업을 하는 메소드
	  // 가입시 중요한 데이터들을 얻기 위해 request객체를 매개변수로 받아 옴
      int result = 0;	
      // DB작업 후 영향을 받은 레코드 개수를 저장할 변수
      Statement stmt = null;	
      
      try {
    	  // request객체의 사용에는 예외처리가 필요하므로 try문 안에서 작업
         request.setCharacterEncoding("utf-8");
         
         String uid       = request.getParameter("uid").toLowerCase().trim();
         String pwd       = request.getParameter("pwd1").toLowerCase().trim();
         String uname    = request.getParameter("uname").trim();
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
         // request로 받는 데이터들 중 사용자가 직접 입력하는 데이터들은 반드시
         // trim()메소드로 불필요한 공백을 제거한 후 받아야 함
         // 아이디 같은 정보는 대소문자 구별을 하지 않는 경우 소문자로 변환하여 받음

         String birth   = by + "-" + bm + "-" + bd;
         String phone    = p1 + "-" + p2 + "-" + p3;
         String email   = e1 + "@" + e2;
         
         String sql = "insert into t_member_list (ml_id, ml_pwd, ml_name, ml_birth, ml_phone, ml_email, ml_point) values ";
         sql+= "('" + uid + "', '" + pwd + "', '" + uname +  "', '" + birth + "', '" + phone + "', '" + email + "', " + 1000 + ")";
         stmt = conn.createStatement();
         result = stmt.executeUpdate(sql);
         
         result = 0;
         sql = "insert into t_member_point (ml_id, mp_use, mp_point, mp_content, mp_balance) values ";
         sql += "('" + uid + "', '" + "s" + "', " + 1000 +  " , '" + "가입축하금" + "', " + 1000 + ")";
         result = stmt.executeUpdate(sql);
         System.out.println(sql);
         
         
         if (zip != null && !zip.equals("")) {
        	 result = 0;
        	 sql = "insert into t_member_addr (ma_isbasic, ml_id, ma_zip, ma_addr1, ma_addr2) values ";
	         sql+= "('" + "y" + "', '" + uid + "', '" + zip +  "', '" + addr1 + "', '" + addr2 + "')";
	         result = stmt.executeUpdate(sql);
	         System.out.println(sql);
         }
         
         
         // insert문이므로 executeUpdate()메소드로 시행됨
         // 결과는 insert된 레코드의 개수로 일반적으로 1이 나와야 정상
                  
      } catch (Exception e) {
         System.out.println("setMemberJoin() 메소드 오류");
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