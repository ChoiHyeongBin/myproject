package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;


public class MainDAO {
	private static MainDAO mainDAO;
	   private Connection conn;
	   
	   private MainDAO() {}   
	      
	   public static MainDAO getInstance() {
	      if (mainDAO == null) {   
	    	  mainDAO = new MainDAO();
	      }
	      
	      return mainDAO;
	   }
	   
	   public void setConnection(Connection conn) {
	      this.conn = conn;
	   }
	// 상품의 목록을 ArrayList 형태로 리턴하는 메소드
	   public ArrayList<PdtInfo> getPdtList() {
		   ArrayList<PdtInfo> pdtList = new ArrayList<PdtInfo>();
		   Statement stmt = null;
		   ResultSet rs = null;
		   PdtInfo pdtInfo = null;
		   
		   try {
			   String sql = "select * from t_product_list where pl_isview = 'y' and pl_new = 'y' ";
			   stmt = conn.createStatement();
			   rs = stmt.executeQuery(sql);
			   
			   while (rs.next()) {
					   pdtInfo = new PdtInfo();
					   // 하나의 게시글 데이터를 담기 위한 PdtInfo 인스턴스 생성
					   
					   pdtInfo.setPl_num(rs.getInt("pl_num"));
					   pdtInfo.setPl_id(rs.getString("pl_id"));
					   pdtInfo.setCs_id(rs.getString("cs_id"));
					   pdtInfo.setPl_name(rs.getString("pl_name"));
					   pdtInfo.setPl_price(rs.getInt("pl_price"));
					   pdtInfo.setPl_img1(rs.getString("pl_img1"));
					   pdtInfo.setPl_img2(rs.getString("pl_img2"));
					   pdtInfo.setPl_stock(rs.getInt("pl_stock"));
					   pdtInfo.setPl_optsize(rs.getString("pl_optsize"));
					   pdtInfo.setPl_optcolor(rs.getString("pl_optcolor"));
					   pdtInfo.setPl_new(rs.getString("pl_new"));
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
					   pdtInfo.setPl_optsize(rs.getString("pl_optsize"));
					   pdtInfo.setPl_optcolor(rs.getString("pl_optcolor"));
					   pdtInfo.setPl_stock(rs.getInt("pl_stock"));
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
}
