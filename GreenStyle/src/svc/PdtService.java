package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*; 
import javax.servlet.http.*;
import dao.*;
import svc.*;
import vo.*;

public class PdtService {
	// 상품 목록을 ArrayList로 받아 리턴하는 메소드
	public ArrayList<PdtInfo> getPdtList(String where, int cpage, int limit) {
		ArrayList<PdtInfo> pdtList = new ArrayList<PdtInfo>();
		PdtDAO pdtDAO = PdtDAO.getInstance();
		Connection conn = getConnection();
		pdtDAO.setConnection(conn);
		pdtList = pdtDAO.getPdtList(where, cpage, limit);
		close(conn);
		return pdtList;
	}
	
	// 하나의 상품 정보를 PdtInfo형 인스턴스로 리턴받는 메소드
	public PdtInfo getPdtInfo(String plid) {
		PdtInfo pdtInfo = new PdtInfo();
		PdtDAO pdtDAO = PdtDAO.getInstance();
		Connection conn = getConnection();
		pdtDAO.setConnection(conn);
		pdtInfo = pdtDAO.getPdtInfo(plid);
		close(conn);
		return pdtInfo;
	}
	
	// 상품의 목록 개수를 리턴하는 메소드
		public int getPdtCount(String where) {
			int rcount = 0;
			PdtDAO pdtDAO = PdtDAO.getInstance();
			Connection conn = getConnection();
			pdtDAO.setConnection(conn);
			rcount = pdtDAO.getPdtCount(where);
			close(conn);
			return rcount;
		}
}
