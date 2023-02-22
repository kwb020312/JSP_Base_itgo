<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ�ֹ�</title>
</head>
<body>
	<%
		// ���۵� ��ǰ id�� ���
		String id = request.getParameter("id");
		// ��ǰ id�� �Ѿ���� ���� ��� ����
		if(id == null || id.trim().equals("")) {
			response.sendRedirect("products.jsp");
			return;
		}
		
		// ��ǰ �������� Ŭ���� �ν��Ͻ�
		ProductRepository dao = ProductRepository.getInstance();
		
		// �ش� id���� Ȱ���� �������� ����
		Product product = dao.getProductById(id);
		
		if(product == null) {
			response.sendRedirect("exceptionNoProductId.jsp");
		}
		
		// ��� ��ǰ �Է�
		ArrayList<Product> goodList = dao.getAllProducts();
		Product goods = new Product();
		
		// ��ǰ ����Ʈ �� ����� �ֹ� ��ǰ�� ���� ��ǰ�� �Է�
		for(int i = 0 ; i < goodList.size() ; i ++) {
			goods = goodList.get(i);
			if(goods.getProductId().equals(id)) {
				break;
			}
		}
		
		// ��ٱ��Ͽ� ��� ��ǰ ����� �Է�
		ArrayList<Product> list = (ArrayList<Product>)session.getAttribute("cartlist");
		if(list == null) {
			list = new ArrayList<Product>();
			session.setAttribute("cartlist", list);
		}
		
		int cnt = 0;
		Product goodsQnt = new Product();
		
		// ����ڰ� �ֹ��� ��ǰ�� �̹� ��ٱ��Ͽ� �ִٸ� ���� ����
		for(int i = 0 ; i < list.size() ; i ++) {
			goodsQnt = list.get(i);
			if(goodsQnt.getProductId().equals(id)) {
				cnt++;
				int orderQuandity = goodsQnt.getQuantity() + 1;
				goodsQnt.setQuantity(orderQuandity);
			}
		}
		
		// ����� �ֹ� ��ǰ�� ��ٱ��Ͽ� ���ٸ� ������ 1, ��ٱ��Ͽ� �߰�
		if(cnt == 0) {
			goods.setQuantity(1);
			list.add(goods);
		}
		
		response.sendRedirect("product.jsp?id="+id);
	%>
</body>
</html>