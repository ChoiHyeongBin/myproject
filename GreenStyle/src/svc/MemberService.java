package svc;

import static db.JdbcUtil.*;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import dao.*;

public class MemberService {
	public int memberUpdate(HttpServletRequest request) {
		int result = 0;
		MemberDAO memberDAO = MemberDAO.getInstance();
		// DAO클래스의 인스턴스 선언 및 생성(쿼리작업을 처리하기 위한 인스턴스)
		Connection conn = getConnection();
		memberDAO.setConnection(conn);
		
		result = memberDAO.memberUpdate(request);
		
		
		if (result == 1) { commit(conn);
		} else {				
			rollback(conn);		
		}
		close(conn);
		
		return result;
	}
	
	public int memberDelete(HttpServletRequest request) {
		int result = 0;
		MemberDAO memberDAO = MemberDAO.getInstance();
		// DAO클래스의 인스턴스 선언 및 생성(쿼리작업을 처리하기 위한 인스턴스)
		Connection conn = getConnection();
		memberDAO.setConnection(conn);
		
		result = memberDAO.memberDelete(request);
		
		
		if (result == 1) { commit(conn);
		} else {				
			rollback(conn);		
		}
		close(conn);
		
		return result;
	}
}
