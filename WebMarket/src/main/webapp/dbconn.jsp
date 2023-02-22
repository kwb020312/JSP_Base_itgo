<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Connection conn = null;
	try {
		String url = "jdbc:mysql://localhost:3306/webmarketdb";
		String user = "root";
		String password = "0000";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
	} catch(SQLException e) {
		out.println("데이터베이스 연결 실패");
		e.printStackTrace();
	}
%>