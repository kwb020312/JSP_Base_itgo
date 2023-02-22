<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
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
<!-- CDN 방식은 사용하지 않음 -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="EUC-KR">
<title>상품 목록</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	
	<%-- <%	
		ProductRepository dao = ProductRepository.getInstance();
	
		// 상품 목록을 모두 가져온다.
		ArrayList<Product> listOfProducts = dao.getAllProducts();
	%> --%>
	
	<div class="container">
		<div class="row" align="center">
			<%@ include file="dbconn.jsp" %> <!-- db 연동 -->
			<%
				/* for(int i = 0 ; i < listOfProducts.size() ; i ++) {
					Product product = listOfProducts.get(i); */
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				String sql = "SELECT * FROM product";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
			%>
				<div class="col-md-4" >
					<img alt="상품 이미지" src="${ pageContext.request.contextPath }/resources/images/<%= rs.getString("p_fileName") %>" style="width:100%" />
					<h3> <%= rs.getString("p_name") %> </h3>
					<p> <%= rs.getString("p_description") %> </p>
					<p> <%= dfFormat.format(Integer.parseInt(rs.getString("p_unitPrice"))) %>원</p>
					<p>
						<a class="btn btn-secondary" role="button" href="./product.jsp?id=<%= rs.getString("p_id") %>">상세정보 &raquo;</a>
					</p>
				</div>
			<%
				}
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			%>
		</div>
	</div>
	<hr />
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>