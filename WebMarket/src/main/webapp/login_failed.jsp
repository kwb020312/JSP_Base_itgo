<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 실패</title>
</head>
<body>
	<!-- 인증 실패시 error 값이 1로 설정됨 -->
	<% response.sendRedirect("login.jsp?error=1"); %>
</body>
</html>