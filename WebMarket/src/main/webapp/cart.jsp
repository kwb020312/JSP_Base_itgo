<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<%
	// 세션의 ID값 받기
	String cartId = session.getId();
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dfFormat = new DecimalFormat("###,###"); // 천단위 구분자 입력
%>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	
	<div class="container" >
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left"><a href="./deleteCart.jsp?cartId=<%= cartId %>" class="btn btn-danger">삭제하기</a></td>
					<td align="right"><a href="./shippingInfo.jsp?cartId=<%= cartId %>" class="btn btn-success">주문하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비교</th>
				</tr>
				<%
					int sum = 0;
					ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
					
					// 전체 상품이 삭제되었다면, 재정의
					if(cartList == null) {
						cartList = new ArrayList<Product>();
					}
					
					// 상품을 가져와 수량 * 가격을 입력
					for(int i = 0 ; i < cartList.size() ; i ++) {
						Product product = cartList.get(i);
						int total = product.getUnitPrice() * product.getQuantity();
						sum+= total;
				%>
				<tr>
					<td><%= product.getProductId() %>-<%= product.getPname() %></td>
					<td><%= dfFormat.format(product.getUnitPrice()) %></td>
					<td><%= product.getQuantity() %></td>
					<td><%= dfFormat.format(total) %></td>
					<td><a href="./removeCart.jsp?id=<%= product.getProductId() %>" class="badge badge-danger">삭제</a></td>
				</tr>
				<% } %>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%= dfFormat.format(sum) %></th>
					<th></th>
				</tr>
			</table>
			<a href="./products.jsp" class="btn btn-secondary">&laquo;쇼핑 계속하기</a>
		</div>
		<hr/>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>