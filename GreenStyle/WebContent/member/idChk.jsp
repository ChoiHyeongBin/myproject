<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_include/incHead.jsp" %>
<%
String uid = request.getParameter("uid");
sql = "select count(*) from t_member_list where ml_id = '" + uid + "'";
System.out.println(sql);
String msg = "<span style='color:red;'>" + uid + "는 이미 사용중인 아이디 입니다.</span>";
String uniqueID = "n";

try {
	if (uid.length() >= 4){
	// 사용자가 입력한 아이디가 4글자 이상인 경우에만 중복확인 작업을 실시하기 위한 if문
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	rs.next();
		if (rs.getInt(1) == 0){
			// 사용자가 입력한 아이디가 사용할 수 있는 아이디이면
			// 아이디가 존재한다면 count(*)의 값이 1이 됨
			msg = "<span style='color:blue;'>" + uid + "는 사용 가능한 아이디 입니다.</span>";
			uniqueID = "y";
		}
	} else {
		msg = "아이디는 4~20자로 영문, 숫자 조합으로 입력하세요.";
		uniqueID = "n";
	}
%>
<script>
var obj = parent.document.getElementById("idMsg");		// msg의 문자열을 넣을 객체 생성
obj.innerHTML = "<%=msg%>";

parent.document.frmJoin.uniqueID.value = "<%=uniqueID%>";
</script>
<%	
} catch(Exception e) {
	e.printStackTrace();
}
%>


<%@ include file="../_include/incFoot.jsp" %>