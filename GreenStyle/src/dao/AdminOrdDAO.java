package dao;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class AdminOrdDAO {
	private static AdminOrdDAO adminOrdDAO;
	private Connection conn;
	
	private AdminOrdDAO() {}	
	
	public static AdminOrdDAO getInstance() {
		if (adminOrdDAO == null) {	
			adminOrdDAO = new AdminOrdDAO();
		}
		
		return adminOrdDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_order_list where 1=1 " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	// if문을 사용하지 않는 것은 count()결과이므로 무조건 결과값이 존재하므로
			rcount = rs.getInt(1);
			System.out.println(sql);
		} catch (Exception e) {
			System.out.println("getListCount(admin) 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcount;
	} 
	
	public ArrayList<OrdInfo> getOrdList(String where, int cpage, int limit) {
		ArrayList<OrdInfo> ordList = new ArrayList<OrdInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		OrdInfo oi = null;
		Statement stmt2 = null;
		ResultSet rs2 = null;	
		OrdDetailInfo odi = null;	
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_order_list where 1=1 " + where;
			sql += " order by ol_num desc limit " + start + ", " + limit;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				oi = new OrdInfo();
				oi.setOl_num(rs.getInt("ol_num"));
				oi.setOl_id(rs.getString("ol_id"));
				oi.setOl_ismem(rs.getString("ol_ismem"));
				oi.setOl_buyer(rs.getString("ol_buyer"));
				oi.setOl_phone(rs.getString("ol_phone"));
				oi.setOl_email(rs.getString("ol_email"));
				oi.setOl_rname(rs.getString("ol_rname"));
				oi.setOl_rphone(rs.getString("ol_rphone"));
				oi.setOl_rzip(rs.getString("ol_rzip"));
				oi.setOl_raddr1(rs.getString("ol_raddr1"));
				oi.setOl_raddr2(rs.getString("ol_raddr2"));
				oi.setOl_comment(rs.getString("ol_comment"));
				oi.setOl_point(rs.getInt("ol_point"));
				oi.setOl_payment(rs.getString("ol_payment"));
				oi.setOl_pay(rs.getInt("ol_pay"));
				oi.setOl_status(rs.getString("ol_status"));
				// oi.setOl_refundbank(rs.getString("ol_refundbank"));
				// oi.setOl_refundaccount(rs.getString("ol_refundaccount"));
				oi.setOl_date(rs.getString("ol_date"));
				oi.setStatus(getStatusTxt(rs.getString("ol_status")));
				oi.setPayStatus(getPayStatusTxt(rs.getString("ol_payment")));
				   
				/// 주문내역의 상품들 목록 저장 쿼리
				sql = "select d.*, p.pl_name, p.pl_img1, cs.cs_id " + 
						"from t_order_detail d, t_product_list p, t_category_small cs " + 
						"where d.pl_id = p.pl_id and ol_id = '" + rs.getString("ol_id") + "' and cs.cs_id = p.cs_id";
						System.out.println(sql);
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(sql);	// rs2는 비어있으면 안됨
						ArrayList<OrdDetailInfo> OrdDetailList = new ArrayList<OrdDetailInfo>();
						if (rs2.next()) {	// 주문 상품이 있으면
							do {
								odi = new OrdDetailInfo();
								// 주문내 상품정보를 담을 인스턴스
								
								odi.setOd_num(rs2.getInt("od_num"));
								odi.setOl_id(rs2.getString("ol_id"));
								odi.setPl_id(rs2.getString("pl_id"));
								odi.setOd_optsize(rs2.getString("od_optsize"));
								odi.setOd_optcolor(rs2.getString("od_optcolor"));
								odi.setOd_price(rs2.getInt("od_price"));
								odi.setOd_amount(rs2.getInt("od_amount"));
								odi.setPl_name(rs2.getString("pl_name"));
								odi.setPl_img1(rs2.getString("pl_img1"));
								odi.setCs_id(rs2.getString("cs_id"));
								
								OrdDetailList.add(odi);
								
								oi.setCs_id(rs2.getString("cs_id"));
							} while (rs2.next());
							// 생성한 상품목록을 oi인스턴스에 담음
							
						} else {	// 주문 상품이 없으면(주문내역에서 상품정보가 없으면)
							return ordList;
						}
						
						oi.setOrdPdtList(OrdDetailList);
						ordList.add(oi);
			}
		} catch (Exception e) {
			System.out.println("getOrdList(admin) 메소드에서 오류 발생");
		} finally {
			close(rs2);
			close(stmt2);
			close(rs);
			close(stmt);
		}
		
		return ordList;
	}
	
	public ArrayList<OrdInfo> getOrdList2(String where, int cpage, int limit) {
		System.out.println("DAO의 getOrdList2 메소드 실행");
		ArrayList<OrdInfo> ordList = new ArrayList<OrdInfo>();
		System.out.println("where : " + where);
		Statement stmt = null;
		ResultSet rs = null;
		OrdInfo oi = null;
		Statement stmt2 = null;
		ResultSet rs2 = null;	
		OrdDetailInfo odi = null;	
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_order_list where " + where;	// 추가
			sql += " order by ol_num desc limit " + start + ", " + limit;
			System.out.println("오더리스트 : " + sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				oi = new OrdInfo();
				oi.setOl_num(rs.getInt("ol_num"));
				oi.setOl_id(rs.getString("ol_id"));
				oi.setOl_ismem(rs.getString("ol_ismem"));
				oi.setOl_buyer(rs.getString("ol_buyer"));
				oi.setOl_phone(rs.getString("ol_phone"));
				oi.setOl_email(rs.getString("ol_email"));
				oi.setOl_rname(rs.getString("ol_rname"));
				oi.setOl_rphone(rs.getString("ol_rphone"));
				oi.setOl_rzip(rs.getString("ol_rzip"));
				oi.setOl_raddr1(rs.getString("ol_raddr1"));
				oi.setOl_raddr2(rs.getString("ol_raddr2"));
				oi.setOl_comment(rs.getString("ol_comment"));
				oi.setOl_point(rs.getInt("ol_point"));
				oi.setOl_payment(rs.getString("ol_payment"));
				oi.setOl_pay(rs.getInt("ol_pay"));
				oi.setOl_status(rs.getString("ol_status"));
				// oi.setOl_refundbank(rs.getString("ol_refundbank"));
				// oi.setOl_refundaccount(rs.getString("ol_refundaccount"));
				oi.setOl_date(rs.getString("ol_date"));
				oi.setStatus(getStatusTxt(rs.getString("ol_status")));
				oi.setPayStatus(getPayStatusTxt(rs.getString("ol_payment")));
				oi.setMc_num(rs.getInt("mc_num"));
				   
				/// 주문내역의 상품들 목록 저장 쿼리
				sql = "select d.*, p.pl_name, p.pl_img1, cs.cs_id " + 
						"from t_order_detail d, t_product_list p, t_category_small cs " + 
						"where d.pl_id = p.pl_id and ol_id = '" + rs.getString("ol_id") + "' and cs.cs_id = p.cs_id";
						System.out.println("주문 상세 및 상품 목록 : " + sql);
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(sql);	// rs2는 비어있으면 안됨
						ArrayList<OrdDetailInfo> OrdDetailList = new ArrayList<OrdDetailInfo>();
						if (rs2.next()) {	// 주문 상품이 있으면
							do {
								odi = new OrdDetailInfo();
								// 주문내 상품정보를 담을 인스턴스
								
								odi.setOd_num(rs2.getInt("od_num"));
								odi.setOl_id(rs2.getString("ol_id"));
								odi.setPl_id(rs2.getString("pl_id"));
								odi.setOd_optsize(rs2.getString("od_optsize"));
								odi.setOd_optcolor(rs2.getString("od_optcolor"));
								odi.setOd_price(rs2.getInt("od_price"));
								odi.setOd_amount(rs2.getInt("od_amount"));
								odi.setPl_name(rs2.getString("pl_name"));
								odi.setPl_img1(rs2.getString("pl_img1"));
								odi.setCs_id(rs2.getString("cs_id"));
								
								OrdDetailList.add(odi);
								
								oi.setCs_id(rs2.getString("cs_id"));
							} while (rs2.next());
							// 생성한 상품목록을 oi인스턴스에 담음
							
						} else {	// 주문 상품이 없으면(주문내역에서 상품정보가 없으면)
							return ordList;
						}
						
						oi.setOrdPdtList(OrdDetailList);
						ordList.add(oi);
			}
		} catch (Exception e) {
			System.out.println("getOrdList2(admin) 메소드에서 오류 발생");
		} finally {
			close(rs2);
			close(stmt2);
			close(rs);
			close(stmt);
		}
		
		return ordList;
	}
	
	public OrdInfo getOrd(int num) {
		OrdInfo ordInfo = null;
		// 지정한 공지사항 글 데이터를 저장하기 위한 인스턴스
		Statement stmt = null;
		// DB에 쿼리를 보내주는 객체
		ResultSet rs = null;
		// 받아온 쿼리를 담는 객체
		
		try {
			String sql = "select * from t_order_list where ol_num = " + num;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);	// ResultSet 생성
			if (rs.next()) {
				ordInfo = new OrdInfo();
				// 하나의 게시글 데이터를 담기 위한 OrdInfo 인스턴스 생성
				
				ordInfo.setOl_num(rs.getInt("ol_num"));
				ordInfo.setOl_num(rs.getInt("ol_num"));
				ordInfo.setOl_id(rs.getString("ol_id"));
				ordInfo.setOl_ismem(rs.getString("ol_ismem"));
				ordInfo.setOl_buyer(rs.getString("ol_buyer"));
				ordInfo.setOl_phone(rs.getString("ol_phone"));
				ordInfo.setOl_email(rs.getString("ol_email"));
				ordInfo.setOl_rname(rs.getString("ol_rname"));
				ordInfo.setOl_rphone(rs.getString("ol_rphone"));
				ordInfo.setOl_rzip(rs.getString("ol_rzip"));
				ordInfo.setOl_raddr1(rs.getString("ol_raddr1"));
				ordInfo.setOl_raddr2(rs.getString("ol_raddr2"));
				ordInfo.setOl_comment(rs.getString("ol_comment"));
				ordInfo.setOl_point(rs.getInt("ol_point"));
				ordInfo.setOl_payment(rs.getString("ol_payment"));
				ordInfo.setOl_pay(rs.getInt("ol_pay"));
				ordInfo.setOl_status(rs.getString("ol_status"));
				// ordInfo.setOl_refundbank(rs.getString("ol_refundbank"));
				// ordInfo.setOl_refundaccount(rs.getString("ol_refundaccount"));
				ordInfo.setOl_date(rs.getString("ol_date"));
				ordInfo.setStatus(getStatusTxt(rs.getString("ol_status")));
				ordInfo.setPayStatus(getPayStatusTxt(rs.getString("ol_payment")));
			}
		} catch(Exception e) {
			System.out.println("getOrd(admin) 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return ordInfo;
	}
	
	public int ordUpdate(HttpServletRequest request) {
		int result = 0;	
		Statement stmt = null;
	  
		try {
			request.setCharacterEncoding("utf-8");
    	
		// request객체의 사용에는 예외처리가 필요하므로 try문 안에서 작업
		// 회원정보 수정용 업데이트문에서 where절에 조건으로 사용하기 위한 id
		String ordStatus       = request.getParameter("ordStatus");
		String optsize		   = request.getParameter("optsize");
		String optcolor		   = request.getParameter("optcolor");
		String olid			   = request.getParameter("olid");

		String sql = "update t_order_list set ";
        sql += "ol_status = '" 		+ ordStatus 	+ "' ";
        // sql += "od_optsize = '" 	+ optsize 		+ "', ";
        // sql += "od_optcolor = '" 	+ optcolor 		+ "' ";
        sql += "where ol_id = " + olid;
        System.out.println(sql);

        stmt = conn.createStatement();
        result = stmt.executeUpdate(sql);
        
        // 상세정보의 변경 쿼리
		sql = "update t_order_detail set od_optsize = '" + optsize + "', od_optcolor = '" + optcolor + "' where ol_id = " + olid;
		System.out.println("상세정보 변경 : " + sql);
		result = stmt.executeUpdate(sql);

		} catch (Exception e) {
        System.out.println("ordUpdate(admin) 메소드 오류");
        e.printStackTrace();
		} finally {
			try {
				close(stmt);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
      
		return result;
	}
	
	// 상태값에 따른 문자열 값 리턴(주문상태)
	public String getStatusTxt(String status) {
		String statusTxt = "";
		switch (status.toLowerCase()) {
			case "a" : statusTxt = "입금대기"; 			break;
			case "b" : statusTxt = "결제완료"; 			break;
			case "c" : statusTxt = "상품준비";	 		break;
			case "d" : statusTxt = "배송준비"; 			break;
			case "e" : statusTxt = "배송중"; 			break;
			case "f" : statusTxt = "배송완료"; 			break;
			case "g" : statusTxt = "반품요청"; 			break;
			case "h" : statusTxt = "반품완료"; 			break;
			case "i" : statusTxt = "환불요청"; 			break;
			case "j" : statusTxt = "환불완료"; 			break;
			case "k" : statusTxt = "교환요청"; 			break;
			case "l" : statusTxt = "교환완료"; 			break;
		}
		
		return statusTxt;
	}
	
	// 상태값에 따른 문자열 값 리턴(결제수단)
	public String getPayStatusTxt(String payStatus) {
		String statusTxt = "";
		switch (payStatus.toLowerCase()) {
			case "a" : statusTxt = "신용/체크카드"; 	break;
			case "b" : statusTxt = "무통장입금"; 		break;
			case "c" : statusTxt = "휴대폰결제"; 		break;
		}
		
		return statusTxt;
	}
	
	// 메인 목록화면
	public ArrayList<OrdInfo> getMainOrdList() {
		ArrayList<OrdInfo> ordList = new ArrayList<OrdInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		OrdInfo oi = null;
		Statement stmt2 = null;
		ResultSet rs2 = null;	
		OrdDetailInfo odi = null;	
		try {
			String sql = "select * from t_order_list where 1=1 ";
			sql += " order by ol_num desc ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				oi = new OrdInfo();
				oi.setOl_num(rs.getInt("ol_num"));
				oi.setOl_id(rs.getString("ol_id"));
				oi.setOl_ismem(rs.getString("ol_ismem"));
				oi.setOl_buyer(rs.getString("ol_buyer"));
				oi.setOl_phone(rs.getString("ol_phone"));
				oi.setOl_email(rs.getString("ol_email"));
				oi.setOl_rname(rs.getString("ol_rname"));
				oi.setOl_rphone(rs.getString("ol_rphone"));
				oi.setOl_rzip(rs.getString("ol_rzip"));
				oi.setOl_raddr1(rs.getString("ol_raddr1"));
				oi.setOl_raddr2(rs.getString("ol_raddr2"));
				oi.setOl_comment(rs.getString("ol_comment"));
				oi.setOl_point(rs.getInt("ol_point"));
				oi.setOl_payment(rs.getString("ol_payment"));
				oi.setOl_pay(rs.getInt("ol_pay"));
				oi.setOl_status(rs.getString("ol_status"));
				// oi.setOl_refundbank(rs.getString("ol_refundbank"));
				// oi.setOl_refundaccount(rs.getString("ol_refundaccount"));
				oi.setOl_date(rs.getString("ol_date"));
				oi.setStatus(getStatusTxt(rs.getString("ol_status")));
				oi.setPayStatus(getPayStatusTxt(rs.getString("ol_payment")));
				   
				/// 주문내역의 상품들 목록 저장 쿼리
				sql = "select d.*, p.pl_name, p.pl_img1, cs.cs_id " + 
						"from t_order_detail d, t_product_list p, t_category_small cs " + 
						"where d.pl_id = p.pl_id and ol_id = '" + rs.getString("ol_id") + "' and cs.cs_id = p.cs_id";
						System.out.println(sql);
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(sql);	// rs2는 비어있으면 안됨
						ArrayList<OrdDetailInfo> OrdDetailList = new ArrayList<OrdDetailInfo>();
						if (rs2.next()) {	// 주문 상품이 있으면
							do {
								odi = new OrdDetailInfo();
								// 주문내 상품정보를 담을 인스턴스
								
								odi.setOd_num(rs2.getInt("od_num"));
								odi.setOl_id(rs2.getString("ol_id"));
								odi.setPl_id(rs2.getString("pl_id"));
								odi.setOd_optsize(rs2.getString("od_optsize"));
								odi.setOd_optcolor(rs2.getString("od_optcolor"));
								odi.setOd_price(rs2.getInt("od_price"));
								odi.setOd_amount(rs2.getInt("od_amount"));
								odi.setPl_name(rs2.getString("pl_name"));
								odi.setPl_img1(rs2.getString("pl_img1"));
								odi.setCs_id(rs2.getString("cs_id"));
								
								OrdDetailList.add(odi);
								
								oi.setCs_id(rs2.getString("cs_id"));
							} while (rs2.next());
							// 생성한 상품목록을 oi인스턴스에 담음
							
						} else {	// 주문 상품이 없으면(주문내역에서 상품정보가 없으면)
							return ordList;
						}
						
						oi.setOrdPdtList(OrdDetailList);
						ordList.add(oi);
			}
		} catch (Exception e) {
			System.out.println("getMainOrdList(admin) 메소드에서 오류 발생");
		} finally {
			close(rs2);
			close(stmt2);
			close(rs);
			close(stmt);
		}
		
		return ordList;
	}
}
