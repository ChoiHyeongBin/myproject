package dao;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class OrdDAO {
	private static OrdDAO ordDAO;
	private Connection conn;
	
	private OrdDAO() {}	
		
	public static OrdDAO getInstance() {
		if (ordDAO == null) {	
			ordDAO = new OrdDAO();
		}
		
		return ordDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	// 장바구니의 상품목록을 ArrayList로 리턴하는 메소드
	public ArrayList<CartInfo> getCartList(String mlid) {
		ArrayList<CartInfo> cartList = new ArrayList<CartInfo>();
		CartInfo cart = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select c.*, p.pl_name, p.pl_img1, p.pl_price, " +
					"p.pl_optsize, p.pl_optcolor, m.ml_point, m.ml_coupon, cs.cs_id " +
					"from t_order_cart c, t_product_list p, t_member_list m, t_category_small cs " +
					"where c.pl_id = p.pl_id and c.oc_memid = '" + mlid + "' and cs.cs_id = p.cs_id " +
					"group by pl_id order by c.pl_id";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				cart = new CartInfo();
				// ArrayList인 cartList에 담기 위해 CartInfo형 인스턴스로 작업함
				
				cart.setOc_num(rs.getInt("oc_num"));
				cart.setOc_ismem(rs.getString("oc_ismem"));
				cart.setOc_memid(mlid);
				cart.setPl_id(rs.getString("pl_id"));
				cart.setOc_optsize(rs.getString("oc_optsize"));
				cart.setOc_optcolor(rs.getString("oc_optcolor"));
				cart.setOc_amount(rs.getInt("oc_amount"));
				cart.setOc_date(rs.getString("oc_date"));
				cart.setPl_name(rs.getString("pl_name"));
				cart.setPl_img1(rs.getString("pl_img1"));
				cart.setPl_price(rs.getInt("pl_price"));
				cart.setPl_optsize(rs.getString("pl_optsize"));
				cart.setPl_optcolor(rs.getString("pl_optcolor"));
				cart.setMl_point(rs.getInt("ml_point"));
				cart.setMl_coupon(rs.getInt("ml_coupon"));
				cart.setCs_id(rs.getString("cs_id"));
				// 생성된 인스턴스에 데이터 채우기
				
				cartList.add(cart);
				// 상품 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}
			
		} catch (Exception e) {
			System.out.println("getCartList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return cartList;
	}
	
	// 구매자가 선택한 상품에 대한 정보를 장바구니에 담는 메소드
	public int cartIn(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			HttpSession session = request.getSession();
			MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
			String mlid = mem.getMl_id();
			String plid = request.getParameter("plid");
			String optsize = request.getParameter("optsize");
			String optcolor = request.getParameter("optcolor");
			String amount = request.getParameter("amount");
			
			String sql = "update t_order_cart set " + 
					" oc_amount = oc_amount + " + amount +
					" where oc_memid = '"	+ mlid 		+ "' " +
					" and pl_id = '" 	  	+ plid 		+ "' " + 
					" and oc_optsize = '" 	+ optsize 	+ "' " +
					" and oc_optcolor = '" 	+ optcolor 	+ "' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			// 동일한 옵션의 상품이 이미 존재한다면 수량만 증가시키는 쿼리 실행
			// 단, 동일하지 않으면 수량의 변경은 일어나지 않음
			
			if (result == 0) {
			// 변경이 일어나지 않았을 경우(동일한 상품이 장바구니에 없을 경우)
				sql = "insert into t_order_cart (oc_memid, pl_id, oc_optsize, oc_optcolor, oc_amount) values ('" +
						mlid + "', '" + plid + "', '" + optsize + "', '" + optcolor + "', '" + amount + "') ";
				result = stmt.executeUpdate(sql);
				System.out.println(sql);
			}
		} catch (Exception e) {
			System.out.println("cartIn() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
		
	// 구매자가 선택한 상품에 대한 정보를 장바구니에 담는 메소드
	public int cartDel(HttpServletRequest request, String mlid) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String isMulti = request.getParameter("isMulti");
			String where = " oc_num = " + request.getParameter("ocNum");
			if (isMulti != null && isMulti.equals("y")) {	// 여러 상품 삭제 시
				String[] ocNums = request.getParameterValues("ocNums");
				where = " (";
				for (int i = 0; i < ocNums.length; i++) {
					where += "oc_num = " + ocNums[i] + " or ";
				}
				where = where.substring(0, where.length() - 4) + ")";
			} 
			
			String sql = "delete from t_order_cart " +
					"where oc_memid = '" + mlid + "' and " + where;
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("cartDel() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
		
	// 구매자가 선택한 옵션으로 변경하는 메소드
	public int cartUp(HttpServletRequest request, String mlid) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String kind = request.getParameter("kind");
			String val = request.getParameter("val");
			String ocNum = request.getParameter("ocNum");
			
			String sql = "update t_order_cart set " +
				"oc_" + kind + " = '" + val + "' " +
				"where oc_memid = '" + mlid + "' and oc_num = " + ocNum;
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("cartUp() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	// 상품 바로구매 메소드
	public ArrayList<CartInfo> getPreOrdList(HttpServletRequest request, String mlid) {
		ArrayList<CartInfo> preOrdList = new ArrayList<CartInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		CartInfo ci = null;	// ci는 데이터를 담을 인스턴스
		
		
		try {
			request.setCharacterEncoding("utf-8");
			String kind = request.getParameter("kind");
			System.out.println("kind : " + kind);
			String sql = "";
			stmt = conn.createStatement();
			
			if (kind.equals("d")) {	// '바로 구매'일 경우
				String plid = request.getParameter("plid");
				String optsize = request.getParameter("optsize");
				String optcolor = request.getParameter("optcolor");
				int amount = Integer.parseInt(request.getParameter("amount"));
				
				System.out.println("plid : " + plid);
				System.out.println("optsize : " + optsize);
				System.out.println("optcolor : " + optcolor);
				System.out.println("amount : " + amount);
				
				sql = "select p.pl_name, p.pl_price, p.pl_img1, cs.cs_id, m.ml_point, m.ml_coupon " +
						"from t_product_list p, t_category_small cs, t_member_list m " +
						" where pl_isview = 'y' and pl_id = '" + plid + "' and cs.cs_id = p.cs_id ";
				System.out.println(sql);
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
					ci = new CartInfo();
					// ArrayList인 preOrdList에 담기 위해 CartInfo형 인스턴스를 생성함
					ci.setPl_id(plid);
					ci.setPl_name(rs.getString("pl_name"));
					ci.setPl_price(rs.getInt("pl_price"));
					ci.setPl_img1(rs.getString("pl_img1"));
					ci.setOc_memid(mlid);
					ci.setOc_optsize(optsize);
					ci.setOc_optcolor(optcolor);
					ci.setOc_amount(amount);
					ci.setCs_id(rs.getString("cs_id"));
					ci.setMl_point(rs.getInt("ml_point"));
					ci.setMl_coupon(rs.getInt("ml_coupon"));
					
					preOrdList.add(ci);
				}
				
			} else { // 장바구니를 이용한 구매일 경우 (kind.equals("c"))
				String[] ocNums = request.getParameterValues("ocNums");
				// 장바구니 번호(PK)를 String배열로 받아 옴
				System.out.println("else문 들어옴");
				String where = " (";
				for (int i = 0 ; i < ocNums.length ; i++) {
					System.out.println("for문 ocNums.length 들어옴");
					where += "c.oc_num = " + ocNums[i] + " or ";
				}
				where = where.substring(0, where.length() - 4) + ")";
				sql = "select c.*, p.pl_name, p.pl_price, p.pl_img1, m.ml_point, m.ml_coupon, a.ma_isbasic, cs.cs_id " + 
					"from t_product_list p, t_order_cart c, t_member_list m, t_member_addr a, t_category_small cs " + 
					"where m.ml_id = '" + mlid + "' and m.ml_id = a.ml_id and c.pl_id = p.pl_id and p.pl_isview = 'y' and " +
					"c.oc_memid = '" + mlid + "' and cs.cs_id = p.cs_id and " + where;
				System.out.println(sql);
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					ci = new CartInfo();

					ci.setOc_num(rs.getInt("oc_num"));
					ci.setOc_ismem(rs.getString("oc_ismem"));
					ci.setOc_memid(mlid);
					ci.setPl_id(rs.getString("pl_id"));
					ci.setOc_optsize(rs.getString("oc_optsize"));
					ci.setOc_optcolor(rs.getString("oc_optcolor"));
					ci.setOc_amount(rs.getInt("oc_amount"));
					ci.setOc_date(rs.getString("oc_date"));
					ci.setPl_name(rs.getString("pl_name"));
					ci.setPl_img1(rs.getString("pl_img1"));
					ci.setPl_price(rs.getInt("pl_price"));
					ci.setMl_point(rs.getInt("ml_point"));
					ci.setMl_coupon(rs.getInt("ml_coupon"));
					ci.setMa_isbasic(rs.getString("ma_isbasic"));
					ci.setCs_id(rs.getString("cs_id"));
					 
					// 생성된 인스턴스에 데이터 채우기
					   
					preOrdList.add(ci);
				}
			}
		}	catch (Exception e) {
			System.out.println("getPreOrdList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return preOrdList;
	}
	
	// 상품 구매를 처리하는 메소드
	public int ordProcess(HttpServletRequest request, String mlid) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			request.setCharacterEncoding("utf-8");
			
			// 배송지 정보
			String rname = request.getParameter("rname");
			String p1 = request.getParameter("p1");
			String p2 = request.getParameter("p2");
			String p3 = request.getParameter("p3");
			String phone = p1 + "-" + p2 + "-" + p3;
			String rzip = request.getParameter("rzip");
			String raddr1 = request.getParameter("raddr1");
			String raddr2 = request.getParameter("raddr2");
			String comment = request.getParameter("comment");
			String call1 = request.getParameter("call1");
			String call2 = request.getParameter("call2");
			String call3 = request.getParameter("call3");
			String call = call1 + "-" + call2 + "-" + call3;
			String ordE1 = request.getParameter("ordE1");
			String ordE2 = request.getParameter("ordE2");
			String email = ordE1 + "@" + ordE2;
			
			System.out.println("rname : " + rname);
			System.out.println("p1 : " + p1);
			System.out.println("p2 : " + p2);
			System.out.println("p3 : " + p3);
			System.out.println("phone : " + phone);
			System.out.println("rzip : " + rzip);
			System.out.println("raddr1 : " + raddr1);
			System.out.println("raddr2 : " + raddr2);
			System.out.println("comment : " + comment);
			System.out.println("call1 : " + call1);
			System.out.println("call2 : " + call2);
			System.out.println("call3 : " + call3);
			
			// 상품정보
			String kind = request.getParameter("kind");
			String[] ocnums = request.getParameterValues("ocnums");
			String[] plids = request.getParameterValues("plids");
			String[] sizes = request.getParameterValues("sizes");
			String[] colors = request.getParameterValues("colors");
			String[] prices = request.getParameterValues("prices");
			String[] amounts = request.getParameterValues("amounts");
			
			System.out.println("kind : " + kind);
			System.out.println("ocnums : " + ocnums);
			System.out.println("sizes : " + sizes);
			System.out.println("colors : " + colors);
			System.out.println("prices : " + prices);
			System.out.println("amounts : " + amounts);
			
			// 결제정보
			String payment = request.getParameter("payment");
			int total = Integer.parseInt(request.getParameter("total"));
			int rpoint = Integer.parseInt(request.getParameter("rpoint"));
			System.out.println("total : " + total);
			System.out.println("payment : " + payment);
			System.out.println("rpoint : " + rpoint);
			
			// 쿠폰 사용시 mcnum의 값이 null이 아닌 숫자 값이 올 것이다.
			int mcnum = Integer.parseInt(request.getParameter("mcnum"));
			System.out.println("mcnum : " + mcnum);
			
			stmt = conn.createStatement();
			
			// 주문ID 생성 쿼리
			Calendar today = Calendar.getInstance();	// 'today'에 오늘날짜와 시간이 들어가게 됨
			int y = today.get(Calendar.YEAR);
			int m = today.get(Calendar.MONTH) + 1;
			int d = today.get(Calendar.DATE);
			String mm = (m < 10 ? "0" + m : "" + m);
			String dd = (d < 10 ? "0" + d : "" + d);
			String olid = y + mm + dd + "1110001";
			
			// 오늘 날짜를 20200519 형식의 문자열로 생성한 후 주문ID 생성
			
			String sql = "select ol_id from t_order_list where date(ol_date) = date(now()) " + 
					"order by ol_id desc limit 1";
			 // 결과 : '202003271110002'
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
			// 오늘 주문한 내역이 있으면(가장 최근 주문한 주문ID를 추출)
				long lng = Long.parseLong(rs.getString("ol_id")) + 1;
				// 기존의 주문ID를 정수로 변환 후 1증가 시킴
				olid = lng + "";	// 새로운 주문ID를 생성
			}
			
			// 202003271110001
			
			// t_order_list 테이블에 insert
			sql = "insert into t_order_list (ol_id, ol_buyer, ol_phone, ol_email, ol_rname, ol_call, ol_rphone, " + 
					"ol_rzip, ol_raddr1, ol_raddr2, ol_comment, ol_point, ol_payment, ol_pay, ol_status, mc_num) " + 
					"values ('" + olid + "', '" + mlid + "', '" + phone + "', '" + email + "', '" + rname + "', '" + call + "' , '" + phone + "', " + 
					"'" + rzip + "', '" + raddr1 + "', " + 
					" '" + raddr2 + "', '" + comment + "', '" + rpoint + "', '" + payment + "', '" + total + "', 'a', " + mcnum + ")";
				System.out.println("주문 테이블에 배송지 및 내용 추가 : " + sql);
				result = stmt.executeUpdate(sql);
				if (result < 1) return result; // insert실패시 바로 return하여 메소드를 종료시키고, 쿼리를 rollback함
				for (int j = 0; j < plids.length; j++) {
					System.out.println("--------------------------------");
					System.out.println("olid : " + olid);
					System.out.println("kind : " + kind);
					System.out.println("prices[" + j + "] : " + prices[j]);
					System.out.println("amounts[" + j + "] : " + amounts[j]);
					System.out.println("sizes[" + j + "] : " + sizes[j]);
					System.out.println("colors[" + j + "] : " + colors[j]);
					System.out.println("ocnums[" + j + "] : " + ocnums[j]);
					System.out.println("plids[" + j + "] : " + plids[j]);
					System.out.println("colors[" + j + "] : " + colors[j]);
					System.out.println("--------------------------------");
				}
				
				// t_order_detail 테이블에 insert 및 t_product_list 테이블에 update
				System.out.println("주문 목록에 등록된 상품 개수 : " + plids.length);
				for (int i = 0; i < plids.length; i++) {
					if (kind.equals("c")) {		// 장바구니를 통해 구매한 경우
						
						// t_cart_list 테이블에서 삭제
						sql = "delete from t_order_cart where oc_num = '" + ocnums[i] + "' and oc_memid = '" + mlid + "'";
						System.out.println("장바구니를 통해 구매할 때 장바구니에 있는 상품 목록 삭제 : " + sql);
						result = stmt.executeUpdate(sql);
						if (result < 1) return result;
					}

					// 주문 상세 테이블의 상품 추가 쿼리
					sql = "insert into t_order_detail (ol_id, pl_id, od_optsize, od_optcolor, od_price, od_amount) " +
							"value ('" + olid + "', '" + plids[i] + "', '" + sizes[i] +  "', '" + colors[i] + "', '" + prices[i] + "', '" + amounts[i] + "')";
					System.out.println("주문 상세 테이블의 상품 추가 : " + sql);
					result = stmt.executeUpdate(sql);
					if (result < 1) return result;
				
					// 상품 테이블의 재고 변경 쿼리
					sql = "update t_product_list set pl_stock = pl_stock - " + amounts[i] + " where pl_stock > 0 and pl_id = '" + plids[i] + "'";
					System.out.println("상품 테이블의 재고 변경 : " + sql);
					result = stmt.executeUpdate(sql);
					
					System.out.println("4차 문제 체크");
					// 상품 테이블의 판매량 변경 쿼리
					sql = "update t_product_list set pl_salecnt = pl_salecnt + " + amounts[i] + " where pl_id = '" + plids[i] + "'";
					System.out.println("상품 테이블의 판매량 변경 : " + sql);
					result = stmt.executeUpdate(sql);
					if (result < 1) return result;
					
					System.out.println("포인트 차감 문제 체크");
					// 포인트 차감 쿼리
					sql = "update t_member_list set ml_point = ml_point - " + rpoint + " where ml_id = '" + mlid + "'";
					System.out.println("포인트 차감 쿼리 : " + sql);
					result = stmt.executeUpdate(sql);
					if (result < 1) return result;
					
					if (mcnum != -1) {	// 사용한 쿠폰의 일련번호가 있을 경우 -1이 아닌 양수값이 나옴 (auto_increment는 1부터 시작하니까 -1은 쿠폰이 아니다)
					sql = "update t_member_coupon set mc_use = 'y' where ml_id = '" + mlid + "' and mc_num = '" + mcnum + "'";
					System.out.println("쿠폰 사용 처리 쿼리 : " + sql);
					result = stmt.executeUpdate(sql);
					if (result < 1) return result;
					}
				}
				
		} catch (Exception e) {
			System.out.println("ordProcess() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	// 주문목록의 레코드 개수를 리턴하는 메소드
	public int getOrdListCount(String mlid) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_order_list where ol_buyer = '" + mlid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	// count()함수 사용시 값이 절대 비어있지 않으므로 검사없이 next()를 실행함
			rcount = rs.getInt(1);
			// 특정 회원(mlid)이 구매한 목록의 레코드 개수를 저장
		} catch (Exception e) {
			System.out.println("getOrdListCount() 메소드에서 오류 발생");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcount;
	}
	
	// 회원이 구매한 상품(들)의 목록을 ArrayList형으로 리턴하는 메소드
	public ArrayList<OrdInfo> getOrdList(HttpServletRequest request, String mlid, int cpage, int limit) {
		ArrayList<OrdInfo> ordList = new ArrayList<OrdInfo>();
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		OrdInfo oi = null;			// 주문저장용 인스턴스
		OrdDetailInfo odi = null;	// 주문내 상품정보 저장용 인스턴스
		
		try {
			request.setCharacterEncoding("utf-8");
			
			int start = (cpage - 1) * limit;							/* 주문완료폼에 여러개 상품이 안뜸(sql문 문제) */
			String sql = "select * from t_order_list where ol_buyer = '" + mlid + "' order by ol_id desc limit " + start + ", " + limit;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {	// 주문내역이 있으면
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
				
				// 주문내역의 상품들 목록 저장 쿼리
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
			System.out.println("getOrdList() 메소드에서 오류 발생");
		} finally {
			close(rs2);
			close(stmt2);
			close(rs);
			close(stmt);
		}
		
		return ordList;
	}
	
	// 회원이 구매한 특정 주문의 정보들을 OrdInfo형으로 리턴하는 메소드
	public OrdInfo getOrdInfo(HttpServletRequest request, String olid, String mlid) {
		OrdInfo ordInfo = new OrdInfo();
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		OrdInfo oi = null;			// 주문저장용 인스턴스
		OrdDetailInfo odi = null;	// 주문내 상품정보 저장용 인스턴스
		
		try {
			String sql = "select ol.*, cs.cs_id from t_order_list ol, t_category_small cs where ol.ol_buyer = '" + mlid + "' and ol.ol_id = '" + olid + "' ";
			System.out.println(sql);
			String csid = ""; // ordDetail에 넣을 csid를 그대로 저장했다가 ordInfo에 있는 csid로 그대로 넣음
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 주문내역이 있으면
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
				
				// 주문내역의 상품들 목록 저장 쿼리
				sql = "select d.*, p.pl_name, p.pl_img1, p.cs_id, cs.cs_id " + 
						"from t_order_detail d, t_product_list p, t_category_small cs " + 
						"where d.pl_id = p.pl_id and d.ol_id = '" + olid + "' and cs.cs_id = p.cs_id ";
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
								csid = rs2.getString("cs_id"); // 조건에 맞는 하나의 cs_id 컬럼을 csid 변수에 집어넣음 
								OrdDetailList.add(odi);
								
								
							} while (rs2.next());
							// 생성한 상품목록을 oi인스턴스에 담음
							
						} else {	// 주문 상품이 없으면(주문내역에서 상품정보가 없으면)
							return oi;
						}
						
						oi.setCs_id(csid); // 집어넣었던 csid를 다시 oi의 cs_id에 집어넣음
						oi.setOrdPdtList(OrdDetailList);
			}
		} catch (Exception e) {
			System.out.println("getOrdInfo() 메소드에서 오류 발생");
			e.printStackTrace();
		} finally {
			close(rs2);
			close(stmt2);
			close(rs);
			close(stmt);
		}
		
		return oi;
	}
		
	// 상태값에 따른 문자열 값 리턴(주문상태)
	public String getStatusTxt(String status) {
		String statusTxt = "";
		switch (status.toLowerCase()) {
			case "a" : statusTxt = "입금대기"; 			break;
			case "b" : statusTxt = "결제완료"; 			break;
			case "c" : statusTxt = "배송준비중"; 			break;
			case "d" : statusTxt = "배송중"; 				break;
			case "e" : statusTxt = "배송완료"; 			break;
			case "f" : statusTxt = "반품요청"; 			break;
			case "g" : statusTxt = "반품완료"; 			break;
			case "h" : statusTxt = "환불요청"; 			break;
			case "i" : statusTxt = "환불완료"; 			break;
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
	
	// 쿠폰의 목록을 ArrayList형으로 리턴하는 메소드
	public ArrayList<MemberCouponInfo> getCouponList(HttpServletRequest request, String mlid) {
		ArrayList<MemberCouponInfo> couponList = new ArrayList<MemberCouponInfo>();
		MemberCouponInfo coupon = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_member_coupon mc, t_admin_coupon ac where ml_id = '" + mlid + "' and mc.ac_num = ac.ac_num";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				coupon = new MemberCouponInfo();
				
				coupon.setMc_num(rs.getInt("mc_num"));
				coupon.setAc_num(rs.getInt("ac_num"));
				coupon.setAc_discount(rs.getInt("ac_discount"));
				coupon.setMl_id(rs.getString("ml_id"));
				coupon.setAc_name(rs.getString("ac_name"));
				coupon.setMc_use(rs.getString("mc_use"));
				coupon.setMc_date(rs.getString("mc_date"));
				coupon.setMc_usedate(rs.getString("mc_usedate"));
				
				couponList.add(coupon);
			}
			
		} catch (Exception e) {
			System.out.println("getCouponList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return couponList;
	}
	
	// 포인트의 목록을 ArrayList형으로 리턴하는 메소드
	public ArrayList<MemberPointInfo> getPointList(HttpServletRequest request, String mlid) {
		ArrayList<MemberPointInfo> pointList = new ArrayList<MemberPointInfo>();
		MemberPointInfo point = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_member_point where ml_id = '" + mlid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				point = new MemberPointInfo();
				
				point.setMp_num(rs.getInt("mp_num"));
				point.setMl_id(mlid);
				point.setMp_use(rs.getString("mp_use"));
				point.setMp_point(rs.getInt("mp_point"));
				point.setMp_content(rs.getString("mp_content"));
				point.setMp_date(rs.getString("mp_date"));
				point.setMp_balance(rs.getInt("mp_balance"));
				
				
				pointList.add(point);
			}
			
		} catch (Exception e) {
			System.out.println("getPointList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return pointList;
	}
	
	// 주문 취소를 하는 메소드
	public int orderCancel(HttpServletRequest request, String olid, String olbuyer) {	
		int result = 0;
		Statement stmt = null;
		
		try {
			request.setCharacterEncoding("utf-8");
			
			stmt = conn.createStatement();
			
			String sql = "delete from t_order_detail where ol_id = '" + olid + "' ";
			System.out.println(sql);
		    result = stmt.executeUpdate(sql);
		    
		    sql = "delete from t_order_list where ol_id = '" + olid + "' and ol_buyer = '" + olbuyer + "' ";
		    System.out.println(sql);
		    result = stmt.executeUpdate(sql);
		    
		} catch (Exception e) {
	         System.out.println("orderCancel() 메소드 오류");
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
}
