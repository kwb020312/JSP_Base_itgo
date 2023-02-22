<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	String sessionId = (String)session.getAttribute("sessionId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 삭제</title>
</head>
<body>
	<!-- DB 접속 -->
	<sql:setDataSource var="dataSource" url="jdbc:mysql://localhost:3306/webmarketdb" driver="com.mysql.cj.jdbc.Driver" user="root" password="0000" />
	
	<sql:update dataSource="${ dataSource }" var="resultSet">
		DELETE FROM members WHERE id=?
		<sql:param value="<%= sessionId %>" />
	</sql:update>
	
	<c:if test="${ resultSet >= 1 }">
		<c:import url="logoutMember.jsp" />
		<c:redirect url="resultMember.jsp" />
	</c:if>
</body>
</html>