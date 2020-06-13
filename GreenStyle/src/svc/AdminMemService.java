package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import svc.*;
import vo.*;

public class AdminMemService {
	public int getListCount(String where) {
		int rcount = 0;
		AdminMemDAO adminMemDAO = AdminMemDAO.getInstance();
		Connection conn = getConnection();
		adminMemDAO.setConnection(conn);
		rcount = adminMemDAO.getListCount(where);
		close(conn);
		return rcount;
	}
	
	public ArrayList<MemberInfo> getMemList(String where, int cpage, int limit) {
		ArrayList<MemberInfo> memberList = null;
		AdminMemDAO adminMemDAO = AdminMemDAO.getInstance();
		Connection conn = getConnection();
		adminMemDAO.setConnection(conn);
		memberList = adminMemDAO.getMemList(where, cpage, limit);
		close(conn);
		
		return memberList;
	}
	public int memberUpdate(HttpServletRequest request) {
		int result = 0;
		AdminMemDAO adminmemDAO = AdminMemDAO.getInstance();
		// DAO클래스의 인스턴스 선언 및 생성(쿼리작업을 처리하기 위한 인스턴스)
		Connection conn = getConnection();
		adminmemDAO.setConnection(conn);
		
		result = adminmemDAO.memberUpdate(request);
		
		
		if (result == 1) { commit(conn);
		} else {				
			rollback(conn);		
		}
		close(conn);
		
		return result;
	}
	
	public MemberInfo getMember(int num) {
		MemberInfo memberInfo = null;
		AdminMemDAO adminMemDAO = AdminMemDAO.getInstance();
		Connection conn = getConnection();
		adminMemDAO.setConnection(conn);
		memberInfo = adminMemDAO.getMember(num);
		close(conn);
		
		return memberInfo;
	}
	
}
