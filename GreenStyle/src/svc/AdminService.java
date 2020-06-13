package svc;

import static db.JdbcUtil.*;	// JdbcUtil의 static메소드들을 바로 사용가능
import java.sql.*;

import javax.servlet.http.HttpServletRequest;

import dao.*;
import dao.*;
import vo.*;

public class AdminService {
	// 로그인 관련 비즈니스 로직을 처리하는 파일
	public AdminInfo main(String uid, String pwd) {
		System.out.println("어드민 서비스 진입");
		AdminDAO adminDAO = AdminDAO.getInstance();
		// AdminDAO 형태의 AdminDAO 인스턴스 생성
		Connection conn = getConnection();
		// JdbcUtil클래스를 static으로 import하였으므로 인스턴스 없이 메소드호출 가능
		adminDAO.setConnection(conn);
		// adminDAO 인스턴스에서 사용할 Connection객체 지정
		AdminInfo main = adminDAO.main(uid, pwd);
		// uid와 pwd를 이용하여 쿼리를 실행 후 결과를 받아옴
		close(conn);
		// 쿼리작업이 끝났으므로 Connection객체를 닫아줌
		
		return main;
	}

}
