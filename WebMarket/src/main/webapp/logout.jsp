<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그아웃</title>
</head>
<body>
	<!-- 모든 사용자를 삭제함 -->
	<% 
		session.invalidate();
		response.sendRedirect("addProduct.jsp");
	%>
</body>
</html>