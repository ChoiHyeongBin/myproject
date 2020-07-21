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

public class NologOrdService {

	public ArrayList<CartInfo> getnologOrdList(HttpServletRequest request) {
		System.out.println("OrdService의 상품 바로 구매");
		ArrayList<CartInfo> NologOrdList = null;
		NologOrdDAO nologordDAO = NologOrdDAO.getInstance();
		Connection conn = getConnection();
		nologordDAO.setConnection(conn);
		NologOrdList = nologordDAO.getnologOrdList(request);
		close(conn);
		return NologOrdList;
	}

	// 상품 구매를 처리하는 메소드
	public int nologordProcess(HttpServletRequest request) {
		int result = 0;
		NologOrdDAO nologordDAO = NologOrdDAO.getInstance();
		Connection conn = getConnection();
		nologordDAO.setConnection(conn);
		result = nologordDAO.nologordProcess(request);
		if (result >= 1)	commit(conn);
		else 				rollback(conn);
		close(conn);
		return result;
	}
	
	// 주문목록의 레코드 개수를 리턴하는 메소드
	public int getnologOrdListCount(String olbuyer) {
		int rcount = 0;
		NologOrdDAO nologordDAO = NologOrdDAO.getInstance();
		Connection conn = getConnection();
		nologordDAO.setConnection(conn);
		rcount = nologordDAO.getnologOrdListCount(olbuyer);
		close(conn);
		
		return rcount;
	}
	
	// 회원이 구매한 상품(들)의 목록을 ArrayList형으로 리턴하는 메소드
	public ArrayList<OrdInfo> getOrdList(HttpServletRequest request, String olbuyer, int cpage, int limit) {
		ArrayList<OrdInfo> ordList = null;
		NologOrdDAO nologordDAO = NologOrdDAO.getInstance();
		Connection conn = getConnection();
		nologordDAO.setConnection(conn);
		ordList = nologordDAO.getOrdList(request, olbuyer, cpage, limit);
		close(conn);
		
		return ordList;
	}
	
	
	// 회원이 구매한 상품(들)의 목록을 ArrayList형으로 리턴하는 메소드
		public ArrayList<OrdInfo> getNologOrdList(HttpServletRequest request, String olbuyer, String olids) {
			System.out.println("getNologOrdList 들어옴");
			ArrayList<OrdInfo> nologordList = null;
			NologOrdDAO nologordDAO = NologOrdDAO.getInstance();
			Connection conn = getConnection();
			nologordDAO.setConnection(conn);
			nologordList = nologordDAO.getNologOrdList(request, olbuyer, olids);
			System.out.println("getNologOrdListDAO 문제 없음");
			close(conn);
			
			return nologordList;
		}
			
	// 회원이 구매한 특정 주문의 정보들을 OrdInfo형으로 리턴하는 메소드
	public OrdInfo getOrdInfo(HttpServletRequest request, String olid) {
		System.out.println("getOrdinfo 들어옴");
		OrdInfo ordInfo = null;
		NologOrdDAO nologordDAO = NologOrdDAO.getInstance();
		Connection conn = getConnection();
		nologordDAO.setConnection(conn);
		ordInfo = nologordDAO.getOrdInfo(request, olid);
		System.out.println("getOrdinfo 문제 없음");
		close(conn);
		
		return ordInfo;
	}
	
	// 구매 취소를 처리하는 메소드
	public int orderCancel(HttpServletRequest request) {
		System.out.println("orderCancel 들어옴");
		int result = 0;
		NologOrdDAO nologordDAO = NologOrdDAO.getInstance();
		Connection conn = getConnection();
		nologordDAO.setConnection(conn);
		result = nologordDAO.orderCancel(request);
		
		if (result >= 1)    commit(conn); 
		else 				rollback(conn);
		close(conn);
		return result;
	}
	
	
	
	
}
