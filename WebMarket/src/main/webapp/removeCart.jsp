<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>해당상품 삭제</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
	
		if(id == null || id.trim().equals("")) {
			response.sendRedirect("products.jsp");
			return;
		}
		
		ProductRepository dao = ProductRepository.getInstance();
		
		Product product = dao.getProductById(id);
		
		if(product == null) {
			response.sendRedirect("exceptionNoProductId.jsp");
		}
		
		ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
		
		Product goodQnt = new Product();
		
		for(int i = 0 ; i < cartList.size(); i++) {
			goodQnt = cartList.get(i);
			if(goodQnt.getProductId().equals(id)) {
				cartList.remove(goodQnt);
			}
		}
		
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>