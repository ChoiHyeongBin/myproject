package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class PdtDAO {
	private static PdtDAO pdtDAO;
	   private Connection conn;
	   
	   private PdtDAO() {}   
	      
	   public static PdtDAO getInstance() {
	      if (pdtDAO == null) {   
	    	  pdtDAO = new PdtDAO();
	      }
	      
	      return pdtDAO;
	   }
	   
	   public void setConnection(Connection conn) {
	      this.conn = conn;
	   }
	   
	// 상품의 목록을 ArrayList 형태로 리턴하는 메소드
	   public ArrayList<PdtInfo> getPdtList(String where, int cpage, int limit) {
		   ArrayList<PdtInfo> pdtList = new ArrayList<PdtInfo>();
		   Statement stmt = null;
		   ResultSet rs = null;
		   PdtInfo pdtInfo = null;
		   
		   try {
			   int start = (cpage - 1) * limit;
			   String sql = "select * from t_product_list ";
			   sql += " where pl_isview = 'y' " + where;
			   sql += " limit " + start + ", " + limit;
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
					   pdtInfo.setPl_stock(rs.getInt("pl_stock"));
					   pdtInfo.setCs_name(rs.getString("cs_name"));
					   pdtInfo.setCs_id(rs.getString("cs_id"));
					   pdtInfo.setPl_optsize(rs.getString("pl_optsize"));
					   pdtInfo.setPl_optcolor(rs.getString("pl_optcolor"));
					   // 생성된 인스턴스에 데이터 채우기
					   
					   pdtList.add(pdtInfo);
					   // 상품 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			   }
			   
		   } catch(Exception e) {
			   System.out.println("getPdtList() 메소드에서 오류 발생");
		   } finally {
			   close(rs);
			   close(stmt);
		   }
		   
		   return pdtList;
	   }
	   
	   // 하나의 상품정보를 PdtInfo형 인스턴스로 리턴받는 메소드
	   public PdtInfo getPdtInfo(String plid) {
			PdtInfo pdtInfo = null;
			
			Statement stmt = null;	// 쿼리로 전송시켜주는 객체
			   ResultSet rs = null;
			   
			   try {
				   String sql = "select p.* from t_product_list p " +
						   	"where p.pl_isview ='y' and p.pl_id = '" + plid + "' ";			
				   stmt = conn.createStatement();
				   rs = stmt.executeQuery(sql);
				   if (rs.next()) {
					   pdtInfo = new PdtInfo();
					   // 하나의 게시글 데이터를 담기 위한 PdtInfo 인스턴스 생성
					   pdtInfo.setPl_num(rs.getInt("pl_num"));
					   pdtInfo.setPl_id(rs.getString("pl_id"));
					   pdtInfo.setPl_name(rs.getString("pl_name"));
					   pdtInfo.setPl_price(rs.getInt("pl_price"));
					   pdtInfo.setCb_id(rs.getString("cb_id"));
					   pdtInfo.setCs_id(rs.getString("cs_id"));
					   pdtInfo.setPl_img1(rs.getString("pl_img1"));
					   pdtInfo.setPl_img2(rs.getString("pl_img2"));
					   pdtInfo.setPl_img3(rs.getString("pl_img3"));
					   pdtInfo.setPl_img4(rs.getString("pl_img4"));
					   pdtInfo.setPl_img5(rs.getString("pl_img5"));
					   pdtInfo.setPl_optsize(rs.getString("pl_optsize"));
					   pdtInfo.setPl_optcolor(rs.getString("pl_optcolor"));
					   pdtInfo.setPl_stock(rs.getInt("pl_stock"));
					   pdtInfo.setPl_issell(rs.getString("pl_issell"));
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
	   
	// 상품들 중 검색되는 전체 개수를 리턴하는 메소드
		public int getPdtCount( String where) {
			int rcount = 0;
			Statement stmt = null;
			ResultSet rs = null;
			try {
				String sql = "select count(*) from t_product_list where 1=1 " + where;
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
}
