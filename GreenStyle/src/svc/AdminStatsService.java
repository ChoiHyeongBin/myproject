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

public class AdminStatsService {
	
	public ArrayList<TopPdtInfo> getPdtTop() {
		ArrayList<TopPdtInfo> pdtTop = null;
		AdminStatsDAO adminStatsDAO = AdminStatsDAO.getInstance();
		Connection conn = getConnection();
		adminStatsDAO.setConnection(conn);
		pdtTop = adminStatsDAO.getPdtTop();
		close(conn);
		
		return pdtTop;
	}
	
	public ArrayList<TopMemberInfo> getMemberTop() {
		ArrayList<TopMemberInfo> memberTop = null;
		AdminStatsDAO adminStatsDAO = AdminStatsDAO.getInstance();
		Connection conn = getConnection();
		adminStatsDAO.setConnection(conn);
		memberTop = adminStatsDAO.getMemberTop();
		close(conn);
		
		return memberTop;
	}
	
	public int getProfit() {
		int result = 0;
		AdminStatsDAO adminStatsDAO = AdminStatsDAO.getInstance();
		Connection conn = getConnection();
		adminStatsDAO.setConnection(conn);
		result = adminStatsDAO.getProfit();
		close(conn);
		
		return result;
	}
	
	public ArrayList<TopPdtInfo> getMenTop() {
		ArrayList<TopPdtInfo> menTop = null;
		AdminStatsDAO adminStatsDAO = AdminStatsDAO.getInstance();
		Connection conn = getConnection();
		adminStatsDAO.setConnection(conn);
		menTop = adminStatsDAO.getMenTop();
		close(conn);
		
		return menTop;
	}
	
	public ArrayList<TopPdtInfo> getWomenTop() {
		ArrayList<TopPdtInfo> womenTop = null;
		AdminStatsDAO adminStatsDAO = AdminStatsDAO.getInstance();
		Connection conn = getConnection();
		adminStatsDAO.setConnection(conn);
		womenTop = adminStatsDAO.getWomenTop();
		close(conn);
		
		return womenTop;
	}
}
