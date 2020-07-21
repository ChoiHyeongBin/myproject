package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class AdminPdtDAO {
	private static AdminPdtDAO adminpdtDAO;
	   private Connection conn;
	   
	   private AdminPdtDAO() {}   
	      
	   public static AdminPdtDAO getInstance() {
	      if (adminpdtDAO == null) {   
	    	  adminpdtDAO = new AdminPdtDAO();
	      }
	      
	      return adminpdtDAO;
	   }
	   
	   public void setConnection(Connection conn) {
	      this.conn = conn;
	   }
	   
	   // 상품의 목록을 ArrayList 형태로 리턴하는 메소드
	   public ArrayList<PdtInfo> getAdminPdtList(HttpServletRequest request, String where, int cpage, int limit) {
		   ArrayList<PdtInfo> adminpdtList = new ArrayList<PdtInfo>();
		   Statement stmt = null;
		   ResultSet rs = null;
		   PdtInfo pdtInfo = null;
		   try {
			   int start = (cpage - 1) * limit;
			   String sql = "select * from t_product_list  where 1=1 " + where;
			   sql += " limit " + start + ", " + limit;
			   System.out.println(sql);
			   stmt = conn.createStatement();
			   rs = stmt.executeQuery(sql);
			   while (rs.next()) {
					   pdtInfo = new PdtInfo();
					   // 하나의 게시글 데이터를 담기 위한 PdtInfo 인스턴스 생성		
					   
					   pdtInfo.setPl_num(rs.getInt("pl_num"));
					   pdtInfo.setPl_id(rs.getString("pl_id"));
					   pdtInfo.setPl_name(rs.getString("pl_name"));
					   pdtInfo.setPl_price(rs.getInt("pl_price"));
					   pdtInfo.setPl_img1(rs.getString("pl_img1"));
					   pdtInfo.setPl_img2(rs.getString("pl_img2"));
					   pdtInfo.setPl_salecnt(rs.getInt("pl_salecnt"));
					   pdtInfo.setCs_name(rs.getString("cs_name"));;
					   pdtInfo.setCs_id(rs.getString("cs_id"));
					   pdtInfo.setPl_optsize(rs.getString("pl_optsize"));
					   pdtInfo.setPl_optcolor(rs.getString("pl_optcolor"));
					   pdtInfo.setPl_issell(rs.getString("pl_issell"));

					   // 생성된 인스턴스에 데이터 채우기
					   
					   adminpdtList.add(pdtInfo);
					   // 상품 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			   }
			   
		   } catch(Exception e) {
			   System.out.println("getPdtList() 메소드에서 오류 발생");
		   } finally {
			   close(rs);
			   close(stmt);
		   }
		   
		   return adminpdtList;
	   }
	   
	   	// 상품들 중 검색되는 전체 개수를 리턴하는 메소드
		public int getPdtCount( String where) {
			int rcount = 0;
			Statement stmt = null;
			ResultSet rs = null;
			try {
				String sql = "select count(*) from t_product_list where 1=1 " + where;
				System.out.println(sql);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				rs.next();	// if문을 사용하지 않는 것은 count()결과이므로 무조건 결과값이 존재하므로
				rcount = rs.getInt(1);
			} catch(Exception e) {
				System.out.println("getListCount() 메소드에서 오류 발생");
			} finally {
				close(rs);
				close(stmt);
			}
		
			return rcount;
		}
		
	   // 하나의 상품정보를 PdtInfo형 인스턴스로 리턴받는 메소드
	   public PdtInfo getPdt(String plid) {
			PdtInfo pdtInfo = null;
			
			Statement stmt = null;	// 쿼리로 전송시켜주는 객체
			   ResultSet rs = null;
			   
			   try {
				   String sql = "select p.* from t_product_list p " +
						   	"where p.pl_id = '" + plid + "' ";
				   System.out.println("sql " + sql);
				   System.out.println("plid " + plid);
				   stmt = conn.createStatement();
				   rs = stmt.executeQuery(sql);
				   if (rs.next()) {
					   pdtInfo = new PdtInfo();
					   // 하나의 게시글 데이터를 담기 위한 PdtInfo 인스턴스 생성
					   	pdtInfo.setCb_id(rs.getString("cb_id"));
					   	pdtInfo.setCs_id(rs.getString("cs_id"));
						pdtInfo.setPl_id(rs.getString("pl_id"));
						pdtInfo.setPl_name(rs.getString("pl_name"));
						pdtInfo.setPl_price(rs.getInt("pl_price"));
						pdtInfo.setPl_img1(rs.getString("pl_img1"));
						pdtInfo.setPl_img2(rs.getString("pl_img2"));
						pdtInfo.setPl_img3(rs.getString("pl_img3"));
						pdtInfo.setPl_img4(rs.getString("pl_img4"));
						pdtInfo.setPl_img5(rs.getString("pl_img5"));
						pdtInfo.setPl_optsize(rs.getString("pl_optsize"));
						pdtInfo.setPl_optcolor(rs.getString("pl_optcolor"));
						pdtInfo.setPl_stock(rs.getInt("pl_stock"));
						pdtInfo.setPl_salecnt(rs.getInt("pl_salecnt"));
						pdtInfo.setPl_isview(rs.getString("pl_isview"));
						pdtInfo.setPl_issell(rs.getString("pl_issell"));
						pdtInfo.setPl_new(rs.getString("pl_new"));
					   // 생성된 인스턴스에 데이터 채우기
				   }
			   } catch(Exception e) {
				   System.out.println("getPdtInfo() 메소드에서 오류 발생");
			   } finally {
				   close(rs);
				   close(stmt);
			   }
			
			return pdtInfo;
	   }
	   
	   // 상품을 등록시키는 메소드
	   public String insertPdt(HttpServletRequest request) {
		   System.out.println("insertPdt로 들어옴");
			int result = 0, plnum = 1;
			String plResult = "";
			Statement stmt = null;
			ResultSet rs = null;
			try {
				String sql = "select max(pl_num) + 1 from t_product_list";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				if (rs.next())	plnum = rs.getInt(1);
				
				String cbid = request.getParameter("cbid").trim().replaceAll("'", "''");
				String csid = request.getParameter("csid").trim().replaceAll("'", "''");
				String plid = request.getParameter("plid").trim().replaceAll("'", "''");
				String plname = request.getParameter("plname").trim().replaceAll("'", "''");
				int plprice = Integer.parseInt(request.getParameter("plprice"));
				String ploptcolor = request.getParameter("ploptcolor").trim().replaceAll("'", "''");
				String ploptsize = request.getParameter("ploptsize").trim().replaceAll("'", "''");
				String plimg1 = request.getParameter("plimg1");
				String plimg2 = request.getParameter("plimg2");
				String plimg3 = request.getParameter("plimg3");
				String plimg4 = request.getParameter("plimg4");
				String plimg5 = request.getParameter("plimg5");
				int plstock = Integer.parseInt(request.getParameter("plstock"));
				String plisview = request.getParameter("plisview").trim().replaceAll("'", "''");
				String plissell = request.getParameter("plissell").trim().replaceAll("'", "''");
				
				sql = "insert into t_product_list (pl_num, cb_id, cs_id, pl_id, pl_name, pl_price, ";
				sql += "pl_optcolor, pl_optsize, pl_img1, pl_img2, pl_img3, pl_img4, pl_img5, pl_stock, pl_isview, pl_issell) values (" + plnum + ", '";
				sql += cbid + "', '" + csid + "', '" + plid + "', '" + plname + "', " + plprice + ", '" + ploptcolor + "', '" + ploptsize + "', '" + plimg1 + "', ";
				sql += "'" + plimg2 + "', '" + plimg3 + "', '" + plimg4 + "', '" + plimg5 + "', " + plstock + ", '" + plisview + "', '" + plissell + "') ";
				System.out.println(sql);
				result = stmt.executeUpdate(sql);
				plResult = result + ":" + plnum;
			} catch(Exception e) {
				System.out.println("insertNotice() 메소드에서 오류 발생");
			} finally {
				close(rs);
				close(stmt);
			}

			return plResult;
	   }
	   
	   
	   	// 상품을 수정하는 메소드
		public int updatePdt(HttpServletRequest request) {
			System.out.println("updatePdtDAO들어옴");
			int result = 0;
			Statement stmt = null;
			try {
				System.out.println("updatePdtDAO try들어옴");	
				String plnum = request.getParameter("num");
				String cbid = request.getParameter("cbid").trim().replaceAll("'", "''");
				String csid = request.getParameter("csid").trim().replaceAll("'", "''");
				String plid = request.getParameter("plid").trim().replaceAll("'", "''");
				String plname = request.getParameter("plname").trim().replaceAll("'", "''");
				int plprice = Integer.parseInt(request.getParameter("plprice"));
				String ploptcolor = request.getParameter("ploptcolor").trim().replaceAll("'", "''");
				String ploptsize = request.getParameter("ploptsize").trim().replaceAll("'", "''");
				String plimg1 = request.getParameter("plimg1");
				String plimg2 = request.getParameter("plimg2");
				String plimg3 = request.getParameter("plimg3");
				String plimg4 = request.getParameter("plimg4");
				String plimg5 = request.getParameter("plimg5");
				int plstock = Integer.parseInt(request.getParameter("plstock"));
				String plisview = request.getParameter("plisview").trim().replaceAll("'", "''");
				String plissell = request.getParameter("plissell").trim().replaceAll("'", "''");

				String sql = "update t_product_list set ";
				sql += "cb_id = '" + cbid + "', cs_id = '" + csid + "', pl_id = '" + plid + "', pl_name = '" + plname + "', pl_price = " + plprice + ", ";
				sql += "pl_optcolor = '" + ploptcolor + "', pl_optsize = '" + ploptsize + "', pl_img1 = '" + plimg1 + "', pl_img2 = '" + plimg2 + "', ";
				sql += "pl_img3 = '" + plimg3 + "', pl_img4 = '" + plimg4 + "', pl_img5 = '" + plimg5 + "', pl_stock = " + plstock + ", ";
				sql += "pl_isview = '" + plisview + "', pl_issell = '" + plissell + "' where pl_id = '" + plid + "' ";
				System.out.println(sql);
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
			} catch(Exception e) {
				System.out.println("updatePdt() 메소드에서 오류 발생");
			} finally {
				close(stmt);
			}

			return result;
		}
		
		// 상품 삭제하는 메소드
		public int deletePdt(HttpServletRequest request) {
			int result = 0;
			Statement stmt = null;
			try {
				String plid = request.getParameter("plid");
				String sql = "delete from t_product_list where pl_id = " + plid;
				System.out.println(sql);
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
			} catch(Exception e) {
				System.out.println("deletePdt() 메소드에서 오류 발생");
			} finally {
				close(stmt);
			}

			return result;
		}
	   
}
