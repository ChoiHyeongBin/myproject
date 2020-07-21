package dao;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class AdminDAO {
	private static AdminDAO adminDAO;
	// 여러 개가 아닌 하나만 존재하게 하기 위한 static
	private Connection conn;
	private AdminDAO() {}
	
	public static AdminDAO getInstance() {
	// LoginDAO의 인스턴스를 생헝해주는 메소드로 하나의 인스턴스만 존재하게 됨
		if (adminDAO == null) {
			adminDAO = new AdminDAO();
			// 새로운 인스턴스를 생성
		}
		
		return adminDAO;
	}
	
	public void setConnection(Connection conn) {
	// LoginDAO에서 사용할 컨넥션 객체를 지정하는 메소드
		this.conn = conn;
	}
	
	public AdminInfo main(String uid, String pwd) {
		// 입력받은 아이디와 비밀번호가 DB의 회원테이블에 실제 하는지 검사하는 메소드
		AdminInfo main = null;
			Statement stmt = null;
			ResultSet rs = null;
			
			String sql = "select * from t_admin_list where al_id = '" + uid + "' and al_pwd = '" + pwd + "' and al_isrun = 'y' ";
			System.out.println("main SQL : " + sql);
			
			try {
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				
				if (rs.next()) {	// 데이터가 있으면
					main = new AdminInfo();
					main.setAl_num(rs.getInt("al_num"));
					main.setAl_id(rs.getString("al_id"));
					main.setAl_pwd(rs.getString("al_pwd"));
					main.setAl_name(rs.getString("al_name"));
					main.setAl_phone(rs.getString("al_phone"));
					main.setAl_email(rs.getString("al_email"));
					main.setAl_isrun(rs.getString("al_isrun"));
					main.setAl_date(rs.getString("al_date"));
					main.setReg_al_num(rs.getInt("reg_al_num"));
					
				}
			} catch(Exception e) {
				System.out.println("main() 메소드 오류");
				e.printStackTrace();
			} finally {
				try {
					close(rs);
					close(stmt);
					
				} catch(Exception e) {
					e.printStackTrace();
				}
				
			}
			
			
			return main;
		}

}
