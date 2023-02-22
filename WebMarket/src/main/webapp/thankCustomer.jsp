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
	
	// ��Ű�� ��� ������ �޾ƿ´�.
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
<title>�ֹ� �Ϸ�</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">�ֹ� �Ϸ�</h1>
		</div>
	</div>
	
	<div class="container">
		<h2 class="alert alert-danger">�ֹ����ּż� �����մϴ�.</h2>
	</div>
	<div class="container">
		<p>�ֹ��� <%= shipping_shippingDate %>�� ��۵� �����Դϴ�!</p>
		<p>�ֹ���ȣ :  <%= shipping_cartId %></p>
	</div>
	<div>
		<p><a href="./products.jsp" class="btn btn-secondary">&laquo; ��ǰ ���</a></p>
	</div>
</body>
</html>
<%
	// �ֹ� �Ϸ��, ���� �� ���� ��Ű ����
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