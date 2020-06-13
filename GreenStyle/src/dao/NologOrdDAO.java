package dao;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class NologOrdDAO {
	private static NologOrdDAO nologordDAO;
	private Connection conn;
	
	private NologOrdDAO() {}	
		
	public static NologOrdDAO getInstance() {
		if (nologordDAO == null) {	
			nologordDAO = new NologOrdDAO();
		}
		
		return nologordDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	// 바로구매
	public ArrayList<CartInfo> getnologOrdList(HttpServletRequest request) {
		ArrayList<CartInfo> NologOrdList = new ArrayList<CartInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		CartInfo ci = null;	// ci는 데이터를 담을 인스턴스
		
		try {
			request.setCharacterEncoding("utf-8");
			String sql = "";
			stmt = conn.createStatement();
			String plid = request.getParameter("plid");
			String optsize = request.getParameter("optsize");
			String optcolor = request.getParameter("optcolor");
			int amount = Integer.parseInt(request.getParameter("amount"));
			String csid = request.getParameter("csid");
			
			sql = "select p.pl_name, p.pl_price, p.pl_img1, p.cs_id, c.cs_id from t_product_list p, t_category_small c " +
					" where pl_isview = 'y' and p.cs_id = c.cs_id and pl_id = '" + plid + "' ";
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				ci = new CartInfo();
				// ArrayList인 preOrdList에 담기 위해 CartInfo형 인스턴스를 생성함
				ci.setPl_id(plid);
				ci.setPl_name(rs.getString("pl_name"));
				ci.setPl_price(rs.getInt("pl_price"));
				ci.setPl_img1(rs.getString("pl_img1"));
				ci.setOc_optsize(optsize);
				ci.setOc_optcolor(optcolor);
				ci.setOc_amount(amount);
				ci.setCs_id(rs.getString("cs_id"));
				
				NologOrdList.add(ci);
			}
		}	catch (Exception e) {
			System.out.println("getPreOrdList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return NologOrdList;
	}
	
	// 상품 구매를 처리하는 메소드
		public int nologordProcess(HttpServletRequest request) {
			int result = 0;
			Statement stmt = null;
			ResultSet rs = null;
			
			try {
				request.setCharacterEncoding("utf-8");
				
				// 배송지 정보
				String orderName = request.getParameter("orderName");
				String rname = request.getParameter("rname");
				String pp1 = request.getParameter("pp1");
				String pp2 = request.getParameter("pp2");
				String pp3 = request.getParameter("pp3");
				String phone = pp1 + "-" + pp2 + "-" + pp3;
				String p1 = request.getParameter("p1");
				String p2 = request.getParameter("p2");
				String p3 = request.getParameter("p3");
				String rphone = p1 + "-" + p2 + "-" + p3;
				String call1 = request.getParameter("call1");
				String call2 = request.getParameter("call2");
				String call3 = request.getParameter("call3");
				String rcall = call1 + "-" + call2 + "-" + call3;
				String rzip = request.getParameter("rzip");
				String raddr1 = request.getParameter("raddr1");
				String raddr2 = request.getParameter("raddr2");
				String comment = request.getParameter("comment");
				String ordE1 = request.getParameter("ordE1");
				String ordE2 = request.getParameter("ordE2");
				String email = ordE1 + "@" + ordE2;
				
				// 상품정보
				String kind = request.getParameter("kind");
				String[] ocnums = request.getParameterValues("ocnums");
				String[] plids = request.getParameterValues("plids");
				String[] sizes = request.getParameterValues("sizes");
				String[] colors = request.getParameterValues("colors");
				String[] prices = request.getParameterValues("prices");
				String[] amounts = request.getParameterValues("amounts");
				
				// 결제정보
				String payment = request.getParameter("payment");
				int total = Integer.parseInt(request.getParameter("total"));
				
				stmt = conn.createStatement();
				
				// 주문ID 생성 쿼리
				Calendar today = Calendar.getInstance();	// 'today'에 오늘날짜와 시간이 들어가게 됨
				int y = today.get(Calendar.YEAR);
				int m = today.get(Calendar.MONTH) + 1;
				int d = today.get(Calendar.DAY_OF_MONTH);
				String mm = (m < 10 ? "0" + m : "" + m);
				String dd = (d < 10 ? "0" + d : "" + d);
				String olid = y + mm + dd + "1110001";
				// 오늘 날짜를 20200519 형식의 문자열로 생성한 후 주문ID 생성
				
				String sql = "select ol_id from t_order_list where date(ol_date) = date(now()) " + 
						"order by ol_id desc limit 1";
				rs = stmt.executeQuery(sql);
				System.out.println(sql);
				if (rs.next()) {
				// 오늘 주문한 내역이 있으면(가장 최근 주문한 주문ID를 추출)
					long lng = Long.parseLong(rs.getString("ol_id")) + 1;
					// 기존의 주문ID를 정수로 변환 후 1증가 시킴
					olid = lng + "";	// 새로운 주문ID를 생성
				}
				
				// t_order_list 테이블에 insert
				sql = "insert into t_order_list (ol_id, ol_ismem, ol_buyer, ol_phone, ol_email, ol_rname, ol_rphone, ol_call, " + 
				"ol_rzip, ol_raddr1, ol_raddr2, ol_comment, ol_payment, ol_pay, ol_status) " + 
				"values ('" + olid + "', 'n', '" + orderName + "', '" + phone + "', '" + email + "', '" + rname + "', '" + rphone + "', " + 
				"'" + rcall + "', '" + rzip + "', '" + raddr1 + "' , '" + raddr2 + "', '" + comment + "', '" + payment + "', '" + total + "', 'a' )";
					System.out.println(sql);
					result = stmt.executeUpdate(sql);
					if (result < 1) return result; // insert실패시 바로 return하여 메소드를 종료시키고, 쿼리를 rollback함
					
					// t_order_detail 테이블에 insert 및 t_product_list 테이블에 update
					for (int i = 0; i < plids.length; i++) {
						// 주문 상세 테이블의 상품 추가 쿼리
						sql = "insert into t_order_detail (ol_id, pl_id, od_optsize, od_optcolor, od_price, od_amount) " +
								"value ('" + olid + "', '" + plids[i] + "', '" + sizes[i] +  "', '" + colors[i] + "', '" + prices[i] + "', '" + amounts[i] + "')";
						System.out.println(sql);
						result = stmt.executeUpdate(sql);
						if (result < 1) return result;
						
						// 상품 테이블의 재고 변경 쿼리
						sql = "update t_product_list set pl_stock = pl_stock - " + amounts[i] + " where pl_stock > 0 and pl_id = '" + plids[i] + "'";
						System.out.println(sql);
						result = stmt.executeUpdate(sql);
						// t_cart_list 테이블에서 삭제
						
						// 상품 테이블의 판매량 변경 쿼리
						sql = "update t_product_list set pl_salecnt = pl_salecnt + " + amounts[i] + " where pl_id = '" + plids[i] + "'";
						System.out.println(sql);
						result = stmt.executeUpdate(sql);
						if (result < 1) return result;
					}	
			} catch (Exception e) {
				System.out.println("ordProcess() 메소드에서 오류 발생");
			} finally {
				close(stmt);
			}
			
			return result;
		}
		
		// 주문목록의 레코드 개수를 리턴하는 메소드
		public int getnologOrdListCount(String olbuyer) {
			int rcount = 0;
			Statement stmt = null;
			ResultSet rs = null;
			try {
				String sql = "select count(*) from t_order_list where ol_buyer = '" + olbuyer + "' ";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				rs.next();	// count()함수 사용시 값이 절대 비어있지 않으므로 검사없이 next()를 실행함
				rcount = rs.getInt(1);
				// 특정 회원(olbuyer)이 구매한 목록의 레코드 개수를 저장
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
		public ArrayList<OrdInfo> getOrdList(HttpServletRequest request, String olbuyer, int cpage, int limit) {
			ArrayList<OrdInfo> ordList = new ArrayList<OrdInfo>();
			Statement stmt = null;
			Statement stmt2 = null;
			ResultSet rs = null;
			ResultSet rs2 = null;
			OrdInfo oi = null;			// 주문저장용 인스턴스
			OrdDetailInfo odi = null;	// 주문내 상품정보 저장용 인스턴스
			
			try {
				request.setCharacterEncoding("utf-8");
				
				int start = (cpage - 1) * limit;
				String sql = "select * from t_order_list o, t_category_small c, t_product_list p where p.cs_id = c.cs_id and  o.ol_buyer = '" + olbuyer + "' " + 
				" order by o.ol_id desc limit 0, 1";
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
					oi.setOl_payment(rs.getString("ol_payment"));
					oi.setOl_pay(rs.getInt("ol_pay"));
					oi.setOl_status(rs.getString("ol_status"));
					oi.setOl_date(rs.getString("ol_date"));
					oi.setStatus(getStatusTxt(rs.getString("ol_status")));
					oi.setCs_id(rs.getString("cs_id"));
					
					// 주문내역의 상품들 목록 저장 쿼리
					sql = "select d.*, p.pl_name, p.pl_img1, p.cs_id " + 
							"from t_order_detail d, t_product_list p " + 
							"where d.pl_id = p.pl_id and ol_id = '" + rs.getString("ol_id") + "'";
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
		public OrdInfo getOrdInfo(HttpServletRequest request, String olid) {
			OrdInfo ordInfo = new OrdInfo();
			Statement stmt = null;
			Statement stmt2 = null;
			ResultSet rs = null;
			ResultSet rs2 = null;
			OrdInfo oi = null;			// 주문저장용 인스턴스
			OrdDetailInfo odi = null;	// 주문내 상품정보 저장용 인스턴스
			
			try {
				String sql = "select * from t_order_list where ol_id = '" + olid + "' ";
				System.out.println(sql);
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
					oi.setOl_payment(rs.getString("ol_payment"));
					oi.setOl_pay(rs.getInt("ol_pay"));
					oi.setOl_status(rs.getString("ol_status"));
					oi.setOl_date(rs.getString("ol_date"));
					oi.setStatus(getStatusTxt(rs.getString("ol_status")));
					oi.setPayStatus(getPayStatusTxt(rs.getString("ol_payment")));
					
					// 주문내역의 상품들 목록 저장 쿼리
					sql = "select d.*, p.pl_name, p.pl_img1, p.cs_id, c.cs_id " + 
							"from t_order_detail d, t_product_list p, t_category_small c " + 
							"where d.pl_id = p.pl_id and ol_id = '" + olid + "' and p.cs_id = c.cs_id ";
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
								} while (rs2.next());
								// 생성한 상품목록을 oi인스턴스에 담음
								
							} else {	// 주문 상품이 없으면(주문내역에서 상품정보가 없으면)
								return oi;
							}
							
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
	
		// 상태값에 따른 문자열 값 리턴
		public String getStatusTxt(String status) {
			String statusTxt = "";
			switch (status.toLowerCase()) {
				case "a" : statusTxt = "입금대기"; 			break;
				case "b" : statusTxt = "결제완료"; 			break;
				case "c" : statusTxt = "상품준비";	 			break;
				case "d" : statusTxt = "배송준비"; 			break;
				case "e" : statusTxt = "배송중"; 				break;
				case "f" : statusTxt = "배송완료"; 			break;
				case "g" : statusTxt = "교환요청"; 			break;
				case "h" : statusTxt = "반품요쳥"; 			break;
				case "i" : statusTxt = "환불요청"; 			break;
				case "j" : statusTxt = "교환완료"; 			break;
				case "k" : statusTxt = "반품완료"; 			break;
				case "l" : statusTxt = "환불완료"; 			break;
			}
			
			return statusTxt;
		}
		
		// 상태값에 따른 문자열 값 리턴(결제수단)
	    public String getPayStatusTxt(String payStatus) {
	       String statusTxt = "";
	       switch (payStatus.toLowerCase()) {
	          case "a" : statusTxt = "신용/체크카드";    break;
	          case "b" : statusTxt = "무통장입금";       break;
	          case "c" : statusTxt = "휴대폰결제";       break;
	       }
	      
	       return statusTxt;
	    }
		
		
		public ArrayList<OrdInfo> getNologOrdList(HttpServletRequest request, String olbuyer, String olids) {
			ArrayList<OrdInfo> nologordList = new ArrayList<OrdInfo>();
			Statement stmt = null;
			Statement stmt2 = null;
			ResultSet rs = null;
			ResultSet rs2 = null;
			OrdInfo oi = null;			// 주문저장용 인스턴스
			OrdDetailInfo odi = null;	// 주문내 상품정보 저장용 인스턴스
			System.out.println(olbuyer + " // " + olids);
			
			try {
				request.setCharacterEncoding("utf-8");
				
				String sql = "select * from t_order_list where ol_buyer = '" + olbuyer + "' and ol_id = '" + olids + "' and ol_ismem = 'n' order by ol_id desc";
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
					oi.setOl_payment(rs.getString("ol_payment"));
					oi.setOl_pay(rs.getInt("ol_pay"));
					oi.setOl_status(rs.getString("ol_status"));
					oi.setOl_date(rs.getString("ol_date"));
					oi.setStatus(getStatusTxt(rs.getString("ol_status")));
					
					// 주문내역의 상품들 목록 저장 쿼리
					sql = "select d.*, p.pl_name, p.pl_img1, p.cs_id, c.cs_id " + 
							"from t_order_detail d, t_product_list p, t_category_small c " + 
							"where d.pl_id = p.pl_id and ol_id = '" + rs.getString("ol_id") + "' and p.cs_id = c.cs_id";
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
								} while (rs2.next());
								// 생성한 상품목록을 oi인스턴스에 담음
								
							} else {	// 주문 상품이 없으면(주문내역에서 상품정보가 없으면)
								return nologordList;
							}
							
							oi.setOrdPdtList(OrdDetailList);
							nologordList.add(oi);
				}
			} catch (Exception e) {
				System.out.println("getnologOrdList() 메소드에서 오류 발생");
			} finally {
				close(rs2);
				close(stmt2);
				close(rs);
				close(stmt);
			}
			
			return nologordList;
		}
		
		public int orderCancel(HttpServletRequest request) {	// 상품구매 취소를 하는 메소드
			int result = 0;
			Statement stmt = null;
			
			try {
				request.setCharacterEncoding("utf-8");
				
				String buyer = request.getParameter("olbuyer");
				String olids = request.getParameter("olids");
				System.out.println(buyer + " // " + olids);
				
				stmt = conn.createStatement();
				
				String sql = "delete from t_order_detail where ol_id = '" + olids + "' ";
				System.out.println("detail" + sql);
			    result = stmt.executeUpdate(sql);
			    
			    sql = "delete from t_order_list where ol_id = '" + olids + "' and ol_ismem = 'n' and ol_buyer = '" + buyer + "' ";
			    System.out.println("detail" + sql);
			    result = stmt.executeUpdate(sql);
			    
			} catch (Exception e) {
		         System.out.println("nologordProcess() 메소드 오류");
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
