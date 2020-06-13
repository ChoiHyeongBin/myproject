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

public class OrdService {
	// 구매자가 선택한 상품에 대한 정보를 장바구니에 담는 메소드
	public int cartIn(HttpServletRequest request) {
		int result = 0;
		
		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		result = ordDAO.cartIn(request);
		if (result == 1)	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
	
	// 구매자가 선택한 상품을 장바구니에서 삭제하는 메소드
	public int cartDel(HttpServletRequest request, String mlid) {
		int result = 0;
		
		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		result = ordDAO.cartDel(request, mlid);
		if (result > 0)		commit(conn);	// delete 시에는 commit, rollback 필요
		else				rollback(conn);
		close(conn);
		
		return result;
	}
	
	// 구매자가 선택한 옵션으로 변경하는 메소드
		public int cartUp(HttpServletRequest request, String mlid) {
			int result = 0;
			
			OrdDAO ordDAO = OrdDAO.getInstance();
			Connection conn = getConnection();
			ordDAO.setConnection(conn);
			result = ordDAO.cartUp(request, mlid);
			if (result == 1)	commit(conn);
			else				rollback(conn);
			close(conn);
			
			return result;
		}
	
	// 장바구니의 상품목록을 ArrayList로 리턴하는 메소드
	public ArrayList<CartInfo> getCartList(String mlid) {
		ArrayList<CartInfo> cartList = null;
		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		cartList = ordDAO.getCartList(mlid);
		close(conn);
		
		return cartList;
	}
	
	// 상품 바로구매 메소드
	public ArrayList<CartInfo> getPreOrdList(HttpServletRequest request, String mlid) {
		System.out.println("OrdService의 상품 바로 구매");
		ArrayList<CartInfo> preOrdList = null;
		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		preOrdList = ordDAO.getPreOrdList(request, mlid);
		close(conn);
		return preOrdList;
	}
		
	// 상품 구매를 처리하는 메소드
	public int ordProcess(HttpServletRequest request, String mlid) {
		int result = 0;

		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		result = ordDAO.ordProcess(request, mlid);
		if (result >= 1)	commit(conn);
		else 				rollback(conn);
		close(conn);
		return result;
	}
	
	// 주문목록의 레코드 개수를 리턴하는 메소드
	public int getOrdListCount(String mlid) {
		int rcount = 0;
		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		rcount = ordDAO.getOrdListCount(mlid);
		close(conn);
		
		return rcount;
	}
	
	// 회원이 구매한 상품(들)의 목록을 ArrayList형으로 리턴하는 메소드
	public ArrayList<OrdInfo> getOrdList(
		HttpServletRequest request, String mlid, int cpage, int limit) {
		ArrayList<OrdInfo> ordList = null;
		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		ordList = ordDAO.getOrdList(request, mlid, cpage, limit);
		close(conn);
		return ordList;
	}
	
	// 회원이 구매한 특정 주문의 정보들을 OrdInfo형으로 리턴하는 메소드
	public OrdInfo getOrdInfo(HttpServletRequest request, String olid, String mlid) {
		System.out.println("OrdService의 getOrdInfo 메소드 가동");
		OrdInfo ordInfo = null;
		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		ordInfo = ordDAO.getOrdInfo(request, olid, mlid);
		close(conn);
		
		return ordInfo;
	}
	
	// 쿠폰의 목록을 ArrayList형으로 리턴하는 메소드
	public ArrayList<MemberCouponInfo> getCouponList(HttpServletRequest request, String mlid) {
		ArrayList<MemberCouponInfo> memberCoupon = null;
		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		memberCoupon = ordDAO.getCouponList(request, mlid);
		close(conn);
		return memberCoupon;
	}
	
	public ArrayList<MemberPointInfo> getPointList(HttpServletRequest request, String mlid) {
		ArrayList<MemberPointInfo> memberPoint = null;
		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		memberPoint = ordDAO.getPointList(request, mlid);
		close(conn);
		return memberPoint;
	}
	
	// 주문 취소를 처리하는 메소드
	public int orderCancel(HttpServletRequest request, String olid, String olbuyer) {
		int result = 0;

		OrdDAO ordDAO = OrdDAO.getInstance();
		Connection conn = getConnection();
		ordDAO.setConnection(conn);
		result = ordDAO.orderCancel(request, olid, olbuyer);
		if (result >= 1)	commit(conn);
		else 				rollback(conn);
		close(conn);
		return result;
	}
}
