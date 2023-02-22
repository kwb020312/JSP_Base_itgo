<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
   	import="java.net.URLDecoder"
%>
<%
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
			if(str.equals("Shipping_shippingDate")) {
				shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			}
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="EUC-KR">
<title>주문 완료</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>
	
	<div class="container">
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
	</div>
	<div class="container">
		<p>주문은 <%= shipping_shippingDate %>에 배송될 예정입니다!</p>
		<p>주문번호 :  <%= shipping_cartId %></p>
	</div>
	<div>
		<p><a href="./products.jsp" class="btn btn-secondary">&laquo; 상품 목록</a></p>
	</div>
</body>
</html>
<%
	// 주문 완료시, 세션 및 관련 쿠키 삭제
	session.invalidate();
	for(int i = 0 ; i < cookies.length ; i ++) {
		Cookie thisCookie = cookies[i];
		String str = thisCookie.getName();
		if(str.equals("Shipping_cartId")) {
			thisCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_name")) {
			thisCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_shippingDate")) {
			thisCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_country")) {
			thisCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_zipCode")) {
			thisCookie.setMaxAge(0);
		}
		if(str.equals("Shipping_addressName")) {
			thisCookie.setMaxAge(0);
		}
		response.addCookie(thisCookie);
		
	}
%>