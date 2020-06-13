package svc;

import static db.JdbcUtil.*;	// JdbcUtil의 static메소드들을 바로 사용가능
import java.sql.*;

import javax.servlet.http.HttpServletRequest;

import dao.LoginDAO;
import dao.MemberDAO;
import vo.MemberInfo;

// 로그인 관련 비즈니스 로직을 처리하는 파일
public class LoginService {
	public MemberInfo getLoginMember(String uid, String pwd) {
		LoginDAO loginDAO = LoginDAO.getInstance();
		// LoginDAO 형태의 loginDAO 인스턴스 생성
		Connection conn = getConnection();
		// JdbcUtil클래스를 static으로 import하였으므로 인스턴스 없이 메소드호출 가능
		loginDAO.setConnection(conn);
		// loginDAO 인스턴스에서 사용할 Connection객체 지정
		MemberInfo loginMember = loginDAO.getLoginMember(uid, pwd);
		// uid와 pwd를 이용하여 쿼리를 실행 후 결과를 받아옴
		close(conn);
		// 쿼리작업이 끝났으므로 Connection객체를 닫아줌
		
		return loginMember;
	}
		
	public int memberLogin(HttpServletRequest request) {
		int result = 0;
		LoginDAO loginDAO = LoginDAO.getInstance();
		// DAO클래스의 인스턴스 선언 및 생성(쿼리작업을 처리하기 위한 인스턴스)
		Connection conn = getConnection();
		loginDAO.setConnection(conn);
		
		result = loginDAO.memberLogin(request);
		
		
		if (result == 1) { commit(conn);
		} else {				
			rollback(conn);		
		}
		close(conn);
		
		return result;
	}
	
}