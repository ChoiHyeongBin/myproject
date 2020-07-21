package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class NoticeDAO {
	private static NoticeDAO noticeDAO;
	private Connection conn;
	
	private NoticeDAO() {}
	
	public static NoticeDAO getInstance() {
		if (noticeDAO == null) {
			noticeDAO = new NoticeDAO();
		}
		
		return noticeDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	// 공지사항 게시물들 중 검색되는 전체 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;	// SQL문을 데이터베이스에 보내기위한 객체
		ResultSet rs = null;	// SQL 질의에 의해 생성된 테이블을 저장하는 객체
		
		try {
			String sql = "select count(*) from t_notice_list where 1=1 " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	// if문을 사용하지 않는 것은 count()결과이므로 무조건 결과값이 존재하므로
			rcount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("getListCount() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcount;
	}
	
	// 공지사항의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<NoticeInfo> getNoticeList(String where, int cpage, int limit) {
		ArrayList<NoticeInfo> noticeList = new ArrayList<NoticeInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		NoticeInfo noticeInfo = null;
		
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_notice_list where 1=1 " + where;
			sql += " order by nl_num desc limit " + start + ", " + limit;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				noticeInfo = new NoticeInfo();
				// 하나의 게시글 데이터를 담기 위한 NoticeInfo 인스턴스 생성
				
				noticeInfo.setNl_num(rs.getInt("nl_num"));
				noticeInfo.setNl_kind(rs.getString("nl_kind"));
				noticeInfo.setNl_title(rs.getString("nl_title"));
				noticeInfo.setNl_content(rs.getString("nl_content"));
				noticeInfo.setNl_read(rs.getInt("nl_read"));
				noticeInfo.setNl_date(rs.getString("nl_date"));
				noticeInfo.setAl_num(rs.getInt("al_num"));
				noticeInfo.setNl_isview(rs.getString("nl_isview"));
				noticeInfo.setAl_name(rs.getString("al_name"));
				// 생성된 인스턴스에 데이터 채우기
				noticeList.add(noticeInfo);
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}
			
		} catch (Exception e) {
			System.out.println("getNoticeList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return noticeList;
	}
	
	// 새 공지사항을 등록시키는 메소드
	public String insertNotice(HttpServletRequest request) {
		int result = 0, nlNum = 1;
		String nlResult = "";
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select max(nl_num) + 1 from t_notice_list";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	nlNum = rs.getInt(1);
			
			String title = request.getParameter("title").trim().replaceAll("'", "''");
			// trim() : 문자열 좌우의 공백을 제거하는 함수
			// replaceAll() : ex) "'"를 찾아서 "''"로 바꿔줌, abc가 들어가면 a or b or c가 들어간 문자열 전체를 바꿔줌
			System.out.println("title : " + title);
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			
			sql = "insert into t_notice_list (nl_num, nl_title, nl_content, al_num) values (" + nlNum + ", '";
			sql += title + "', '" + content + "', 0)";
			System.out.println(sql);
			result = stmt.executeUpdate(sql);
			nlResult = result + ":" + nlNum;
			
		} catch(Exception e) {
			System.out.println("insertNotice() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return nlResult;
	}
	
	// 공지사항을 삭제하는 메소드
	public int deleteNotice(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String num = request.getParameter("num");
			
			String sql = "delete from t_notice_list where nl_num = " + num;
			System.out.println(sql);
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("deleteNotice() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	// 공지사항 게시글의 조회수를 증가시키는 메소드
	public int updateRead(int num) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_notice_list set ";
			sql += "nl_read = nl_read + 1 where nl_num = " + num;
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("updateRead() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	// 특정 공지사항 글 하나를 리턴하는 메소드
	public NoticeInfo getNotice(int num) {
		NoticeInfo noticeInfo = null;
		// 지정한 공지사항 글 데이터를 저장하기 위한 인스턴스
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_notice_list where nl_num = " + num;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				noticeInfo = new NoticeInfo();
				
				noticeInfo.setNl_num(rs.getInt("nl_num"));
				noticeInfo.setNl_kind(rs.getString("nl_kind"));
				noticeInfo.setNl_title(rs.getString("nl_title"));
				noticeInfo.setNl_content(rs.getString("nl_content"));
				noticeInfo.setNl_read(rs.getInt("nl_read"));
				noticeInfo.setNl_date(rs.getString("nl_date"));
				noticeInfo.setAl_num(rs.getInt("al_num"));
				noticeInfo.setNl_isview(rs.getString("nl_isview"));
				noticeInfo.setAl_name(rs.getString("al_name"));
			}
			
		} catch (Exception e) {
			System.out.println("getNotice() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return noticeInfo;
	}
	
	// 공지사항을 수정하는 메소드
	public int updateNotice(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String num = request.getParameter("num");
			String title = request.getParameter("title").trim().replaceAll("'", "''");
			System.out.println("title : " + title);
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			System.out.println("content : " + content);
			// ' 를 '' 로 바꿔야 인식이 됨
			
			String sql = "update t_notice_list set ";
			sql += "nl_title = '" + title + "', ";
			sql += "nl_content = '" + content + "' ";
			sql += "where nl_num = " + num;
			System.out.println(sql);
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("updateNotice() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	// 이전 글 리턴 메소드
	public String getPrevTitle(int num) {
		Statement stmt = null;
		ResultSet rs = null;
		String prev = "";
		
		try {
			String sql = "select nl_title from t_notice_list where nl_num = " + (num - 1);
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next())	prev = rs.getString(1);
			// ResultSet에 저장된 Select문 실행 결과를 행단위로 1행씩 넘겨서 만약에 다음 행이 있으면 true, 다음 행이 없으면 false를 반환하는 함수 
			// while(rs.next())를 하게되면 한 루프가 돌아갈 때 마다 1행씩 넘겨주다가 더이상 행이 없으면 while문이 끝나게 됨
			// getString() 함수는 해당 순서의 열에있는 데이터를 String형으로 받아옴
			// ex) rs.getString(2)를 하게되면 2번째 열에있는 데이터를 가져오게 됨

		} catch (Exception e) {
			System.out.println("getPrevTitle() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return prev;
	}
	
	// 다음 글 리턴 메소드
	public String getNextTitle(int num) {
		Statement stmt = null;
		ResultSet rs = null;
		String next = "";
		
		try {
			String sql = "select nl_title from t_notice_list where nl_num = " + (num + 1);
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next())	next = rs.getString(1);
			
		} catch (Exception e) {
			System.out.println("getNextTitle() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		
		return next;
	}
}
