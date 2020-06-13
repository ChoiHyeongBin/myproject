package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*; 
import javax.servlet.http.*;
import dao.*;
import svc.*;
import vo.*;


public class AdminPdtService {

	public ArrayList<PdtInfo> getAdminPdtList(HttpServletRequest request, String where, int cpage, int limit) {
		System.out.println("getAdminPdtList 들어옴");
		ArrayList<PdtInfo> adminpdtList = new ArrayList<PdtInfo>();
		AdminPdtDAO adminpdtDAO = AdminPdtDAO.getInstance();
		Connection conn = getConnection();
		adminpdtDAO.setConnection(conn);
		adminpdtList = adminpdtDAO.getAdminPdtList(request, where, cpage, limit);
		System.out.println("getAdminPdtList 문제없음");
		close(conn);
		return adminpdtList;
	}
	
	// 상품의 목록 개수를 리턴하는 메소드
	public int getPdtCount(String where) {
		System.out.println("getPdtCount 들어옴");
		int rcount = 0;
		AdminPdtDAO adminpdtDAO = AdminPdtDAO.getInstance();
		Connection conn = getConnection();
		adminpdtDAO.setConnection(conn);
		rcount = adminpdtDAO.getPdtCount(where);
		System.out.println("getPdtCount 문제없음");
		close(conn);
		return rcount;
	}
	
	// 하나의 상품 정보를 PdtInfo형 인스턴스로 리턴받는 메소드
	public PdtInfo getPdt(String plid) {
		PdtInfo pdtInfo = new PdtInfo();
		System.out.println("plid " + plid);
		AdminPdtDAO adminpdtDAO = AdminPdtDAO.getInstance();
		Connection conn = getConnection();
		adminpdtDAO.setConnection(conn);
		pdtInfo = adminpdtDAO.getPdt(plid);
		close(conn);
		return pdtInfo;
	}
	
	// 공지사항 등록결과와 글번호를 String형으로 리턴하는 메소드
	public String insertPdt(HttpServletRequest request) {
		AdminPdtDAO adminpdtDAO = AdminPdtDAO.getInstance();
		Connection conn = getConnection();
		adminpdtDAO.setConnection(conn);
		String plResult = adminpdtDAO.insertPdt(request);
		int result = Integer.parseInt(plResult.substring(0, plResult.indexOf(':')));
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return plResult;
	}
	// 공지사항 게시글에 대한 수정결과를 int형으로 리턴하는 메소드
	public int updatePdt(HttpServletRequest request) {
		System.out.println("updatePdtService 들어옴");
		AdminPdtDAO adminpdtDAO = AdminPdtDAO.getInstance();
		Connection conn = getConnection();
		adminpdtDAO.setConnection(conn);
		int result = adminpdtDAO.updatePdt(request);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}

	// 공지사항 게시글을 삭제한 후 결과를 int형으로 리턴하는 메소드
	public int deletePdt(HttpServletRequest request) {
		AdminPdtDAO adminpdtDAO = AdminPdtDAO.getInstance();
		Connection conn = getConnection();
		adminpdtDAO.setConnection(conn);
		int result = adminpdtDAO.deletePdt(request);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
}
