package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*; 
import javax.servlet.http.*;
import dao.*;
import svc.*;
import vo.*;

public class MainService {
	// 상품 목록을 ArrayList로 받아 리턴하는 메소드
	public ArrayList<PdtInfo> getPdtList(String where) {
		ArrayList<PdtInfo> pdtList = new ArrayList<PdtInfo>();
		MainDAO mainDAO = MainDAO.getInstance();
		Connection conn = getConnection();
		mainDAO.setConnection(conn);
		pdtList = mainDAO.getPdtList();
		close(conn);
		return pdtList;
	}
	
	// 하나의 상품 정보를 PdtInfo형 인스턴스로 리턴받는 메소드
	public PdtInfo getPdtInfo(String plid) {
		PdtInfo pdtInfo = new PdtInfo();
		MainDAO mainDAO = MainDAO.getInstance();
		Connection conn = getConnection();
		mainDAO.setConnection(conn);
		pdtInfo = mainDAO.getPdtInfo(plid);
		close(conn);
		return pdtInfo;
	}
}
