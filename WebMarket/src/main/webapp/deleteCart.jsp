<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ٱ��� ����</title>
</head>
<body>
	<%
		// ��� ��ǰ�� �����ϱ� ���ؼ� sessionID���� ����
		String id = request.getParameter("cartId");
	
		if(id == null || id.trim().equals("")) {
			response.sendRedirect("cart.jsp");
			return;
		}
		// ������ �����ϰ� �ִ�.
		session.invalidate();
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>