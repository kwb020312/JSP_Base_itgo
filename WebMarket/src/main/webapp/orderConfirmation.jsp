<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
	import="java.net.URLDecoder"    
%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_shippingDate = "";
	String shipping_country = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";
	
	// 쿠키의 모든 내용을 받아온다.
	Cookie[] cookies = request.getCookies();
	
	if(cookies != null) {
		for(int i = 0 ; i < cookies.length ; i ++) {
			Cookie thisCookie = cookies[i];
			String str = thisCookie.getName();
			
			if(str.equals("Shipping_cartId")) {
				shipping_cartId = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
			if(str.equals("Shipping_name")) {
				shipping_name = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
			if(str.equals("Shipping_shippingDate")) {
				shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
			if(str.equals("Shipping_country")) {
				shipping_country = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
			if(str.equals("Shipping_zipCode")) {
				shipping_zipCode = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
			if(str.equals("Shipping_addressName")) {
				shipping_addressName = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="EUC-KR">
<title>주문 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>
	
	<div class="container col-8 alert alert-info">
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong>
				<br/>
				<span>성명 : <%= shipping_name %></span>
				<br/>
				<span>우편번호 : <%= shipping_zipCode %></span>
				<br/>
				<span>주소 : <%= shipping_addressName %></span>
				<br/>
			</div>
			<div class="col-4" align="right">
				<p><em>배송일 : <%= shipping_shippingDate %></em></p>
			</div>
			<div>
				<table class="table table-hover">
					<tr>
						<th class="text-center">물품</th>
						<th class="text-center">수량</th>
						<th class="text-center">가격</th>
						<th class="text-center">소계</th>
					</tr>
					<%
						int sum=0;
						ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
						if(cartList == null) {
							cartList = new ArrayList<Product>();
						}
						for(int i = 0 ; i < cartList.size() ; i ++) {
							Product product = cartList.get(i);
							int total = product.getUnitPrice() * product.getQuantity(); // 해당 물품의 가격 * 수량
							sum+= total; // 소계
					%>
					<tr>
						<td class="text-center"><em><%= product.getPname() %></em></td>
						<td class="text-center"><em><%= product.getQuantity() %></em></td>
						<td class="text-center"><em><%= product.getUnitPrice() %>원</em></td>
						<td class="text-center"><em><%= total %>원</em></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td></td>
						<td></td>
						<td class="text-right"><strong>총액 : </strong></td>
						<td class="text-center text-danger"><strong>총액 : <%= sum %> </strong></td>
					</tr>
				</table>
				<a href="./shippingInfo.jsp?cartId=<%= shipping_cartId %>" class="btn btn-secondary" role="button">이전</a>
				<a href="./thankCustomer.jsp" class="btn btn-success" role="button">주문완료</a>
				<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button">취소</a>
			</div>
		</div>
	</div>
</body>
</html>