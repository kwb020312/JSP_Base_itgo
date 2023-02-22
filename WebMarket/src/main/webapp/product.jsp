<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductRepository"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="exceptionNoProductId.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dfFormat = new DecimalFormat("###,###"); // 천단위 구분자 입력
%>
<html>
<head>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="EUC-KR">
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<script type="text/javascript">
	function addToCart() {
		// confirm() 함수는 사용자의 선택을 반영할 때 사용
		if(confirm("해당 상품을 장바구니에 추가하시겠습니까?")) {
			document.addForm.submit()
		} else {
			document.addForm.reset()
		}
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
<%-- 	<%
		ProductRepository dao = ProductRepository.getInstance();
		// 상품 id 값을 할당
		String id = request.getParameter("id");
		Product product = dao.getProductById(id);
	%> --%>
	<%@ include file="dbconn.jsp" %>
	<%
		// 어떤 제품을 편집할 것인가
		String productId = request.getParameter("id");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM product WHERE p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
	%>
	<div class="container">
		<div class="row">
			<!--  이미지 추가 -->
			<div class="col-md-5" >
				<img src="${ pageContext.request.contextPath }/resources/images/<%= rs.getString("p_filename") %>" style="width: 100%;" />
			</div>
			<div class="col-md-6">
				<h3><%= rs.getString("p_name") %></h3>
				<p><%= rs.getString("p_description") %></p>
				<p><b>상품 코드 : </b><span class="badge badge-danger" ><%= rs.getString("p_id") %></span></p>
				<p><b>제조사 : </b><%= rs.getString("p_manufacturer") %></p>
				<p><b>분류 : </b><%= rs.getString("p_category") %></p>
				<p><b>재고 수 : </b><%= dfFormat.format(Long.parseLong(rs.getString("p_unitsInStock"))) %></p>
				<h4><%= dfFormat.format(Integer.parseInt(rs.getString("p_unitPrice"))) %>원</h4>
				<br/>
				<form name="addForm" action="./addCart.jsp?id=<%= rs.getString("p_id") %>" method="post" >
					<!-- 상품 주문을 클릭 시, addToCart함수 호출 -->
					<a href="#" class="btn btn-info" onclick="addToCart()" >상품 주문 &raquo;</a>
					<!-- 장바구니 추가, 클릭 시, cart.jsp로 이동 -->
					<a href="./cart.jsp" class="btn btn-warning">장바구니 &raquo;</a>
					<a href="./products.jsp" class="btn btn-secondary" >상품 목록 &raquo;</a>
				</form>
			</div>
		</div>
		<hr />
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
	<% } %>
</body>
</html>