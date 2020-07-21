package db;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

//DB관련 공통 작업들을 위한 메소드들을 정의해 놓은 클래스
//모든 메소드는 public static으로 지정하여 인스턴스 없이 사용토록 한다.
public class JdbcUtil {
	public static Connection getConnection() {
	// Connection객체를 생성하여 리턴하는 메소드
		Connection conn = null;

		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource)envCtx.lookup("jdbc/MySQLDB");
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			// conn을 이용한 쿼리작업에 기본적으로 트랜잭션을 걸어줌
			// 쿼리작업시 commit이나 rollback 등의 명령으로 쿼리작업을 마무리해야 함
			// 단, select쿼리는 제외하고, insert, update, delete 쿼리에만 걸어줌
		} catch(Exception e) {
			System.out.println("DB 컨넥션 생성 오류!!");
			e.printStackTrace();
		}

		return conn;
	}

	public static void close(Connection conn) {
		try {
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public static void close(Statement stmt) {
		try {
			stmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public static void close(ResultSet rs) {
		try {
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public static void commit(Connection conn) {
		try {
			conn.commit();
			System.out.println("commit success");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public static void rollback(Connection conn) {
		try {
			conn.rollback();
			System.out.println("rollback success");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
