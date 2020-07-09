package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import svc.*;
import vo.*;

public class NoticeService {
	// 공지사항의 목록 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		NoticeDAO noticeDAO = NoticeDAO.getInstance();	// getInstance() : 싱글턴패턴이며, 하나의 인스턴스만 가지고 공유해서 쓰임
		Connection conn = getConnection();
		noticeDAO.setConnection(conn);
		rcount = noticeDAO.getListCount(where);
		close(conn);
		
		return rcount;
	}
	
	// 공지사항의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<NoticeInfo> getNoticeList(String where, int cpage, int limit) {
		ArrayList<NoticeInfo> noticeList = new ArrayList<NoticeInfo>();
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		Connection conn = getConnection();
		noticeDAO.setConnection(conn);
		noticeList = noticeDAO.getNoticeList(where, cpage, limit);
		close(conn);
		
		return noticeList;
	}
	
	// 공지사항 등록결과와 글번호를 String형으로 리턴하는 메소드
	public String insertNotice(HttpServletRequest request) {
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		Connection conn = getConnection();
		noticeDAO.setConnection(conn);
		String nlResult = noticeDAO.insertNotice(request);
		int result = Integer.parseInt(nlResult.substring(0, nlResult.indexOf(':')));
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);
		
		return nlResult;
	}
	
	// 공지사항 게시글에 대한 수정결과를 int형으로 리턴하는 메소드 
	public int updateNotice(HttpServletRequest request) {
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		Connection conn = getConnection();
		noticeDAO.setConnection(conn);
		int result = noticeDAO.updateNotice(request);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);
		
		return result;
	}
	
	// 공지사항 게시글을 삭제한 후 결과를 int형으로 리턴하는 메소드 
	public int deleteNotice(HttpServletRequest request) {
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		Connection conn = getConnection();
		noticeDAO.setConnection(conn);
		int result = noticeDAO.deleteNotice(request);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);
		
		return result;
	}
		
	
	// 특정 공지사항 글 하나를 리턴하는 메소드
	public NoticeInfo getNotice(int num) {
		NoticeInfo noticeInfo = null;
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		Connection conn = getConnection();
		noticeDAO.setConnection(conn);
		noticeInfo = noticeDAO.getNotice(num);
		close(conn);
		
		return noticeInfo;
	}
	
	// 공지사항 게시글의 조회수를 증가시킨 후 결과를 int형으로 리턴하는 메소드
	public int updateRead(int num) {
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		Connection conn = getConnection();
		noticeDAO.setConnection(conn);
		int result = noticeDAO.updateRead(num);
		
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);
		
		return result;
	}
	
	public String getPrevTitle(int num) {
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		Connection conn = getConnection();
		noticeDAO.setConnection(conn);
		String prev = noticeDAO.getPrevTitle(num);
		close(conn);
		return prev;
	}
	
	public String getNextTitle(int num) {
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		Connection conn = getConnection();
		noticeDAO.setConnection(conn);
		String next = noticeDAO.getNextTitle(num);
		close(conn);
		return next;
	}
}