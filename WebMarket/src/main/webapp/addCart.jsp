<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품주문</title>
</head>
<body>
	<%
		// 전송된 상품 id를 얻기
		String id = request.getParameter("id");
		// 상품 id가 넘어오지 않은 경우 종료
		if(id == null || id.trim().equals("")) {
			response.sendRedirect("products.jsp");
			return;
		}
		
		// 상품 데이터의 클래슷 인스턴스
		ProductRepository dao = ProductRepository.getInstance();
		
		// 해당 id값을 활용해 상세정보를 받음
		Product product = dao.getProductById(id);
		
		if(product == null) {
			response.sendRedirect("exceptionNoProductId.jsp");
		}
		
		// 모든 상품 입력
		ArrayList<Product> goodList = dao.getAllProducts();
		Product goods = new Product();
		
		// 상품 리스트 중 사용자 주문 상품과 같은 상품을 입력
		for(int i = 0 ; i < goodList.size() ; i ++) {
			goods = goodList.get(i);
			if(goods.getProductId().equals(id)) {
				break;
			}
		}
		
		// 장바구니에 담긴 물품 목록을 입력
		ArrayList<Product> list = (ArrayList<Product>)session.getAttribute("cartlist");
		if(list == null) {
			list = new ArrayList<Product>();
			session.setAttribute("cartlist", list);
		}
		
		int cnt = 0;
		Product goodsQnt = new Product();
		
		// 사용자가 주문한 상품이 이미 장바구니에 있다면 수량 증가
		for(int i = 0 ; i < list.size() ; i ++) {
			goodsQnt = list.get(i);
			if(goodsQnt.getProductId().equals(id)) {
				cnt++;
				int orderQuandity = goodsQnt.getQuantity() + 1;
				goodsQnt.setQuantity(orderQuandity);
			}
		}
		
		// 사용자 주문 상품이 장바구니에 없다면 수량은 1, 장바구니에 추가
		if(cnt == 0) {
			goods.setQuantity(1);
			list.add(goods);
		}
		
		response.sendRedirect("product.jsp?id="+id);
	%>
</body>
</html>