<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>장바구니 비우기</title>
</head>
<body>
	<%
		// 모든 상품을 삭제하기 위해서 sessionID값을 얻음
		String id = request.getParameter("cartId");
	
		if(id == null || id.trim().equals("")) {
			response.sendRedirect("cart.jsp");
			return;
		}
		// 세션을 삭제하고 있다.
		session.invalidate();
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>