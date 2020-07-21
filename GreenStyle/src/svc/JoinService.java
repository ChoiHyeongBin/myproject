package svc;

import static db.JdbcUtil.*;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import dao.JoinDAO;

// 실제 작업(비즈니스 로직)을 처리하는 클래스
public class JoinService {
	public int setMemberJoin(HttpServletRequest request) {
		int result = 0;
		JoinDAO joinDAO = JoinDAO.getInstance();
		// DAO클래스의 인스턴스 선언 및 생성(쿼리작업을 처리하기 위한 인스턴스)
		Connection conn = getConnection();
		joinDAO.setConnection(conn);
		
		result = joinDAO.setMemberJoin(request);
		// 회원가입 쿼리를 작업하기 위해 setMemberJoin() 메소드를 호출
		// 결과값으로는 쿼리작업(insert) 후 영향을 받은 레코드의 개수를 받아옴
		// 결과값은 한 명의 회원가입이기 때문에 1이어야 함
		
		if (result == 1) {		// 회원가입 성공시
			commit(conn);		// 쿼리 적용
		} else {				// 회원가입 실패시
			rollback(conn);		// 쿼리 취소
		}
		close(conn);
		
		return result;
	}
}
