<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 태그 라이브러리를 사용하기 위해 import -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 로그인 정보를 가져온다.
	String id = request.getParameter("id");
	String pw = request.getParameter("password");
%>

<!-- DB접속 -->
<sql:setDataSource var="dataSource" url="jdbc:mysql://localhost:3306/webmarketdb" driver="com.mysql.cj.jdbc.Driver" user="root" password="0000" />

<!-- SQL Query -->
<sql:query dataSource="${ dataSource }" var="resultSet">
	SELECT * FROM members WHERE id=? and password=?
	<sql:param value="<%= id %>" />
	<sql:param value="<%= pw %>" />
</sql:query>

<c:forEach var="row" items="${ resultSet.rows }">
<%
	session.setAttribute("sessionId", id);
%>
	<c:redirect url="resultMember.jsp?msg=2" />
</c:forEach>

<c:redirect url="loginMember.jsp?error=1" />