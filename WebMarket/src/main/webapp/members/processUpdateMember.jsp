<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 태그 라이브러리를 사용하기 위해 import -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	
	// 입력받은 년, 월, 일을 합친다.
	String year = request.getParameter("birthyy");
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;
	
	// 주소, 확장주소를 합친다.
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	String mail = mail1 + "@" + mail2;
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	// 가입 시점을 저장한다.
	/* SimpleDateFormat sDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String regist_day = sDateFormat.format(new Date()); */
%>

<!-- DB접속 -->
<sql:setDataSource var="dataSource" url="jdbc:mysql://localhost:3306/webmarketdb" driver="com.mysql.cj.jdbc.Driver" user="root" password="0000" />

<!-- jstl라이브러리의 sql태그를 사용한 DB 데이터 입력 코드 -->
<!-- update는 수정, 입력, 삭제까지 모두 담당한다. -->
<sql:update dataSource="${ dataSource }" var="resultSet">
	UPDATE members SET password=?, name=?, gender=?, birth=?, mail=?, phone=?, address=? WHERE id=?;
	<sql:param value="<%= password %>" />
	<sql:param value="<%= name %>" />
	<sql:param value="<%= gender %>" />
	<sql:param value="<%= birth %>" />
	<sql:param value="<%= mail %>" />
	<sql:param value="<%= phone %>" />
	<sql:param value="<%= address %>" />
	<sql:param value="<%= id %>" />
</sql:update>

<c:if test="${ resultSet >= 1 }">
	<c:redirect url="resultMember.jsp?msg=0" />
</c:if>