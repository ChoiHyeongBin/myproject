<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
Connection conn = null;
// DB로 연결할 때 사용하는 클래스

String driver = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/portfolio?serverTimezone=Asia/Seoul";
// mysql 5.1 이상부터는 '?serverTimezone=Asia/Seoul'를 필수로 입력해야 함
// localhost : mySql DBMS가 설치된 서버를 의미하며, 웹서버와 다른 서버일 경우 IP입력
// mall : 연결할 DB의 이름
// ?serverTimezone=Asia/Seoul : 5.1버전 이상부터 입력하는 시간대 지정 문자열

boolean isConnect = false;

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	// 아이디와 암호를 이용하여 DB에 연결함
	
	isConnect = true;
	
	conn.close();
	// Connection객체를 포함한 DB관련 객체들은 반드시 사용 후 close()메소드를 이용하여 닫아주는 것이 좋다.
} catch (Exception e) {
	isConnect = false;
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>
<% if (isConnect) { %>
	DB에 성공적으로 연결되었습니다.
<% } else  { %>
	DB연결에 실패하였습니다.
<% } %>
</h2>
</body>
</html>