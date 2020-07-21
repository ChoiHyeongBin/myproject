<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ResultSet rs2 = null;
String sql2 = null;

String driver = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/portfolio?serverTimezone=Asia/Seoul";


try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");

} catch(Exception e) {
	e.printStackTrace();
}

String user_id = (String)session.getAttribute("user_id");
int user_point = (Integer)session.getAttribute("user_point");
boolean isLogin = false;
if (user_id != null) isLogin = true;

request.setCharacterEncoding("utf-8");
%>